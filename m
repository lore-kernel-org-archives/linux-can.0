Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8047F3C5;
	Fri,  2 Oct 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939555; cv=pass; b=mnjJOpFr/GBfSIrnqSARG9h0zUqlyQsDfnJKd86v0j4Pfi3vz+f6hVNqMdnV4wkMiRKayPfM0jE9B0codn9iL11Dqzwj2Gl/1cS0ovMm5cpLV4R7l78Mqhq7IjN6uAqvXf5nCz4zLDLnixlfFBIzXqKBGvZQKm/QzGF0A6j/o4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939555; c=relaxed/simple;
	bh=pskMthLz4b3LQ2AwOrhPuOgxDQb5duiqzpGd2NQdzak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfgYmuNXwbe9sjxFqIaGmqqpNRmoEv1pBbxkWFGTHZkHhAAAUZ0guARzw4zwvWyTtXpGeHd243zPYwfpLK6RIED+I4Uf35znUVKVlkJ890vz3uzr+IRhz6vuMwLv8H/cq2L/2I2E87/juKP7+xXpy5GdRqrK6vk1Q0aO3kiZ+z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YWR4Zs6C; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YWR4Zs6C"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 09BA52007F9;
	Fri, 02 Oct 2026 13:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790939543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/dVgt0j1Ogg5WfqbybadIqEviEDwsZ71OgyWB5ldo/8=;
	b=YWR4Zs6C0evjxhYDwwe7ymbQQQiDmiXMw9QDVD9HKlh3v3qK5Wdv1fOV5SYcksaJNbM14G
	6G4dCZkYbRL22Tq0e8EZO9ffoFW9RCT9eCKlKq9M/KvcCF4cNpGLf55wwOuPNzb8eDWuNn
	l5ZBMTdzixM1G6LsWKj9u/bcivbsDER+ualRrvS1n+qaQqgm3iYpL9IbBNG4ZH2MptSugM
	D6P3HJY0uVGXilNgrT17TunFBI1vS0ZQEPclcVg7WVeB9/dHsDJ8Lux2VtHRwR53JDA365
	iixWEXkWbqNbMJnYn3fUPVNsUr3cheT1HE2/on+5/mHPleXobySrFkpcNRovcg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790939543; a=rsa-sha256;
	cv=none;
	b=azrPJFVO8mGy8Izd5VCMHXZbgFytNesVRae4u4MHSmbmgbku6pwd00fE7NhDBmpYtMEDrS
	NDp7Z86bnOtQpxHxFv+bXaxZ941PamqUdm3Gqk1qUuQpN4Wqa3QNugYghGmRhAkE3MkQhr
	K9BEWJk/zkgifMIQlAGj04O2Vr/Pm3/Kdl3SFVHkflkFPmtTbE/D+OxaK+LSbjPfNsVzkR
	BuUsNLZjGdtdi9G2I6sqQ4BsrabKaRcjw09LDilKOmwr+mh61rneYtNx6xIBiFnyr3nccM
	rB80KeiGL8mzJBHD68faxDsBz6NKHRq+IKOgiaybhgE2C88q0cgIoSAAV27kRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790939543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/dVgt0j1Ogg5WfqbybadIqEviEDwsZ71OgyWB5ldo/8=;
	b=Y/W8zD2+hBXd8XrDaFZqZQ7t0GHXi7ZCale4U/d1zKBLw8R+j9SPz06Xr8u2o6Cpgv/xUy
	YUUG7vofcGLZmuZKPAURug74P+ozv1t+IF3UKhjOLYvs5833orH7MsG+Dx8LtNzYpXhyC+
	p4V6gDC/F9+/VZSYxmEKUNJWpovYTgmJPHAjQgHHFXGZlki2Wpc+OmWVDADGL62z0+BQ5f
	imQyi6VxlWeBiFU3DCV7yDPZ1UeMS1wnXOy+Vfai0A9n/8rQHXLWup7rkinC/A73uTearn
	YsJbG5p0m1qNiql+DQzJCzWM8Yxw3vAx/0q1osI9uKrpxyRWUfLmzFx7HYE1dg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCbBe-003spc-2z;
	Fri, 02 Oct 2026 13:12:22 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5A0E5B857D;
	Fri, 02 Oct 2026 11:12:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 13:12:17 +0200
Subject: [PATCH can-next v4] can: gs_usb: add workarounds for HScanT USB to
 CAN adapter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-gs_usb-hscant-v4-1-13c75d27d9f7@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBAF0KuYrq1pBwTqynsYY2iZQl0U0haCI
 dzdgsYFGpc/M//9iXh0Bj057SbicDDetDaGdL8jqiltjdRUMRNgkDEBKa39rfeSNl6VNlCpMRN
 FLkUugcRO51CbcfUuJH5Qi2Mg19fF9/KOKizc8tsYH1r3WKcHvjbeK8VmZeCU0xSypFAl08VRn
 zu0dR9ca814qHAdGOAvAZEoc8UVgzRjKH4SyYfgjMGWSCKhhQQJCRcs/ybmeX4C5wgycFEBAAA
 =
X-Change-ID: 20260924-gs_usb-hscant-bfe6987b97b2
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10595; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pskMthLz4b3LQ2AwOrhPuOgxDQb5duiqzpGd2NQdzak=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjaP3HK0v9SLzw7Tm70TFV5uPHD5x2KCZM+yMTJvNvpe
 eBR6pNnKztKWRjEuBhkxRRZlv44oSgQ6FDa+zJhEswcViaQIQxcnAIwkUZuhr+SErtsVsToSVnE
 a+sYqCxL61m3L+PKno6Gxq27JbJ+TBFhZJj69+p3BYYlf7fmsf/ambCZtVK2pufmgmfP34k/kEl
 NsuAEAA==
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
Changes in v4:
- add placeholders for enum gs_usb_breq value 15, 16
- add missing changelog for v3
- rebase to current net-next/main
- Link to v3: https://patch.msgid.link/20261002-gs_usb-hscant-v3-1-f9b2b2319079@pengutronix.de

Changes in v3:
- described GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE in more detail
- use ensure that GS_USB_QUIRK_HSCANT_IN_URB_SIZE ist bigger than a struct
  gs_host_frame CAN-FD frame _with_ timestamps, not just a struct
  gs_host_frame CAN-FD without timestamps
- correct number of max channels to 255 in patch description
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
 drivers/net/can/usb/gs_usb.c | 130 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..ae082bca3a36 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,6 +72,9 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
+	__GS_USB_BREQ_PLACEHOLDER_15,
+	__GS_USB_BREQ_PLACEHOLDER_16,
+	GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT = 17,
 };
 
 enum gs_can_mode {
@@ -188,6 +191,21 @@ struct gs_device_termination_state {
 
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
@@ -812,6 +830,18 @@ static int gs_usb_set_data_bittiming(struct gs_can *dev)
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
@@ -1069,6 +1099,16 @@ static int gs_can_open(struct net_device *netdev)
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
@@ -1314,6 +1354,50 @@ static const u16 gs_usb_termination_const[] = {
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
@@ -1385,8 +1469,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const.feature);
-	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+	gs_usb_make_candev_get_feature(dev, dconf, &bt_const);
+	feature = dev->feature;
+
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1514,6 +1599,34 @@ static void gs_destroy_candev(struct gs_can *dev)
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
@@ -1560,6 +1673,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	rc = gs_usb_probe_quirks(intf, &dconf);
+	if (rc)
+		return rc;
+
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
@@ -1604,10 +1721,15 @@ static int gs_usb_probe(struct usb_interface *intf,
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
base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
change-id: 20260924-gs_usb-hscant-bfe6987b97b2

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

