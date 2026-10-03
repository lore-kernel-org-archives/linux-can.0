Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A039A4CF;
	Sat,  3 Oct 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068029; cv=pass; b=HKWzVsUyjdndM0Zgqo+mDYkRSqbNAbSP8/M+e8P4+fDF+n7AIge59zkqcPFVV2okz8Cap9Re44io/e6Q52/gg6hIv61Oe0UcFbbQy/PQ5fYheoCrZl6EqSJM0RuT7Y3qh5UoGhC/LaX/lSYlz09LCC9FP+iXe/cQbx+qG3f+ig0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068029; c=relaxed/simple;
	bh=9yiswVObzQAmHq834D5itYlPKNEQdaiAAxPdnV6WRDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCfxnnHXtUp+zbpLhQAajcDYoWZUh6V7EEaEdvIGaYJYapIT37ImV6qJ7GLU3oSV5bVljSWD45LyeHKMAL74iIdamTDGoSlaYHMOqoaz3f/eZTY0pu17DsMZB4BRNxyjsnC7EbBxzNAKcSW21xsD7ZvCVmjK7l7VPnn2FUIcX0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NTwo7I7c; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NTwo7I7c"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B08E202303;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wfj5cqhwO+Z6b4hbDEyukv2vKZjRk9VuPZ02HdOvmDI=;
	b=NTwo7I7cfElPFf0hhGnMNqo14kthQNFfrDIUAzcDMwtR1gG2WN0zix1OktHpbnUugtbB7s
	iU82T+ns/tlW/qF5Z2zPG6k+CwBAeT1t1njUfIo/RGTBGbpVJA9UqX8LTCWzP23s2lIYFT
	jWcGuC/RvlTnJZ9UfF8V/LJ0GJeLCtt7dAd1aRPelnKCUWcSCvhttK0sDzLUyby/wrbUCu
	MuXIVEaC8gqx1ggFrxXE3yZHHBq7kyXWeUFg8cO48NL27xDDj0tn7/jPdpAscv2Lq2vRyi
	bM8+DQtTqGYjM0GtEfLppZHBPUbV+mkspxDVGq6EY30E8wJs8uH4CkOBFuMdLw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=a+EYaj+2t7dPGkBcddMpOFeu9OCiHiqsoAo0H1S64MWNnzgyc4YUYvJA2GKwNdJUU6pNO6
	q4zngYyP9T4CUVcEZQ5rNUo6UiR7ldvCXjEmtFARVQnbutl/Ubr2gYIljiS2pw0+p6iao0
	4ehx2BQKAGw/UYQ25iZ9OScGiC6Qf0S/2nqPSxZSgXtLPL17Ge7bpVQzJMUk9IeFq8YPU+
	lSLIvGbX3fmE4IvxD8fVc6zbhI0m0ck8rGVUoRlYljicyC+Gm3YIchP5YmVrqNMBN57vZ8
	+Z6OKTfXU44HdAhrcyWyVpeBghpe0OyDbIDuy7KO2gmWyyk4fwOOYX7Ap0CgSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wfj5cqhwO+Z6b4hbDEyukv2vKZjRk9VuPZ02HdOvmDI=;
	b=Gd+59f2lgawat1mjCWyKE9AxH3QoIcfn3NcsgbrK95E5jC1ipsWesNTZljb+LjqF8B/t6O
	KhwfTK+6oSUMn0HR0lagVTQ41Is6CoQh8m1+54fMqVE8O2wRBpaQTkBCama/eYJ7pGB391
	8oGHmf9sGpnjhaN9NKqseDmy9iOyAqWKIezkL89Zrfl4dzG6cEwR7NrFmsU+IhOSgd+wwS
	aQB+f8ZFOweD/+TBjOZTr3EZU8QAcZMG+uIHfhfR9X2ZVWe3qEM27/WiNlC8V+EZpxxmhr
	IeeSz3CnFBqbLwMS6Wt2DdzvPttCufI8n2SRQUtdo4J2Clx406YkQxgpAA8+OQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mg-0A;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A6BCB5B93A6;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:13 +0200
Subject: [PATCH can-next 04/10] can: gs_usb: gs_make_candev(): sort
 evaluation of device features
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-4-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4012; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9yiswVObzQAmHq834D5itYlPKNEQdaiAAxPdnV6WRDE=;
 b=kA0DAAoWzDpk+q6ZrdIByyZiAGrBh26hOx6k6S0z/tO6cVGbGkp/sTk6Gb6ng27hb36HZfedW
 4h1BAAWCgAdFiEEpfjIIRBRQHWN6WCSzDpk+q6ZrdIFAmrBh24ACgkQzDpk+q6ZrdKlfwEApWVF
 kvLjDdK9viAWjHZE4Z56+fKYRMvLns6+9D6JBcMA/1zKtstd8pZTmGRDg855bWlJx2bLuaxrA3f
 jCpqwSNoE
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To simplify maintenance and improve readability, sort the evaluation of the
device features by the value of each feature.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 54 +++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b0e7202f0fc0..406c11efba79 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1370,6 +1370,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	feature = le32_to_cpu(bt_const.feature);
 	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
+
+	/* keep sorted by GS_CAN_FEATURE */
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
 
@@ -1382,6 +1384,11 @@ static struct gs_can *gs_make_candev(unsigned int channel,
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
@@ -1390,27 +1397,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
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
@@ -1434,11 +1420,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
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
@@ -1472,6 +1453,27 @@ static struct gs_can *gs_make_candev(unsigned int channel,
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

