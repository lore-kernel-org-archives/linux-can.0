Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DAB417BCC;
	Mon, 20 Jul 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555317; cv=none; b=R6/g8arxH/C7V6dAV7CuA5a74sEYzm0Kis0+BPR7L5batggM+OP9QKvgXr4y2UIZdg8JjoBvwpMUUpXSnc6q8vLurGrJy1jolCgce+XRc2GV4OUHMAbaGm/MN8LAmxjhPiNl2DL9Mc9HJBSVloBZ+udjMxxA+5xK2d4rFrGEtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555317; c=relaxed/simple;
	bh=SNHleqaZ2q2R2o8p2sR3JoQnTLPD8QnYbeOMnJeue0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CluutTSO8OlLrwtyB5qrM4JAsQd8SgRekD4SdA01s3rT5C8QP7BRpdMxHZ5u6TGPnn2K3P4jiPM8jaB3FzxzMRky9fPAdaHPU9r55ONeILsauOv+2nMqCKZkVP5cwiVgQK0EsoqiXPtV19Xk8Gz5w0kAby/zRoJ6ukPgAwdL/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C46542028D8;
	Mon, 20 Jul 2026 15:48:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM6-000Pmd-2G;
	Mon, 20 Jul 2026 15:48:26 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3BD4256E520;
	Mon, 20 Jul 2026 13:48:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:04 +0200
Subject: [PATCH can-next 03/13] can: gs_usb: update USB protocol
 definitions contributed by Elmue firmware
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-3-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=SNHleqaZ2q2R2o8p2sR3JoQnTLPD8QnYbeOMnJeue0Y=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5d8fEYrXdwvidtXeOOWyWeM0pXDewuE/L4+ONpgs
 /yTY8azjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEwkbBYjw+Pszb2nVTKTFLZZ
 2Uw+XKsV92hDTs3nkm7X6zO9OLSYzzD84b/+1X3C9R038yKY9wo8vP369rJ1dXlGtx9p+i5znM7
 pwgsA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The gs_usb compatible firmware by Elmue extended the USB protocol.

Document the newly added GS_CAN_FEATURE_ELM_* bits and the new
GS_USB_BREQ_ELM_GET_* USB requests along with some placeholders for future
extensions.

Link: https://github.com/Elmue/CANable-2.5-firmware-Slcan-and-Candlelight
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 2f55030a21a5..57062983b148 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -72,6 +72,23 @@ enum gs_usb_breq {
 	GS_USB_BREQ_SET_TERMINATION,
 	GS_USB_BREQ_GET_TERMINATION,
 	GS_USB_BREQ_GET_STATE,
+	__GS_USB_BREQ_PLACEHOLDER_15,
+	__GS_USB_BREQ_PLACEHOLDER_16,
+	__GS_USB_BREQ_PLACEHOLDER_17,
+	__GS_USB_BREQ_PLACEHOLDER_18,
+	__GS_USB_BREQ_PLACEHOLDER_19,
+	GS_USB_BREQ_ELM_GET_BOARDINFO = 20,
+	GS_USB_BREQ_ELM_SET_FILTER,
+	GS_USB_BREQ_ELM_GET_LASTERROR,
+	GS_USB_BREQ_ELM_SET_BUSLOADREPORT,
+	GS_USB_BREQ_ELM_SET_PINSTATUS,
+	GS_USB_BREQ_ELM_GET_PINSTATUS,
+	GS_USB_BREQ_ELM_READ_FLASH,
+	GS_USB_BREQ_ELM_WRITE_FLASH,
+	__GS_USB_BREQ_ELM_PLACEHOLDER_28,
+	__GS_USB_BREQ_ELM_PLACEHOLDER_29,
+	__GS_USB_BREQ_ELM_PLACEHOLDER_30,
+	__GS_USB_BREQ_ELM_PLACEHOLDER_31,
 };
 
 enum gs_can_mode {
@@ -168,7 +185,14 @@ struct gs_device_termination_state {
 #define GS_CAN_FEATURE_TERMINATION BIT(11)
 #define GS_CAN_FEATURE_BERR_REPORTING BIT(12)
 #define GS_CAN_FEATURE_GET_STATE BIT(13)
-#define GS_CAN_FEATURE_MASK GENMASK(13, 0)
+#define GS_CAN_FEATURE_ELM_PROTOCOL BIT(14)
+/* supported by Elmue firmware until 0x260528 (including) */
+#define GS_CAN_FEATURE_ELM_DISABLE_TX_ECHO BIT(15)
+/* supported by Elmue firmware since 0x260529 (including) */
+#define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS BIT(15)
+/* supported by Elmue firmware 0x260528 only */
+#define GS_CAN_FEATURE_ELM_DEV_FLAG_SEND_USB_BLOBS_260528 BIT(16)
+#define GS_CAN_FEATURE_MASK GENMASK(16, 0)
 
 /* internal quirks - keep in GS_CAN_FEATURE space for now */
 

-- 
2.53.0

