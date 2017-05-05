From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
Date: Fri, 5 May 2017 07:36:58 +0300
Message-ID: <20170505043658.nenftnwsiek4l2w4@mwanda>
References: <20170504114236.zx7ktyrwiktpkmjw@mwanda>
 <CAKT-o-c8yhPzsKk4UaM=9qG+9oW=yPdariZuV=BgkWUk4+cBDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21236 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdEEEhJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2017 00:37:09 -0400
Content-Disposition: inline
In-Reply-To: <CAKT-o-c8yhPzsKk4UaM=9qG+9oW=yPdariZuV=BgkWUk4+cBDg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?S2/FgsWCxIV0YWos?= Remigiusz <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

On Thu, May 04, 2017 at 04:46:58PM +0200, Kołłątaj, Remigiusz wrote:
> Hi Dan,
> 
> On 4 May 2017 at 13:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Remigiusz Kołłątaj,
> >
> > The patch 51f3baad7de9: "can: mcba_usb: Add support for Microchip CAN
> > BUS Analyzer" from Apr 14, 2017, leads to the following static
> > checker warning:
> >
> >         drivers/net/can/usb/mcba_usb.c:366 mcba_usb_start_xmit()
> >         error: 'usb_msg.dlc' from user is not capped properly
> >
> > drivers/net/can/usb/mcba_usb.c
> >    320  static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
> >    321                                         struct net_device *netdev)
> >    322  {
> >    323          struct mcba_priv *priv = netdev_priv(netdev);
> >    324          struct can_frame *cf = (struct can_frame *)skb->data;
> >                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Smatch distrusts skb->data.
> >
> >
> >    325          struct mcba_usb_ctx *ctx = NULL;
> >    326          struct net_device_stats *stats = &priv->netdev->stats;
> >    327          u16 sid;
> >    328          int err;
> >    329          struct mcba_usb_msg_can usb_msg = {
> >    330                  .cmd_id = MBCA_CMD_TRANSMIT_MESSAGE_EV
> >    331          };
> >    332
> >    333          if (can_dropped_invalid_skb(netdev, skb))
> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > We do actually cap cf->can_dlc here but it's limited to
> > CANFD_MAX_DLEN (64) on one path.  Also instead of calling it ->can_dlc
> > we call it "->len".  My devel versions of Smatch could have parsed this
> > if we had kept the types consistent.
> 
> The function looks as follows:
> 
> static inline bool can_dropped_invalid_skb(struct net_device *dev,
>  struct sk_buff *skb) {
> const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> if (skb->protocol == htons(ETH_P_CAN)) {
> if (unlikely(skb->len != CAN_MTU ||
>     cfd->len > CAN_MAX_DLEN))
> goto inval_skb;
> } else if (skb->protocol == htons(ETH_P_CANFD)) {
> if (unlikely(skb->len != CANFD_MTU ||
>     cfd->len > CANFD_MAX_DLEN))
> goto inval_skb;
> } else
> goto inval_skb;
> 
> MCBA supports normal frames only so it falls into ETH_P_CAN.

Where is the function my static checker can look at to verify this?

> Both DLC and SKB sizes are verified here. I understand that it may be
> difficult for static analyser...

The difficulty is because can_dropped_invalid_skb() treats skb->data as
a canfd_frame struct and mcba_usb_start_xmit() treats it as a can_frame.
The layouts happen to align, but the names are different.

> Maybe you could make all values coming from skb trustworthy after they
> are verified with can_dropped_invalid_skb()?

That's a trickier thing and it probably doesn't scale.

regards,
dan carpenter

