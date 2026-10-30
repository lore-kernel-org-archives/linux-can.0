Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357107;
	b=cs1iYoQnhuc1bAZ9Ns3G8FtixNXP+7QsXZwAbNcgNxsGkKTjqlUL4RNFmQCMiUOvmI11
	 xjcwLahkvJ/Hd9TKcn603MD6e9Vw2nq6WRh3OOhift8IoiE46uV6SJEimaLjQnLhWX9vA
	 ArURN4PR28TL1IRyPEuvdBRbWzsJ1s1cajNYBd5GLgJJ+aeyZPOihMT/gu3QRkVogEvdO
	 ETrZ+GVitSEBXXFXWxitEwaRuxCoa9b7IhlLWWHQjy+9nChifjoWQ2X2YmXsVdIk/RPEn
	 VaiinA+Xm2yz5jTE0GmctuAt23rrM8nn8To9Eia4OFMN5tFzMVztQWS8eAExSfcqaVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YA2LTPX3mPPF2lg3V5ofXC/LL75Ir8pxOfv0IijEi+0=;
	b=Yaho27hWjmoJo0bairy/+1DhNogtbs0yh/nUTrgy4Fp0M1BArfjtLGst8kJI94pxRsa1
	 yjmX4XC6xodv8mw69z/B5p7oGCONtangbUmvLOEuP1f4vr3+RolTxRvHlRf5DTirA5I+Z
	 +U2OJvqXjI3A7ib/+uRMIoUFDpJybXUUe0b4hYMxhE3nXJCf97iBnSIohHbSVdMRJzKea
	 O3nqBwPoc3gJ8zJy3dO+nSzavezdRbDTw92ChrIhiMb596wsDoNfrmm/bvc4l68RVUIWJ
	 7xpOtiUPtDZDWxHXEZiXe43NrcVPsAEMvokTDdAMb139APfDs7I7yYCXz/9BUqTh1PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H1/TcwrP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBB606A32C;
	Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1/TcwrP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357106;
	b=uzuOxddvv3URv95wXJyJUdfgkCQZaG1w/H52IFZBy41OE7gBluWWw65ixlyuCQdH0dx5
	 2+/Q6w/SsUIGThXERzIszf+JHYxy2drlG8EdHpDX8+s6MXeoHA7N7o1n6ZGUEbZ23YEFh
	 br5vzTPtTRYErkQVjOIIRJedJ0uJeprHWzrCxUlVEixkDLv7wlvFzSG0AFvYOHxdB5W9F
	 eg5XUSevv/kQxUt0q/LppAHNmPNfchESu4FykjKgjQLWUp4sqyk6MPjve0WEaTDLTkQTU
	 Itxqo/iAtmN2igEVhF7sj3IlXLx0O6cPPRad2/o5gey7FFOVMTNROvryi6o9tmwwAFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YA2LTPX3mPPF2lg3V5ofXC/LL75Ir8pxOfv0IijEi+0=;
	b=axRE/5/DPhSWFXF1BRy823NrvcXr4gUgps0sz6pH8nF7IE/MHiIGB1iJ5pYKfAd9rPt8
	 mOQyDxWzEcDlzhl+10J2Jml1h8X1x7Bv6kCyDAt+Bee2A0zyx/wNLeGOuEZzkUiPC0UWZ
	 pY6KSSm4IMSDMoo8DFsZ68r+tnqW0A0dnQjV33tDJmVsa9j1R8GVI/LoKuncbjtPJ+vHF
	 /lrLt6aL6LNPkFh/5HCSOJwvH3upuWXMbc1PZmZmIFi5rIfdMZWhIFl4/I1K2v/KtjWob
	 6/Fy8qms7ezBuDvPFWNhUXwasHsHM8+DkER370xICJxQlPNU2KjmB0UN/fd4Kj+F3jA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB6011F0093A;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357106;
	bh=YA2LTPX3mPPF2lg3V5ofXC/LL75Ir8pxOfv0IijEi+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H1/TcwrPXzto3ogjkGQIuxGNvBpIVun6ZyKfyQH3BS7zt0t+QxoZTSO8YzeCViWb3
	 /jfbYGc8FnnCoLCmGShfNqtbGLmmHQrOf48K5EXh85rMFvtWVKTL3U6eUqlgcDejWH
	 U8AaU3O8m2WALwRloqB5RVO4cy/Oi9/p6tswkCYQcK01EoYV1CLU7JQa8MzIy2wIfy
	 eTSdZTLGuqHpHVFJC3c/YeiwqUsgkum9P8JszVP6pGHpaGgf2sJaoq4HPucsKosfzl
	 fsxaFbDiv5JUe7TTVsjpng47gP8+wEFsECeXIKeVONTa2L4poX7q2pcjkNuVr4zoVb
	 qHb1u9JjFVygQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6FFF54373E;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:52 +0100
Subject: [PATCH v7 03/13] can: peak_usb: sort ctrlmode_supported flags
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
Message-Id: <20261030-canfd_check_channel_idx-v7-3-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=4857;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=oEYQRYzkYIe4Qmr0JjmSF25wf7nh1ZgQWOaicfDJor4=;
 b=8pmc3lIlipnQCGwbjUDPmK2uuQjxPtkD5V7/fPaAlaKqOFNqBKDWx+KQWT0emYMM38wcCaF2z
 xvEcl8AqWIFCodS2NRxjr+pmRMHYfogY3ERM9TDQQDOEbyW3Hl2y0ec
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

Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c     |  7 ++++---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c  | 32 ++++++++++++++++++-----------
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c |  3 ++-
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 785224e00c4e..afe5e68d5ea3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -915,8 +915,8 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 	if (dev->device_rev >= 41) {
 		struct can_priv *priv = netdev_priv(dev->netdev);
 
-		priv->ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT |
-					    CAN_CTRLMODE_LOOPBACK;
+		priv->ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK |
+					    CAN_CTRLMODE_ONE_SHOT;
 	} else {
 		dev_info(dev->netdev->dev.parent,
 			 "Firmware update available. Please contact support.peak@hms-networks.com\n");
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


