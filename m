From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: pcan_usb: fix wrong memcpy() bytes length
Date: Fri,  9 Aug 2013 11:44:06 +0200
Message-ID: <1376041446-24058-2-git-send-email-mkl@pengutronix.de>
References: <1376041446-24058-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966066Ab3HIJoW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2013 05:44:22 -0400
In-Reply-To: <1376041446-24058-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, davem@davemloft.net, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

Fix possibly wrong memcpy() bytes length since some CAN records received from
PCAN-USB could define a DLC field in range [9..15].
In that case, the real DLC value MUST be used to move forward the record pointer
but, only 8 bytes max. MUST be copied into the data field of the struct
can_frame object of the skb given to the network core.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
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
1.8.3.1

