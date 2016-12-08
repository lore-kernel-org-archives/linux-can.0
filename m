From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/4] can: peak: fix usage of usb specific data type
Date: Thu,  8 Dec 2016 15:38:41 +0100
Message-ID: <1481207924-28977-2-git-send-email-s.grosjean@peak-system.com>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:43652 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751688AbcLHOjI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2016 09:39:08 -0500
In-Reply-To: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch fixes the wrong usage of a specific USB data type into a common
header file. This common header file is intended to define the common data
types and values that define access to the PEAK-System CAN-FD IP, whatever
the PC interface is.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_ucan.h   |  5 ++---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/can/usb/peak_usb/pcan_ucan.h
index 2147678..104a467 100644
--- a/drivers/net/can/usb/peak_usb/pcan_ucan.h
+++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
@@ -213,10 +213,9 @@ struct __packed pucan_tx_msg {
 };
 
 /* build the cmd opcode_channel field with respect to the correct endianness */
-static inline __le16 pucan_cmd_opcode_channel(struct peak_usb_device *dev,
-					      int opcode)
+static inline __le16 pucan_cmd_opcode_channel(int index, int opcode)
 {
-	return cpu_to_le16(((dev->ctrl_idx) << 12) | ((opcode) & 0x3ff));
+	return cpu_to_le16(((index) << 12) | ((opcode) & 0x3ff));
 }
 
 /* return the channel number part from any received message channel_dlc field */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 3047325..64cba85 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -238,7 +238,7 @@ static int pcan_usb_fd_build_restart_cmd(struct peak_usb_device *dev, u8 *buf)
 
 	/* 1st, reset error counters: */
 	prc = (struct pucan_wr_err_cnt *)pc;
-	prc->opcode_channel = pucan_cmd_opcode_channel(dev,
+	prc->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 						       PUCAN_CMD_WR_ERR_CNT);
 
 	/* select both counters */
@@ -257,9 +257,10 @@ static int pcan_usb_fd_build_restart_cmd(struct peak_usb_device *dev, u8 *buf)
 
 		puo->opcode_channel =
 			(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) ?
-			pucan_cmd_opcode_channel(dev,
+			pucan_cmd_opcode_channel(dev->ctrl_idx,
 						 PUCAN_CMD_CLR_DIS_OPTION) :
-			pucan_cmd_opcode_channel(dev, PUCAN_CMD_SET_EN_OPTION);
+			pucan_cmd_opcode_channel(dev->ctrl_idx,
+						 PUCAN_CMD_SET_EN_OPTION);
 
 		puo->options = cpu_to_le16(PUCAN_OPTION_CANDFDISO);
 
@@ -274,7 +275,7 @@ static int pcan_usb_fd_build_restart_cmd(struct peak_usb_device *dev, u8 *buf)
 
 	/* next, go back to operational mode */
 	cmd = (struct pucan_command *)pc;
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 				(dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
 						PUCAN_CMD_LISTEN_ONLY_MODE :
 						PUCAN_CMD_NORMAL_MODE);
@@ -296,7 +297,7 @@ static int pcan_usb_fd_set_bus(struct peak_usb_device *dev, u8 onoff)
 		struct pucan_command *cmd = (struct pucan_command *)pc;
 
 		/* build cmd to go back to reset mode */
-		cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+		cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 							PUCAN_CMD_RESET_MODE);
 		l = sizeof(struct pucan_command);
 	}
@@ -332,7 +333,7 @@ static int pcan_usb_fd_set_filter_std(struct peak_usb_device *dev, int idx,
 	}
 
 	for (i = idx; i < n; i++, cmd++) {
-		cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+		cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 							PUCAN_CMD_FILTER_STD);
 		cmd->idx = cpu_to_le16(i);
 		cmd->mask = cpu_to_le32(mask);
@@ -352,7 +353,7 @@ static int pcan_usb_fd_set_options(struct peak_usb_device *dev,
 {
 	struct pcan_ufd_options *cmd = pcan_usb_fd_cmd_buffer(dev);
 
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 					(onoff) ? PUCAN_CMD_SET_EN_OPTION :
 						  PUCAN_CMD_CLR_DIS_OPTION);
 
@@ -368,7 +369,7 @@ static int pcan_usb_fd_set_can_led(struct peak_usb_device *dev, u8 led_mode)
 {
 	struct pcan_ufd_led *cmd = pcan_usb_fd_cmd_buffer(dev);
 
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 						       PCAN_UFD_CMD_LED_SET);
 	cmd->mode = led_mode;
 
@@ -382,7 +383,7 @@ static int pcan_usb_fd_set_clock_domain(struct peak_usb_device *dev,
 {
 	struct pcan_ufd_clock *cmd = pcan_usb_fd_cmd_buffer(dev);
 
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 						       PCAN_UFD_CMD_CLK_SET);
 	cmd->mode = clk_mode;
 
@@ -396,7 +397,7 @@ static int pcan_usb_fd_set_bittiming_slow(struct peak_usb_device *dev,
 {
 	struct pucan_timing_slow *cmd = pcan_usb_fd_cmd_buffer(dev);
 
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 						       PUCAN_CMD_TIMING_SLOW);
 	cmd->sjw_t = PUCAN_TSLOW_SJW_T(bt->sjw - 1,
 				dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
@@ -417,7 +418,7 @@ static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
 {
 	struct pucan_timing_fast *cmd = pcan_usb_fd_cmd_buffer(dev);
 
-	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
 						       PUCAN_CMD_TIMING_FAST);
 	cmd->sjw = PUCAN_TFAST_SJW(bt->sjw - 1);
 	cmd->tseg2 = PUCAN_TFAST_TSEG2(bt->phase_seg2 - 1);
-- 
2.7.4

