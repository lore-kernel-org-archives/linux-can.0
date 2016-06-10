From: Maximilian Schneider <max@schneidersoft.net>
Subject: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.
Date: Fri, 10 Jun 2016 20:39:22 +0000
Message-ID: <1465591162.2164.2.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from h2448646.stratoserver.net ([85.214.222.201]:52292 "EHLO
	h2448646.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcFJUbb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2016 16:31:31 -0400
Received: from blackbox (unknown [152.242.234.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: max@schneidersoft.net)
	by h2448646.stratoserver.net (Postfix) with ESMTPSA id A3C06D9406B5
	for <linux-can@vger.kernel.org>; Fri, 10 Jun 2016 20:31:25 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From a58480fb1c7bb86c11c0d861f3f2997941a84a65 Mon Sep 17 00:00:00 2001
From: Maximilian Schneider <max@schneidersoft.net>
Date: Fri, 10 Jun 2016 16:50:16 +0000
Subject: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.

currently supported on candleLight interfaces.

Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/gs_usb.c | 140 ++++++++++++++++++++++++++++++-------------
 1 file changed, 98 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index acb0c84..b6a9fef 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -44,7 +44,9 @@ enum gs_usb_breq {
 	GS_USB_BREQ_MODE,
 	GS_USB_BREQ_BERR,
 	GS_USB_BREQ_BT_CONST,
-	GS_USB_BREQ_DEVICE_CONFIG
+	GS_USB_BREQ_DEVICE_CONFIG,
+	GS_USB_BREQ_TIMESTAMP,
+	GS_USB_BREQ_IDENTIFY
 };
 
 enum gs_can_mode {
@@ -63,6 +65,11 @@ enum gs_can_state {
 	GS_CAN_STATE_SLEEPING
 };
 
+enum gs_can_identify_mode {
+	GS_CAN_IDENTIFY_OFF = 0,
+	GS_CAN_IDENTIFY_ON
+};
+
 /* data types passed between host and device */
 struct gs_host_config {
 	u32 byte_order;
@@ -82,10 +89,10 @@ struct gs_device_config {
 } __packed;
 
 #define GS_CAN_MODE_NORMAL               0
-#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
-#define GS_CAN_MODE_LOOP_BACK            (1<<1)
-#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
-#define GS_CAN_MODE_ONE_SHOT             (1<<3)
+#define GS_CAN_MODE_LISTEN_ONLY          BIT(0)
+#define GS_CAN_MODE_LOOP_BACK            BIT(1)
+#define GS_CAN_MODE_TRIPLE_SAMPLE        BIT(2)
+#define GS_CAN_MODE_ONE_SHOT             BIT(3)
 
 struct gs_device_mode {
 	u32 mode;
@@ -106,10 +113,16 @@ struct gs_device_bittiming {
 	u32 brp;
 } __packed;
 
-#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
-#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
-#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
-#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
+struct gs_identify_mode {
+	u32 mode;
+} __packed;
+
+#define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
+#define GS_CAN_FEATURE_LOOP_BACK        BIT(1)
+#define GS_CAN_FEATURE_TRIPLE_SAMPLE    BIT(2)
+#define GS_CAN_FEATURE_ONE_SHOT         BIT(3)
+#define GS_CAN_FEATURE_HW_TIMESTAMP     BIT(4)
+#define GS_CAN_FEATURE_IDENTIFY         BIT(5)
 
 struct gs_device_bt_const {
 	u32 feature;
@@ -214,7 +227,8 @@ static void gs_free_tx_context(struct gs_tx_context *txc)
 
 /* Get a tx context by id.
  */
-static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev, unsigned int id)
+static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev,
+					       unsigned int id)
 {
 	unsigned long flags;
 
@@ -457,7 +471,8 @@ static void gs_usb_xmit_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 }
 
-static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
+				     struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
 	struct net_device_stats *stats = &dev->netdev->stats;
@@ -661,9 +676,12 @@ static int gs_can_open(struct net_device *netdev)
 	/* finally start device */
 	dm->mode = GS_CAN_MODE_START;
 	rc = usb_control_msg(interface_to_usbdev(dev->iface),
-			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
+					     0),
 			     GS_USB_BREQ_MODE,
-			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			     USB_DIR_OUT |
+			     USB_TYPE_VENDOR |
+			     USB_RECIP_INTERFACE,
 			     dev->channel,
 			     0,
 			     dm,
@@ -726,7 +744,56 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static struct gs_can *gs_make_candev(unsigned int channel, struct usb_interface *intf)
+static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
+{
+	int rc;
+	struct gs_identify_mode imode;
+	struct gs_can *dev = netdev_priv(netdev);
+
+	imode.mode = do_identify ? GS_CAN_IDENTIFY_ON : GS_CAN_IDENTIFY_OFF;
+	rc = usb_control_msg(interface_to_usbdev(dev->iface),
+			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
+					     0),
+			     GS_USB_BREQ_IDENTIFY,
+			     USB_DIR_OUT |
+			     USB_TYPE_VENDOR |
+			     USB_RECIP_INTERFACE,
+			     dev->channel,
+			     0,
+			     &imode,
+			     sizeof(imode),
+			     100);
+
+	return (rc > 0) ? 0 : -1;
+}
+
+/* blink LED's for finding the this interface */
+static int gs_usb_set_phys_id(struct net_device *dev,
+			      enum ethtool_phys_id_state state)
+{
+	int rv = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		rv = gs_usb_set_identify(dev, GS_CAN_IDENTIFY_ON);
+		break;
+	case ETHTOOL_ID_INACTIVE:
+		rv = gs_usb_set_identify(dev, GS_CAN_IDENTIFY_OFF);
+		break;
+	default:
+		break;
+	}
+
+	return rv;
+}
+
+static const struct ethtool_ops gs_usb_ethtool_ops = {
+	.set_phys_id = gs_usb_set_phys_id,
+};
+
+static struct gs_can *gs_make_candev(unsigned int channel,
+				     struct usb_interface *intf,
+				     struct gs_device_config *dconf)
 {
 	struct gs_can *dev;
 	struct net_device *netdev;
@@ -814,10 +881,14 @@ static struct gs_can *gs_make_candev(unsigned int channel, struct usb_interface
 	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 
-	kfree(bt_const);
-
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
+	if (dconf->sw_version > 1)
+		if (bt_const->feature & GS_CAN_FEATURE_IDENTIFY)
+			netdev->ethtool_ops = &gs_usb_ethtool_ops;
+
+	kfree(bt_const);
+
 	rc = register_candev(dev->netdev);
 	if (rc) {
 		free_candev(dev->netdev);
@@ -835,19 +906,16 @@ static void gs_destroy_candev(struct gs_can *dev)
 	free_candev(dev->netdev);
 }
 
-static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static int gs_usb_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)
 {
 	struct gs_usb *dev;
 	int rc = -ENOMEM;
 	unsigned int icount, i;
-	struct gs_host_config *hconf;
-	struct gs_device_config *dconf;
-
-	hconf = kmalloc(sizeof(*hconf), GFP_KERNEL);
-	if (!hconf)
-		return -ENOMEM;
+	struct gs_host_config hconf;
+	struct gs_device_config dconf;
 
-	hconf->byte_order = 0x0000beef;
+	hconf.byte_order = 0x0000beef;
 
 	/* send host config */
 	rc = usb_control_msg(interface_to_usbdev(intf),
@@ -856,22 +924,16 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 			     1,
 			     intf->altsetting[0].desc.bInterfaceNumber,
-			     hconf,
-			     sizeof(*hconf),
+			     &hconf,
+			     sizeof(hconf),
 			     1000);
 
-	kfree(hconf);
-
 	if (rc < 0) {
 		dev_err(&intf->dev, "Couldn't send data format (err=%d)\n",
 			rc);
 		return rc;
 	}
 
-	dconf = kmalloc(sizeof(*dconf), GFP_KERNEL);
-	if (!dconf)
-		return -ENOMEM;
-
 	/* read device config */
 	rc = usb_control_msg(interface_to_usbdev(intf),
 			     usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
@@ -879,22 +941,16 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 			     USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 			     1,
 			     intf->altsetting[0].desc.bInterfaceNumber,
-			     dconf,
-			     sizeof(*dconf),
+			     &dconf,
+			     sizeof(dconf),
 			     1000);
 	if (rc < 0) {
 		dev_err(&intf->dev, "Couldn't get device config: (err=%d)\n",
 			rc);
-
-		kfree(dconf);
-
 		return rc;
 	}
 
-	icount = dconf->icount+1;
-
-	kfree(dconf);
-
+	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
 
 	if (icount > GS_MAX_INTF) {
@@ -915,7 +971,7 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	dev->udev = interface_to_usbdev(intf);
 
 	for (i = 0; i < icount; i++) {
-		dev->canch[i] = gs_make_candev(i, intf);
+		dev->canch[i] = gs_make_candev(i, intf, &dconf);
 		if (IS_ERR_OR_NULL(dev->canch[i])) {
 			/* save error code to return later */
 			rc = PTR_ERR(dev->canch[i]);
-- 
2.1.4


