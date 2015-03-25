From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: ems_usb: mark timestamp as little endian
Date: Wed, 25 Mar 2015 10:37:54 +0100
Message-ID: <1427276274-19994-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36026 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbbCYJh5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2015 05:37:57 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: haas@ems-wuensche.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch marks the timestamp in struct ems_cpc_msg as little endian, though
it's not used in the driver for now.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 481f5392970a..866bac0ae7e9 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -200,8 +200,8 @@ struct __packed ems_cpc_msg {
 	u8 type;	/* type of message */
 	u8 length;	/* length of data within union 'msg' */
 	u8 msgid;	/* confirmation handle */
-	u32 ts_sec;	/* timestamp in seconds */
-	u32 ts_nsec;	/* timestamp in nano seconds */
+	__le32 ts_sec;	/* timestamp in seconds */
+	__le32 ts_nsec;	/* timestamp in nano seconds */
 
 	union {
 		u8 generic[64];
-- 
2.1.4

