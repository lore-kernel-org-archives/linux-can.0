From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] peak_usb: fix hwtstamp assignment
Date: Wed, 21 Nov 2012 22:43:59 +0100
Message-ID: <50AD4B1F.4070806@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30236 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab2KVSoD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 13:44:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

The skb->tstamp is set to the hardware timestamp when available in the USB
urb message. This leads to user visible timestamps which contain the 'uptime'
of the USB adapter - and not the usual system generated timestamp.

Fix this wrong assignment by applying the available hardware timestamp to the
skb_shared_hwtstamps data structure - which is intended for this purpose.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

Hello Marc, hello Stephane,

i think we would generally need to support a hwtstamp_ioctl() for CAN
interfaces which are controlled with a struct hwtstamp_config in the future.

For now this patch fixes the current issue much better than a simple removal
of the skb->tstamp assignment.

I'm currently on a business trip and i accidentally missed to take two PEAK
USB interfaces with me to test this patch. It's compile tested ...

So let's wait for an Acked-by from Stephane.

Regards,
Oliver



diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 86f26a1..25723d8 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -519,8 +519,10 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 	mc->pdev->dev.can.state = new_state;
 
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
+		struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+
 		peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
-		skb->tstamp = timeval_to_ktime(tv);
+		hwts->hwtstamp = timeval_to_ktime(tv);
 	}
 
 	netif_rx(skb);
@@ -605,6 +607,7 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	struct timeval tv;
+	struct skb_shared_hwtstamps *hwts;
 
 	skb = alloc_can_skb(mc->netdev, &cf);
 	if (!skb)
@@ -652,7 +655,8 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 
 	/* convert timestamp into kernel time */
 	peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	hwts = skb_hwtstamps(skb);
+	hwts->hwtstamp = timeval_to_ktime(tv);
 
 	/* push the skb */
 	netif_rx(skb);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index e1626d9..30d79bf 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -532,6 +532,7 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	struct can_frame *can_frame;
 	struct sk_buff *skb;
 	struct timeval tv;
+	struct skb_shared_hwtstamps *hwts;
 
 	skb = alloc_can_skb(netdev, &can_frame);
 	if (!skb)
@@ -549,7 +550,8 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 		memcpy(can_frame->data, rx->data, can_frame->can_dlc);
 
 	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(rx->ts32), &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	hwts = skb_hwtstamps(skb);
+	hwts->hwtstamp = timeval_to_ktime(tv);
 
 	netif_rx(skb);
 	netdev->stats.rx_packets++;
@@ -570,6 +572,7 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	u8 err_mask = 0;
 	struct sk_buff *skb;
 	struct timeval tv;
+	struct skb_shared_hwtstamps *hwts;
 
 	/* nothing should be sent while in BUS_OFF state */
 	if (dev->can.state == CAN_STATE_BUS_OFF)
@@ -664,7 +667,8 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	dev->can.state = new_state;
 
 	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(er->ts32), &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	hwts = skb_hwtstamps(skb);
+	hwts->hwtstamp = timeval_to_ktime(tv);
 	netif_rx(skb);
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;


