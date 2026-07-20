Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8537FF5C;
	Mon, 20 Jul 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555324; cv=none; b=a/9pBTSMpKD5f9Oq94v25iVsznsZ61sIfY8fYcGR+zUNj3Lfjd+pXmoz+CU60ABXRZmnBEjv07I2yEq8PRq7ZQiPVabwIrqTYXiyY6zcaj2Fn3J/PIGaRTCwE4vpbd0cnfxDHG9WofM07L3djuTdjzI3MfZAX1YLwarabOAZ+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555324; c=relaxed/simple;
	bh=VGDIUVBKISgogud9BjBBAC7hCLcMWsVB5mLvEJttnwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZrt6oJhyIv6a0bw1mMRcTSSZH0iZxEyan2sjwUjOAj0vwvYahtGzDNVnN+lL5TF93/2I1f1QkoRNDeGJjqnclz0zhUqtcL5nXW2SwThsvOyJN8KMe4KtrSaZ/A2c9RYsSti/rUAMYZehY6fPKozixOB60MbEc3OYgXCcC1ZvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 207802028E1;
	Mon, 20 Jul 2026 15:48:30 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloMA-000Pn9-07;
	Mon, 20 Jul 2026 15:48:30 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 84A0F56E52C;
	Mon, 20 Jul 2026 13:48:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:12 +0200
Subject: [PATCH can-next 11/13] can: gs_usb: implement
 CAN_CTRLMODE_BERR_REPORTING for devices without native support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-11-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=VGDIUVBKISgogud9BjBBAC7hCLcMWsVB5mLvEJttnwA=;
 b=kA0DAAoWzDpk+q6ZrdIByyZiAGpeJyOiqkvP5+g5otLSdG7Mhs8PIu1+zdjPooe0Q0xbVesYS
 oh1BAAWCgAdFiEEpfjIIRBRQHWN6WCSzDpk+q6ZrdIFAmpeJyMACgkQzDpk+q6ZrdJM8gEA/B8l
 HOqa5zLSpX4FDzgJVdXsKCi5f6GceWqnvU9JLWEA/jfzPJSXc7KwDz5y9ub2ZLDtHGWg9aopSxu
 AfX/HzswB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

RX or TX problems on the CAN bus are signaled by the controller in the form
of CAN bus error. Each bus error increases the CAN error
counters (successful RX or TX decreases the counters). When certain limits
are crossed the controller changes into a different state.

As CAN bus errors might come at a very high rate (>1 KHz), they are
disabled in Linux by default.

Commit 2f3cdad1c616 ("can: gs_usb: add ability to enable / disable berr
reporting") added support to disable CAN bus error reporting if the
firmware supports it. The candlelight firmware recently added support for
this.

Implement CAN_CTRLMODE_BERR_REPORTING for devices that don't support
disabling CAN bus error reporting.

In gs_usb_receive_bulk_callback(), check if the driver received a CAN error
message. If CAN bus error reporting is disabled, drop CAN bus errors, but
process CAN state changes.

Unconditionally announce that the driver supports CAN bus error reporting
by setting CAN_CTRLMODE_BERR_REPORTING in ctrlmode_supported. But only
request CAN bus error reporting from the device if the firmware supports
it and the user space has configured it.

Link: https://github.com/candle-usb/candleLight_fw/pull/303
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 186abc95c977..bc69e6b3c512 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -724,7 +724,8 @@ gs_usb_should_handle_can_error(const struct gs_can *dev, const struct gs_host_fr
 		return true;
 
 	/* handle CAN bus errors */
-	if (hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK))
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING &&
+	    hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_TRX | CAN_ERR_ACK))
 		return true;
 
 	return false;
@@ -1182,7 +1183,7 @@ static int gs_can_open(struct net_device *netdev)
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		flags |= GS_CAN_FEATURE_ONE_SHOT;
 
-	if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+	if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING && dev->feature & GS_CAN_FEATURE_BERR_REPORTING)
 		flags |= GS_CAN_FEATURE_BERR_REPORTING;
 
 	if (ctrlmode & CAN_CTRLMODE_FD)
@@ -1519,7 +1520,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
 
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
+	dev->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
+		CAN_CTRLMODE_CC_LEN8_DLC;
 
 	feature = le32_to_cpu(bt_const.feature);
 	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
@@ -1621,9 +1623,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		}
 	}
 
-	if (feature & GS_CAN_FEATURE_BERR_REPORTING)
-		dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
-
 	if (feature & GS_CAN_FEATURE_GET_STATE)
 		dev->can.do_get_berr_counter = gs_usb_can_get_berr_counter;
 

-- 
2.53.0

