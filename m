Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A503B3892;
	Mon, 20 Jul 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555323; cv=none; b=Qv1DcRWANZDltq7z1ND/ThXVhx6vG4uwhFXQNsIKyfWyL34ifWL6qxFa89jwdvJ5Q/UgqCZrQ1LWDBPNWFVrwY1YAsB73X//jINGvZdlYv0WhyeuYczeOBxwP7J88igJ9qI8IZ2fh70A9oPoOZYqyjGa6JdIw1OUj8MImdaxogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555323; c=relaxed/simple;
	bh=HFfuf93yQbIFax5XUlCbnfLMmkMLsGHEpFKHAlnuWZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqoQ9rcwPH21CrLJJVBLNjkDVV+l/h6EOZc4wr4gdCofP9AQwjJydKP+06/hPmvclKYGEm1dK5YXjLWwT/1NrhNWLcJ9ibkchcjyWJWqJ2SSJnLeQXOot6RFJeqK+FmBmyM8whDkFcoybVgMIOOkUKvoCF+BE/N772Oq8v+OIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0121E2028DC;
	Mon, 20 Jul 2026 15:48:28 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM7-000Pmp-2v;
	Mon, 20 Jul 2026 15:48:27 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6942A56E523;
	Mon, 20 Jul 2026 13:48:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:07 +0200
Subject: [PATCH can-next 06/13] can: gs_usb: gs_make_candev(): sort
 evaluation of device features
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-gs_usb-new-features-v1-6-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HFfuf93yQbIFax5XUlCbnfLMmkMLsGHEpFKHAlnuWZ4=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5dd83baL73SjNZP7j0yRgmfZdI/5Wvy6AflLWW+o
 FGcoLOlo5SFQYyLQVZMkWXpjxOKAoEOpb0vEybBzGFlAhnCwMUpABOZuYThr6zZUzOGJ/03jyo+
 ePjxR4rF+a7Eq2Fy6ab77whXq5tonmD4p5r7NFn6boF16CTbpO1XnmzeaW5q+4zhmWDUlruvl3i
 IcQMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To simplify maintenance and improve readability, sort the evaluation of the
device features by the value of each feature.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 54 +++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d049ae20b53d..d77f0940c035 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1420,6 +1420,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	feature = le32_to_cpu(bt_const.feature);
 	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+
+	/* keep sorted by GS_CAN_FEATURE */
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1432,6 +1434,11 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	if (feature & GS_CAN_FEATURE_ONE_SHOT)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 
+	/* GS_CAN_FEATURE_IDENTIFY is only supported for sw_version > 1 */
+	if (!(le32_to_cpu(dconf->sw_version) > 1 &&
+	      feature & GS_CAN_FEATURE_IDENTIFY))
+		dev->feature &= ~GS_CAN_FEATURE_IDENTIFY;
+
 	if (feature & GS_CAN_FEATURE_FD) {
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		/* The data bit timing will be overwritten, if
@@ -1440,27 +1447,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->bt_const;
 	}
 
-	if (feature & GS_CAN_FEATURE_TERMINATION) {
-		rc = gs_usb_get_termination(netdev, &dev->can.termination);
-		if (rc) {
-			dev->feature &= ~GS_CAN_FEATURE_TERMINATION;
-
-			dev_info(&intf->dev,
-				 "Disabling termination support for channel %d (%pe)\n",
-				 channel, ERR_PTR(rc));
-		} else {
-			dev->can.termination_const = gs_usb_termination_const;
-			dev->can.termination_const_cnt = ARRAY_SIZE(gs_usb_termination_const);
-			dev->can.do_set_termination = gs_usb_set_termination;
-		}
-	}
-
-	if (feature & GS_CAN_FEATURE_BERR_REPORTING)
-		dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
-
-	if (feature & GS_CAN_FEATURE_GET_STATE)
-		dev->can.do_get_berr_counter = gs_usb_can_get_berr_counter;
-
 	/* The CANtact Pro from LinkLayer Labs is based on the
 	 * LPC54616 µC, which is affected by the NXP LPC USB transfer
 	 * erratum. However, the current firmware (version 2) doesn't
@@ -1484,11 +1470,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->feature |= GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX |
 			GS_CAN_FEATURE_QUIRK_BREQ_CANTACT_PRO;
 
-	/* GS_CAN_FEATURE_IDENTIFY is only supported for sw_version > 1 */
-	if (!(le32_to_cpu(dconf->sw_version) > 1 &&
-	      feature & GS_CAN_FEATURE_IDENTIFY))
-		dev->feature &= ~GS_CAN_FEATURE_IDENTIFY;
-
 	/* fetch extended bit timing constants if device has feature
 	 * GS_CAN_FEATURE_FD and GS_CAN_FEATURE_BT_CONST_EXT
 	 */
@@ -1522,6 +1503,27 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
+	if (feature & GS_CAN_FEATURE_TERMINATION) {
+		rc = gs_usb_get_termination(netdev, &dev->can.termination);
+		if (rc) {
+			dev->feature &= ~GS_CAN_FEATURE_TERMINATION;
+
+			dev_info(&intf->dev,
+				 "Disabling termination support for channel %d (%pe)\n",
+				 channel, ERR_PTR(rc));
+		} else {
+			dev->can.termination_const = gs_usb_termination_const;
+			dev->can.termination_const_cnt = ARRAY_SIZE(gs_usb_termination_const);
+			dev->can.do_set_termination = gs_usb_set_termination;
+		}
+	}
+
+	if (feature & GS_CAN_FEATURE_BERR_REPORTING)
+		dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
+
+	if (feature & GS_CAN_FEATURE_GET_STATE)
+		dev->can.do_get_berr_counter = gs_usb_can_get_berr_counter;
+
 	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 

-- 
2.53.0

