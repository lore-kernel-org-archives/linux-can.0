From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 4/4] can: flexcan: Disable error irq when in error passive
Date: Tue, 12 Aug 2014 15:43:07 +0200
Message-ID: <1407850987-26707-4-git-send-email-alexander.stein@systec-electronic.com>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35618 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751737AbaHLNqq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 09:46:46 -0400
In-Reply-To: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

If the error irq is enabled and the hardware is trying to send a CAN
message to an open bus it will receive a lot of acknowledge errors and
generating lots of interrupts. So error interrupts are disabled when
entering error passive and reenable them when leaving error passive.
We can only leave error passive by receiving CAN frames in which case NAPI
is scheduled anyway or by sending more CAN frames when send is possible
again. But with the transition of error counters from 96 to 95 the flags
TX_WRN and RX_WRN are gone again, so we need to remember the flags state
to detect a change there.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/flexcan.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 65102e5456c2..9f604c14ad92 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -207,6 +207,7 @@ struct flexcan_priv {
 
 	void __iomem *base;
 	u32 reg_esr;
+	int warn;
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
@@ -575,6 +576,14 @@ static void flexcan_enable_err_irq(struct flexcan_priv *priv)
 		priv->reg_ctrl_default &= ~FLEXCAN_CTRL_ERR_MSK;
 }
 
+static void flexcan_disable_err_irq(struct flexcan_priv *priv)
+{
+	/* Disable the flag in reg_ctrl_default which will be written
+	 * in flexcan_poll
+	 */
+	priv->reg_ctrl_default &= ~FLEXCAN_CTRL_ERR_MSK;
+}
+
 static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -584,15 +593,19 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	int flt;
 
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
+	priv->warn = reg_esr & (FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN);
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
 		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
 					FLEXCAN_ESR_RX_WRN))))
 			new_state = CAN_STATE_ERROR_ACTIVE;
 		else
 			new_state = CAN_STATE_ERROR_WARNING;
-	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE))
+
+		flexcan_enable_err_irq(priv);
+	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
 		new_state = CAN_STATE_ERROR_PASSIVE;
-	else
+		flexcan_disable_err_irq(priv);
+	} else
 		new_state = CAN_STATE_BUS_OFF;
 
 	/* state hasn't changed */
@@ -735,6 +748,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
 	    (reg_esr & (FLEXCAN_ESR_ERR_STATE |
 			FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN)) ||
+	    (priv->warn !=
+		(reg_esr & (FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN))) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/*
 		 * The error bits are cleared on read,
-- 
1.8.5.5

