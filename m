Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB743D34BC;
	Mon, 20 Jul 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555327; cv=none; b=FZFkf9/RY65ICJZ2/f1SYcl/1kBHmqbbM2O2DzoHCXXKVfZmybiMa/XybuyWFZQ8fHiZgMbvlk00c2/cYRVJDgiBT2xrWbMDJK4SZuKwUlv8PL3v7MtoyKRnUdwnc09HF8qkOHtxxDhVht2Kv/XuuzOQI0S1uIBvjxhFVuBK6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555327; c=relaxed/simple;
	bh=0AJI/pKCyaXwABlN95c4VoE1LkAgFi7Ks7IBI0DP7gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJdyvQ0zBCatRcpiPXzmDB5+8OJv1FSncitbj9CGPjJv/J8fIVGmPIz65RJOfuNAm/UGuRLT+aAOu/f0Q1ZZXcID0U76wGzwGwD/fLbGQfYsBbTKFNldxT46fsJhT+H+LsG4zRbtL3vYbzUDplop4dGq6amv8dD0mkmDLJcdQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE1792028E3;
	Mon, 20 Jul 2026 15:48:30 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloMA-000PnH-2q;
	Mon, 20 Jul 2026 15:48:30 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D09E56E532;
	Mon, 20 Jul 2026 13:48:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:14 +0200
Subject: [PATCH can-next 13/13] can: gs_usb: implement CAN bus off recovery
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-13-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5146; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0AJI/pKCyaXwABlN95c4VoE1LkAgFi7Ks7IBI0DP7gA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU1c958B2y7viSKTa65A1/y64ct0uNLBSsDpVLbjNV
 fjz8ZKGjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEykspSR4Z9wXGXuPDZLTtV0
 thMa796wRzyf9off9WTktaOvRe43fmdk+Havad/Wfha57ltK8toW1VZHOR5wHv+1RWxT26YJC93
 +MgEA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Traditionally gs_usb compatible CAN devices implement automatic CAN bus off
recovery. Either supported by the CAN IP core in hardware or in the device
firmware.

This turned out to be inflexible, the USB host and thus the user space has
no control over the CAN bus recovery of behaviour. The gs_usb has not
implemented the struct can_priv::do_set_mode that's used to restart the CAN
controller after a CAN bus off.

Recent candleLight firmware closes the gap by implementing the
GS_CAN_FEATURE_BUS_OFF_RECOVERY feature. If the host sets
GS_CAN_FEATURE_BUS_OFF_RECOVERY flag is set device disables automatic CAN
bus off recovery, a manual recovery can be started with the USB request
GS_USB_BREQ_BUS_OFF_RECOVERY.

Implement gs_usb_set_mode() to recover the device via the
GS_USB_BREQ_BUS_OFF_RECOVERY USB request.

Extend gs_make_candev(): if the device signals
GS_CAN_FEATURE_BUS_OFF_RECOVERY support, set the struct
can_priv::do_set_mode callback. In gs_can_open() activate
GS_CAN_FEATURE_BUS_OFF_RECOVERY if supported.

Update gs_update_state() to use the default can_bus_off() handler if the
device goes bus off and GS_CAN_FEATURE_BUS_OFF_RECOVERY.

Link: https://github.com/candle-usb/candleLight_fw/pull/317
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 47 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6355d05e4a16..e4ee9a1ef3f6 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -89,6 +89,7 @@ enum gs_usb_breq {
 	__GS_USB_BREQ_ELM_PLACEHOLDER_29,
 	__GS_USB_BREQ_ELM_PLACEHOLDER_30,
 	__GS_USB_BREQ_ELM_PLACEHOLDER_31,
+	GS_USB_BREQ_BUS_OFF_RECOVERY = 32,
 };
 
 enum gs_can_mode {
@@ -217,6 +218,10 @@ struct gs_device_tdc {
 	__le32 mode;
 } __packed __aligned(4);
 
+struct gs_device_bus_off_recovery {
+	u32 unused;
+} __packed __aligned(4);
+
 #define GS_CAN_FEATURE_LISTEN_ONLY BIT(0)
 #define GS_CAN_FEATURE_LOOP_BACK BIT(1)
 #define GS_CAN_FEATURE_TRIPLE_SAMPLE BIT(2)
@@ -240,7 +245,8 @@ struct gs_device_tdc {
 #define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS_260528 BIT(16)
 #define GS_CAN_FEATURE_FILTER BIT(16)
 #define GS_CAN_FEATURE_TDC BIT(17)
-#define GS_CAN_FEATURE_MASK GENMASK(17, 0)
+#define GS_CAN_FEATURE_BUS_OFF_RECOVERY BIT(18)
+#define GS_CAN_FEATURE_MASK GENMASK(18, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 
@@ -573,14 +579,22 @@ static void gs_update_state(struct gs_can *dev, struct can_frame *cf,
 		return;
 
 	/* some firmware does automatically CAN bus off recovery, account for this */
-	if (cf->can_id & CAN_ERR_RESTARTED ||
-	    (dev->can.state == CAN_STATE_BUS_OFF && new_state < CAN_STATE_BUS_OFF)) {
+	if (!(dev->feature & GS_CAN_FEATURE_BUS_OFF_RECOVERY) &&
+	    (cf->can_id & CAN_ERR_RESTARTED ||
+	     (dev->can.state == CAN_STATE_BUS_OFF && new_state < CAN_STATE_BUS_OFF))) {
 		can_stats->restarts++;
 		/* some firmware doesn't set CAN_ERR_RESTARTED, fixup */
 		cf->can_id |= CAN_ERR_RESTARTED;
 	}
 
 	can_change_state(dev->can.dev, cf, tx_state, rx_state);
+
+	/* If device supports explicit CAN bus off recovery by the host, use default CAN bus off
+	 * handler. Otherwise the device will recover itself.
+	 */
+	if (new_state == CAN_STATE_BUS_OFF &&
+	    dev->feature & GS_CAN_FEATURE_BUS_OFF_RECOVERY)
+		can_bus_off(dev->netdev);
 }
 
 static u32 gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
@@ -1243,6 +1257,9 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_TDC)
 		flags |= GS_CAN_FEATURE_TDC;
 
+	if (dev->feature & GS_CAN_FEATURE_BUS_OFF_RECOVERY)
+		flags |= GS_CAN_FEATURE_BUS_OFF_RECOVERY;
+
 	rc = gs_usb_set_bittiming(dev);
 	if (rc) {
 		netdev_err(netdev, "failed to set bittiming: %pe\n", ERR_PTR(rc));
@@ -1330,6 +1347,27 @@ static int gs_usb_get_state(const struct net_device *netdev,
 	return 0;
 }
 
+static int gs_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+
+	switch (mode) {
+	case CAN_MODE_START: {
+		struct gs_device_bus_off_recovery bus_off_recovery = { 0 };
+
+		return usb_control_msg_send(dev->udev, 0, GS_USB_BREQ_BUS_OFF_RECOVERY,
+					    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+					    dev->channel, 0,
+					    &bus_off_recovery, sizeof(bus_off_recovery),
+					    USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int gs_usb_can_get_berr_counter(const struct net_device *netdev,
 				       struct can_berr_counter *bec)
 {
@@ -1735,6 +1773,9 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.do_get_auto_tdcv = gs_usb_get_auto_tdcv;
 	}
 
+	if (feature & GS_CAN_FEATURE_BUS_OFF_RECOVERY)
+		dev->can.do_set_mode = gs_usb_set_mode;
+
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 

-- 
2.53.0

