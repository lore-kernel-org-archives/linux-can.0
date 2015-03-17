From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: AW: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 10:33:59 +0000
Message-ID: <20150317103359.11690.3930@shannon>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
 <20150316124621.14895.31220@shannon>
 <8CE1D0B9BFD2404DA079DDE1814A6F2E03294EFD39B3@esd-s3.esd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0085.outbound.protection.outlook.com ([157.55.234.85]:45856
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932143AbbCQKty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 06:49:54 -0400
In-Reply-To: <8CE1D0B9BFD2404DA079DDE1814A6F2E03294EFD39B3@esd-s3.esd.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?q?Thomas_K=C3=B6rper?= <Thomas.Koerper@esd.eu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Thomas,

Quoting Thomas K=C3=B6rper (2015-03-17 06:30:02)
> Hi Andri,
>=20
> I've looked at the sources you mentioned, but I'm a little bit unsure=
 now /
> the handling seems not perfectly consistent to me. (flexcan calls
> can_change_state() with tx/rx_state of 0 in the bus off path. Only
That's an oversight on my part.

> kvaser_usb counts rx_dropped++ if skb alloc failed, and setting=20
Yes, Darwish is very diligent in handling OOM.

> cf->data[6]/cf->data[7] to the counter values seems also rarely used)
Some chips don't expose the error counters.

>=20
> ...so let me show the reworked function first before I post a new pat=
ch:
>=20
> static void
> handle_core_msg_errstatechange(struct acc_core *core,
>                                const struct acc_bmmsg_errstatechange =
*msg)
> {
>         struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
>         struct net_device_stats *stats =3D &core->net_dev->stats;
>         struct can_frame *cf;
>         struct sk_buff *skb;
>=20
>         skb =3D alloc_can_err_skb(core->net_dev, &cf);
>         if (skb) {
>                 enum can_state new_state;
>                 u8 txerr;
>                 u8 rxerr;
>=20
>                 txerr =3D (u8)(msg->reg_status >> 8);
>                 rxerr =3D (u8)msg->reg_status;
>=20
>                 cf->data[6] =3D txerr;
>                 cf->data[7] =3D rxerr;
>=20
>                 if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_BS) =
{
>                         new_state =3D CAN_STATE_BUS_OFF;
>                 } else if (msg->reg_status & ACC_REG_STATUS_MASK_STAT=
US_EP) {
>                         new_state =3D CAN_STATE_ERROR_PASSIVE;
>                 } else if (msg->reg_status & ACC_REG_STATUS_MASK_STAT=
US_ES) {
>                         new_state =3D CAN_STATE_ERROR_WARNING;
>                 } else {
>                         new_state =3D CAN_STATE_ERROR_ACTIVE;
>                 }
>=20
>                 if (new_state !=3D priv->can.state) {
>                         enum can_state tx_state, rx_state;
>=20
>                         tx_state =3D (txerr >=3D rxerr) ? new_state :=
 0;
>                         rx_state =3D (rxerr >=3D txerr) ? new_state :=
 0;
>=20
>                         can_change_state(core->net_dev, cf, tx_state,=
 rx_state);
>                 }
>=20
>                 netif_rx(skb);
>                 stats->rx_packets++;
>                 stats->rx_bytes +=3D cf->can_dlc;
>         } else {
>                 stats->rx_dropped++;
>         }
>=20
>         if (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_BS) {
>                 acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
>                 can_bus_off(core->net_dev);
>         }
> }
>=20

Looks good!

Best regards,
Andri
