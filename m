Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482F42C500;
	Thu,  1 Oct 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841783; cv=none; b=UEORuxU2tpdxe6MULwWa0XXYsZJqrADvKsN5It0BL85A3C/eoh2HgnBT6AlqXNu4ich9IJNr0DlS4WMSnskVRZf83nIAdEgDU05tRJU9AF0hvkK2WAcWpXAk3oATWAEorBBgAYqO6tpxMJ5LGYMwrg5UCUz5j07P1RujwYx2TTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841783; c=relaxed/simple;
	bh=PFgVSXxApSPCiBUKltrKyIrGC+VrNvWkqed+5crv62M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7VFxrWGjYNH/VTzFqnkTo0vMlD4T6iVpC1DBa/nz/RUErmOw7AlAyRGxCUgVckOr2LYRXUVGOYO4sVLA/PE/s7WuWxu8ge/wygBZCpld2n/TRWYhLqieWCUtZJ8mgtG66Ssy0x2f5Rx+/qLLbximIgpEjI7tTZna0mwQni55dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XGSHWGCI; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XGSHWGCI"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5687678050A;
	Thu,  1 Oct 2026 10:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790841777;
	bh=PFgVSXxApSPCiBUKltrKyIrGC+VrNvWkqed+5crv62M=;
	h=From:To:Cc:Subject:Date:From;
	b=XGSHWGCIoROlitWBd0BAJjMy7OqabJbXT3/T6zajNJ1be8zW/FEHFK65/RZPs6Laf
	 yHDROq+bVwo0I28jS9xTqO0nWDsBYS4dTsHhPF3X3eYrlC3Gep/OxEbN85dKKUTAjg
	 Uy9Db4pOaBsxjE1/DPfma7oscG7W4wIl4tdCYP7qyYjSZfcR/lIWkp2nL0CUtN1tKb
	 Q/yVC54GWl96vptguVcCmDYa5BoeCqCQj6K62KgKA9FZurztsVvEaMPLkP7GbAFcxI
	 OP+si4g4ktLxozwX6tfrR+UjUsIZ+BYQmeCeFLNEONUxAIKPMpwU5a7Bf7/kP3COLH
	 N8EuANeB49Bzw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH] can: peak_usb: Sort CAN_CTRLMODE flags by value
Date: Thu,  1 Oct 2026 10:02:39 +0200
Message-ID: <20261001080241.30151-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Sort the CAN_CTRLMODE flags in ctrlmode_supported by ascending bit value.

No functional change intended.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 40 +++++++++++++---------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 5840623662af..9081f30e3d35 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1263,10 +1263,12 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.name = "PCAN-USB FD",
 	.device_id = PCAN_USBFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1340,10 +1342,12 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.name = "PCAN-Chip USB",
 	.device_id = PCAN_USBCHIP_PRODUCT_ID,
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-		CAN_CTRLMODE_BERR_REPORTING,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1417,10 +1421,12 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.name = "PCAN-USB Pro FD",
 	.device_id = PCAN_USBPROFD_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1494,10 +1500,12 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.name = "PCAN-USB X6",
 	.device_id = PCAN_USBX6_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_FD |
-			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
+			      CAN_CTRLMODE_FD |
+			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
-- 
2.43.0

