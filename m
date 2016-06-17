From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/2] can: gs_usb: add ethtool set_phys_id callback to locate physical device
Date: Fri, 17 Jun 2016 12:03:27 +0200
Message-ID: <1466157807-12727-3-git-send-email-mkl@pengutronix.de>
References: <1466157807-12727-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35370 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933535AbcFQKDg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:03:36 -0400
In-Reply-To: <1466157807-12727-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>, Hubert Denkmair <hubert@denkmair.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Maximilian Schneider <max@schneidersoft.net>

This patch Implements the ethtool set_phys_id callback to ease the
locating of specific physical devices. Currently only supported on
candleLight interfaces.

Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
[mkl: split codingstyle change sinto separate patch]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 116 +++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6186a9436bb8..360764324c54 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -39,7 +39,9 @@ enum gs_usb_breq {
 	GS_USB_BREQ_MODE,
 	GS_USB_BREQ_BERR,
 	GS_USB_BREQ_BT_CONST,
-	GS_USB_BREQ_DEVICE_CONFIG
+	GS_USB_BREQ_DEVICE_CONFIG,
+	GS_USB_BREQ_TIMESTAMP,
+	GS_USB_BREQ_IDENTIFY,
 };
 
 enum gs_can_mode {
@@ -58,6 +60,11 @@ enum gs_can_state {
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
@@ -101,10 +108,16 @@ struct gs_device_bittiming {
 	u32 brp;
 } __packed;
 
+struct gs_identify_mode {
+	u32 mode;
+} __packed;
+
 #define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
 #define GS_CAN_FEATURE_LOOP_BACK        BIT(1)
 #define GS_CAN_FEATURE_TRIPLE_SAMPLE    BIT(2)
 #define GS_CAN_FEATURE_ONE_SHOT         BIT(3)
+#define GS_CAN_FEATURE_HW_TIMESTAMP     BIT(4)
+#define GS_CAN_FEATURE_IDENTIFY         BIT(5)
 
 struct gs_device_bt_const {
 	u32 feature;
@@ -724,7 +737,59 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static struct gs_can *gs_make_candev(unsigned int channel, struct usb_interface *intf)
+static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_identify_mode imode;
+	int rc;
+
+	if (do_identify)
+		imode.mode = GS_CAN_IDENTIFY_ON;
+	else
+		imode.mode = GS_CAN_IDENTIFY_OFF;
+
+	rc = usb_control_msg(interface_to_usbdev(dev->iface),
+			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
+					     0),
+			     GS_USB_BREQ_IDENTIFY,
+			     USB_DIR_OUT | USB_TYPE_VENDOR |
+			     USB_RECIP_INTERFACE,
+			     dev->channel,
+			     0,
+			     &imode,
+			     sizeof(imode),
+			     100);
+
+	return (rc > 0) ? 0 : rc;
+}
+
+/* blink LED's for finding the this interface */
+static int gs_usb_set_phys_id(struct net_device *dev,
+			      enum ethtool_phys_id_state state)
+{
+	int rc = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		rc = gs_usb_set_identify(dev, GS_CAN_IDENTIFY_ON);
+		break;
+	case ETHTOOL_ID_INACTIVE:
+		rc = gs_usb_set_identify(dev, GS_CAN_IDENTIFY_OFF);
+		break;
+	default:
+		break;
+	}
+
+	return rc;
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
@@ -812,10 +877,14 @@ static struct gs_can *gs_make_candev(unsigned int channel, struct usb_interface
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
@@ -833,19 +902,16 @@ static void gs_destroy_candev(struct gs_can *dev)
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
-
-	hconf->byte_order = 0x0000beef;
+	struct gs_host_config hconf = {
+		.byte_order = 0x0000beef,
+	};
+	struct gs_device_config dconf;
 
 	/* send host config */
 	rc = usb_control_msg(interface_to_usbdev(intf),
@@ -854,22 +920,16 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
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
@@ -877,22 +937,16 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
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
@@ -913,7 +967,7 @@ static int gs_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	dev->udev = interface_to_usbdev(intf);
 
 	for (i = 0; i < icount; i++) {
-		dev->canch[i] = gs_make_candev(i, intf);
+		dev->canch[i] = gs_make_candev(i, intf, &dconf);
 		if (IS_ERR_OR_NULL(dev->canch[i])) {
 			/* save error code to return later */
 			rc = PTR_ERR(dev->canch[i]);
-- 
2.8.1

