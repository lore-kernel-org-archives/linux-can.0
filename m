From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] peak_usb: PCAN-USB specific part: fix little endian usage
Date: Wed,  7 Mar 2012 15:31:30 +0100
Message-ID: <1331130691-25782-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-4d.bbox.fr ([194.158.122.134]:44804 "EHLO mail-4d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab2CGOa0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 7 Mar 2012 09:30:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-usb Mailing List <linux-usb@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

That patch fixes some bad usage of two little-endian variables, which lead to
some warning/error when building the peak_usb driver.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8a7982e..86f26a1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -741,16 +741,14 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 
 	/* can id */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		__le32 tmp32 = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		__le32 tmp32 = cpu_to_le32((cf->can_id & CAN_ERR_MASK) << 3);
 
-		tmp32 <<= 3;
 		*pc |= PCAN_USB_STATUSLEN_EXT_ID;
 		memcpy(++pc, &tmp32, 4);
 		pc += 4;
 	} else {
-		__le16 tmp16 = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		__le16 tmp16 = cpu_to_le16((cf->can_id & CAN_ERR_MASK) << 5);
 
-		tmp16 <<= 5;
 		memcpy(++pc, &tmp16, 2);
 		pc += 2;
 	}
-- 
1.7.5.4

