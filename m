Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7B4483A9;
	Fri,  2 Oct 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928921; cv=pass; b=F1wwr5+P7HYfpAcNNs01kk4JKhvHp8q/O0Ig9a9hghp+y8l8xU41BJqWH/ILe3pb///7l6ZAUYSy0voI2/3DRVdsobCrAyORBzn1c8dXUn5pkIaFn/BX9qcfVcR5Jzg/cqOY7vp6wxd8jDJCtembAJ8g6JuAzyf5jqOchZfwWTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928921; c=relaxed/simple;
	bh=0jdeh7Akkkl0061qy0BqnnUzpniScdvh7hM74V+LDE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaUiZ3enCLFUvY4NWiRN6O6oRgV1EuqoURTC+UYpQ1KY2cibLQ8+vgZ5iHhL3yx6pTZp2qwEnHMQsCowVbbj/hQeqg26mySuZdmXHTLkbeLrt8Xlqth35hY9/WN1O9DJj3g1qKid7oxL6Ri9LSNw5g/fKk/T9sBTa+SOngQNxTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gVNHbnwC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gVNHbnwC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E229B20196E;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujPqLMKOC/IySaBxORj4Yfo0Zz/74GG3s4bYpfM/1AY=;
	b=gVNHbnwCRca+m8vK/VD2NooDeXLDzGETk7T65UGvxxcUiq5qaEC/P1gsfTbTHyM/vc3wKD
	cpCSUxSKEMd5KAMWjCDC/6Aqo1zR6igx79PVnuaLz+ZgntuHwz9OxEc4jKRnJV52PS/LE0
	IzIGgnPSsArQGsYqaxh0Z/I8TNeQz9xYTS9OlpC6d6a6jT2eCFUAWA7rG56HFBYW5PHv6P
	6/WIGGrO2LlAYtCosTs88elsIuGgdSX22peTrs7Je1E3SBHHjWzWE6Yua9UvIuA7btFZbK
	I6mLrK3i2UJNI+jNXhF9KTXo+tsJko7Azbrem63c+HQv1jHoMkbM38UEnqJC7w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=GQnoKlJyI9xmpBdXfV60fdGYFBeaSGrvvnYjS54FrR9Tk/QuEScjCqwlHDbS3A/Me498Jo
	qWwqEVQ84n6cEctpybIFnC0BD8mvKzEllYQv52f8ul8IcibI3Wyl9bJQKb83CY2/ngqHTT
	emNJ0wbFBhK4UbZTuj1eaG2YSLbYHhfhLCPPqY5TMMfw47FSYp7S+KyZ69J/BY9hnzWc5O
	SWnrdMbDxJlFqScmaY2yRYV06VXWz7PXcQPibh3Hy5LwEonc3UJyZAYg00+16VOzJADhcP
	AZhQvk/WvOKC1QaPXMLaro+Wu+2WmhDzF6KCT8J43Zm0v+M4Ggch+zaxMgjW4w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujPqLMKOC/IySaBxORj4Yfo0Zz/74GG3s4bYpfM/1AY=;
	b=dEIY4nQErfZnlKCu6EezBF/5me3pTJX09MuH4QxTP71FzcLfs+4Jv2Lo9jenio1aIXBlsX
	fR45EqNcv2quK+GlMLjHxmU5QUDbpcLxfkbrOpcOL5ZIatAcCCS0zjl9auDNwc8vg3W7/W
	/bgI63OQydjL3BHNArcpG7tjlugrHHixQtIVisVKlOQSZVQRt1ZkDCwKdiHFElET1p1XNZ
	Qvh81TLIv1FpM0IK6OPKLfYFPudHfm68lrvbbFlYRFnB9BKi3eWH/3LB18J2/Bc6zL3Avp
	Qi+jI4B05MBaqAlnIA0aQ2FU602UUjQrfSt/ySgOK+pxNs1W5WrbqiVXHCZgXg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVN-2f;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6F86F5B828C;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:12 +0200
Subject: [PATCH can-next 5/7] can: peak_usb: Sort CAN_CTRLMODE flags by
 value
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-peak_usb_enhancements-v1-5-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=JMSdZD6DWcM+mPFbnPeuGQfvtZazmrSvaMixhheu0v8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan1yUvfya4WTVGdxye5MbhA5WM+/SdXT6EfBtWaewf
 Op3/rNOHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZiIFivDX0E+LYuvAu4T6+cE
 nrxbyPJqjsn0t0+1fuh2nsrY8a7k1WRGhk5mccEVwS77d2ZeSTFrv/el0sU/S/atSt72g2rrVOx
 5+QA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Sort the CAN_CTRLMODE flags in ctrlmode_supported by ascending bit value.

No functional change intended.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 32 +++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 0d46f4ce5dca..82502594a409 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1198,9 +1198,11 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.name = "PCAN-USB FD",
 	.device_id = PCAN_USBFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1274,9 +1276,11 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.name = "PCAN-Chip USB",
 	.device_id = PCAN_USBCHIP_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1350,9 +1354,11 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.name = "PCAN-USB Pro FD",
 	.device_id = PCAN_USBPROFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1426,9 +1432,11 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.name = "PCAN-USB X6",
 	.device_id = PCAN_USBX6_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},

-- 
2.53.0

