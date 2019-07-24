From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/7] can: flexcan: fix stop mode acknowledgment
Date: Wed, 24 Jul 2019 15:03:20 +0200
Message-ID: <20190724130322.31702-6-mkl@pengutronix.de>
References: <20190724130322.31702-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190724130322.31702-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

To enter stop mode, the CPU should manually assert a global Stop Mode
request and check the acknowledgment asserted by FlexCAN. The CPU must
only consider the FlexCAN in stop mode when both request and
acknowledgment conditions are satisfied.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v5.0
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 33ce45d51e15..fcec8bcb53d6 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -400,9 +400,10 @@ static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
 	priv->write(reg_mcr, &regs->mcr);
 }
 
-static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
+static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
+	unsigned int ackval;
 	u32 reg_mcr;
 
 	reg_mcr = priv->read(&regs->mcr);
@@ -412,20 +413,37 @@ static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	/* enable stop request */
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+
+	/* get stop acknowledgment */
+	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
+				     ackval, ackval & (1 << priv->stm.ack_bit),
+				     0, FLEXCAN_TIMEOUT_US))
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
-static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
+static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
+	unsigned int ackval;
 	u32 reg_mcr;
 
 	/* remove stop request */
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 0);
 
+	/* get stop acknowledgment */
+	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
+				     ackval, !(ackval & (1 << priv->stm.ack_bit)),
+				     0, FLEXCAN_TIMEOUT_US))
+		return -ETIMEDOUT;
+
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
+
+	return 0;
 }
 
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
@@ -1614,7 +1632,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 		 */
 		if (device_may_wakeup(device)) {
 			enable_irq_wake(dev->irq);
-			flexcan_enter_stop_mode(priv);
+			err = flexcan_enter_stop_mode(priv);
+			if (err)
+				return err;
 		} else {
 			err = flexcan_chip_disable(priv);
 			if (err)
@@ -1664,10 +1684,13 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
+	int err;
 
 	if (netif_running(dev) && device_may_wakeup(device)) {
 		flexcan_enable_wakeup_irq(priv, false);
-		flexcan_exit_stop_mode(priv);
+		err = flexcan_exit_stop_mode(priv);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.20.1
