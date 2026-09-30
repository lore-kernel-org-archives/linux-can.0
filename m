Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AF4E01FA;
	Wed, 30 Sep 2026 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775335; cv=none; b=mSZ+ep22nWo0b0/jAgfgYDCgEK+f83ONXaZND6XcyIOEivceA0rJHBVbOhCothzFR/JZabY6wvY8042OMzI/wCIbIGpXuwwqdGIvXrSvTHMES7g1Cd72OoIqiCGzvIO2EE5NsmOT6Dzyw9ZICP22XFaq2prb8kTg7cD4Bp1tL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775335; c=relaxed/simple;
	bh=r7h4U9YKMPrR7nlChjWCNOB1XfOyNYsr7P795fJvqrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EZvbpS7keLp7OuY3RqPdPffNur/XRk0XQN3gf52IyI2wfH8voS0XY0UuRxWeqgePqReHm4t8hY+7OtjsxOwVSXrcs5rGd0ZcHokg9SioqorJKNVU8mgKAFWDs2o+STrpFgpxu+X+4dHwJm6ZocXYmqCmYlYtn7ncQ6VcGVvJVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=STvwneNc; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="STvwneNc"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5AFF1780389;
	Wed, 30 Sep 2026 15:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790775309;
	bh=r7h4U9YKMPrR7nlChjWCNOB1XfOyNYsr7P795fJvqrk=;
	h=From:Date:Subject:To:Cc:From;
	b=STvwneNc2hVxo0oL1+sq+XJZnHj7SB3S9QyRxa0O4wgimFpAI5JLaGfd8J7N+yJRf
	 +/7JD8CQFtjbUZskViwOiJZqvBgo7/oLrwDbl1LFpdByeWVshrnvvZrPSgdMVkTjII
	 TphaWtrR7XXQznb0YTdDs260autB/T8nAzpZolfltFNDR5GjJ2HNdH2y+DjfVXA8MA
	 6u2DYr0J83XSubLPut0Yo3U++Nw2u/G5l4xZsvvAMgoCTr5W+9TrpWhwJjDKoRUNTU
	 f9NQiDmhad7n2qBC0nJ4p1+caIvtnO6Qxdy8U/DF+rIrp0EfuhaIjJs2DkVj6V4dOB
	 R6RNBTi7iajIg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Wed, 30 Sep 2026 15:34:48 +0200
Subject: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-peak_usb-canfd-loopback-v1-1-fdcb87611fc6@peak-system.fr>
X-B4-Tracking: v=1; b=H4sIAPcPvWoC/y2NUQrCMBBEr1L220DaolCvIiJJuqtrJYnZRoTSu
 7tq5+/BzJsFBAujwLFZoOCLhVNUaHcNhJuLVzQ8KkNnu4MdemsyuulSxZvgIo3mkVL2LkyGNGi
 JBtvuQde5IPH7Zz6d/yzV3zHMX93WKPisejlvtXX9ALVFAJ+QAAAA
X-Change-ID: 20260930-peak_usb-canfd-loopback-ffffe0ff9015
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.16.0

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

This commit adds loopback mode support for all PEAK-System USB-to-CAN FD
interfaces.

The implementation follows the same approach as the peak_pciefd driver.
The only difference is local echo handling: on USB devices, transmit
confirmations are provided through USB write acknowledgments rather than
through the reception of a controller-generated loopback frame.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 5840623662af..a00ce1f52341 100644
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
@@ -1266,7 +1272,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
 			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+			CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1343,7 +1349,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-		CAN_CTRLMODE_BERR_REPORTING,
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1420,7 +1426,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
 			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+			CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1497,7 +1503,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
 			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
-			CAN_CTRLMODE_BERR_REPORTING,
+			CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},

---
base-commit: baf950233c8efcd3807f771ae5dc3cd6f5326278
change-id: 20260930-peak_usb-canfd-loopback-ffffe0ff9015

Best regards,
--  
Stéphane Grosjean <s.grosjean@peak-system.fr>

