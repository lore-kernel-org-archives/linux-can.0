From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [bug report] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Thu, 4 May 2017 16:46:58 +0200
Message-ID: <CAKT-o-c8yhPzsKk4UaM=9qG+9oW=yPdariZuV=BgkWUk4+cBDg@mail.gmail.com>
References: <20170504114236.zx7ktyrwiktpkmjw@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35383 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdEDOrU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2017 10:47:20 -0400
Received: by mail-vk0-f45.google.com with SMTP id v20so9046382vke.2
        for <linux-can@vger.kernel.org>; Thu, 04 May 2017 07:47:19 -0700 (PDT)
In-Reply-To: <20170504114236.zx7ktyrwiktpkmjw@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org

Hi Dan,

On 4 May 2017 at 13:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Remigiusz Ko=C5=82=C5=82=C4=85taj,
>
> The patch 51f3baad7de9: "can: mcba_usb: Add support for Microchip CAN
> BUS Analyzer" from Apr 14, 2017, leads to the following static
> checker warning:
>
>         drivers/net/can/usb/mcba_usb.c:366 mcba_usb_start_xmit()
>         error: 'usb_msg.dlc' from user is not capped properly
>
> drivers/net/can/usb/mcba_usb.c
>    320  static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
>    321                                         struct net_device *netdev)
>    322  {
>    323          struct mcba_priv *priv =3D netdev_priv(netdev);
>    324          struct can_frame *cf =3D (struct can_frame *)skb->data;
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Smatch distrusts skb->data.
>
>
>    325          struct mcba_usb_ctx *ctx =3D NULL;
>    326          struct net_device_stats *stats =3D &priv->netdev->stats;
>    327          u16 sid;
>    328          int err;
>    329          struct mcba_usb_msg_can usb_msg =3D {
>    330                  .cmd_id =3D MBCA_CMD_TRANSMIT_MESSAGE_EV
>    331          };
>    332
>    333          if (can_dropped_invalid_skb(netdev, skb))
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We do actually cap cf->can_dlc here but it's limited to
> CANFD_MAX_DLEN (64) on one path.  Also instead of calling it ->can_dlc
> we call it "->len".  My devel versions of Smatch could have parsed this
> if we had kept the types consistent.

The function looks as follows:

static inline bool can_dropped_invalid_skb(struct net_device *dev,
 struct sk_buff *skb) {
const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
if (unlikely(skb->len !=3D CAN_MTU ||
    cfd->len > CAN_MAX_DLEN))
goto inval_skb;
} else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
if (unlikely(skb->len !=3D CANFD_MTU ||
    cfd->len > CANFD_MAX_DLEN))
goto inval_skb;
} else
goto inval_skb;

MCBA supports normal frames only so it falls into ETH_P_CAN. Both DLC
and SKB sizes are verified here. I understand that it may be difficult
for static analyser... Maybe you could make all values coming from skb
trustworthy after they are verified with can_dropped_invalid_skb()?

>
>    334                  return NETDEV_TX_OK;
>    335
>    336          ctx =3D mcba_usb_get_free_ctx(priv, cf);
>    337          if (!ctx)
>    338                  return NETDEV_TX_BUSY;
>    339
>    340          can_put_echo_skb(skb, priv->netdev, ctx->ndx);
>    341
>    342          if (cf->can_id & CAN_EFF_FLAG) {
>    343                  /* SIDH    | SIDL                 | EIDH   | EIDL
>    344                   * 28 - 21 | 20 19 18 x x x 17 16 | 15 - 8 | 7 - =
0
>    345                   */
>    346                  sid =3D MCBA_SIDL_EXID_MASK;
>    347                  /* store 28-18 bits */
>    348                  sid |=3D (cf->can_id & 0x1ffc0000) >> 13;
>    349                  /* store 17-16 bits */
>    350                  sid |=3D (cf->can_id & 0x30000) >> 16;
>    351                  put_unaligned_be16(sid, &usb_msg.sid);
>    352
>    353                  /* store 15-0 bits */
>    354                  put_unaligned_be16(cf->can_id & 0xffff, &usb_msg.=
eid);
>    355          } else {
>    356                  /* SIDH   | SIDL
>    357                   * 10 - 3 | 2 1 0 x x x x x
>    358                   */
>    359                  put_unaligned_be16((cf->can_id & CAN_SFF_MASK) <<=
 5,
>    360                                     &usb_msg.sid);
>    361                  usb_msg.eid =3D 0;
>    362          }
>    363
>    364          usb_msg.dlc =3D cf->can_dlc;
>    365
>    366          memcpy(usb_msg.data, cf->data, usb_msg.dlc);
>                        ^^^^^^^^^^^^
> This only has room for 8 bytes, so 64 might be a buffer overflow?
>

thanks can_dropped_invalid_skb() cf->can_dlc is guaranteed to be <=3D 8.


> regards,
> dan carpenter

Regards,
Remik



--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
