Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679276;
	b=g6n356fKKmQexJZbOAdJHb3u7jBlwDhsHpt2jZs07Jkv3LGqLKBODph0tGseX2QveeHj
	 ++hB+eGhZLE2UDfsMKL8da0ftQNlnnS4pj3PqfieSIWPfdrVt/lHcR2cg02DNO101lXdD
	 4u/nD9cl3lW4CEX9SZ5xs/zzflcoJo4s+uJZ8a2ctBsYPb1RNlHHAKLfN1NNvWYqLYVo4
	 bvxw/gx4wLtwgnzgIE55ZEynT9RkEZFP5CbW0ddaLMHPlUSKAmuj3gR97BfWGULz72byE
	 yGPk1KBTBZIgGl9fO5mR7Z5eKG+fShg+VLm4umYa+OLEUM3403403WoOcMq2/zaxubQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679276;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	b=g2wglbXTQ4577eV4ce6uSAuNrXP/pkCjXycXGrgGp+ju2xqZuekkRKwuaTJLoNVTbNxk
	 f0CfLWYfldkpt1HFanrer8S/E4O47xclHZXiBahBRKPJjPYrA2oYa93iOh7B7XuQBEtKm
	 OTHRqD+IZ8CsnCvsgdgIb+aLlLHmIKv22Ovaw3fMFlCGXm8ansn+EbtFJZvX+QLlzOYdq
	 RGMB4kSgWs7hcAUDI6ZLRwTxmN5E2+oF7iOtEIqvt01yB2vXjJxGp2vD30uTI4rI1Sy9J
	 cbb6Ar+z3jaBr2poGryaDk/T/sBaZqrehIQQIorXlSvno3UySVASXP8tz+IKNDWsTjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYIW2WCv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79924606A324;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYIW2WCv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679276;
	b=TV8pCw86nIsom3aYUfkNYsBEQ9Hp4Gsorpn2Sd5jzJ8bomPJaU4zyLZIl9HCSR08qotC
	 KvFhOFEKsuHDnEGwGcNyWQteoSpFq9K0kdwrizbJd18gOLp6RZpmXV5ccQOy62UQEc9kc
	 b0FrWtUjzlrzAOTDyITMIecjpgb0vl2eBDrOWls/L8HawSRj3mTWLwFWw2ECUHTOM6vUh
	 28wkOWNcgxXyZbz459nuoNpgtGamlTU6EliOHJcQ1b7/a4rQw8Pgs/1rATELzeFmA5dyR
	 1fwivHQTQqRU7h6yrb+sBF7HzzmrsFYYZDgKD9HPyR0504n0/VUr5d0MhfsjT6s/lgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679276;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	b=meaL3YfIDOwJi3xE5gV4cOeAclZStyT4ary+3ddsnbdFPIIZAEBotN/TY98wQxgZOFuI
	 vnARA+dX78TB61Ai2TwoBL3TGBJuyBgqhwuvy5NngeUT8wprftUTH4ffL972M4xBDlHk8
	 im6md0rC0xPmxio8lpX4fGp3uZeTuuQIYQGr8ErmmSnjL6sQRXwLzxp8EcS/tmJRNc+Xo
	 cVNGxHgGZaoV2I2P8pa5ruiVHoOW1pdFgy+jNS5RAlckycArhSw1ZHyeKEaZwApz1CJKK
	 FliSFAGdgxPOmmmC3SZjrApNVqhCGNP5TYS2QZyeBBwPD8t6vb6IngrLV+GRBbBfpEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26C391F000C7;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679276;
	bh=aRXYllM9CBSwb+oBFdWQ8OrqxDITeiZO+tNWy7el8F8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KYIW2WCvG50rkORsOGHA6ymmChI0sB9Hkk8SSfbinbmG5VH86wB5wjw3sIOAhfVjY
	 J4CXXEdKg3L/7tfwu9gIqDNsYka2sDwbRLY5ul2GS/XlLzX8wmaCgAWwKreZ4crbqe
	 /GsCNavhsVAbUPjfqsqvTJVQqpw2t0ad4AnqdTKb/jSAShB6DLF/fGFVYZtLp7b1IW
	 5KRqYE47mhMqWIdWul5Qse/G3qFy1DoWk8O+zQeAOs9qrhhaeiFSTf2evNaDHmsz7T
	 99kaKwwT59AAmRozwhROgZIOH0OYnxQdjp5+xNoNqO/RuNyTs3h740h98z8UkDi3+o
	 GObTKpjUcv3Mg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98F0C435B9;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:48 +0200
Subject: [PATCH v6 03/13] can: peak_usb: sort ctrlmode_supported flags
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
Message-Id: <20261022-canfd_check_channel_idx-v6-3-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=4357;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=MYONh3sP/YxQkbkdVfbPovx+Teoc4eh5O2DBc8w60Zc=;
 b=M9uLMlESbqIhlqSzzYdpOu3lr+n/uFOHVO0RT8WyZDYWGht0dfnSY1PfQ1s35D7EvsuivXOia
 3vwPrKde+OkATLTjX+/AD4GdUznuEDHQTfdRP0DIZS/ghEn4vQKmJWO
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


