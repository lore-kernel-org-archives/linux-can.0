From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: m_can: Enable TX FIFO Handling for M_CAN IP
 version >= v3.1.x
Date: Tue, 21 Mar 2017 15:50:07 +0100
Message-ID: <8f3eed2e-d0a7-020d-84cf-561a98827076@pengutronix.de>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-5-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="75PLiJ7SkHT0wT61qQfL0ImBrHrSGGqlP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38723 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932822AbdCUOuO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2017 10:50:14 -0400
In-Reply-To: <1489154417-19669-5-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75PLiJ7SkHT0wT61qQfL0ImBrHrSGGqlP
Content-Type: multipart/mixed; boundary="aqKHuQIHOe21gc9CuEQMqTirSraW8onw7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org
Message-ID: <8f3eed2e-d0a7-020d-84cf-561a98827076@pengutronix.de>
Subject: Re: [PATCH 3/3] can: m_can: Enable TX FIFO Handling for M_CAN IP
 version >= v3.1.x
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-5-git-send-email-mario.huettel@de.bosch.com>
In-Reply-To: <1489154417-19669-5-git-send-email-mario.huettel@de.bosch.com>

--aqKHuQIHOe21gc9CuEQMqTirSraW8onw7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2017 03:00 PM, Mario Huettel wrote:
> * Added defines for TX Event FIFO Element
> * Adapted ndo_start_xmit function.
>   For versions >=3D v3.1.x it uses the TX FIFO to optimize the data
>   throughput. It stores the echo skb at the same index as in the
>   M_CAN's TX FIFO. The frame's message marker is set to this index.
>   This message marker is received in the TX Event FIFO after
>   the message was successfully transmitted. It is used to echo the
>   correct echo skb back to the network stack.
> * Added m_can_echo_tx_event function. It reads all received
>   message markers in the TX Event FIFO and loops back the
>   corresponding echo skbs.

Does the driver echo the CAN frames in the order you put them into the
FIFO and the HW sends them onto the wire?

> * ISR checks for new TX Event Entry interrupt for version >=3D 3.1.x.
> * Added spinlock to prevent concurrent accesses on the TX queue.
>=20
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
> ---
>  drivers/net/can/m_can/m_can.c | 198 ++++++++++++++++++++++++++++++++++=
+++-----
>  1 file changed, 174 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 1538944..1a30d0e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -341,6 +342,11 @@ enum m_can_versions {
>  #define TX_BUF_MM_SHIFT		24
>  #define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
> =20
> +/* Tx event FIFO Element */
> +/* E1 */
> +#define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
> +#define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
> +
>  /* address offset and element number for each FIFO/Buffer in the Messa=
ge RAM */
>  struct mram_cfg {
>  	u16 off;
> @@ -358,6 +364,8 @@ struct m_can_priv {
>  	void __iomem *base;
>  	u32 irqstatus;
>  	enum m_can_versions version;
> +	/* Spinlock to protect TX queue */
> +	spinlock_t xmit_lock;
> =20
>  	/* message ram configuration */
>  	void __iomem *mram_base;
> @@ -828,6 +836,44 @@ static int m_can_poll(struct napi_struct *napi, in=
t quota)
>  	return work_done;
>  }
> =20
> +static void m_can_echo_tx_event(struct net_device *dev)
> +{
> +	u32 txe_count =3D 0;
> +	u32 m_can_txefs;
> +	u32 fgi =3D 0;
> +	int i =3D 0;
no need to init as 0
> +	unsigned int msg_mark;
> +
no blank line here

> +	struct m_can_priv *priv =3D netdev_priv(dev);
> +	struct net_device_stats *stats =3D &dev->stats;
> +
> +	/* read tx event fifo status */
> +	m_can_txefs =3D m_can_read(priv, M_CAN_TXEFS);
> +
> +	/* Get Tx Event fifo element count */
> +	txe_count =3D (m_can_txefs & TXEFS_EFFL_MASK)
> +			>> TXEFS_EFFL_SHIFT;
> +
> +	/* Get and process all sent elements */
> +	for (i =3D 0; i < txe_count; i++) {

Is this a true hardware fifo, so that you echo the elements in the order
you sent them?

> +		/* retrieve get index */
> +		fgi =3D (m_can_read(priv, M_CAN_TXEFS) & TXEFS_EFGI_MASK)
> +			>> TXEFS_EFGI_SHIFT;
> +
> +		/* get message marker */
> +		msg_mark =3D (m_can_txe_fifo_read(priv, fgi, 4) &
> +			    TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
> +
> +		/* ack txe element */
> +		m_can_write(priv, M_CAN_TXEFA, (TXEFA_EFAI_MASK &
> +						(fgi << TXEFA_EFAI_SHIFT)));
> +
> +		/* update stats */
> +		stats->tx_bytes +=3D can_get_echo_skb(dev, msg_mark);
> +		stats->tx_packets++;
> +	}
> +}
> +
>  static irqreturn_t m_can_isr(int irq, void *dev_id)
>  {
>  	struct net_device *dev =3D (struct net_device *)dev_id;
> @@ -855,11 +901,19 @@ static irqreturn_t m_can_isr(int irq, void *dev_i=
d)
>  	}
> =20
>  	/* transmission complete interrupt */

make it a switch(priv->version) on the first level

> -	if (ir & IR_TC) {
> +	if ((ir & IR_TC) && priv->version =3D=3D M_CAN_V30X) {
>  		stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>  		stats->tx_packets++;
>  		can_led_event(dev, CAN_LED_EVENT_TX);
>  		netif_wake_queue(dev);
> +	} else if ((ir & IR_TEFN) &&
> +		   (priv->version =3D=3D M_CAN_V31X ||
> +		    priv->version =3D=3D M_CAN_V32X)) {
> +		/* New TX FIFO Element arrived */
> +		m_can_echo_tx_event(dev);
> +		can_led_event(dev, CAN_LED_EVENT_TX);
> +		if (netif_queue_stopped(dev) && !m_can_tx_fifo_full(priv))
> +			netif_wake_queue(dev);
>  	}
> =20
>  	return IRQ_HANDLED;
> @@ -1052,7 +1106,12 @@ static void m_can_chip_config(struct net_device =
*dev)
>  	/* enable interrupts */
>  	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
>  	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> -		m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC_30X);
> +		if (priv->version =3D=3D M_CAN_V30X)
switch()
> +			m_can_write(priv, M_CAN_IE, IR_ALL_INT &
> +				    ~(IR_ERR_LEC_30X));
> +		else
> +			m_can_write(priv, M_CAN_IE, IR_ALL_INT &
> +				    ~(IR_ERR_LEC_31X));
>  	else
>  		m_can_write(priv, M_CAN_IE, IR_ALL_INT);
> =20
> @@ -1329,19 +1388,35 @@ static int m_can_close(struct net_device *dev)
>  	return 0;
>  }
> =20
> +static int m_can_next_echo_skb_occupied(struct net_device *dev, int pu=
tidx)
> +{
> +	struct m_can_priv *priv =3D netdev_priv(dev);
> +	/*get wrap around for loopback skb index */
         ^^ space
> +	unsigned int wrap =3D priv->can.echo_skb_max;
> +	int next_idx;
> +
> +	/* calculate next index */
> +	next_idx =3D (++putidx >=3D wrap ? 0 : putidx);
> +
> +	/* check if occupied */
> +	return !!priv->can.echo_skb[next_idx];
> +}
> +
>  static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  				    struct net_device *dev)
>  {
>  	struct m_can_priv *priv =3D netdev_priv(dev);
>  	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> -	u32 id, cccr;
> +	u32 id, cccr, fdflags;
>  	int i;
> +	int putidx;
> +	unsigned long irqsave;
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> =20
> -	netif_stop_queue(dev);
> -
> +	/* Generate ID field for TX buffer Element */
> +	/* Common to all supported M_CAN versions */
>  	if (cf->can_id & CAN_EFF_FLAG) {
>  		id =3D cf->can_id & CAN_EFF_MASK;
>  		id |=3D TX_BUF_XTD;
> @@ -1352,33 +1427,105 @@ static netdev_tx_t m_can_start_xmit(struct sk_=
buff *skb,
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		id |=3D TX_BUF_RTR;
> =20
> -	/* message ram configuration */
> -	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
> -	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16)=
;
> +	if (priv->version =3D=3D M_CAN_V30X) {
switch()
> +		netif_stop_queue(dev);
> =20
> -	for (i =3D 0; i < cf->len; i +=3D 4)
> -		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
> -				 *(u32 *)(cf->data + i));
> +		/* message ram configuration */
> +		m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
> +		m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC,
> +				 can_len2dlc(cf->len) << 16);
> =20
> -	can_put_echo_skb(skb, dev, 0);
> +		for (i =3D 0; i < cf->len; i +=3D 4)
> +			m_can_fifo_write(priv, 0,
> +					 M_CAN_FIFO_DATA(i / 4),
> +					 *(u32 *)(cf->data + i));
> +
> +		can_put_echo_skb(skb, dev, 0);
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> +			cccr =3D m_can_read(priv, M_CAN_CCCR);
> +			cccr &=3D ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
> +			if (can_is_canfd_skb(skb)) {
> +				if (cf->flags & CANFD_BRS)
> +					cccr |=3D CCCR_CMR_CANFD_BRS <<
> +						CCCR_CMR_SHIFT;
> +				else
> +					cccr |=3D CCCR_CMR_CANFD <<
> +						CCCR_CMR_SHIFT;
> +			} else {
> +				cccr |=3D CCCR_CMR_CAN << CCCR_CMR_SHIFT;
> +			}
> +			m_can_write(priv, M_CAN_CCCR, cccr);
> +		}
> +		m_can_write(priv, M_CAN_TXBTIE, 0x1);
> +		m_can_write(priv, M_CAN_TXBAR, 0x1);
> +		/* End of xmit function for version 3.0.x */

maybe put this into a subfunction....

> +	} else if (priv->version =3D=3D M_CAN_V31X ||
> +		   priv->version =3D=3D M_CAN_V32X) {
> +		/* Check if FIFO full */
> +		if (m_can_tx_fifo_full(priv)) {
> +			/* This shouldn't happen */
> +			netif_stop_queue(dev);
> +			netdev_warn(dev,
> +				    "TX queue active although FIFO is full.");
> +			return NETDEV_TX_BUSY;
> +		}
> =20
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> -		cccr =3D m_can_read(priv, M_CAN_CCCR);
> -		cccr &=3D ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
> +		/* get put index for frame */
> +		putidx =3D ((m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
> +				  >> TXFQS_TFQPI_SHIFT);
> +		/* Write ID Field to FIFO Element */
> +		m_can_fifo_write(priv, putidx, M_CAN_FIFO_ID, id);
> +
> +		/* get CAN FD configuration of frame */
> +		fdflags =3D 0;
>  		if (can_is_canfd_skb(skb)) {
> +			fdflags |=3D TX_BUF_FDF;
>  			if (cf->flags & CANFD_BRS)
> -				cccr |=3D CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
> -			else
> -				cccr |=3D CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
> -		} else {
> -			cccr |=3D CCCR_CMR_CAN << CCCR_CMR_SHIFT;
> +				fdflags |=3D TX_BUF_BRS;
>  		}
> -		m_can_write(priv, M_CAN_CCCR, cccr);
> +
> +		/* Construct DLC Field. Also contains CAN-FD configuration
> +		 * use put index of fifo as message marker
> +		 * it is used in TX interrupt for
> +		 * sending the correct echo frame
> +		 */
> +		m_can_fifo_write(priv, putidx, M_CAN_FIFO_DLC,
> +				 ((putidx << TX_BUF_MM_SHIFT) &
> +				  TX_BUF_MM_MASK) |
> +				 (can_len2dlc(cf->len) << 16) |
> +				 fdflags | TX_BUF_EFC);
> +
> +		for (i =3D 0; i < cf->len; i +=3D 4)
> +			m_can_fifo_write(priv, putidx, M_CAN_FIFO_DATA(i / 4),
> +					 *(u32 *)(cf->data + i));
> +
> +		/* Push loopback echo.
> +		 * Will be looped back on TX interrupt based on message marker
> +		 */
> +		can_put_echo_skb(skb, dev, putidx);
> +
> +		/* Enable TX FIFO element to start transfer  */
> +		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
> +
> +		/* wait until put index has changed */
> +		while (((m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
> +			>> TXFQS_TFQPI_SHIFT) =3D=3D putidx)
> +			;

why is this needed? what does this do?

> +
> +		/* Lock spinlock for TX to prevent concurrent
> +		 * access on the network queue
> +		 */
> +		spin_lock_irqsave(&priv->xmit_lock, irqsave);

What does this lock protect? It's only used in the m_can_start_xmit()
function, which is only entered by a single instance of the networking
stack.

> +
> +		/* stop network queue if fifo full */
> +			if (m_can_tx_fifo_full(priv) ||
> +			    m_can_next_echo_skb_occupied(dev, putidx))
> +				netif_stop_queue(dev);
> +
> +		spin_unlock_irqrestore(&priv->xmit_lock, irqsave);
>  	}
> =20
> -	/* enable first TX buffer to start transfer  */
> -	m_can_write(priv, M_CAN_TXBTIE, 0x1);
> -	m_can_write(priv, M_CAN_TXBAR, 0x1);
> =20
>  	return NETDEV_TX_OK;
>  }
> @@ -1552,9 +1699,12 @@ static int m_can_plat_probe(struct platform_devi=
ce *pdev)
>  	dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
>  		 KBUILD_MODNAME, priv->base, dev->irq);
> =20
> +	spin_lock_init(&priv->xmit_lock);
> +
>  	/* Probe finished
>  	 * Stop clocks. They will be reactivated once the M_CAN device is ope=
ned
>  	 */
> +
>  	goto disable_cclk_ret;
> =20
>  failed_free_dev:
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aqKHuQIHOe21gc9CuEQMqTirSraW8onw7--

--75PLiJ7SkHT0wT61qQfL0ImBrHrSGGqlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljRPZ8ACgkQHv7KIOw4
HPafewf/euAdnk9tK/CZNxVySP2YkXsmR2R3cY12Jfca0Gy2MEtRVfUzahywXxHl
STZdOSc8Ic0hKOb4Tjp1Q+zjMzlDEe7ZXFMjPxRzltse0VSRwxDCznikJD1eONU4
XOg+x+ftCVQgTOTdpEcqW9zM4v0ktVokdavj+cX44+XUN7+xtcuUfWiqM0eJ2IIm
2MJ74L0B6r4WuHsUw/R9knY8QSSFzNutkHyMi7SgM2ITQAsP4030/1FnTyeBXdjs
Ah3H1QL11egMlZrGAYHyFi+29q92HKle228bUZcUc27+VMsxHIAn3Ljxs56hXWcs
uEkgzfhVG4nkcj/1zoL8M0xMmeY+9g==
=+lfK
-----END PGP SIGNATURE-----

--75PLiJ7SkHT0wT61qQfL0ImBrHrSGGqlP--
