Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42C422558;
	Mon, 20 Jul 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555318; cv=none; b=FN2RCZhoALtDzs6jkgo43iHKH1/R3LE9+JWXgr8eZ02QFuDox0XP1PpZ1qaCMhFWV0E7AbJWxJTnLpgB5l8e3lSqU7Lh228a2FJjnnklQ9BJ23eSguGfRVaNh6c5x5i6JInTjJGNCZFwwVSX8YeF4ngZwPR8prR4o9H028EyUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555318; c=relaxed/simple;
	bh=vHGDWfgrCVCk7ndp2ooFqyZLm638GrOopzetugJNxsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDzsFIEHMR7JPIy2I1yolfQw0NugsLL/hl0Qo9S1NoGicokO+lW7pz2WJgGaajzFs2Koroi1OQ5JMslgcfcumxRD5xC8T4dMh8tW9h62qJXvo3dTBd17RqBIM8+UYahSWZG8zqZ/rwT3gbTRECblp6ueATBkaDuY80qjHT1JZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 677272028D7;
	Mon, 20 Jul 2026 15:48:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM6-000PmZ-13;
	Mon, 20 Jul 2026 15:48:26 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D932456E51F;
	Mon, 20 Jul 2026 13:48:25 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:03 +0200
Subject: [PATCH can-next 02/13] can: gs_usb: replace all GS_CAN_MODE_* by
 GS_CAN_FEATURE_*
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-2-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vHGDWfgrCVCk7ndp2ooFqyZLm638GrOopzetugJNxsk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5cQvSlYEJy/+Kug9yt3S3nnC3GNcUXX90oZnQ6d7
 Sz8Ok20o5SFQYyLQVZMkWXpjxOKAoEOpb0vEybBzGFlAhnCwMUpABPRfMrIsG6OBW+W3YtLXHFB
 a3cmv10fZeHznevvTa25bpyuwX7r+hgZnk711NRMKXJPdZ6oIKD7+LG5ouXRfzN+2nQp6t+K/7q
 THQA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The values for the defines GS_CAN_MODE_* and GS_CAN_FEATURE_* are
intentionally identical.

The device signals its capabilities with GS_CAN_FEATURE_* in struct
gs_device_bt_const::feature and the driver activates them with
GS_CAN_MODE_* in struct gs_device_mode::flags.

Standardize on GS_CAN_FEATURE_* to eliminate redundant macro definitions
and align the driver with the candlelight firmware implementation (commit
cdadf34281c7 ("gs_usb: replace all GS_CAN_MODE_xxx by GS_CAN_FEATURE_xxx").

Link: https://github.com/candle-usb/candleLight_fw/commit/cdadf34281c777740229b152ce928ca9a819d727
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c8bb6eeff667..2f55030a21a5 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -127,21 +127,6 @@ struct gs_device_config {
 	__le32 hw_version;
 } __packed;
 
-#define GS_CAN_MODE_LISTEN_ONLY BIT(0)
-#define GS_CAN_MODE_LOOP_BACK BIT(1)
-#define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)
-#define GS_CAN_MODE_ONE_SHOT BIT(3)
-#define GS_CAN_MODE_HW_TIMESTAMP BIT(4)
-/* GS_CAN_FEATURE_IDENTIFY BIT(5) */
-/* GS_CAN_FEATURE_USER_ID BIT(6) */
-#define GS_CAN_MODE_PAD_PKTS_TO_MAX_PKT_SIZE BIT(7)
-#define GS_CAN_MODE_FD BIT(8)
-/* GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9) */
-/* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
-/* GS_CAN_FEATURE_TERMINATION BIT(11) */
-#define GS_CAN_MODE_BERR_REPORTING BIT(12)
-/* GS_CAN_FEATURE_GET_STATE BIT(13) */
-
 struct gs_device_mode {
 	__le32 mode;
 	__le32 flags;
@@ -1033,26 +1018,26 @@ static int gs_can_open(struct net_device *netdev)
 
 	/* flags */
 	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
-		flags |= GS_CAN_MODE_LOOP_BACK;
+		flags |= GS_CAN_FEATURE_LOOP_BACK;
 
 	if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		flags |= GS_CAN_MODE_LISTEN_ONLY;
+		flags |= GS_CAN_FEATURE_LISTEN_ONLY;
 
 	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+		flags |= GS_CAN_FEATURE_TRIPLE_SAMPLE;
 
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
-		flags |= GS_CAN_MODE_ONE_SHOT;
+		flags |= GS_CAN_FEATURE_ONE_SHOT;
 
 	if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		flags |= GS_CAN_MODE_BERR_REPORTING;
+		flags |= GS_CAN_FEATURE_BERR_REPORTING;
 
 	if (ctrlmode & CAN_CTRLMODE_FD)
-		flags |= GS_CAN_MODE_FD;
+		flags |= GS_CAN_FEATURE_FD;
 
 	/* if hardware supports timestamps, enable it */
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		flags |= GS_CAN_MODE_HW_TIMESTAMP;
+		flags |= GS_CAN_FEATURE_HW_TIMESTAMP;
 
 	rc = gs_usb_set_bittiming(dev);
 	if (rc) {

-- 
2.53.0

