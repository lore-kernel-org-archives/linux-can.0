From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Tue, 23 Sep 2014 14:58:07 +0200
Message-ID: <54216E5F.2010804@pengutronix.de>
References: <1411048090-16837-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pabs0L7mW6Tnajpn50CeRlLPC3QjM67D0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56546 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbaIWM6P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Sep 2014 08:58:15 -0400
In-Reply-To: <1411048090-16837-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pabs0L7mW6Tnajpn50CeRlLPC3QjM67D0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2014 03:48 PM, David Jander wrote:
> The FlexCAN controller has a RX FIFO that is only 6 messages deep, and =
a
> mailbox space capable of holding up to 63 messages.
> This space was largely unused, limiting the permissible latency from
> interrupt to NAPI to only 6 messages. This patch uses all available MBs=

> for message reception and frees the MBs in the IRQ handler to greatly
> decrease the likelihood of receive overruns.
>=20
> Signed-off-by: David Jander <david@protonic.nl>

I think we can improve the algorithm a bit.

I see a problem when you receive 4 CAN frames:

0-1-2-3

then the irq handler starts, 0 gets processed and is empty (E)

E-1-2-3

while in the interrupt handler another two frames come in:

4-1-2-3-5

I suggest add a variable to the priv which indicates the next MB to read
from. Further, don't clear the mailbox direclty after it's been read,
wait until a certain amount of read mailboxes accumulate, .e.g. when the
rx_next point to 32. I have a work-in-progress code which to abstract
this algorithm, but it limited to 32 mailboxes. It should work on the
at91 but I don't know if it's flexible enought yet to work on the
flexcan, too.

more comments inline.

Marc

> ---
>=20
> changes since v3:
>  - rebased on flexcan-next branch of linux-can-next
>=20
>  drivers/net/can/flexcan.c | 299 ++++++++++++++++++++++++++++++++++----=
--------
>  1 file changed, 220 insertions(+), 79 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 172065c..2f71ac6 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2005-2006 Varma Electronics Oy
>   * Copyright (c) 2009 Sascha Hauer, Pengutronix
>   * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
> + * Copyright (c) 2014 David Jander, Protonic Holland
>   *
>   * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
>   *
> @@ -40,8 +41,8 @@
> =20
>  #define DRV_NAME			"flexcan"
> =20
> -/* 8 for RX fifo and 2 error handling */
> -#define FLEXCAN_NAPI_WEIGHT		(8 + 2)
> +/* 64 MB's */
> +#define FLEXCAN_NAPI_WEIGHT		(64)
> =20
>  /* FLEXCAN module configuration register (CANMCR) bits */
>  #define FLEXCAN_MCR_MDIS		BIT(31)
> @@ -113,6 +114,9 @@
>  #define FLEXCAN_MECR_ECCDIS		BIT(8)
>  #define FLEXCAN_MECR_NCEFAFRZ		BIT(7)
> =20
> +/* FLEXCAN control register 2 (CTRL2) bits */
> +#define FLEXCAN_CTRL2_EACEN		BIT(16)
> +
>  /* FLEXCAN error and status register (ESR) bits */
>  #define FLEXCAN_ESR_TWRN_INT		BIT(17)
>  #define FLEXCAN_ESR_RWRN_INT		BIT(16)
> @@ -147,18 +151,17 @@
> =20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */
> -#define FLEXCAN_TX_BUF_RESERVED		8
> -#define FLEXCAN_TX_BUF_ID		9
> +#define FLEXCAN_TX_BUF_RESERVED		0
> +#define FLEXCAN_TX_BUF_ID		1
>  #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
> -#define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
> -#define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
> -#define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
> -#define FLEXCAN_IFLAG_DEFAULT \
> -	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \=

> -	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
> +#define FLEXCAN_IFLAG1_DEFAULT 		(0xfffffffe)

Can you calculate the bit mask from the define FLEXCAN_TX_BUF_ID, so
that it's easier to upgrade the driver to make use of multiple TX mailbox=
es.

> +#define FLEXCAN_IFLAG2_DEFAULT 		(0xffffffff)
> =20
>  /* FLEXCAN message buffers */
> -#define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
> +#define FLEXCAN_MB_CODE_SHIFT		24
> +#define FLEXCAN_MB_CODE_MASK		(0xf << FLEXCAN_MB_CODE_SHIFT)
> +#define FLEXCAN_MB_CNT_CODE(x)		(((x) << FLEXCAN_MB_CODE_SHIFT) & \
> +						FLEXCAN_MB_CODE_MASK)

Can you make use of the newly defined FLEXCAN_MB_CODE_ below. I've
created an incremental patch. Patch will follow.

>  #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
>  #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
>  #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
> @@ -176,8 +179,6 @@
>  #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
>  #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
> =20
> -#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
> -
>  #define FLEXCAN_TIMEOUT_US             (50)
> =20
>  /*
> @@ -230,7 +231,9 @@ struct flexcan_regs {
>  	u32 rxfir;		/* 0x4c */
>  	u32 _reserved3[12];	/* 0x50 */
>  	struct flexcan_mb cantxfg[64];	/* 0x80 */
> -	u32 _reserved4[408];
> +	u32 _reserved4[256];	/* 0x480 */
> +	u32 rximr[64];		/* 0x880 */
> +	u32 _reserved5[88];	/* 0x980 */
>  	u32 mecr;		/* 0xae0 */
>  	u32 erriar;		/* 0xae4 */
>  	u32 erridpr;		/* 0xae8 */
> @@ -259,6 +262,9 @@ struct flexcan_priv {
>  	struct flexcan_platform_data *pdata;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct flexcan_mb cantxfg_copy[FLEXCAN_NAPI_WEIGHT];
> +	int second_first;

nitpick: bool?

> +	u32 rx_idx;

nitpick: unsigned int, as it's not a register

>  };
> =20
>  static struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
> @@ -688,16 +694,30 @@ static int flexcan_poll_state(struct net_device *=
dev, u32 reg_esr)
>  	return 1;
>  }
> =20
> -static void flexcan_read_fifo(const struct net_device *dev,
> -			      struct can_frame *cf)
> +static int flexcan_read_frame(struct net_device *dev, int n)
>  {
> -	const struct flexcan_priv *priv =3D netdev_priv(dev);
> -	struct flexcan_regs __iomem *regs =3D priv->base;
> -	struct flexcan_mb __iomem *mb =3D &regs->cantxfg[0];
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_mb *mb =3D &priv->cantxfg_copy[n];
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
>  	u32 reg_ctrl, reg_id;
> +	u32 code;
> =20
> -	reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> -	reg_id =3D flexcan_read(&mb->can_id);
> +	reg_ctrl =3D mb->can_ctrl;
> +	code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
> +
> +	/* is this MB empty? */
> +	if ((code !=3D 0x2) && (code !=3D 0x6))
> +		return 0;
> +
> +	skb =3D alloc_can_skb(dev, &cf);
> +	if (unlikely(!skb)) {
> +		stats->rx_dropped++;
> +		return 0;
> +	}
> +
> +	reg_id =3D mb->can_id;
>  	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
>  		cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
>  	else
> @@ -707,27 +727,9 @@ static void flexcan_read_fifo(const struct net_dev=
ice *dev,
>  		cf->can_id |=3D CAN_RTR_FLAG;
>  	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
> =20
> -	*(__be32 *)(cf->data + 0) =3D cpu_to_be32(flexcan_read(&mb->data[0]))=
;
> -	*(__be32 *)(cf->data + 4) =3D cpu_to_be32(flexcan_read(&mb->data[1]))=
;
> -
> -	/* mark as read */
> -	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> -	flexcan_read(&regs->timer);
> -}
> -
> -static int flexcan_read_frame(struct net_device *dev)
> -{
> -	struct net_device_stats *stats =3D &dev->stats;
> -	struct can_frame *cf;
> -	struct sk_buff *skb;
> -
> -	skb =3D alloc_can_skb(dev, &cf);
> -	if (unlikely(!skb)) {
> -		stats->rx_dropped++;
> -		return 0;
> -	}
> +	*(__be32 *)(cf->data + 0) =3D cpu_to_be32(mb->data[0]);
> +	*(__be32 *)(cf->data + 4) =3D cpu_to_be32(mb->data[1]);
> =20
> -	flexcan_read_fifo(dev, cf);
>  	netif_receive_skb(skb);
> =20
>  	stats->rx_packets++;
> @@ -741,10 +743,16 @@ static int flexcan_read_frame(struct net_device *=
dev)
>  static int flexcan_poll(struct napi_struct *napi, int quota)
>  {
>  	struct net_device *dev =3D napi->dev;
> -	const struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->base;
> -	u32 reg_iflag1, reg_esr;
> +	u32 reg_esr;
>  	int work_done =3D 0;
> +	int n;
> +	int ret;
> +
> +	/* disable RX IRQs */
> +	flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->imask1);
> +	flexcan_write(0, &regs->imask2);

Please use defines here. BTW: the RX IRQ has to disabled in the IRQ handl=
er.

> =20
>  	/*
>  	 * The error bits are cleared on read,
> @@ -755,12 +763,13 @@ static int flexcan_poll(struct napi_struct *napi,=
 int quota)
>  	/* handle state changes */
>  	work_done +=3D flexcan_poll_state(dev, reg_esr);
> =20
> -	/* handle RX-FIFO */
> -	reg_iflag1 =3D flexcan_read(&regs->iflag1);
> -	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
> -	       work_done < quota) {
> -		work_done +=3D flexcan_read_frame(dev);
> -		reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +	/* handle mailboxes */
> +	for (n =3D 0; (n < ARRAY_SIZE(priv->cantxfg_copy)) &&
> +			(work_done < quota); n++) {
> +		ret =3D flexcan_read_frame(dev, n);
> +		if (!ret)
> +			break;
> +		work_done +=3D ret;
>  	}
> =20
>  	/* report bus errors */
> @@ -769,24 +778,157 @@ static int flexcan_poll(struct napi_struct *napi=
, int quota)
> =20
>  	if (work_done < quota) {
>  		napi_complete(napi);
> -		/* enable IRQs */
> -		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> -		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> +		priv->rx_idx =3D 0;
> +
> +		/* enable RX IRQs */
> +		flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
> +		flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
>  	}
> =20
>  	return work_done;
>  }
> =20
> +static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	struct flexcan_mb __iomem *mb;
> +	struct flexcan_mb *dst;
> +	u32 reg_ctrl;
> +	u32 code;
> +
> +	mb =3D &regs->cantxfg[i];
> +	dst =3D &priv->cantxfg_copy[priv->rx_idx];
> +	reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> +	code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
> +
> +	while (code & 1) {
> +		/* MB busy, shouldn't take long */
> +		reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> +		code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;=

> +	}
> +
> +	/* Copy contents */
> +	dst->can_ctrl =3D reg_ctrl;
> +	dst->can_id =3D flexcan_read(&mb->can_id);
> +	dst->data[0] =3D flexcan_read(&mb->data[0]);
> +	dst->data[1] =3D flexcan_read(&mb->data[1]);
> +
> +	/* If it's FULL or OVERRUN, clear the interrupt flag and lock MB */
> +	if ((code =3D=3D 0x2) || (code =3D=3D 0x6)) {
> +		if (i < 32)
> +			flexcan_write(BIT(i), &regs->iflag1);
> +		else
> +			flexcan_write(BIT(i - 32), &regs->iflag2);

what about chaging the regs struct? Make it an ifalgs[2] array and you
can use the 5th bit as the array index.

> +		flexcan_write(FLEXCAN_MB_CNT_CODE(0x0), &mb->can_ctrl);
> +		if ((code =3D=3D 0x6) || (priv->rx_idx =3D=3D
> +				(ARRAY_SIZE(priv->cantxfg_copy) - 1))) {
> +			/* This MB was overrun, we lost data */
> +			priv->dev->stats.rx_over_errors++;
> +			priv->dev->stats.rx_errors++;
> +		}
> +		if (priv->rx_idx < (ARRAY_SIZE(priv->cantxfg_copy) - 1))
> +			priv->rx_idx++;

Can you move the overflow handling into the poll handler

> +	}
> +
> +	return code;
> +}
> +
> +static void flexcan_unlock_if_locked(struct flexcan_priv *priv, int i)=


What about calling it call it flexcan_mb_unlock(), the if locked is an
optimisation :)

> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	struct flexcan_mb __iomem *mb;
> +	u32 reg_ctrl;
> +	u32 code;
> +
> +	mb =3D &regs->cantxfg[i];
> +	reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> +	code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
> +	if (!code)
> +		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4), &mb->can_ctrl);
> +}
> +
> +/*
> + * flexcan_copy_rxmbs
> + *
> + * This function is called from interrupt and needs to make a safe cop=
y
> + * of the MB area to offload the chip immediately to avoid loosing
> + * messages due to latency.
> + * To avoid loosing messages due to race-conditions while reading the =
MB's,
> + * we need to make use of the locking mechanism of FlexCAN. Unfortunat=
ely,
> + * in this mode, automatic locking applies _only_ to MBs that are _not=
_ EMPTY.
> + * This means we could identify a MB as EMPTY while it is about to get=
 filled.
> + * To avoid this situation from disturbing our queue ordering, we do t=
he
> + * following:
> + * We split the MB area into two halves:
> + * The lower 32 (-2 due to one TX-MB and errata ERR005829) and the upp=
er 32.
> + * We start with all MBs in EMPTY state and all filters disabled (don'=
t care).
> + * FlexCAN will start filling from the lowest MB. Once this function i=
s called,
> + * we copy and disable in an atomic operation all FULL MBs. The first =
EMPTY one
> + * we encounter may be about to get filled so we stop there. Next time=
 FlexCAN
> + * will have filled more MBs. Once there are no EMPTY MBs in the lower=
 half, we
> + * EMPTY all FULL or locked MBs again.
> + * Next time we have the following situation:
> + * If there is a FULL MB in the upper half, it is because it was about=
 to get
> + * filled when we scanned last time, or got filled just before emptyin=
g the
> + * lowest MB, so this will be the first MB we need to copy now. If the=
re are
> + * no EMPTY MBs in the lower half at this time, it means we cannot gua=
rantee
> + * ordering anymore. It also means latency exceeded 30 messages.
> + */

I'm not sure

> +static void flexcan_copy_rxmbs(struct flexcan_priv *priv, u32 iflag1, =
u32 iflag2)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	int i;
> +
> +	if (priv->second_first) {
> +		/* Begin with second half */
> +		for(i =3D 32; i < 64; i++) {
> +			flexcan_copy_one_rxmb(priv, i);
> +			flexcan_unlock_if_locked(priv, i);
> +		}
> +	}
> +
> +	/* Copy and disable FULL MBs */
> +	for(i =3D 1; i < 64; i++) {
> +		if (i =3D=3D FLEXCAN_TX_BUF_ID)
> +			continue;
> +		if (flexcan_copy_one_rxmb(priv, i) =3D=3D 0x4)

Typical linux coding style is to avoid the evaluation of a function's
return value directly in an if().

ret =3D foo();
if (ret) {
}

> +			break;
> +	}
> +
> +	if ((i >=3D 32) && priv->second_first)
> +		netdev_warn(priv->dev, "RX order cannot be guaranteed. count=3D%d\n"=
, i);
> +
> +	priv->second_first =3D 0;
> +
> +	/* No EMPTY MB in first half? */
> +	if (i >=3D 32) {
> +		/* Re-enable all disabled MBs */
> +		for(i =3D 1; i < 64; i++) {
> +			if (i =3D=3D FLEXCAN_TX_BUF_ID)
> +				continue;

Please start your loop at a sensible value to avoid checking for
FLEXCAN_TX_BUF_ID.

> +			flexcan_unlock_if_locked(priv, i);
> +		}
> +
> +		/* Next time we need to check the second half first */
> +		priv->second_first =3D 1;
> +	}
> +
> +	/* Unlock the last locked MB if any */
> +	flexcan_read(&regs->timer);
> +}
> +
>  static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  {
>  	struct net_device *dev =3D dev_id;
>  	struct net_device_stats *stats =3D &dev->stats;
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->base;
> -	u32 reg_iflag1, reg_esr;
> +	u32 reg_iflag1, reg_iflag2, reg_esr;
> =20
>  	reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +	reg_iflag2 =3D flexcan_read(&regs->iflag2);
>  	reg_esr =3D flexcan_read(&regs->esr);
> +
>  	/* ACK all bus error and state change IRQ sources */
>  	if (reg_esr & FLEXCAN_ESR_ALL_INT)
>  		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> @@ -797,7 +939,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	 * - state change IRQ
>  	 * - bus error IRQ and bus error reporting is activated
>  	 */
> -	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> +	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2 ||
>  	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>  	    flexcan_has_and_handle_berr(priv, reg_esr)) {
>  		/*
> @@ -805,20 +947,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>  		 * save them for later use.
>  		 */
>  		priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
> -		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
> -			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);

You have to disable all RX irqs here.

> -		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> -		       &regs->ctrl);
> +		flexcan_copy_rxmbs(priv, reg_iflag1, reg_iflag2);
>  		napi_schedule(&priv->napi);
>  	}
> =20
> -	/* FIFO overflow */
> -	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
> -		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
> -		dev->stats.rx_over_errors++;
> -		dev->stats.rx_errors++;
> -	}
> -
>  	/* transmission complete interrupt */
>  	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
>  		stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
> @@ -911,11 +1043,11 @@ static int flexcan_chip_start(struct net_device =
*dev)
>  	 *
>  	 */
>  	reg_mcr =3D flexcan_read(&regs->mcr);
> -	reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
> -	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
> +	reg_mcr &=3D ~(FLEXCAN_MCR_MAXMB(0xff) | FLEXCAN_MCR_FEN);
> +	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
>  		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
>  		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
> -		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
> +		FLEXCAN_MCR_BCC | FLEXCAN_MCR_MAXMB(0x3f);

Please create a define for this.

>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>  	flexcan_write(reg_mcr, &regs->mcr);
> =20
> @@ -951,28 +1083,36 @@ static int flexcan_chip_start(struct net_device =
*dev)
>  	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
>  	flexcan_write(reg_ctrl, &regs->ctrl);
> =20
> -	/* clear and invalidate all mailboxes first */
> -	for (i =3D FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
> -		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
> +	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
> +		/* CTRL2: Enable EACEN */
> +		reg_crl2 =3D flexcan_read(&regs->crl2);
> +		reg_crl2 |=3D FLEXCAN_CTRL2_EACEN;
> +		flexcan_write(reg_crl2, &regs->crl2);
> +	}
> +
> +	/* Prepare mailboxes. Skip the first, use one for TX the rest for RX =
*/
> +	for (i =3D 1; i < ARRAY_SIZE(regs->cantxfg); i++) {
> +		if (i =3D=3D FLEXCAN_TX_BUF_ID)
> +			flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
> +				&regs->cantxfg[i].can_ctrl);
Please use sensible values for the array to start, move the TX mailbox
initialization out of this loop.
> +		else
> +			flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
>  			      &regs->cantxfg[i].can_ctrl);
> +		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
>  	}
> =20
>  	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
>  	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
> =20
> -	/* mark TX mailbox as INACTIVE */
> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> -		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> +	priv->second_first =3D 0;
> +	priv->rx_idx =3D 0;
> =20
>  	/* acceptance mask/acceptance code (accept everything) */
>  	flexcan_write(0x0, &regs->rxgmask);
>  	flexcan_write(0x0, &regs->rx14mask);
>  	flexcan_write(0x0, &regs->rx15mask);
> =20
> -	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
> -		flexcan_write(0x0, &regs->rxfgmask);
> -

This is only fifo related, right?

>  	/*
>  	 * On Vybrid, disable memory error detection interrupts
>  	 * and freeze mode.
> @@ -1009,8 +1149,9 @@ static int flexcan_chip_start(struct net_device *=
dev)
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> =20
> -	/* enable FIFO interrupts */
> -	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> +	/* enable all MB interrupts */
> +	flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
> +	flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
> =20
>  	/* print chip status */
>  	netdev_dbg(dev, "%s: reading mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,=

>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pabs0L7mW6Tnajpn50CeRlLPC3QjM67D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQhbl8ACgkQjTAFq1RaXHPODwCgmT1wNBPMXTeGs8JeMpIiuSa2
940AoJIMOjKPMJjnYcFcnYA8cj+Lq7bi
=pcS8
-----END PGP SIGNATURE-----

--pabs0L7mW6Tnajpn50CeRlLPC3QjM67D0--
