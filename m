From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [bug report] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Fri, 5 May 2017 08:23:23 +0200
Message-ID: <CAKT-o-edEXX=AOtX_JZk8ox0RwZYSA2bDiOAuxsfE9GjvtDhmw@mail.gmail.com>
References: <20170504114236.zx7ktyrwiktpkmjw@mwanda> <CAKT-o-c8yhPzsKk4UaM=9qG+9oW=yPdariZuV=BgkWUk4+cBDg@mail.gmail.com>
 <20170505043658.nenftnwsiek4l2w4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34129 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755774AbdEEGXp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2017 02:23:45 -0400
Received: by mail-ua0-f178.google.com with SMTP id g49so22964205uaa.1
        for <linux-can@vger.kernel.org>; Thu, 04 May 2017 23:23:44 -0700 (PDT)
In-Reply-To: <20170505043658.nenftnwsiek4l2w4@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org

On 5 May 2017 at 06:36, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, May 04, 2017 at 04:46:58PM +0200, Ko=C5=82=C5=82=C4=85taj, Remigi=
usz wrote:
>> Hi Dan,
>>
>> On 4 May 2017 at 13:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> >
>> > Hello Remigiusz Ko=C5=82=C5=82=C4=85taj,
>> >
>> > The patch 51f3baad7de9: "can: mcba_usb: Add support for Microchip CAN
>> > BUS Analyzer" from Apr 14, 2017, leads to the following static
>> > checker warning:
>> >
>> >         drivers/net/can/usb/mcba_usb.c:366 mcba_usb_start_xmit()
>> >         error: 'usb_msg.dlc' from user is not capped properly
>> >
>> > drivers/net/can/usb/mcba_usb.c
>> >    320  static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
>> >    321                                         struct net_device *netd=
ev)
>> >    322  {
>> >    323          struct mcba_priv *priv =3D netdev_priv(netdev);
>> >    324          struct can_frame *cf =3D (struct can_frame *)skb->data=
;
>> >                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > Smatch distrusts skb->data.
>> >
>> >
>> >    325          struct mcba_usb_ctx *ctx =3D NULL;
>> >    326          struct net_device_stats *stats =3D &priv->netdev->stat=
s;
>> >    327          u16 sid;
>> >    328          int err;
>> >    329          struct mcba_usb_msg_can usb_msg =3D {
>> >    330                  .cmd_id =3D MBCA_CMD_TRANSMIT_MESSAGE_EV
>> >    331          };
>> >    332
>> >    333          if (can_dropped_invalid_skb(netdev, skb))
>> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > We do actually cap cf->can_dlc here but it's limited to
>> > CANFD_MAX_DLEN (64) on one path.  Also instead of calling it ->can_dlc
>> > we call it "->len".  My devel versions of Smatch could have parsed thi=
s
>> > if we had kept the types consistent.
>>
>> The function looks as follows:
>>
>> static inline bool can_dropped_invalid_skb(struct net_device *dev,
>>  struct sk_buff *skb) {
>> const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>> if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
>> if (unlikely(skb->len !=3D CAN_MTU ||
>>     cfd->len > CAN_MAX_DLEN))
>> goto inval_skb;
>> } else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
>> if (unlikely(skb->len !=3D CANFD_MTU ||
>>     cfd->len > CANFD_MAX_DLEN))
>> goto inval_skb;
>> } else
>> goto inval_skb;
>>
>> MCBA supports normal frames only so it falls into ETH_P_CAN.
>
> Where is the function my static checker can look at to verify this?

For CANFD devices you need to have ctrlmode set to CAN_CTRLMODE_FD.

>
>> Both DLC and SKB sizes are verified here. I understand that it may be
>> difficult for static analyser...
>
> The difficulty is because can_dropped_invalid_skb() treats skb->data as
> a canfd_frame struct and mcba_usb_start_xmit() treats it as a can_frame.
> The layouts happen to align, but the names are different.

The names differs because there is a difference in DLC (data length
code) for CAN and CANFD. For normal CAN payload length matches dlc.
For CAN FD it does not. Take a look at explanation here:
https://www.can-cia.org/can-knowledge/can/can-fd/

>
>> Maybe you could make all values coming from skb trustworthy after they
>> are verified with can_dropped_invalid_skb()?
>
> That's a trickier thing and it probably doesn't scale.
>
> regards,
> dan carpenter
>

Regards,
Remik


--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
