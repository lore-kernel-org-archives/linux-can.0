From: <tthayer@opensource.altera.com>
Subject: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.
Date: Thu, 16 Jun 2016 11:10:19 -0500
Message-ID: <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0073.outbound.protection.outlook.com ([65.55.169.73]:24752
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751563AbcFPQFp (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 16 Jun 2016 12:05:45 -0400
In-Reply-To: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, mkl@pengutronix.de, wg@grandegger.com, richard.andrysek@gomtec.de
Cc: anilkumar@ti.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tthayer.linux@gmail.com, tthayer@opensource.altera.com

From: Thor Thayer <tthayer@opensource.altera.com>

When testing CAN write floods on Altera's CycloneV, the
first 2 bytes are sometimes 0x00, 0x00 or corrupted
instead of the values sent. Also observed bytes 4 & 5
were corrupted in some cases.

The D_CAN Data registers are 32 bits and changing from
16 bit writes to 32 bit writes fixes the problem.

Testing performed on Altera CycloneV (D_CAN).
Requesting tests on other C_CAN & D_CAN platforms.

Reported-by: Richard Andrysek <richard.andrysek@gomtec.de>
Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/net/can/c_can/c_can.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index f91b094..e3dccd3 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -332,9 +332,23 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 
-	for (i = 0; i < frame->can_dlc; i += 2) {
-		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
-				frame->data[i] | (frame->data[i + 1] << 8));
+	if (priv->type == BOSCH_D_CAN) {
+		u32 data = 0, dreg = C_CAN_IFACE(DATA1_REG, iface);
+
+		for (i = 0; i < frame->can_dlc; i += 4, dreg += 2) {
+			data = (u32)frame->data[i];
+			data |= (u32)frame->data[i + 1] << 8;
+			data |= (u32)frame->data[i + 2] << 16;
+			data |= (u32)frame->data[i + 3] << 24;
+			priv->write_reg32(priv, dreg, data);
+		}
+	} else {
+		for (i = 0; i < frame->can_dlc; i += 2) {
+			priv->write_reg(priv,
+					C_CAN_IFACE(DATA1_REG, iface) + i / 2,
+					frame->data[i] |
+					(frame->data[i + 1] << 8));
+		}
 	}
 }
 
@@ -402,10 +416,20 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	} else {
 		int i, dreg = C_CAN_IFACE(DATA1_REG, iface);
 
-		for (i = 0; i < frame->can_dlc; i += 2, dreg ++) {
-			data = priv->read_reg(priv, dreg);
-			frame->data[i] = data;
-			frame->data[i + 1] = data >> 8;
+		if (priv->type == BOSCH_D_CAN) {
+			for (i = 0; i < frame->can_dlc; i += 4, dreg += 2) {
+				data = priv->read_reg32(priv, dreg);
+				frame->data[i] = data;
+				frame->data[i + 1] = data >> 8;
+				frame->data[i + 2] = data >> 16;
+				frame->data[i + 3] = data >> 24;
+			}
+		} else {
+			for (i = 0; i < frame->can_dlc; i += 2, dreg++) {
+				data = priv->read_reg(priv, dreg);
+				frame->data[i] = data;
+				frame->data[i + 1] = data >> 8;
+			}
 		}
 	}
 
-- 
1.7.9.5

