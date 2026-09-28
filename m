Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68064E0B8E;
	Mon, 28 Sep 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612498; cv=pass; b=fSDJJ2BWF8y6q672SGTyIYpeNhHMjjW3L1VKUNYlJQssqr9IMWa5xRovhYUasyFqsQjVYIDrWwpk1asJQFsV8cSBG4inMhCEWftHX7i1ArxpPqUGF7JMhURaTzEW9D3SnzTMYBRrz77312l84wTuQgg/0M/sknDXXrRN9anu/1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612498; c=relaxed/simple;
	bh=6j0Pr3nzGjSxjTbY11W/IX5BFBufvKFbBB1QeYR9PQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k5zzlkZ6JJB7D72Q/EBy2j46R/gfbfzWKBgpW3ZnWfWTmiuzWnTOfNmFennc9Vjm5Fln5DulQ0gU/cCIbykDZb/CbHMjh6ZkdNFtGGyw1Vgs75qs7S6xSQG6Xu8bINjOgXbpNW8hfGGx3KIvbbWfqmNUH1XpotRZx3x9oARklG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=N/GMy69y; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="N/GMy69y"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4BA78201E7F;
	Mon, 28 Sep 2026 18:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790612489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/pm32GAMojZQt+fD7Lcf5AQpWBX16gia7idQ1sM+6SM=;
	b=N/GMy69y2AVN+Pu21pLLzbX8ul5bHqZlA3mNTI6acWjEu3iPpjbin6ip7l0cd/IGpZm01p
	tKBWaRwkZC/tdpvrDDJyfKFRd9ZxlE/xw1T2mnx8j7xIATTdVlszZp5fpck8eYL0uJ02s7
	7vER9metWmgTYO9WdXOLfV8c3XHJhspsL+ouITmDKEYPioKn/ymkB1xv+P3uOAiw5zcPam
	h7mw/wPN1fXzMjsc8BQAEOJAra9vUI4ji0Ba8Y9hPZzF963Tj8WpwGJkiVqEIIwM8Jnj+T
	Fsuj1wvhduW2VGjOyFzB1Y2ONae0cgor1LVeAEdVhvCYyVAIX3lurd3BwYn6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790612489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/pm32GAMojZQt+fD7Lcf5AQpWBX16gia7idQ1sM+6SM=;
	b=Fsp2GBnTVImOffHhxBoCyp5TaPXAggAmSYsxTDUq5sx4M40ppaBkMYM7bEnVus8slgsQTQ
	D9I6WcQjQdlFYND+kvvIGolN9KY7AD5MmvsvzXf2K1zqwG34+BuJvan2zT7wFzDULl89Bk
	N8HmivaonMDNF9/2QeEtIAitJaURUKDk8cfH1ITIq1C+BgybxXqnXyGjE1Naaea42T3NIY
	HgbwnHT19VxYtKSjdTqawU1xWdozGBKF6wJ0kSG4TiQm7cFFZLfXSJC+nkI8L2yHcZ5viL
	u3+wIpbXShkH5D9fHSlKm6GotSdoahflzwdKNXHOWK/jB+9mGsKtImow8ynIMA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790612489; a=rsa-sha256;
	cv=none;
	b=f6PUAOGJY4t5e/AlSkIaYdfsQDRdNacvjk3Q9aLiBJOjP+tk2EYyDM0UP4nr0jnENjVv2H
	03H+yFLdYxCtLnn5hC8IGjEj4GyuAUBeFhCABhR+/l2JhcXtXYUVR98NlRwZ1o7gq8piMn
	qNukqk1HTbIIKqL773EqQGWBArmkZXb1Nz2eDPV3lYS8vTOx589ixZ49rraIfEnYUgZyMB
	WRTowq6lt8KBjn1d1JeASQLdUnPmJoo9u/l+KX6DMH1cDpqoWFJCCWynDj2HgEhlBpBgkR
	E3u8AVEKpKenMcuG2gEikpH1683agv56+KqHriD4ZzF+VE5rVzL7jz5OROsvNw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBE6b-003Fsj-0d;
	Mon, 28 Sep 2026 18:21:29 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E670F5B130D;
	Mon, 28 Sep 2026 16:21:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 28 Sep 2026 18:21:24 +0200
Subject: [PATCH can] can: gs_usb: add workarounds for HScanT USB to CAN
 adapter
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gs_usb-hscant-v1-1-42638ca0f85f@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMBAEf0X2uQENoo2/IqV46anXhyg5LYL47
 0b7OMvO7FCOwoom2xH5JypTSFA8MvixCwMb+SSGzW2VO1uaQd+rkhnVd2Ex1HPlnjW5miySM0f
 uZbt7LdIDr/+oK33ZL1cJx3ECNX+jF3YAAAA=
X-Change-ID: 20260924-gs_usb-hscant-bfe6987b97b2
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7815; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6j0Pr3nzGjSxjTbY11W/IX5BFBufvKFbBB1QeYR9PQs=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjaNYV1Jdv6l2cm8KTH/LoYZP9ynYO1euGyTxFpFvqPQ
 lLK1I53dZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiZl6MDGe7yrzOXL1SmXlB
 /1CmjXePbpjYf1Gz9V2HBF63pXW/KmBk2CrVlHB6xmldk9MzpnRKK5bVOIo6NYSYNey91BZWkGz
 BAwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The HScanT [1] is a RISC-V based USB to 4 channels CAN-FD adapter, which is
compatible with the gs_usb protocol.

The device is shipped with firmware version 0x00010007 and needs several
quirks to work properly.

The HScanT FW announces 5 channels, but the hardware has only 4. Workaround
the problem by changing the struct gs_device_config::icount to 3, which
corresponds to 4 channels.

The HScanT FW always sends USB In URB with length 512 bytes. Add quirk
GS_CAN_FEATURE_QUIRK_HSCANT_URB_LENGTH to allocate URBs of that length.

This driver supports up to 256 channels per USB Interface. The HScanT
device has 4 channels, but the FW requires each channels to be bound to a
USB interface using the GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT USB
request. Add quirk to GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL to bind the
CAN channel to the USB Interface 0 during gs_can_open()

Link: https://github.com/cherry-embedded/HSCanT-hardware
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 110 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..ec8256b46646 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,6 +72,7 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
+	GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT = 17,
 };
 
 enum gs_can_mode {
@@ -188,6 +189,18 @@ struct gs_device_termination_state {
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
+/* HScanT firmware version 0x00010007:
+ * - FW requires the binding of CAN channels to USB Interfaces
+ * - Route all CAN channels to USB Interface 0
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL BIT(29)
+
+/* HScanT firmware version 0x00010007:
+ * - FW requires bulk In URBs with >= 512 bytes.
+ * - Use struct quirk_hscant sized (512 bytes) In URBs as a workaround.
+ */
+#define GS_CAN_FEATURE_QUIRK_HSCANT_URB_LENGTH BIT(30)
+
 /* CANtact Pro original firmware:
  * BREQ DATA_BITTIMING overlaps with GET_USER_ID
  */
@@ -261,6 +274,10 @@ struct canfd_quirk {
 	u8 quirk;
 } __packed;
 
+struct quirk_hscant {
+	u8 quirk[512];
+} __packed;
+
 /* struct gs_host_frame::echo_id == GS_HOST_FRAME_ECHO_ID_RX indicates
  * a regular RX'ed CAN frame
  */
@@ -284,6 +301,7 @@ struct gs_host_frame {
 		DECLARE_FLEX_ARRAY(struct canfd, canfd);
 		DECLARE_FLEX_ARRAY(struct canfd_ts, canfd_ts);
 		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);
+		DECLARE_FLEX_ARRAY(struct quirk_hscant, quirk_hscant);
 	};
 } __packed;
 /* The GS USB devices make use of the same flags and masks as in
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
@@ -1314,6 +1354,49 @@ static const u16 gs_usb_termination_const[] = {
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
+			GS_CAN_FEATURE_QUIRK_HSCANT_URB_LENGTH;
+	}
+}
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1385,8 +1468,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const.feature);
-	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+	gs_usb_make_candev_get_feature(dev, dconf, &bt_const);
+	feature = dev->feature;
+
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1514,6 +1598,20 @@ static void gs_destroy_candev(struct gs_can *dev)
 	free_candev(dev->netdev);
 }
 
+static void gs_usb_probe_quirks(const struct usb_device *udev, struct gs_device_config *dconf)
+{
+	if (!udev->manufacturer || !udev->product)
+		return;
+
+	/* HScanT firmware version 0x00010007:
+	 * - FW has an icount of 4, which corresponds to 5 CAN interfaces.
+	 *   The hardware has only 4 interfaces, fixup.
+	 */
+	if (gs_usb_is_hscant(udev, dconf, 0x00010007) &&
+	    dconf->icount == 4)
+		dconf->icount = 3;
+}
+
 static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
@@ -1560,6 +1658,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	gs_usb_probe_quirks(udev, &dconf);
+
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
@@ -1604,10 +1704,12 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		parent->canch[i]->parent = parent;
 
-		/* set RX packet size based on FD and if hardware
+		/* set RX packet size based on quirks, FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		if (parent->canch[i]->feature & GS_CAN_FEATURE_QUIRK_HSCANT_URB_LENGTH) {
+			hf_size_rx = struct_size(hf, quirk_hscant, 1);
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

