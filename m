From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6/6] net: can: ifi: Add more detailed error reporting
Date: Sun, 8 May 2016 20:58:29 +0200
Message-ID: <572F8C55.5060007@pengutronix.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
 <1462660456-6179-6-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="awIxfTA7bP24bVwKb9Vj1GsFRjXU6NQ2D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47209 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859AbcEHS6i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 14:58:38 -0400
In-Reply-To: <1462660456-6179-6-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--awIxfTA7bP24bVwKb9Vj1GsFRjXU6NQ2D
Content-Type: multipart/mixed; boundary="PkOHIDDAsDIB6U3d1CrfshIocrx7wFSKv"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Message-ID: <572F8C55.5060007@pengutronix.de>
Subject: Re: [PATCH 6/6] net: can: ifi: Add more detailed error reporting
References: <1462660456-6179-1-git-send-email-marex@denx.de>
 <1462660456-6179-6-git-send-email-marex@denx.de>
In-Reply-To: <1462660456-6179-6-git-send-email-marex@denx.de>

--PkOHIDDAsDIB6U3d1CrfshIocrx7wFSKv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2016 12:34 AM, Marek Vasut wrote:
> The updated specification for the IFI CANFD core contains description
> of more detailed error reporting capability of the core. Implement
> support for this detailed error reporting.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
>  drivers/net/can/ifi_canfd/ifi_canfd.c | 109 ++++++++++++++++++++++++++=
++++++--
>  1 file changed, 105 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/if=
i_canfd/ifi_canfd.c
> index ba6cd43..495879f 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -52,7 +52,8 @@
>  #define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
> =20
>  #define IFI_CANFD_INTERRUPT			0xc
> -#define IFI_CANFD_INTERRUPT_ERROR_WARNING	((u32)BIT(1))
> +#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
> +#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
>  #define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
>  #define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
>  #define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
> @@ -103,7 +104,26 @@
> =20
>  #define IFI_CANFD_RES1				0x40
> =20
> -#define IFI_CANFD_RES2				0x44
> +#define IFI_CANFD_ERROR_CTR			0x44
> +#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0xff
> +#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
> +#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
> =20
>  #define IFI_CANFD_PAR				0x48
> =20
> @@ -197,6 +217,8 @@ static void ifi_canfd_irq_enable(struct net_device =
*ndev, bool enable)
>  	if (enable) {
>  		enirq =3D IFI_CANFD_IRQMASK_TXFIFO_EMPTY |
>  			IFI_CANFD_IRQMASK_RXFIFO_NEMPTY;
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +			enirq |=3D IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>  	}
> =20
>  	writel(IFI_CANFD_IRQMASK_SET_ERR |
> @@ -335,6 +357,68 @@ static int ifi_canfd_handle_lost_msg(struct net_de=
vice *ndev)
>  	return 1;
>  }
> =20
> +static int ifi_canfd_handle_lec_err(struct net_device *ndev, const u32=
 errctr)
> +{
> +	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	const u32 errmask =3D IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST |
> +			    IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST |
> +			    IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST |
> +			    IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST |
> +			    IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST |
> +			    IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST |
> +			    IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST;
> +
> +	if (!(errctr & errmask))	/* No error happened. */
> +		return 0;
> +
> +	priv->can.can_stats.bus_error++;
> +	stats->rx_errors++;
> +
> +	/* Propagate the error condition to the CAN stack. */
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (unlikely(!skb))
> +		return 0;
> +
> +	/* Read the error counter register and check for new errors. */
> +	cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
> +		cf->data[2] |=3D CAN_ERR_PROT_OVERLOAD;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT0;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT1;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +
> +	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +
> +	/* Reset the error counter, ack the IRQ and re-enable the counter. */=

> +	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR=
);
> +	writel(IFI_CANFD_INTERRUPT_ERROR_COUNTER,
> +	       priv->base + IFI_CANFD_INTERRUPT);
> +	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CT=
R);
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_receive_skb(skb);
> +
> +	return 1;
> +}
> +
>  static int ifi_canfd_get_berr_counter(const struct net_device *ndev,
>  				      struct can_berr_counter *bec)
>  {
> @@ -470,6 +554,7 @@ static int ifi_canfd_poll(struct napi_struct *napi,=
 int quota)
> =20
>  	u32 stcmd =3D readl(priv->base + IFI_CANFD_STCMD);
>  	u32 rxstcmd =3D readl(priv->base + IFI_CANFD_STCMD);
> +	u32 errctr =3D readl(priv->base + IFI_CANFD_ERROR_CTR);
> =20
>  	/* Handle bus state changes */
>  	if ((stcmd & stcmd_state_mask) ||
> @@ -480,6 +565,10 @@ static int ifi_canfd_poll(struct napi_struct *napi=
, int quota)
>  	if (rxstcmd & IFI_CANFD_RXSTCMD_OVERFLOW)
>  		work_done +=3D ifi_canfd_handle_lost_msg(ndev);
> =20
> +	/* Handle lec errors on the bus */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		work_done +=3D ifi_canfd_handle_lec_err(ndev, errctr);
> +
>  	/* Handle normal messages on RX */
>  	if (!(rxstcmd & IFI_CANFD_RXSTCMD_EMPTY))
>  		work_done +=3D ifi_canfd_do_rx_poll(ndev, quota - work_done);
> @@ -499,7 +588,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev=
_id)
>  	struct net_device_stats *stats =3D &ndev->stats;
>  	const u32 rx_irq_mask =3D IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY |
>  				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER |
> -				IFI_CANFD_INTERRUPT_ERROR_WARNING;
> +				IFI_CANFD_INTERRUPT_ERROR_WARNING |
> +				IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>  	const u32 tx_irq_mask =3D IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
>  				IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
>  	const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |

I'll fold this hunk to get rid of another of this warnings :(


>   CC [M]  drivers/net/can/ifi_canfd/ifi_canfd.o
> drivers/net/can/ifi_canfd/ifi_canfd.c: In function =E2=80=98ifi_canfd_i=
sr=E2=80=99:
> drivers/net/can/ifi_canfd/ifi_canfd.c:595:27: warning: large integer im=
plicitly truncated to unsigned type [-Woverflow]
>   const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |
>                            ^

> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/if=
i_canfd/ifi_canfd.c
> index 495879f30906..2d1d22eec750 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -592,8 +592,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev=
_id)
>                                 IFI_CANFD_INTERRUPT_ERROR_COUNTER;
>         const u32 tx_irq_mask =3D IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
>                                 IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
> -       const u32 clr_irq_mask =3D ~(IFI_CANFD_INTERRUPT_SET_IRQ |
> -                                  IFI_CANFD_INTERRUPT_ERROR_WARNING);
> +       const u32 clr_irq_mask =3D ~((u32)(IFI_CANFD_INTERRUPT_SET_IRQ =
|
> +                                        IFI_CANFD_INTERRUPT_ERROR_WARN=
ING));
>         u32 isr;
> =20
>         isr =3D readl(priv->base + IFI_CANFD_INTERRUPT);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PkOHIDDAsDIB6U3d1CrfshIocrx7wFSKv--

--awIxfTA7bP24bVwKb9Vj1GsFRjXU6NQ2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL4xWAAoJED07qiWsqSVqvAUIAIPU18jh6tD+s6vl7/xL4U6p
G8TJgbJI9RSz/I1Ko/9Fy0fWuhxHkG+92oGDQikAyxzAeralKIZUx9rHskpY46TZ
JK0QBnwxt5dK3Gr+FbA56Izb1AqeKJk2D24+p+1pppI8pm3gmyie8phkY4Hq2JNa
EWTPvhn3RVvZmw8Nqx4mfLe9FdNt50lpAYhKA+HkWkvaT1l5OvIjDyWvOh/p6tad
PSSAKmWzneV+k/Er+TWELL8cR1DQr3hgz8JufcK/uYo6R1QzNyMYMBTRXb9rKcIE
Gcdcz4eD3uklccA4HiFfz+1x0Irft0tRP7oWUJ4Jtob5sBNH4HyBRN6/RBIlZvU=
=Qnvo
-----END PGP SIGNATURE-----

--awIxfTA7bP24bVwKb9Vj1GsFRjXU6NQ2D--
