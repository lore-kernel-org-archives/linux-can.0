From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/13] can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode acknowledgment
Date: Mon,  9 Dec 2019 17:32:51 +0100
Message-ID: <20191209163256.12000-9-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>, Sean Nyekjaer <sean@geanix.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Stop Mode is entered when Stop Mode is requested at chip level and
MCR[LPM_ACK] is asserted by the FlexCAN.

Double check with IP owner, the MCR[LPM_ACK] bit should be polled for
stop mode acknowledgment, not the acknowledgment from chip level which
is used to gate flexcan clocks.

This patch depends on:

    b7603d080ffc ("can: flexcan: add low power enter/exit acknowledgment helper")

Fixes: 5f186c257fa4 (can: flexcan: fix stop mode acknowledgment)
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v5.0
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 9f3a5e56fc37..94d10ec954a0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -435,7 +435,6 @@ static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
 static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
-	unsigned int ackval;
 	u32 reg_mcr;
 
 	reg_mcr = priv->read(&regs->mcr);
@@ -446,36 +445,24 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
 
-	/* get stop acknowledgment */
-	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
-				     ackval, ackval & (1 << priv->stm.ack_bit),
-				     0, FLEXCAN_TIMEOUT_US))
-		return -ETIMEDOUT;
-
-	return 0;
+	return flexcan_low_power_enter_ack(priv);
 }
 
 static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
-	unsigned int ackval;
 	u32 reg_mcr;
 
 	/* remove stop request */
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 0);
 
-	/* get stop acknowledgment */
-	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
-				     ackval, !(ackval & (1 << priv->stm.ack_bit)),
-				     0, FLEXCAN_TIMEOUT_US))
-		return -ETIMEDOUT;
 
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	return 0;
+	return flexcan_low_power_exit_ack(priv);
 }
 
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
-- 
2.24.0
