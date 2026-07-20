Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C122426D07;
	Mon, 20 Jul 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555323; cv=none; b=DQHNF8N9hFji5NhtpsYxyXc2tMjKnMZ0l2zqF9FE3A8P/73t824tzHRpPlh2v5yJDjC4FSxiVnlnmlWGlcxJhtxTVyu0WoihStfNqNWQZ2MDYY1fY7Xw+VmVb+SDcUZW8WBruzfVfzO7WvgUfQe3H293Km8Jg/3kdekz3jnkz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555323; c=relaxed/simple;
	bh=9To91hPxgPnCHohNZ5HQ8prM96DS0vnszY4R+gCqvps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sESZiywRerHHDy7mz+omGvIBLC33AaTTdXKf8KBxmoKXu4thl/vBLVYlU75wYbmY7mSxn3QSKTHRRNW3GDAYEnCJOAfFY81sa2Za9rd5OzL/mhbTsGAPAGFzZ1qLOnz9CFNamoa4eBVvtU5miUaokbP/3Owg0Nh1D04RnEWOA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 884892028E2;
	Mon, 20 Jul 2026 15:48:30 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloMA-000PnD-1U;
	Mon, 20 Jul 2026 15:48:30 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EF32156E530;
	Mon, 20 Jul 2026 13:48:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:13 +0200
Subject: [PATCH can-next 12/13] can: gs_usb: implement Transceiver Delay
 Compensation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-12-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6890; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9To91hPxgPnCHohNZ5HQ8prM96DS0vnszY4R+gCqvps=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU1dRXG580iXFrUs/3GSmYpPjJZ9XB2uEP55K8r1UG
 xXSWb+so5SFQYyLQVZMkWXpjxOKAoEOpb0vEybBzGFlAhnCwMUpABOpZWVkOMAQJpTn5HAiz2nz
 s/syLzmMr5VdSqnrK/ykZLBiJ7eFAcP/oEMBC9zYZKbLuul6evxYxv1E4o4cU7eDtGjp3BCWBa0
 sAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

For CAN-FD with data bitrate of more than 1...2 mbit/s, a transceiver delay
compensation (TDC) must be configured. Recent candleLight firmware added
support to control TDC via USB.

Extend gs_make_candev(): if the device signals TDC support with
GS_CAN_FEATURE_TDC, get struct gs_device_tdc_const from the device with the
USB request GS_USB_BREQ_GET_TDC_CONST and pass it to CAN device layer.

In gs_can_open() configure the TDC with USB request GS_USB_BREQ_SET_TDC and
activate TDC by setting flags GS_CAN_FEATURE_TDC.

Add the gs_usb_get_auto_tdcv() function that reads the current TDCV value
from the device (USB request GS_USB_BREQ_GET_TDC) and pass it to the CAN
device layer.

Link: https://github.com/candle-usb/candleLight_fw/pull/318
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 117 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc69e6b3c512..6355d05e4a16 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -74,9 +74,9 @@ enum gs_usb_breq {
 	GS_USB_BREQ_GET_STATE,
 	GS_USB_BREQ_SET_FILTER,
 	GS_USB_BREQ_GET_FILTER,
-	__GS_USB_BREQ_PLACEHOLDER_17,
-	__GS_USB_BREQ_PLACEHOLDER_18,
-	__GS_USB_BREQ_PLACEHOLDER_19,
+	GS_USB_BREQ_GET_TDC_CONST,
+	GS_USB_BREQ_SET_TDC,
+	GS_USB_BREQ_GET_TDC,
 	GS_USB_BREQ_ELM_GET_BOARDINFO = 20,
 	GS_USB_BREQ_ELM_SET_FILTER,
 	GS_USB_BREQ_ELM_GET_LASTERROR,
@@ -196,6 +196,27 @@ struct gs_device_filter {
 	};
 } __packed __aligned(4);
 
+#define GS_CAN_TDC_MODE_OFF BIT(0)
+#define GS_CAN_TDC_MODE_AUTO BIT(1)
+#define GS_CAN_TDC_MODE_MANUAL BIT(2)
+
+struct gs_device_tdc_const {
+	__le32 tdcv_min;
+	__le32 tdcv_max;
+	__le32 tdco_min;
+	__le32 tdco_max;
+	__le32 tdcf_min;
+	__le32 tdcf_max;
+	__le32 mode;
+} __packed __aligned(4);
+
+struct gs_device_tdc {
+	__le32 tdcv;
+	__le32 tdco;
+	__le32 tdcf;
+	__le32 mode;
+} __packed __aligned(4);
+
 #define GS_CAN_FEATURE_LISTEN_ONLY BIT(0)
 #define GS_CAN_FEATURE_LOOP_BACK BIT(1)
 #define GS_CAN_FEATURE_TRIPLE_SAMPLE BIT(2)
@@ -218,7 +239,8 @@ struct gs_device_filter {
 /* supported by Elmue firmware 0x260528 only */
 #define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS_260528 BIT(16)
 #define GS_CAN_FEATURE_FILTER BIT(16)
-#define GS_CAN_FEATURE_MASK GENMASK(16, 0)
+#define GS_CAN_FEATURE_TDC BIT(17)
+#define GS_CAN_FEATURE_MASK GENMASK(17, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
@@ -345,6 +367,7 @@ struct gs_can {
 	struct usb_device *udev;
 
 	struct can_bittiming_const bt_const, data_bt_const;
+	struct can_tdc_const tdc_const;
 	unsigned int channel;	/* channel number */
 
 	u32 feature;
@@ -1086,6 +1109,30 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int gs_usb_set_tdc(const struct gs_can *dev)
+{
+	const struct can_tdc *tdc = &dev->can.fd.tdc;
+	struct gs_device_tdc device_tdc = {
+		.tdcv = cpu_to_le32(tdc->tdcv),
+		.tdco = cpu_to_le32(tdc->tdco),
+		.tdcf = cpu_to_le32(tdc->tdcf),
+	};
+
+	const u32 ctrlmode = dev->can.ctrlmode;
+
+	if (ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+		device_tdc.mode = cpu_to_le32(GS_CAN_TDC_MODE_AUTO);
+	else if (ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+		device_tdc.mode = cpu_to_le32(GS_CAN_TDC_MODE_MANUAL);
+	else
+		device_tdc.mode = cpu_to_le32(GS_CAN_TDC_MODE_OFF);
+
+	return usb_control_msg_send(dev->udev, 0, GS_USB_BREQ_SET_TDC,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				    dev->channel, 0, &device_tdc, sizeof(device_tdc),
+				    USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+}
+
 static int gs_can_open(struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
@@ -1193,6 +1240,9 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_FEATURE_HW_TIMESTAMP;
 
+	if (dev->feature & GS_CAN_FEATURE_TDC)
+		flags |= GS_CAN_FEATURE_TDC;
+
 	rc = gs_usb_set_bittiming(dev);
 	if (rc) {
 		netdev_err(netdev, "failed to set bittiming: %pe\n", ERR_PTR(rc));
@@ -1207,6 +1257,14 @@ static int gs_can_open(struct net_device *netdev)
 		}
 	}
 
+	if (dev->feature & GS_CAN_FEATURE_TDC) {
+		rc = gs_usb_set_tdc(dev);
+		if (rc) {
+			netdev_err(netdev, "failed to set TDC: %pe\n", ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1452,6 +1510,25 @@ static const u16 gs_usb_termination_const[] = {
 	GS_USB_TERMINATION_ENABLED
 };
 
+static int gs_usb_get_auto_tdcv(const struct net_device *netdev, u32 *tdcv)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	struct gs_device_tdc tdc;
+	int rc;
+
+	rc = usb_control_msg_recv(dev->udev, 0, GS_USB_BREQ_GET_TDC,
+				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  dev->channel, 0,
+				  &tdc, sizeof(tdc), USB_CTRL_GET_TIMEOUT,
+				  GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	*tdcv = le32_to_cpu(tdc.tdcv);
+
+	return 0;
+}
+
 static struct gs_can *gs_make_candev(unsigned int channel,
 				     struct usb_interface *intf,
 				     struct gs_device_config *dconf)
@@ -1626,6 +1703,38 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	if (feature & GS_CAN_FEATURE_GET_STATE)
 		dev->can.do_get_berr_counter = gs_usb_can_get_berr_counter;
 
+	if (feature & GS_CAN_FEATURE_TDC) {
+		struct gs_device_tdc_const tdc_const;
+
+		rc = usb_control_msg_recv(interface_to_usbdev(intf), 0,
+					  GS_USB_BREQ_GET_TDC_CONST,
+					  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+					  channel, 0, &tdc_const,
+					  sizeof(tdc_const),
+					  1000, GFP_KERNEL);
+		if (rc) {
+			dev_err(&intf->dev,
+				"Couldn't get TDC const for channel %d (%pe)\n",
+				channel, ERR_PTR(rc));
+			goto out_free_candev;
+		}
+
+		dev->tdc_const.tdcv_min = le32_to_cpu(tdc_const.tdcv_min);
+		dev->tdc_const.tdcv_max = le32_to_cpu(tdc_const.tdcv_max);
+		dev->tdc_const.tdco_min = le32_to_cpu(tdc_const.tdco_min);
+		dev->tdc_const.tdco_max = le32_to_cpu(tdc_const.tdco_max);
+		dev->tdc_const.tdcf_min = le32_to_cpu(tdc_const.tdcf_min);
+		dev->tdc_const.tdcf_max = le32_to_cpu(tdc_const.tdcf_max);
+
+		if (tdc_const.mode & cpu_to_le32(GS_CAN_TDC_MODE_MANUAL))
+			dev->can.ctrlmode_supported |= CAN_CTRLMODE_TDC_MANUAL;
+		if (tdc_const.mode & cpu_to_le32(GS_CAN_TDC_MODE_AUTO))
+			dev->can.ctrlmode_supported |= CAN_CTRLMODE_TDC_AUTO;
+
+		dev->can.fd.tdc_const = &dev->tdc_const;
+		dev->can.fd.do_get_auto_tdcv = gs_usb_get_auto_tdcv;
+	}
+
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 

-- 
2.53.0

