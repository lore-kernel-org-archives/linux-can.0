From: Olivier Sobrie <olivier.sobrie@gmail.com>
Subject: Re: Patch for kvaser_usb
Date: Fri, 26 Apr 2013 22:51:50 +0200
Message-ID: <20130426205150.GA28450@thinkoso.home>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
Reply-To: Olivier Sobrie <olivier.sobrie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55440 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab3DZUvz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 16:51:55 -0400
Received: by mail-wi0-f174.google.com with SMTP id m6so1047259wiv.13
        for <linux-can@vger.kernel.org>; Fri, 26 Apr 2013 13:51:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jonas Peterson <jonas.peterson@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

Hello Jonas,

On Fri, Apr 26, 2013 at 06:35:26PM +0200, Jonas Peterson wrote:
> Sorry for the sparse information, will get back efter the week-end
> with firmware information. Should be "latest by Dec 2012".
> 
> Yes, please add the signed-off-by.

Thank you for the patch, I'll check it next week with my devices (Leaf
Light and USBcan R).

Have a nice week-end,

Olivier

> 
> Jonas
> 
> On Fri, Apr 26, 2013 at 5:00 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > Hello Jonas,
> >
> > adding Olivier Sobrie, the author of the driver to the loop.
> >
> > On 04/26/2013 04:50 PM, Jonas Peterson wrote:
> >> I've tried the kvaser_usb driver with my Kvaser USBcan Pro and no can
> >> frames are properly received. It seems like they are all flagged as
> >> log messages. I patched the driver and have used it for a while now.
> >> Feel free to use it as you please.
> >
> > Thanks for your feedback. Which firmware version of the Kvaser USBcan
> > Pro are you using?
> >
> > Can I add a Signed-off-by[1] to your patch?
> >
> > Marc
> >
> > [1]
> > http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298
> >>
> >> Best regards,
> >> Jonas Peterson
> >>
> >> --- /drivers/net/can/usb/kvaser_usb.c 2013-04-26 16:20:19.748994249 +0200
> >> +++ kvaser_usb.c 2012-12-14 15:59:10.017829818 +0100
> >> @@ -858,6 +858,62 @@
> >>   stats->rx_bytes += cf->can_dlc;
> >>  }
> >>
> >> +static void kvaser_usb_rx_can_log_msg(const struct kvaser_usb *dev,
> >> +   const struct kvaser_msg *msg)
> >> +{
> >> + struct kvaser_usb_net_priv *priv;
> >> + struct can_frame *cf;
> >> + struct sk_buff *skb;
> >> + struct net_device_stats *stats;
> >> + u8 channel = msg->u.log_message.channel;
> >> +
> >> + if (channel >= dev->nchannels) {
> >> + dev_err(dev->udev->dev.parent,
> >> + "Invalid channel number (%d)\n", channel);
> >> + return;
> >> + }
> >> +
> >> + priv = dev->nets[channel];
> >> + stats = &priv->netdev->stats;
> >> +
> >> + if (msg->u.log_message.flags & (MSG_FLAG_ERROR_FRAME | MSG_FLAG_NERR |
> >> +   MSG_FLAG_OVERRUN)) {
> >> + kvaser_usb_rx_can_err(priv, msg);
> >> + dev_err(dev->udev->dev.parent,
> >> + "Error frame (flags: 0x%02x)",
> >> +     msg->u.log_message.flags);
> >> + return;
> >> + } else if (msg->u.log_message.flags & ~MSG_FLAG_REMOTE_FRAME) {
> >> + dev_err(dev->udev->dev.parent,
> >> + "Unhandled frame (flags: 0x%02x)",
> >> +     msg->u.log_message.flags);
> >> + netdev_warn(priv->netdev,
> >> +     "Unhandled frame (flags: 0x%02x)",
> >> +     msg->u.log_message.flags);
> >> + return;
> >> + }
> >> +
> >> + skb = alloc_can_skb(priv->netdev, &cf);
> >> + if (!skb) {
> >> + dev_err(dev->udev->dev.parent, "Alloc error");
> >> + stats->tx_dropped++;
> >> + return;
> >> + }
> >> +
> >> + cf->can_id = msg->u.log_message.id;
> >> + cf->can_dlc = msg->u.log_message.dlc;
> >> +
> >> + if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
> >> + cf->can_id |= CAN_RTR_FLAG;
> >> + else
> >> + memcpy(cf->data, &msg->u.log_message.data, cf->can_dlc);
> >> +
> >> + netif_rx(skb);
> >> +
> >> + stats->rx_packets++;
> >> + stats->rx_bytes += cf->can_dlc;
> >> +}
> >> +
> >>  static void kvaser_usb_start_chip_reply(const struct kvaser_usb *dev,
> >>   const struct kvaser_msg *msg)
> >>  {
> >> @@ -921,8 +977,11 @@
> >>   break;
> >>
> >>   case CMD_LOG_MESSAGE:
> >> - if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
> >> + if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME) {
> >>   kvaser_usb_rx_error(dev, msg);
> >> + } else {
> >> + kvaser_usb_rx_can_log_msg(dev, msg);
> >> + }
> >>   break;
> >>
> >>   case CMD_TX_ACKNOWLEDGE:
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> >
> > --
> > Pengutronix e.K.                  | Marc Kleine-Budde           |
> > Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> > Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> > Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> >

-- 
Olivier
