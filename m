From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: flexcan: patch
Date: Fri, 6 May 2016 12:26:17 +0200
Message-ID: <572C7149.6040307@pengutronix.de>
References: <14855451462460611@web29h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JsVTTW2eKILnQfxDg96ulibQBcaF7dNF8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34576 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757987AbcEFK0b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 May 2016 06:26:31 -0400
In-Reply-To: <14855451462460611@web29h.yandex.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mikhail Kofanov <c5r@yandex.ru>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JsVTTW2eKILnQfxDg96ulibQBcaF7dNF8
Content-Type: multipart/mixed; boundary="gdmEMNSn9Ckfr13ehfFBDfNdAWVe4eDoI"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mikhail Kofanov <c5r@yandex.ru>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <572C7149.6040307@pengutronix.de>
Subject: Re: can: flexcan: patch
References: <14855451462460611@web29h.yandex.ru>
In-Reply-To: <14855451462460611@web29h.yandex.ru>

--gdmEMNSn9Ckfr13ehfFBDfNdAWVe4eDoI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2016 05:03 PM, Mikhail Kofanov wrote:
> Hello!
>=20
> There is small patch for imx flexcan driver.
> 1. Improve state change handling
> 2. add tx/rx error counter to state change error frame
>=20
> Tested on imx25 based custom board.

Against which kernel version does this patch apply?

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e2d7ded..84d1fd8 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -581,11 +581,14 @@ static int flexcan_poll_state(struct net_device *=
dev, u32 reg_esr)
>         struct flexcan_priv *priv =3D netdev_priv(dev);
>         struct sk_buff *skb;
>         struct can_frame *cf;
> +       struct flexcan_regs __iomem *regs =3D priv->regs;
>         enum can_state new_state =3D 0, rx_state =3D 0, tx_state =3D 0;=

>         int flt;
>         struct can_berr_counter bec;
> =20
>         flt =3D reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
> +       /* always send error counters in error frame */
> +       __flexcan_get_berr_counter(dev, &bec);
>         if (likely(flt =3D=3D FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
>                 tx_state =3D unlikely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
>                         CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIV=
E;
> @@ -593,7 +596,6 @@ static int flexcan_poll_state(struct net_device *de=
v, u32 reg_esr)
>                         CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIV=
E;
>                 new_state =3D max(tx_state, rx_state);
>         } else {
> -               __flexcan_get_berr_counter(dev, &bec);
>                 new_state =3D flt =3D=3D FLEXCAN_ESR_FLT_CONF_PASSIVE ?=

>                         CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
>                 rx_state =3D bec.rxerr >=3D bec.txerr ? new_state : 0;
> @@ -603,6 +605,8 @@ static int flexcan_poll_state(struct net_device *de=
v, u32 reg_esr)
>         /* state hasn't changed */
>         if (likely(new_state =3D=3D priv->can.state))
>                 return 0;
> +       netdev_dbg(dev, "reg_esr=3D0x%x flt=3D0x%x ctrl=3D0x%08x new_st=
ate=3D%d\n", reg_esr, flt, flex
> +                        new_state);
> =20
>         skb =3D alloc_can_err_skb(dev, &cf);
>         if (unlikely(!skb))
> @@ -613,6 +617,8 @@ static int flexcan_poll_state(struct net_device *de=
v, u32 reg_esr)
>         if (unlikely(new_state =3D=3D CAN_STATE_BUS_OFF))
>                 can_bus_off(dev);
> =20
> +       cf->data[6] =3D bec.txerr;
> +       cf->data[7] =3D bec.rxerr;
>         dev->stats.rx_packets++;
>         dev->stats.rx_bytes +=3D cf->can_dlc;
>         netif_receive_skb(skb);
> @@ -679,7 +685,7 @@ static int flexcan_poll(struct napi_struct *napi, i=
nt quota)
>         /* The error bits are cleared on read,
>          * use saved value from irq handler.
>          */
> -       reg_esr =3D flexcan_read(&regs->esr) | priv->reg_esr;
> +       reg_esr =3D flexcan_read(&regs->esr) | (priv->reg_esr & FLEXCAN=
_ESR_ERR_BUS);
> =20
>         /* handle state changes */
>         work_done +=3D flexcan_poll_state(dev, reg_esr);
> @@ -721,24 +727,29 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>         if (reg_esr & FLEXCAN_ESR_ALL_INT)
>                 flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr=
);
> =20
> +
>         /* schedule NAPI in case of:
>          * - rx IRQ
> -        * - state change IRQ
> +        * - tx/rx warning or bus-off
> +        * - any state change
>          * - bus error IRQ and bus error reporting is activated
>          */
>         if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
>             (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +           ((reg_esr & FLEXCAN_ESR_FLT_CONF_MASK) !=3D (priv->reg_esr =
& FLEXCAN_ESR_FLT_CONF_MAS

There seems to be a problem with this mail, the rest of this line is
missing.

Marc

>             flexcan_has_and_handle_berr(priv, reg_esr)) {
>                 /* The error bits are cleared on read,
>                  * save them for later use.
>                  */
> -               priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
> +               priv->reg_esr =3D reg_esr;
>                 flexcan_write(FLEXCAN_IFLAG_DEFAULT &
>                               ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->=
imask1);
>                 flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ER=
R_ALL,
>                               &regs->ctrl);
>                 napi_schedule(&priv->napi);
>         }
> +       else
> +               priv->reg_esr =3D reg_esr;
> =20
>         /* FIFO overflow */
>         if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gdmEMNSn9Ckfr13ehfFBDfNdAWVe4eDoI--

--JsVTTW2eKILnQfxDg96ulibQBcaF7dNF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXLHFMAAoJED07qiWsqSVq7eIH/3fBPuudufaT2nWxprAGTcRb
nX6b6FL24psvaR5IFDIBvMJnGyl+NMjduiijLZKWi88Nzpuoz2SCcnkQl7W+Dr/i
Ltk+6bww+Njg8A35fuvkZ/Yz8rQL4C9pyyAn/0o0QMeqOIBZhswnGd1GGXV4q/ZM
wjeW8Vua05lp0GTXu+oSc4EtJZ9J+vOVfYHAelBir4ur5LaqBhdlmjKFXzdn/o/I
Ggun0FS1wDK33fz1jr1pPSDxWcIarA9NndNgwRXOG/L2gzd7XJmIIjGzCtXRLyn8
WBO0MnLAjVEEmDYpp4Qo9XEOKH0RDWNGWkWrTs2Q/RQnICokMF0RipKW9fBZYsk=
=b+vb
-----END PGP SIGNATURE-----

--JsVTTW2eKILnQfxDg96ulibQBcaF7dNF8--
