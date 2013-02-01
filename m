From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: Set reserved bit in IFx_MASK2 to 1 on write
Date: Fri,  1 Feb 2013 10:25:14 +0100
Message-ID: <1359710714-1565-2-git-send-email-mkl@pengutronix.de>
References: <1359710714-1565-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3BAJZU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 04:25:20 -0500
In-Reply-To: <1359710714-1565-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexander Stein <alexander.stein@systec-electronic.com>

According to C_CAN documentation, the reserved bit in IFx_MASK2 register is
fixed 1.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 58607f1..2282b1a 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -488,8 +488,12 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 
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
1.7.10.4

