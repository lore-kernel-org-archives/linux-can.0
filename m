Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496636B934;
	Mon, 28 Sep 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619103; cv=pass; b=W4RNY7KEBIaq/7xlHIPG+Qv5O9pxzqlba4IvMq0NcB2vaXKfdUFVp1fcnALvYn6r+RrXwbWMBLrZwGr8k+eTFAu75+5TNyTlMEiJM5LS7pLJa199Hxn73BzdR0qMhTes6kuCrLHtq8JiPUvauDB5iRTfESC3r9QCPOMYJDP+1Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619103; c=relaxed/simple;
	bh=Kah3eHbTKoaJ+iJtfht2O2ZaIcJAx3eMuaDUm0OAr18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hsHwqS84g1CI+LMMOzFYI6ajSVZ3MnumOLwKxf4jWrcC8MgesQQtCFyjqIT0+AdgNxc0PNvWjEQ4f9LfRHBc15EWxQB1OJfPQs4NSDWhXJLsYz1aut/Wnf2f3o/ShbWZ/gcJfONwFUVS7q/D4lE5FfaCFtLdxLIyVkk6CgpBal8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Fq1jPeaV; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Fq1jPeaV"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 63109201E30;
	Mon, 28 Sep 2026 20:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790619093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWMduxsExf3/W+XCkHfjwiKgowofx7uk6DUJ6Fq7QcQ=;
	b=Fq1jPeaVxofdzcS1HuCj+s4RISDEM4nTmSvhwuXpaRDdCBF6ChA8kfGL7QFWWtgIXGZOm6
	zlCjXTnYvOZCSzL9jDxJD6ArZbqaWYFRn4PTn9cvUX08QrN7bDSb3i9IoWcTcpB3UU/wP4
	jY9qC7KOhrR4BpaC0GpUI6tVHR65bEzmcpJp26qS02BCKUr54IEZ/ON89qcLDmY+Y/vlLw
	qHcwn2Ar86qvUaoUZSqKW/DBVNh6VwHT5CHrbYszcb1NJwsjzt/j1uUMn2JNy+y5Qu6fpy
	Rg0FwVWwUts/mqVspXTbERMMeUZhr+QePgs+DFu+l0/31JnLwiW4CJwk7lRgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790619093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JWMduxsExf3/W+XCkHfjwiKgowofx7uk6DUJ6Fq7QcQ=;
	b=geBFGmug9RZm6aYSa3beZoXodNbPCeB7GJ1WmjnukFhvU4car/IJdOlZgCFsBw5wma/FxY
	+K156nE5AjldXvNZcZNVE+G7T3HzdNZ68q1Xw4xe2UH4YEp0x6lrE4LxD6S/jp3UXUJsKu
	rRMySP0OezzXXAQ1d0/HZ8t2+5v1zN5Ab1lAl1hL0JxdXH8jxMcxUflLrlV5rB+Wy6C5X7
	+scpVKDqhf8a9aDkaUtaYO2rCz1d0TJvF3Cj9qZ5/hFe89UAlshfKJ7cztg2fwR22yseUh
	SFT3yCpEZNZ55/A6zJbMAjeXhlMCokIXfzC4PyRoaFkIrrULFeCgHngjertV3g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790619093; a=rsa-sha256;
	cv=none;
	b=U6LakWSgH4H/Pu8AIGnEfvxoROGxbbsCSDqcVCDsDWoCdbLwGZ2CSKJDQkTBlsZ44ybKos
	TnPnYfXeNkFYDv9T+PswXnZtPJAEvHiSWLiJOcQ2Xij7q8d3ePuzpU1gkZK+sjs+TQDNeR
	tVX/1U/+7PFws5GpG3B3z547nBnSD7ZY9bmpog9yPIGg/RaG1ozzjbJ7KEU29V1NBBb2+r
	ZKoyOUgsZIsI4k66DsswXuwC4FTDQHhgjGyav8SVzyzKV4n38FvCBK8lypZKml6riq8rD5
	/tucxJ6mWiKtltAzpp73rdcvlq13q+Yza2iJvNmbTQWUlmZfs8rpOkhXpaVi0g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBFp7-003GTe-0x;
	Mon, 28 Sep 2026 20:11:33 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 08A2F5B1442;
	Mon, 28 Sep 2026 18:11:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 28 Sep 2026 20:11:21 +0200
Subject: [PATCH can v2] can: gs_usb: add workarounds for HScanT USB to CAN
 adapter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gs_usb-hscant-v2-1-a7c1c02460e9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBBEf4Xs2RqoCMWT/2GIoWUL66GQbiEYw
 r9b0JPHmbyZtwKjJ2S4JSt4nIlpcDHIUwKmb1yHgtqYQaaySCuZi46fE2vRs2lcENpiUalSV6W
 WEDejR0vL8feASED9LXnSLzRhf9qxnjgM/n1Y5+yAfwL1J5gzkYlcFhdlmtSqq72P6Lop+MHRc
 m4R6m3bPnYQ8PXGAAAA
X-Change-ID: 20260924-gs_usb-hscant-bfe6987b97b2
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8496; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Kah3eHbTKoaJ+iJtfht2O2ZaIcJAx3eMuaDUm0OAr18=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjatfaSM8sc233WrqK3EvlYr6gXvZya8e76lMTPq5JlW
 tY5moQ86ChlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEeOYw/He/a7Ppc+quuMly
 U/qanJ/zH+Y99KPDrXJJ+sVqzTMe3p8YGV6uPLf+/empvY/F/uVeYv/qGR1t/KB437prGvPcLl1
 608UGAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The HScanT [1] is a RISC-V based USB to 4 channels CAN-FD adapter, which is
compatible with the gs_usb protocol.

The device is shipped with firmware version 0x00010007 and needs several
quirks to work properly.

The HScanT FW announces 5 channels, but the hardware has only 4. Workaround
the problem by changing the struct gs_device_config::icount to 3, which
corresponds to 4 channels.

The HScanT FW requires a USB High Speed Hub, bail out if device is
connected to slower USB Hub.

The HScanT FW always sends USB In URB with length 512 bytes and seems to
have broken Zero Packet Length handling. Add quirk
GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE to allocate URBs of 513 bytes to work
around these issues.

This driver supports up to 256 channels per USB Interface. The HScanT
device has 4 channels, but the FW requires each channels to be bound to a
USB interface using the GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT USB
request. Add quirk to GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL to bind the
CAN channel to the USB Interface 0 during gs_can_open()

Link: https://github.com/cherry-embedded/HSCanT-hardware
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- drop struct quirk_hscant and use length of 513 bytes for USB In URB
  (detected by sashiko)
- bail out on USB Full Speed eor slower Hubs
- Link to v1: https://patch.msgid.link/20260928-gs_usb-hscant-v1-1-42638ca0f85f@pengutronix.de
---
 drivers/net/can/usb/gs_usb.c | 125 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..60a58dcea897 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,6 +72,7 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
+	GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT = 17,
 };
 
 enum gs_can_mode {
@@ -188,6 +189,21 @@ struct gs_device_termination_state {
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
+/* HScanT firmware version 0x00010007:
+ * - FW requires the binding of CAN channels to USB Interfaces.
+ * - Route all CAN channels to USB Interface 0.
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL BIT(29)
+
+/* HScanT firmware version 0x00010007:
+ * - FW sends bulk In URBs with length of 512 bytes.
+ * - When using In URBs with 512 bytes it will send a second in URB with length 0
+ *   It seems the ZLP handling is broken.
+ * - Use In URBs of length GS_USB_QUIRK_HSCANT_IN_URB_SIZE as a workaround.
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE BIT(30)
+#define GS_USB_QUIRK_HSCANT_IN_URB_SIZE (513)
+
 /* CANtact Pro original firmware:
  * BREQ DATA_BITTIMING overlaps with GET_USER_ID
  */
@@ -812,6 +828,18 @@ static int gs_usb_set_data_bittiming(struct gs_can *dev)
 				    GFP_KERNEL);
 }
 
+static int gs_usb_hscant_bind_channel_to_interface(const struct gs_can *dev)
+{
+	const u16 interface_number = 0;
+
+	/* Bind dev->channel to interface_number */
+	return usb_control_msg_send(dev->udev, 0, GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				    dev->channel, interface_number,
+				    NULL, 0, 1000,
+				    GFP_KERNEL);
+}
+
 static void gs_usb_xmit_callback(struct urb *urb)
 {
 	struct gs_tx_context *txc = urb->context;
@@ -1069,6 +1097,16 @@ static int gs_can_open(struct net_device *netdev)
 		}
 	}
 
+	if (dev->feature & GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL) {
+		rc = gs_usb_hscant_bind_channel_to_interface(dev);
+		if (rc) {
+			netdev_err(netdev,
+				   "failed to bind Channel to Interface: %pe\n",
+				   ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1314,6 +1352,49 @@ static const u16 gs_usb_termination_const[] = {
 	GS_USB_TERMINATION_ENABLED
 };
 
+static bool gs_usb_is_hscant(const struct usb_device *udev,
+			     const struct gs_device_config *dconf,
+			     const u32 sw_version)
+{
+	if (udev->descriptor.idVendor != cpu_to_le16(USB_GS_USB_1_VENDOR_ID) ||
+	    udev->descriptor.idProduct != cpu_to_le16(USB_GS_USB_1_PRODUCT_ID))
+		return false;
+
+	if (strcmp(udev->manufacturer, "HScanT") ||
+	    strcmp(udev->product, "HScanT USB to CAN adapter"))
+		return false;
+
+	if (dconf->sw_version != cpu_to_le32(sw_version))
+		return false;
+
+	return true;
+}
+
+static void
+gs_usb_make_candev_get_feature(struct gs_can *dev, const struct gs_device_config *dconf,
+			       const struct gs_device_bt_const *bt_const)
+{
+	const struct usb_device *udev = dev->udev;
+	const u32 feature = le32_to_cpu(bt_const->feature);
+
+	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+
+	if (!udev->manufacturer || !udev->product)
+		return;
+
+	/* HScanT firmware version 0x00010007:
+	 * - FW doesn't advertise GS_CAN_FEATURE_BT_CONST_EXT,
+	 *   but implements GS_USB_BREQ_BT_CONST_EXT, fixup.
+	 * - FW requires binding of CAN channel to USB Interface, add quirk.
+	 * - FW requires bulk In URBs with >= 512 bytes, add quirk.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007)) {
+		dev->feature |= GS_CAN_FEATURE_BT_CONST_EXT |
+			GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL |
+			GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE;
+	}
+}
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1385,8 +1466,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const.feature);
-	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+	gs_usb_make_candev_get_feature(dev, dconf, &bt_const);
+	feature = dev->feature;
+
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1514,6 +1596,34 @@ static void gs_destroy_candev(struct gs_can *dev)
 	free_candev(dev->netdev);
 }
 
+static int gs_usb_probe_quirks(const struct usb_interface *intf, struct gs_device_config *dconf)
+{
+	const struct usb_device *udev = interface_to_usbdev(intf);
+
+	if (!udev->manufacturer || !udev->product)
+		return 0;
+
+	/* HScanT firmware version 0x00010007:
+	 * - FW has an icount of 4, which corresponds to 5 CAN interfaces.
+	 *   The hardware has only 4 interfaces, fixup.
+	 * - FW provides broken Endpoint Descriptors on USB Full Speed Hubs:
+	 *   config 1 interface 0 altsetting 0 endpoint 0x4 has invalid maxpacket 512, setting to 64
+	 *   Probably related to GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE,
+	 *   FW only works on USB High Speed Hubs, detect and bail out.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007)) {
+		if (dconf->icount == 4)
+			dconf->icount = 3;
+
+		if (udev->speed < USB_SPEED_HIGH) {
+			dev_err(&intf->dev, "Device only works with USB High Speed Hubs\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -1560,6 +1670,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	rc = gs_usb_probe_quirks(intf, &dconf);
+	if (rc)
+		return rc;
+
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
@@ -1604,10 +1718,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		parent->canch[i]->parent = parent;
 
-		/* set RX packet size based on FD and if hardware
+		/* set RX packet size based on quirks, FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE) {
+			hf_size_rx = GS_USB_QUIRK_HSCANT_IN_URB_SIZE;
+			BUILD_BUG_ON(struct_size(hf, canfd, 1) > GS_USB_QUIRK_HSCANT_IN_URB_SIZE);
+		} else if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
 			else

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260924-gs_usb-hscant-bfe6987b97b2

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

