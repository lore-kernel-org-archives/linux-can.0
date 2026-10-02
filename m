Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113541D12C;
	Fri,  2 Oct 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931727; cv=pass; b=ZNI1cEr5YMVtzASI4KIjlW3gedwMSdPB0Tl4R7nKPkuWlT7jLhh6nqScvHTN++o+fpj0cJcxcpiwNAzNX1VqFP7w2LvVsiTlRSrOa0ml9q+Z7VQXNlkYFaL+ZeoQ3Qyd3AOlDKopEU4Y3OCmTiSKQhGntqYq1AEKbmEr7eswJb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931727; c=relaxed/simple;
	bh=oZtZ1ANd6My5Zwo641nF24E1i9fdfKxfeQ+qEiOMdJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eWFlEzzfppNNzvDG3dtnMnhbWUZxjEn4a4tz+6xJOjE0bVM/l7Tgo7uvCgiC80UZs0HoyNcE2d/53MatHVpO19wnGjLz8yAgThZevXJnBTkY/1YFdannUPUNYBvzkSPk52mDC7sviefuNTP3DwjRjXOmZNRdvYYSEwxFkNqEFFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XUrGbQFk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XUrGbQFk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 64181201547;
	Fri, 02 Oct 2026 11:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790931719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JBEAP5JrsbcBsu26VZh1yf0j/o83s6Ftiyzs5zox1sw=;
	b=XUrGbQFkb3xlmzJM+joM58KiVm+bRPGw5dsRgET6jXOK8HY/jpUJsVCIu4NNjypB5n/Mjg
	TL1gtEL+2ddNSN2b/g1F8TTyA34p+7E/K7yO+k9SpCF12SM8Dw+Zz0SdYvUwonDyCPbVZX
	b3bNhTbnKx8ZKnESZzqIXj8WTajWhYqlwYAjQwNVTnbXsamaM+ZWi7s2yuo01GJR4lYult
	5XrxPAzumEV//DjgqYKDh0tCEcrffQgP05pWUJg0CgVzYAmCFjCRekM4T6F5+PJnTJQPXL
	pGhaT2/VrVMsjeNtpmgskJFGyL2uK8KOYTAlvnFxZW4fRR7H+iKnGSwzjuEGqA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790931719; a=rsa-sha256;
	cv=none;
	b=F3MSBW7pN2OxR1FbjLjEuhBz/6RZBuMThp26L1NHsSHEOcSf0LyR/ES5sYcUV5v1lMx7Ro
	z/thcz6c/vGcGbk/vIATxYscnwGw08rQUMdfdRpB21LPULRTIygSAth05xRdlIrGUVVkfU
	woL5Ggazu0wsYxxg2lel2nRJwUCuKt3+2n4cXTj+9QzxgNVucJdTjVsHBrODNbf5E3iqW4
	pFQgk4sUklSpjtrr1tXFp4Cr5L5uGxegCwgR6iMA96ncUTDiyNwtA/odb4XHkfPFR99jv/
	tIdRJ+52wXl6ILq6ST3hiLpGCNDM9wM+gpJaz/Rq0FrFjfDoZiGZusC6qa0kOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790931719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JBEAP5JrsbcBsu26VZh1yf0j/o83s6Ftiyzs5zox1sw=;
	b=NvByYNYrm+GN9Nxl7zKZVLUGCC3K/nnUUznzgsuTckJSGuUK/ea5gyzhoaOzzHCFLWUl5F
	D7VwML9u6gNlZvNO6WwafXUZZil7UX/C5eSuRvBG2tscGnREiG5BLcsP96prk/sQLRFlL5
	w+38cTgvXmxxtps7weDgy+6XEOTOPMeY+mGh+tWGrfEVgR/55f945ZXVSzXsYiyViCj63r
	ecbPhJ6ur2OYorB5p0XoUai9bLzKnAADol/2rxB4IbTTtQgRyv543jG2AUlMyIgtPrfiWV
	TRXpabXT311GpiVoENXZkpL00NoSTLPfLjd+fp/JyxRTbJyH/7Z4FIrUjBsLdQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCZ9T-003ren-0z;
	Fri, 02 Oct 2026 11:01:59 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0F3C35B83A4;
	Fri, 02 Oct 2026 09:01:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 11:01:56 +0200
Subject: [PATCH can-next v3] can: gs_usb: add workarounds for HScanT USB to
 CAN adapter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-gs_usb-hscant-v3-1-f9b2b2319079@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBREr0K6tqYULMWV9zDGtOUX6qKQ/kIwh
 Ltb0JUmLicz895CEIIDJOdsIQEmh673KRSHjJhO+Raoa1ImnHHBal7SFu8jatqhUT5SbUHUstJ
 1pTlJnyGAdfPOu5K0oB7mSG7vBkf9ABM33LbtHMY+PHf1lO+Pj0V+Waac5rTkopBGMStP9jKAb
 8cYeu/mYwO7YOJ/ETwhVGVyw3gpGNQ/iHVdX4y6qd8OAQAA
X-Change-ID: 20260924-gs_usb-hscant-bfe6987b97b2
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9981; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=oZtZ1ANd6My5Zwo641nF24E1i9fdfKxfeQ+qEiOMdJ0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjaX8ySksH7pWaik/CiM2fsi4N/LjOKvdtstdg39fSki
 e4Oc+JzOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRyccZ/int2uDwMn6f1ARJ
 k5Cn78PW21VlGm7N3ZZrqq3x+TbTVCVGhj2nC/f7Mv3hO+CkWescFrYs9p96ZWuPsPzzZd4sEx5
 oMQIA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The HScanT is a RISC-V-based USB-to-4-channel CAN-FD adapter that is
compatible with the gs_usb protocol. The device ships with firmware
version 0x00010007 and requires several quirks to function properly.

The HScanT firmware specifies 5 channels, but the µC contains only 4
m_can IP cores. To work around this issue, change the value of `struct
gs_device_config::icount` to 3, which corresponds to 4 channels.

The HScanT supports CAN-FD with different bit-timing constants for
arbitration and data rate. The firmware reports that it supports
CAN-FD (GS_CAN_FEATURE_FD), but does not support querying the data
bit-timing constants (GS_CAN_FEATURE_BT_CONST_EXT). As a result, the driver
uses the arbitration bit-timing constants for the data rate.

According to EcuBus-Pro (a cross-platform CAN analyzer), if the
firmware supports GS_CAN_FEATURE_FD, it also supports querying the
data bit timing constants. Fix: Add GS_CAN_FEATURE_BT_CONST_EXT if
GS_CAN_FEATURE_FD is set.

The HScanT firmware requires a USB High Speed Hub, bail out if device is
connected to slower USB Hub.

The HScanT firmware requires In-URBs with a length of at least 512 bytes.
If In-URBs with a length of less than 512 bytes are used, the firmware does
not send any In-URBs.

When using In-URBs with exactly 512 bytes (= maximum packet length of the
endpoint), 512-byte In-URBs are sent, immediately followed by a 0-byte
In-URB. This results in a "short read" error in
gs_usb_receive_bulk_callback(). This can be avoided by using In-URBs with a
length of 513 bytes.

Add the GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE quirk to allocate In-URBs that
are 513 bytes in size and work around these issues.

This driver supports up to 255 channels per USB interface. The HScanT
device has 4 channels, but the firmware requires that each channel be bound
to a USB interface via the USB request
"GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT." Add a quirk to
"GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL" to bind the CAN channel to USB
interface 0 during "gs_can_open()".

Link: https://github.com/cherry-embedded/HSCanT-hardware
Link: https://github.com/ecubus/EcuBus-Pro/blob/86f6e1bab0de/src/main/docan/candle/api/candle.c#L307-L313
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- Link to v2: https://patch.msgid.link/20260928-gs_usb-hscant-v2-1-a7c1c02460e9@pengutronix.de

Changes in v2:
- drop struct quirk_hscant and use length of 513 bytes for USB In URB
  (detected by sashiko)
- bail out on USB Full Speed or slower Hubs
- Link to v1: https://patch.msgid.link/20260928-gs_usb-hscant-v1-1-42638ca0f85f@pengutronix.de

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/usb/gs_usb.c | 128 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..67e57ccbcdec 100644
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
+ * - FW sends bulk In-URBs with length of 512 bytes.
+ * - When using In-URBs with 512 bytes it will send a second In-URB with length 0
+ *   It seems the ZLP handling is broken.
+ * - Use In-URBs of length GS_USB_QUIRK_HSCANT_IN_URB_SIZE as a workaround.
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
@@ -1314,6 +1352,50 @@ static const u16 gs_usb_termination_const[] = {
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
+	 * - According to EcuBus-Pro: if FW support GS_CAN_FEATURE_FD,
+	 *   it also supports the GS_CAN_FEATURE_BT_CONST_EXT, fixup.
+	 * - FW requires binding of CAN channel to USB Interface, add quirk.
+	 * - FW requires bulk In-URBs with >= 512 bytes, add quirk.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007)) {
+		if (dev->feature & GS_CAN_FEATURE_FD)
+			dev->feature |= GS_CAN_FEATURE_BT_CONST_EXT;
+		dev->feature |=  GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL |
+			GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE;
+	}
+}
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1385,8 +1467,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const.feature);
-	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+	gs_usb_make_candev_get_feature(dev, dconf, &bt_const);
+	feature = dev->feature;
+
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1514,6 +1597,34 @@ static void gs_destroy_candev(struct gs_can *dev)
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
@@ -1560,6 +1671,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	rc = gs_usb_probe_quirks(intf, &dconf);
+	if (rc)
+		return rc;
+
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
@@ -1604,10 +1719,15 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		parent->canch[i]->parent = parent;
 
-		/* set RX packet size based on FD and if hardware
+		/* set RX packet size based on quirks, FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE) {
+			BUILD_BUG_ON(struct_size(hf, canfd_ts, 1) >
+				     GS_USB_QUIRK_HSCANT_IN_URB_SIZE);
+
+			hf_size_rx = GS_USB_QUIRK_HSCANT_IN_URB_SIZE;
+		} else if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
 			else

---
base-commit: d24e8ac715de2e16a53c144005b1863660a5fbea
change-id: 20260924-gs_usb-hscant-bfe6987b97b2

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

