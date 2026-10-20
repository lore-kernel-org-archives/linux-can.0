Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503053;
	b=oovabPE/ajFt3x5Eg1tD3HYG8Jpl4qWUzVrdqYTuVai2SEG3wYOBejyCiaUGF1bCQvNO
	 5L7t5DnR/sHOy7PxobbMHDOK767SVXav89qPEyXaoSF31wXJabZVg8k5yfGs5TbBiIu7X
	 P3rhOD5/6iHMkL0XmzyGiTguORJoW0auOU3cUxJ10HY5YCTdKTH/cwkWlaBoC9XTpx1xv
	 lXckyisQcz7jYZb2AZkpOaGjc6g8lK5br64VNSHBk6p6Gy5SXm+HUa8nlppPQ5SsboKwf
	 FuA/QctpWUQP6HoZST4OajSlTp2U4SkjQHRiRIqJA7s+Lzty2UnpENLoRrMGP5dcuRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503053;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	b=3Q6XbsISU4/R4j5KTEeyPXNqUeOW0ttBV8C15w6rp1She1qRRVbbJLgTTcCWvtO58XlO
	 cuZvHomafcMmUNy67ORbooDefnAGTy1wyGW4P+rZ0T2kgOIeaB9bNLknTrOMUIH6krj9Z
	 VxYKIjUjsREJqTguGBhJj3/dqvlztm7V4RdtvIhco+7Sz7CpN0VrEUSLoC1ko6rPSYEKl
	 2w6gUyeBYYZs798LuHSL5KXI1wu/Ha1PgJzDQg231AOnFwwrFvv2VBhdLyoGhX20dzJtK
	 IjqUNk2WQFHBRCgQz9589Ox/+KMfq6VCXoHq3xgmqtEnh+LISi00WtJvFyL2B8+XbXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac8XmBNT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70334606A321;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ac8XmBNT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503053;
	b=QAHArxlXTIBYxLe1QZjAulY/YTJnVV7150GtGDKNSPDDSOlWLuSK5t+RkmdkR2NTSqux
	 QQyrHlPnGKeKHORTLBMXvUlDLgH2C9RMk7YNT8mrQQgcmIhg4O7Oertr9zHHjlkC8NRdx
	 WUzyBP3sM9WmOaTizIzvENsM38o2W06L2O0hJ1O4GTGkJXSv5Hpn280QqEJ46OcFVRC7Q
	 g0lsY8SKMqS1JtFwlwizwmjvYPCoKrehjPp8sSWv85mqnXBQSR9inqgQZ95aWhAzSuYjM
	 eeUMzMu/Fmcr1WMODU5heSsgrlUkk51MOnYJs22ja2v91K9RZ+Wo27f/NvvjUpt3kNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503053;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	b=lgnw58m6DeEb5LwvvKpnYdcHvBEXoHxtV8lARyRYLDiOzLq5GP0L4810gW1OCTyDXIVd
	 Ufq76sXSGM3DZB5/r45h7j7MipBOM3mzmIuBcsCEuhi8m02C4f13Q/iBIyRW3U/TUTOl8
	 D68UW5G5YFAL1lNe1KQ5w8fTF+vm1zveMOxRuX5rktga3hg3oAQvVU4xJy0roPmAJ5QQB
	 0eB6V69/QAyBJVO1dgTQcGGyUdypy+IykV1KpMSrE6M6kY+UQPvfqZgZG/+lR6xvwLupB
	 0wK7E1Gkl/wvaD3/r6Exv5qtX85SRerdSVvW1kZTZme4ep+kW4PjrvhCv3dmwvTR4Uw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2F2161F000C7;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503053;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ac8XmBNTPlZJHkaw5UIYLi1PqsiHw3QsDYt7gQoSeBQ+/X7yqNfIgqI+6NA1EfZWk
	 VDpQMT6g99cKRUvq1VfFjm15duKzCFjLaFfmBR3nk5vFxJ3mv+1WWlIjSONlUF4R0c
	 s3/zp4PWllefQAp0eN5ApQSTaL7NmtB+OiTzqq4eBj4XPRWNlU86fKb++ktxiVO0sq
	 oi5nrwC5TZH8rblljfZM3Ke9z3i/MT9qywWO0kn1hpyUCh6wlSI/Mb4vTma3n7owvZ
	 QX+fOLhXeja8Ke2SA9aLLw8k6Sl83/i0vHm0OUQMYZNFHzMeSqkW53L2jAfr2Ss5UK
	 oP9LZwMdEIXpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 95AD143181;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:42 +0200
Subject: [PATCH v5 03/10] can: peak_usb: sort ctrlmode_supported flags
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-canfd_check_channel_idx-v5-3-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=4357;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=MYONh3sP/YxQkbkdVfbPovx+Teoc4eh5O2DBc8w60Zc=;
 b=76WdxrlsI8SxoEpv+uK7hJTHTHWwzibP18zCF+DpfzGbxWRvI1Ngrcn8E/jvWZ/jNAEEYjZ3S
 ydfETGBpDytCnY419cWFIdSt0RfT4oLHNlo5wUZch1oWS9jBBM5P3Ei
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Order the CAN_CTRLMODE_* flags in ctrlmode_supported according to
their numerical values.

This is a cosmetic change only and does not alter the driver
behavior.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c     |  3 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c  | 32 ++++++++++++++++++-----------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |  3 ++-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 785224e00c4e..169c00d93463 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -1016,7 +1016,8 @@ const struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
-	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2,
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
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index b6be8c19e537..4c3d89a160af 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1072,7 +1072,8 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT,
 	.clock = {
 		.freq = PCAN_USBPRO_CRYSTAL_HZ,

-- 
2.53.0


