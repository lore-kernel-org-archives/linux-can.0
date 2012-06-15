From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: precedence error in c_can_chip_config()
Date: Fri, 15 Jun 2012 12:20:44 +0200
Message-ID: <1339755644-6686-2-git-send-email-mkl@pengutronix.de>
References: <1339755644-6686-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46321 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2FOKU4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Jun 2012 06:20:56 -0400
In-Reply-To: <1339755644-6686-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Dan Carpenter <dan.carpenter@oracle.com>

(CAN_CTRLMODE_LISTENONLY & CAN_CTRLMODE_LOOPBACK) is (0x02 & 0x01) which
is zero so the condition is never true.  The intent here was to test
that both flags were set.

Cc: <stable@kernel.org> # 2.6.39+
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 8dc84d6..86cd532 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -590,8 +590,8 @@ static void c_can_chip_config(struct net_device *dev)
 	priv->write_reg(priv, &priv->regs->control,
 			CONTROL_ENABLE_AR);
 
-	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY &
-					CAN_CTRLMODE_LOOPBACK)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
+	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
 		/* loopback + silent mode : useful for hot self-test */
 		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
 				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
-- 
1.7.4.1

