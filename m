From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: end pending transmission on network stop (ifdown)
Date: Wed, 21 Jan 2015 22:46:31 +0100
Message-ID: <1421876791-31014-2-git-send-email-mkl@pengutronix.de>
References: <1421876791-31014-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52017 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbbAUVql (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Jan 2015 16:46:41 -0500
In-Reply-To: <1421876791-31014-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Viktor Babrian <babrian.viktor@renyi.mta.hu>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Viktor Babrian <babrian.viktor@renyi.mta.hu>

Put controller into init mode in network stop to end pending transmissions. The
issue is observed in cases when transmitted frame is not acked.

Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index f94a9fa60488..c672c4dcffac 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -615,6 +615,9 @@ static void c_can_stop(struct net_device *dev)
 
 	c_can_irq_control(priv, false);
 
+	/* put ctrl to init on stop to end ongoing transmission */
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_INIT);
+
 	/* deactivate pins */
 	pinctrl_pm_select_sleep_state(dev->dev.parent);
 	priv->can.state = CAN_STATE_STOPPED;
-- 
2.1.4

