From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH v4 1/2] can: kvaser_usb: Simplify struct kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 14:41:06 +0100
Message-ID: <20180216134107.9096-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42134 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031758AbeBPNl1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 08:41:27 -0500
Received: by mail-lf0-f67.google.com with SMTP id t204so1441505lff.9
        for <linux-can@vger.kernel.org>; Fri, 16 Feb 2018 05:41:27 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

serial_number_high can be removed from the struct since it is never used in
the USBcan II firmware.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
Changes in v4:
  - Move change of ean to second patch.

Changes in v3:
  - Change data type of ean, from u32 to __le32.

Changes in v2:
  - Made this a separate patch.

 drivers/net/can/usb/kvaser_usb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 63587b8e6825..ca808a1bc892 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -196,16 +196,8 @@ struct kvaser_msg_simple {
 struct kvaser_msg_cardinfo {
 	u8 tid;
 	u8 nchannels;
-	union {
-		struct {
-			__le32 serial_number;
-			__le32 padding;
-		} __packed leaf0;
-		struct {
-			__le32 serial_number_low;
-			__le32 serial_number_high;
-		} __packed usbcan0;
-	} __packed;
+	__le32 serial_number;
+	__le32 padding0;
 	__le32 clock_resolution;
 	__le32 mfgdate;
 	u8 ean[8];
@@ -218,7 +210,7 @@ struct kvaser_msg_cardinfo {
 			u8 padding;
 		} __packed usbcan1;
 	} __packed;
-	__le16 padding;
+	__le16 padding1;
 } __packed;
 
 struct kvaser_msg_cardinfo2 {
-- 
2.16.1

