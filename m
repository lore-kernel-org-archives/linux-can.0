Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC53385D9D;
	Thu,  1 Oct 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849299; cv=none; b=M88wKcYUMVVHUItER6Nw+wUO0ra1WGcik/0wqH2gv9TRWcxCOKt2h/oteUOsrwuyitMKLUAcGLGdSYGQMz2MVFoJ5EA2+xGnKBhox/Kws0pvrWdkKp4jbRxTZ+lOVWM5Yp3OUYHwMaj+C9ciqZn33BxUraJTcCIQBJeiOW7vinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849299; c=relaxed/simple;
	bh=WARDNPOfPVbA5BG15Ne4HZMhWXrHybNaOIwvPu26K10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLo+wpgclGZyu5ElViBnwzzt1PPalFypjp9PtJidOrPXNgcrWUhWbMmQGNTJdv2XCOvTyJi5Ob+TyWAWX60SgzIozuBwY6vREOH+z6tzfcYGJpV16niZMCVo8pbbpXbR4zDxQjfapJaCB/BtsKnQcSWuxmDeemWSNWiAaXw87PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GbiGvudM; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GbiGvudM"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id EC723780507;
	Thu,  1 Oct 2026 12:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790849287;
	bh=WARDNPOfPVbA5BG15Ne4HZMhWXrHybNaOIwvPu26K10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbiGvudM+9iqt2+tQPP+yGbde5vpMEht20w9i/aNhGO1wasRM4VdBdNLRknM4w+1E
	 46LCaSHWrOAyFVQMVNaWFOeHeh4oMD8vDwaHGL9wZQkQcFHt2dqyDkEF6P3h34yOwu
	 V/roEoSuH9/2IEOURababSCfKVXH6ORfYw2cA5kPIU8Y1CqC7J9kYNHiF7qzLWTC8j
	 wRWqF6ymOkWDvFXC5HvM0uVJ1z2eAUCMzl2vvJgCoDKEiQst26OP9XI0hnwy4/AIfj
	 bvmOyjR0XJfai4H0hORMMq3+/0fqYHp9pq1VhgaznK7bjEFmNa1pa66GwfduMkuSxj
	 nbQHIsnxg4b7g==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH v2] can: peak_usb: Add support of loopback mode to the PCAN-USB FD family
Date: Thu,  1 Oct 2026 12:05:29 +0200
Message-ID: <20261001100749.76312-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <'<20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr>'>
References: <'<20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr>'>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

This commit adds loopback mode support for all PEAK-System USB-to-CAN FD
interfaces.

The implementation follows the same approach as the peak_pciefd driver.
The only difference is local echo handling: on USB devices, transmit
confirmations are provided through USB write acknowledgments rather than
through the reception of a controller-generated loopback frame.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
Changes in v2:
- Rebase on top of the CAN_CTRLMODE sorting patch requested by
  Marc Kleine-Budde.
- Keep CAN_CTRLMODE flags sorted by value.
- Link to v1: https://patch.msgid.link/20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 9081f30e3d35..59debe009f92 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -934,6 +934,12 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
 	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		tx_msg_flags |= PUCAN_MSG_SINGLE_SHOT;
 
+	/* Request controller loopback and mark the frame as self-received,
+	 * matching the behavior of the peak_pciefd driver.
+	 */
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		tx_msg_flags |= PUCAN_MSG_LOOPED_BACK | PUCAN_MSG_SELF_RECEIVE;
+
 	tx_msg->flags = cpu_to_le16(tx_msg_flags);
 	tx_msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, dlc);
 	memcpy(tx_msg->d, cfd->data, cfd->len);
@@ -1263,7 +1269,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.name = "PCAN-USB FD",
 	.device_id = PCAN_USBFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1342,7 +1349,8 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.name = "PCAN-Chip USB",
 	.device_id = PCAN_USBCHIP_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1421,7 +1429,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.name = "PCAN-USB Pro FD",
 	.device_id = PCAN_USBPROFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
@@ -1500,7 +1509,8 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.name = "PCAN-USB X6",
 	.device_id = PCAN_USBX6_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			      CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
 			      CAN_CTRLMODE_BERR_REPORTING |
-- 
2.43.0

Best regards,
---
Stéphane Grosjean <s.grosjean@peak-system.fr>
