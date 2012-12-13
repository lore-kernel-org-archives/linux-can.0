From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] c_can: Set reserved bit in IFx_MASK2 to set 1 on write
Date: Thu, 13 Dec 2012 10:06:10 +0100
Message-ID: <1355389570-24180-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53140 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277Ab2LMJGS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Dec 2012 04:06:18 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/c_can/c_can.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 30646d6..2f9dedd2 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -495,8 +495,12 @@ static void c_can_setup_receive_object(struct net_device *dev,
 
 	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface),
 			IFX_WRITE_LOW_16BIT(mask));
+
+	/* According to C_CAN documentation, the reserved bit
+	 * in IFx_MASK2 register is fixed 1
+	 */
 	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface),
-			IFX_WRITE_HIGH_16BIT(mask));
+			IFX_WRITE_HIGH_16BIT(mask) | BIT(13));
 
 	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
 			IFX_WRITE_LOW_16BIT(id));
-- 
1.7.8.6

