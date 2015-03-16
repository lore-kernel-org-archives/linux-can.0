From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] peak_usb_fd: add support for ISO / non-ISO mode switching
Date: Mon, 16 Mar 2015 11:57:53 +0100
Message-ID: <1426503473-7403-2-git-send-email-s.grosjean@peak-system.com>
References: <1426503473-7403-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:55850 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbCPK6S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 06:58:18 -0400
In-Reply-To: <1426503473-7403-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>

The PCAN USB (pro) FD adapters with firmware versions > 2.x support the
switching between ISO (default) and non-ISO conform bitstreams on the CAN bus.
The setting for the 2.x firmware adapters can be modified with the 'ip' tool
from the iproute2 package (option: fd-non-iso [on|off]).

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/usb/peak_usb/pcan_ucan.h   |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 31 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/can/usb/peak_usb/pcan_ucan.h
index 1fb3330..e8fc495 100644
--- a/drivers/net/can/usb/peak_usb/pcan_ucan.h
+++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
@@ -104,6 +104,7 @@ struct __packed pucan_wr_err_cnt {
 /* uCAN SET_EN/CLR_DIS _OPTION command fields */
 #define PUCAN_OPTION_ERROR		0x0001
 #define PUCAN_OPTION_BUSLOAD		0x0002
+#define PUCAN_OPTION_CANDFDISO		0x0004
 
 struct __packed pucan_options {
 	__le16	opcode_channel;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 7506a83..90bd96f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -251,6 +251,27 @@ static int pcan_usb_fd_build_restart_cmd(struct peak_usb_device *dev, u8 *buf)
 	/* moves the pointer forward */
 	pc += sizeof(struct pucan_wr_err_cnt);
 
+	/* add command to switch from ISO to non-ISO mode, if fw allows it */
+	if (dev->can.ctrlmode_supported & CAN_CTRLMODE_FD_NON_ISO) {
+		struct pucan_options *puo = (struct pucan_options *)pc;
+
+		puo->opcode_channel =
+			(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO) ?
+			pucan_cmd_opcode_channel(dev,
+						 PUCAN_CMD_CLR_DIS_OPTION) :
+			pucan_cmd_opcode_channel(dev, PUCAN_CMD_SET_EN_OPTION);
+
+		puo->options = cpu_to_le16(PUCAN_OPTION_CANDFDISO);
+
+		/* to be sure that no other extended bits will be taken into
+		 * account
+		 */
+		puo->unused = 0;
+
+		/* moves the pointer forward */
+		pc += sizeof(struct pucan_options);
+	}
+
 	/* next, go back to operational mode */
 	cmd = (struct pucan_command *)pc;
 	cmd->opcode_channel = pucan_cmd_opcode_channel(dev,
@@ -860,8 +881,14 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			 pdev->usb_if->fw_info.fw_version[2],
 			 dev->adapter->ctrl_count);
 
-		/* the currently supported hw is non-ISO */
-		dev->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
+		/* check for ability to switch between ISO/non-ISO modes */
+		if (pdev->usb_if->fw_info.fw_version[0] >= 2) {
+			/* firmware >= 2.x supports ISO/non-ISO switching */
+			dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
+		} else {
+			/* firmware < 2.x only supports fixed(!) non-ISO */
+			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
+		}
 
 		/* tell the hardware the can driver is running */
 		err = pcan_usb_fd_drv_loaded(dev, 1);
-- 
1.9.1

