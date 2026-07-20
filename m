Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0A426432;
	Mon, 20 Jul 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555317; cv=none; b=tUXojaV9f1qY6ojtBmodOxUKm6OMOOUJx7ke0XevzkY6XQ2R++bx9epwumJ9W/cZP7ybFLtZb2K7LXzsnwrLC1IHhuAmXnWJTR+FwzfdMqBnpRhRikgoPS4IYm2zOEhIt6AXKvM0KsX9QIGDMnJPLSRhHM1wtypJrPZOq4rv92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555317; c=relaxed/simple;
	bh=S9wrOEJ5JCczZJ76JEv65xY/YI097d4nfOjEqW8oxQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1VITbvfgSbGbilQmt7Bt/aBrlCC/7BINGx4kqli0AjV+e8W8aBjZXtIrne6ZHG25iFofOzTHehqqOHvAm5Vho7J6cKuY52y/BfBFuLtCq9Kimq9vD+LllHsCWWmR0go70q+oV1NWQex9HU9eSHS726zZ1m9OIJ/a7ryUaZ28cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2AD182028D9;
	Mon, 20 Jul 2026 15:48:27 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM7-000Pmh-0G;
	Mon, 20 Jul 2026 15:48:27 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 97DED56E521;
	Mon, 20 Jul 2026 13:48:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:05 +0200
Subject: [PATCH can-next 04/13] can: gs_usb: document GS_CAN_FEATURE_FILTER
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-4-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=S9wrOEJ5JCczZJ76JEv65xY/YI097d4nfOjEqW8oxQU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5e6MXNtxR9+xzVy13c819k2kffstJYtrvdMu6/Nu
 D7FX26iTUcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmcsSdkWG9mMp07yy96Xln
 3dwTjxdJnMzewHQ1KZ9NuWql/M5pmqYM/0utXn7rj13g1JWle8Xl+Zd1h956/DQpUjj14KH0AWa
 THk4A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Document the feature ("GS_CAN_FEATURE_FILTER") that indicates that the CAN
controller supports querying CAN filter capabilities with the
GS_USB_BREQ_GET_FILTER control message and setting CAN filter with the
GS_USB_BREQ_SET_FILTER control message.

Link: https://github.com/candle-usb/candleLight_fw/pull/204
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 57062983b148..82be2db76fe7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,8 +72,8 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
-	__GS_USB_BREQ_PLACEHOLDER_15,
-	__GS_USB_BREQ_PLACEHOLDER_16,
+	GS_USB_BREQ_SET_FILTER,
+	GS_USB_BREQ_GET_FILTER,
 	__GS_USB_BREQ_PLACEHOLDER_17,
 	__GS_USB_BREQ_PLACEHOLDER_18,
 	__GS_USB_BREQ_PLACEHOLDER_19,
@@ -120,6 +120,10 @@ enum gs_can_termination_state {
 #define GS_USB_TERMINATION_DISABLED CAN_TERMINATION_DISABLED
 #define GS_USB_TERMINATION_ENABLED 120
 
+enum gs_device_filter_dev {
+	GS_DEVICE_FILTER_DEV_BXCAN = 1,         /* bxcan, 14 filters */
+};
+
 /* data types passed between host and device */
 
 /* The firmware on the original USB2CAN by Geschwister Schneider
@@ -171,6 +175,27 @@ struct gs_device_termination_state {
 	__le32 state;
 } __packed;
 
+struct gs_device_filter_info {
+	u8 dev;		/* enum gs_device_filter_dev */
+	u8 reserved[3];
+}  __packed __aligned(4);
+
+struct gs_device_filter_bxcan {
+	__le32 fs1r;
+	__le32 fm1r;
+	__le32 ffa1r;
+	__le32 fa1r;
+	__le32 fr1[14];
+	__le32 fr2[14];
+} __packed __aligned(4);
+
+struct gs_device_filter {
+	struct gs_device_filter_info info;
+	union {
+		struct gs_device_filter_bxcan bxcan;
+	};
+} __packed __aligned(4);
+
 #define GS_CAN_FEATURE_LISTEN_ONLY BIT(0)
 #define GS_CAN_FEATURE_LOOP_BACK BIT(1)
 #define GS_CAN_FEATURE_TRIPLE_SAMPLE BIT(2)
@@ -192,6 +217,7 @@ struct gs_device_termination_state {
 #define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS BIT(15)
 /* supported by Elmue firmware 0x260528 only */
 #define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS_260528 BIT(16)
+#define GS_CAN_FEATURE_FILTER BIT(16)
 #define GS_CAN_FEATURE_MASK GENMASK(16, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */

-- 
2.53.0

