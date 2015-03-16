From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Mon, 16 Mar 2015 12:46:21 +0000
Message-ID: <20150316124621.14895.31220@shannon>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0099.outbound.protection.outlook.com ([157.55.234.99]:15552
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751732AbbCPNCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 09:02:10 -0400
In-Reply-To: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?utf-8?q?Thomas_K=C3=B6rper?= <thomas.koerper@esd.eu>

Quoting Thomas K=C3=B6rper (2015-03-16 12:15:13)
[...]
> +static void
> +handle_core_msg_errstatechange(struct acc_core *core,
> +                              const struct acc_bmmsg_errstatechange =
*msg)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +       struct net_device_stats *stats =3D &core->net_dev->stats;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +       int is_busoff;
> +       int is_passive;
> +       int is_warning;
> +       u8 txerr;
> +       u8 rxerr;
> +
> +       txerr =3D (u8)(msg->reg_status >> 8);
> +       rxerr =3D (u8)msg->reg_status;
> +       is_warning =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_=
ES) !=3D 0;
> +       is_passive =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_=
EP) !=3D 0;
> +       is_busoff =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_B=
S) !=3D 0;
> +
> +       skb =3D alloc_can_err_skb(core->net_dev, &cf);
> +       if (skb) {
> +               if (is_busoff) {
> +                       priv->can.state =3D CAN_STATE_BUS_OFF;
> +                       /* bus-offs counted by can_bus_off() */
> +                       cf->can_id |=3D CAN_ERR_BUSOFF;
> +               } else if (is_passive) {
> +                       priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
> +                       priv->can.can_stats.error_passive++;
> +                       cf->data[1] =3D (txerr > rxerr) ?
> +                                       CAN_ERR_CRTL_TX_PASSIVE :
> +                                       CAN_ERR_CRTL_RX_PASSIVE;
> +                       cf->can_id |=3D CAN_ERR_CRTL;
> +                       cf->data[6] =3D txerr;
> +                       cf->data[7] =3D rxerr;
> +               } else if (is_warning) {
> +                       priv->can.state =3D CAN_STATE_ERROR_WARNING;
> +                       priv->can.can_stats.error_warning++;
> +                       cf->data[1] =3D (txerr > rxerr) ?
> +                                       CAN_ERR_CRTL_TX_WARNING :
> +                                       CAN_ERR_CRTL_RX_WARNING;
> +                       cf->can_id |=3D CAN_ERR_CRTL;
> +                       cf->data[6] =3D txerr;
> +                       cf->data[7] =3D rxerr;
> +               } else {
> +                       priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +                       /* restarts counted in dev.c */
>
There is now a back-to-error-active message available for use, so you c=
an do
    cf->can_id =3D CAN_ERR_CRTL;
    cf->data[1] =3D CAN_ERROR_CRTL_ACTIVE.
However, you could shave off a few lines in this code by using
can_change_state().
>
> +               }
> +
> +               netif_rx(skb);
> +               stats->rx_packets++;
> +               stats->rx_bytes +=3D cf->can_dlc;
> +       }
> +
> +       if (is_busoff) {
> +               acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> +               can_bus_off(core->net_dev);
> +       }
> +}
> +
[...]

can_change_state() is now used in mscan, flexcan, sja1000, kvaser and p=
eak.
Those drivers should provide sufficent examples for you to learn how to=
 use the
function.

Best regards,
Andri Yngvason
