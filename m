From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/4] can: peak: fix usage of const qualifier in pointers args
Date: Thu,  8 Dec 2016 15:38:42 +0100
Message-ID: <1481207924-28977-3-git-send-email-s.grosjean@peak-system.com>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:39243 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751772AbcLHOjI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2016 09:39:08 -0500
In-Reply-To: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

Fixes the usage of the const qualifier in the memory pointer arguments
of the declared inline functions. By changing the line containing "const",
this patch also changes the name of the arg into a more usual one.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_ucan.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/can/usb/peak_usb/pcan_ucan.h
index 104a467..25e20ef 100644
--- a/drivers/net/can/usb/peak_usb/pcan_ucan.h
+++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
@@ -219,25 +219,25 @@ static inline __le16 pucan_cmd_opcode_channel(int index, int opcode)
 }
 
 /* return the channel number part from any received message channel_dlc field */
-static inline int pucan_msg_get_channel(struct pucan_rx_msg *rm)
+static inline int pucan_msg_get_channel(const struct pucan_rx_msg *msg)
 {
-	return rm->channel_dlc & 0xf;
+	return msg->channel_dlc & 0xf;
 }
 
 /* return the dlc value from any received message channel_dlc field */
-static inline int pucan_msg_get_dlc(struct pucan_rx_msg *rm)
+static inline int pucan_msg_get_dlc(const struct pucan_rx_msg *msg)
 {
-	return rm->channel_dlc >> 4;
+	return msg->channel_dlc >> 4;
 }
 
-static inline int pucan_ermsg_get_channel(struct pucan_error_msg *em)
+static inline int pucan_ermsg_get_channel(const struct pucan_error_msg *msg)
 {
-	return em->channel_type_d & 0x0f;
+	return msg->channel_type_d & 0x0f;
 }
 
-static inline int pucan_stmsg_get_channel(struct pucan_status_msg *sm)
+static inline int pucan_stmsg_get_channel(const struct pucan_status_msg *msg)
 {
-	return sm->channel_p_w_b & 0x0f;
+	return msg->channel_p_w_b & 0x0f;
 }
 
 #endif
-- 
2.7.4

