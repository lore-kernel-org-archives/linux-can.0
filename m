From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: peak_usb: timestamp issue
Date: Wed, 21 Nov 2012 16:34:22 +0100
Message-ID: <50ACF47E.7010004@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010007020007090606020806"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p04-ob.rzone.de ([81.169.146.178]:52928 "EHLO
	mo-p04-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab2KUPth (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 10:49:37 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010007020007090606020806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Stephane,

i was working with the PEAK USB adapter today and got the problem of different
timestamps with 'candump -x -ta can0':

Timestamps of received CAN frames looked like my system 'uptime'.
Send CAN frames had the real system time.

The problem is, that you insert the hardware timestamp of the PEAK USB
adapters into skb->tstamp ...

This is wrong. For hardware timestamps (RX/TX) there's a special handling in
the Linux Kernel, see at

	linux/Documentation/networking/timestamping.txt

For now i just removed the setting of your HW timestamps on my Linux box (see
attached patch).

Please fix the HW timestamp handling in your driver by supporting the HW
timstamp API correctly.

Tnx,
Oliver

--------------010007020007090606020806
Content-Type: text/x-patch;
 name="peak_usb_ts_hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="peak_usb_ts_hack.patch"

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 86f26a1..4de6bf3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -520,7 +520,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 
 	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
 		peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
-		skb->tstamp = timeval_to_ktime(tv);
+		/* HACK to disable wrongly introduced hardware timestamp */
+		//skb->tstamp = timeval_to_ktime(tv);
 	}
 
 	netif_rx(skb);
@@ -652,7 +653,8 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 
 	/* convert timestamp into kernel time */
 	peak_usb_get_ts_tv(&mc->pdev->time_ref, mc->ts16, &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	/* HACK to disable wrongly introduced hardware timestamp */
+	//skb->tstamp = timeval_to_ktime(tv);
 
 	/* push the skb */
 	netif_rx(skb);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index e1626d9..52f3743 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -549,7 +549,8 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 		memcpy(can_frame->data, rx->data, can_frame->can_dlc);
 
 	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(rx->ts32), &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	/* HACK to disable wrongly introduced hardware timestamp */
+	//skb->tstamp = timeval_to_ktime(tv);
 
 	netif_rx(skb);
 	netdev->stats.rx_packets++;
@@ -664,7 +665,8 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	dev->can.state = new_state;
 
 	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(er->ts32), &tv);
-	skb->tstamp = timeval_to_ktime(tv);
+	/* HACK to disable wrongly introduced hardware timestamp */
+	//skb->tstamp = timeval_to_ktime(tv);
 	netif_rx(skb);
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;

--------------010007020007090606020806--
