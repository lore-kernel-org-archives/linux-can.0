From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] pcan_usb: fix wrong memcpy() bytes length
Date: Thu,  8 Aug 2013 10:52:31 +0200
Message-ID: <1375951951-18507-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:40624 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934040Ab3HHJBC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Aug 2013 05:01:02 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

Fix possibly wrong memcpy() bytes length since some CAN records received from
PCAN-USB could define a DLC field in range [9..15].
In that case, the real DLC value MUST be used to move forward the record pointer
but, only 8 bytes max. MUST be copied into the data field of the struct
can_frame object of the skb given to the network core.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 25723d8..925ab8e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -649,7 +649,7 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		if ((mc->ptr + rec_len) > mc->end)
 			goto decode_failed;
 
-		memcpy(cf->data, mc->ptr, rec_len);
+		memcpy(cf->data, mc->ptr, cf->can_dlc);
 		mc->ptr += rec_len;
 	}
 
-- 
1.7.10.4

