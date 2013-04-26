From: Jonas Peterson <jonas.peterson@gmail.com>
Subject: Patch for kvaser_usb
Date: Fri, 26 Apr 2013 16:50:41 +0200
Message-ID: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50692 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3DZOum (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 10:50:42 -0400
Received: by mail-wg0-f46.google.com with SMTP id e11so2161933wgh.1
        for <linux-can@vger.kernel.org>; Fri, 26 Apr 2013 07:50:41 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I've tried the kvaser_usb driver with my Kvaser USBcan Pro and no can
frames are properly received. It seems like they are all flagged as
log messages. I patched the driver and have used it for a while now.
Feel free to use it as you please.

Best regards,
Jonas Peterson

--- /drivers/net/can/usb/kvaser_usb.c 2013-04-26 16:20:19.748994249 +0200
+++ kvaser_usb.c 2012-12-14 15:59:10.017829818 +0100
@@ -858,6 +858,62 @@
  stats->rx_bytes += cf->can_dlc;
 }

+static void kvaser_usb_rx_can_log_msg(const struct kvaser_usb *dev,
+   const struct kvaser_msg *msg)
+{
+ struct kvaser_usb_net_priv *priv;
+ struct can_frame *cf;
+ struct sk_buff *skb;
+ struct net_device_stats *stats;
+ u8 channel = msg->u.log_message.channel;
+
+ if (channel >= dev->nchannels) {
+ dev_err(dev->udev->dev.parent,
+ "Invalid channel number (%d)\n", channel);
+ return;
+ }
+
+ priv = dev->nets[channel];
+ stats = &priv->netdev->stats;
+
+ if (msg->u.log_message.flags & (MSG_FLAG_ERROR_FRAME | MSG_FLAG_NERR |
+   MSG_FLAG_OVERRUN)) {
+ kvaser_usb_rx_can_err(priv, msg);
+ dev_err(dev->udev->dev.parent,
+ "Error frame (flags: 0x%02x)",
+     msg->u.log_message.flags);
+ return;
+ } else if (msg->u.log_message.flags & ~MSG_FLAG_REMOTE_FRAME) {
+ dev_err(dev->udev->dev.parent,
+ "Unhandled frame (flags: 0x%02x)",
+     msg->u.log_message.flags);
+ netdev_warn(priv->netdev,
+     "Unhandled frame (flags: 0x%02x)",
+     msg->u.log_message.flags);
+ return;
+ }
+
+ skb = alloc_can_skb(priv->netdev, &cf);
+ if (!skb) {
+ dev_err(dev->udev->dev.parent, "Alloc error");
+ stats->tx_dropped++;
+ return;
+ }
+
+ cf->can_id = msg->u.log_message.id;
+ cf->can_dlc = msg->u.log_message.dlc;
+
+ if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
+ cf->can_id |= CAN_RTR_FLAG;
+ else
+ memcpy(cf->data, &msg->u.log_message.data, cf->can_dlc);
+
+ netif_rx(skb);
+
+ stats->rx_packets++;
+ stats->rx_bytes += cf->can_dlc;
+}
+
 static void kvaser_usb_start_chip_reply(const struct kvaser_usb *dev,
  const struct kvaser_msg *msg)
 {
@@ -921,8 +977,11 @@
  break;

  case CMD_LOG_MESSAGE:
- if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
+ if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME) {
  kvaser_usb_rx_error(dev, msg);
+ } else {
+ kvaser_usb_rx_can_log_msg(dev, msg);
+ }
  break;

  case CMD_TX_ACKNOWLEDGE:
