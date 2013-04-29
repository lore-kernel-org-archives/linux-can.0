From: Jonas Peterson <jonas.peterson@gmail.com>
Subject: Re: Patch for kvaser_usb
Date: Mon, 29 Apr 2013 13:09:54 +0200
Message-ID: <CAJW3KNUYN-Nbee36-BQ-w0wiTAAv4t4X80SMHTUGx+oOFX8idg@mail.gmail.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
	<517A968D.20508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:45574 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3D2LJ4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 07:09:56 -0400
Received: by mail-we0-f176.google.com with SMTP id s10so5383270wey.35
        for <linux-can@vger.kernel.org>; Mon, 29 Apr 2013 04:09:55 -0700 (PDT)
In-Reply-To: <517A968D.20508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

> Thanks for your feedback. Which firmware version of the Kvaser USBcan
> Pro are you using?

2.7.600

/Jonas


On Fri, Apr 26, 2013 at 5:00 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Hello Jonas,
>
> adding Olivier Sobrie, the author of the driver to the loop.
>
> On 04/26/2013 04:50 PM, Jonas Peterson wrote:
>> I've tried the kvaser_usb driver with my Kvaser USBcan Pro and no can
>> frames are properly received. It seems like they are all flagged as
>> log messages. I patched the driver and have used it for a while now.
>> Feel free to use it as you please.
>
> Thanks for your feedback. Which firmware version of the Kvaser USBcan
> Pro are you using?
>
> Can I add a Signed-off-by[1] to your patch?
>
> Marc
>
> [1]
> http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298
>>
>> Best regards,
>> Jonas Peterson
>>
>> --- /drivers/net/can/usb/kvaser_usb.c 2013-04-26 16:20:19.748994249 +0200
>> +++ kvaser_usb.c 2012-12-14 15:59:10.017829818 +0100
>> @@ -858,6 +858,62 @@
>>   stats->rx_bytes += cf->can_dlc;
>>  }
>>
>> +static void kvaser_usb_rx_can_log_msg(const struct kvaser_usb *dev,
>> +   const struct kvaser_msg *msg)
>> +{
>> + struct kvaser_usb_net_priv *priv;
>> + struct can_frame *cf;
>> + struct sk_buff *skb;
>> + struct net_device_stats *stats;
>> + u8 channel = msg->u.log_message.channel;
>> +
>> + if (channel >= dev->nchannels) {
>> + dev_err(dev->udev->dev.parent,
>> + "Invalid channel number (%d)\n", channel);
>> + return;
>> + }
>> +
>> + priv = dev->nets[channel];
>> + stats = &priv->netdev->stats;
>> +
>> + if (msg->u.log_message.flags & (MSG_FLAG_ERROR_FRAME | MSG_FLAG_NERR |
>> +   MSG_FLAG_OVERRUN)) {
>> + kvaser_usb_rx_can_err(priv, msg);
>> + dev_err(dev->udev->dev.parent,
>> + "Error frame (flags: 0x%02x)",
>> +     msg->u.log_message.flags);
>> + return;
>> + } else if (msg->u.log_message.flags & ~MSG_FLAG_REMOTE_FRAME) {
>> + dev_err(dev->udev->dev.parent,
>> + "Unhandled frame (flags: 0x%02x)",
>> +     msg->u.log_message.flags);
>> + netdev_warn(priv->netdev,
>> +     "Unhandled frame (flags: 0x%02x)",
>> +     msg->u.log_message.flags);
>> + return;
>> + }
>> +
>> + skb = alloc_can_skb(priv->netdev, &cf);
>> + if (!skb) {
>> + dev_err(dev->udev->dev.parent, "Alloc error");
>> + stats->tx_dropped++;
>> + return;
>> + }
>> +
>> + cf->can_id = msg->u.log_message.id;
>> + cf->can_dlc = msg->u.log_message.dlc;
>> +
>> + if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
>> + cf->can_id |= CAN_RTR_FLAG;
>> + else
>> + memcpy(cf->data, &msg->u.log_message.data, cf->can_dlc);
>> +
>> + netif_rx(skb);
>> +
>> + stats->rx_packets++;
>> + stats->rx_bytes += cf->can_dlc;
>> +}
>> +
>>  static void kvaser_usb_start_chip_reply(const struct kvaser_usb *dev,
>>   const struct kvaser_msg *msg)
>>  {
>> @@ -921,8 +977,11 @@
>>   break;
>>
>>   case CMD_LOG_MESSAGE:
>> - if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
>> + if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME) {
>>   kvaser_usb_rx_error(dev, msg);
>> + } else {
>> + kvaser_usb_rx_can_log_msg(dev, msg);
>> + }
>>   break;
>>
>>   case CMD_TX_ACKNOWLEDGE:
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
