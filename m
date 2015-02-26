From: "Ahmed S. Darwish" <darwish.07-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] can: kvaser_usb: Utilize all possible tx URBs
Date: Thu, 26 Feb 2015 10:24:36 -0500
Message-ID: <20150226152436.GC6075@linux>
References: <20150226152011.GA6075@linux>
 <20150226152202.GB6075@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150226152202.GB6075@linux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>, Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andri Yngvason <andri.yngvason-zCUwNCi8n9MAvxtiuMwx3w@public.gmane.org>
Cc: Linux-CAN <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

From: Ahmed S. Darwish <ahmed.darwish-PLTpYtXPOU4AvxtiuMwx3w@public.gmane.org>

The driver currently limits the number of outstanding, not yet
ACKed, transfers to 16 URBs. Meanwhile, the Kvaser firmware
provides its actual max supported number of outstanding
transmissions in its reply to the CMD_GET_SOFTWARE_INFO message.

One example is the UsbCan-II HS/LS device which reports support
of up to 48 tx URBs instead of just 16, increasing the driver
throughput by two-fold and reducing the possibility of -ENOBUFs.

Dynamically set the max tx URBs value according to firmware
replies.

Signed-off-by: Ahmed S. Darwish <ahmed.darwish-PLTpYtXPOU4AvxtiuMwx3w@public.gmane.org>
---
 drivers/net/can/usb/kvaser_usb.c | 62 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index a316fa4..8f835a1 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -24,7 +24,6 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 
-#define MAX_TX_URBS			16
 #define MAX_RX_URBS			4
 #define START_TIMEOUT			1000 /* msecs */
 #define STOP_TIMEOUT			1000 /* msecs */
@@ -455,8 +454,13 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	/* @max_tx_urbs: Firmware-reported maximum number of possible
+	 * outstanding transmissions on this specific Kvaser hardware. The
+	 * value is also used as a sentinel for marking free URB contexts.
+	 */
 	u32 fw_version;
 	unsigned int nchannels;
+	unsigned int max_tx_urbs;
 	enum kvaser_usb_family family;
 
 	bool rxinitdone;
@@ -469,7 +473,7 @@ struct kvaser_usb_net_priv {
 
 	atomic_t active_tx_urbs;
 	struct usb_anchor tx_submitted;
-	struct kvaser_usb_tx_urb_context tx_contexts[MAX_TX_URBS];
+	struct kvaser_usb_tx_urb_context *tx_contexts;
 
 	struct completion start_comp, stop_comp;
 
@@ -655,9 +659,13 @@ static int kvaser_usb_get_software_info(struct kvaser_usb *dev)
 	switch (dev->family) {
 	case KVASER_LEAF:
 		dev->fw_version = le32_to_cpu(msg.u.leaf.softinfo.fw_version);
+		dev->max_tx_urbs =
+			le16_to_cpu(msg.u.leaf.softinfo.max_outstanding_tx);
 		break;
 	case KVASER_USBCAN:
 		dev->fw_version = le32_to_cpu(msg.u.usbcan.softinfo.fw_version);
+		dev->max_tx_urbs =
+			le16_to_cpu(msg.u.usbcan.softinfo.max_outstanding_tx);
 		break;
 	}
 
@@ -712,7 +720,7 @@ static void kvaser_usb_tx_acknowledge(const struct kvaser_usb *dev,
 
 	stats = &priv->netdev->stats;
 
-	context = &priv->tx_contexts[tid % MAX_TX_URBS];
+	context = &priv->tx_contexts[tid % dev->max_tx_urbs];
 
 	/* Sometimes the state change doesn't come after a bus-off event */
 	if (priv->can.restart_ms &&
@@ -739,7 +747,7 @@ static void kvaser_usb_tx_acknowledge(const struct kvaser_usb *dev,
 	stats->tx_bytes += context->dlc;
 	can_get_echo_skb(priv->netdev, context->echo_index);
 
-	context->echo_index = MAX_TX_URBS;
+	context->echo_index = dev->max_tx_urbs;
 	atomic_dec(&priv->active_tx_urbs);
 
 	netif_wake_queue(priv->netdev);
@@ -805,13 +813,14 @@ static int kvaser_usb_simple_msg_async(struct kvaser_usb_net_priv *priv,
 
 static void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv)
 {
+	struct kvaser_usb *dev = priv->dev;
 	int i;
 
 	usb_kill_anchored_urbs(&priv->tx_submitted);
 	atomic_set(&priv->active_tx_urbs, 0);
 
-	for (i = 0; i < MAX_TX_URBS; i++)
-		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
+	for (i = 0; i < dev->max_tx_urbs; i++)
+		priv->tx_contexts[i].echo_index = dev->max_tx_urbs;
 }
 
 static void kvaser_usb_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
@@ -1687,8 +1696,8 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	if (cf->can_id & CAN_RTR_FLAG)
 		*msg_tx_can_flags |= MSG_FLAG_REMOTE_FRAME;
 
-	for (i = 0; i < ARRAY_SIZE(priv->tx_contexts); i++) {
-		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
+	for (i = 0; i < dev->max_tx_urbs; i++) {
+		if (priv->tx_contexts[i].echo_index ==  dev->max_tx_urbs) {
 			context = &priv->tx_contexts[i];
 			break;
 		}
@@ -1720,7 +1729,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 
 	atomic_inc(&priv->active_tx_urbs);
 
-	if (atomic_read(&priv->active_tx_urbs) >= MAX_TX_URBS)
+	if (atomic_read(&priv->active_tx_urbs) >= dev->max_tx_urbs)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
@@ -1860,7 +1869,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 	if (err)
 		return err;
 
-	netdev = alloc_candev(sizeof(*priv), MAX_TX_URBS);
+	netdev = alloc_candev(sizeof(*priv), dev->max_tx_urbs);
 	if (!netdev) {
 		dev_err(&intf->dev, "Cannot alloc candev\n");
 		return -ENOMEM;
@@ -1868,19 +1877,26 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 
 	priv = netdev_priv(netdev);
 
+	priv->tx_contexts = kzalloc(dev->max_tx_urbs *
+				    sizeof(*priv->tx_contexts), GFP_KERNEL);
+	if (!priv->tx_contexts) {
+		free_candev(netdev);
+		return -ENOMEM;
+	}
+
 	init_completion(&priv->start_comp);
 	init_completion(&priv->stop_comp);
 
-	init_usb_anchor(&priv->tx_submitted);
-	atomic_set(&priv->active_tx_urbs, 0);
-
-	for (i = 0; i < ARRAY_SIZE(priv->tx_contexts); i++)
-		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
-
 	priv->dev = dev;
 	priv->netdev = netdev;
 	priv->channel = channel;
 
+	init_usb_anchor(&priv->tx_submitted);
+	atomic_set(&priv->active_tx_urbs, 0);
+
+	for (i = 0; i < dev->max_tx_urbs; i++)
+		priv->tx_contexts[i].echo_index = dev->max_tx_urbs;
+
 	priv->can.state = CAN_STATE_STOPPED;
 	priv->can.clock.freq = CAN_USB_CLOCK;
 	priv->can.bittiming_const = &kvaser_usb_bittiming_const;
@@ -1909,7 +1925,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 		return err;
 	}
 
-	netdev_dbg(netdev, "device registered\n");
+	netdev_info(netdev, "device registered\n");
 
 	return 0;
 }
@@ -1990,6 +2006,13 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 		return err;
 	}
 
+	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
+		((dev->fw_version >> 24) & 0xff),
+		((dev->fw_version >> 16) & 0xff),
+		(dev->fw_version & 0xffff));
+
+	dev_dbg(&intf->dev, "Max oustanding tx = %d URBs\n", dev->max_tx_urbs);
+
 	err = kvaser_usb_get_card_info(dev);
 	if (err) {
 		dev_err(&intf->dev,
@@ -1997,11 +2020,6 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 		return err;
 	}
 
-	dev_dbg(&intf->dev, "Firmware version: %d.%d.%d\n",
-		((dev->fw_version >> 24) & 0xff),
-		((dev->fw_version >> 16) & 0xff),
-		(dev->fw_version & 0xffff));
