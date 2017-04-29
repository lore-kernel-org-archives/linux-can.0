From: Bogdan Mirea <Bogdan-Stefan_mirea@mentor.com>
Subject: [PATCH] Enabling rcar_can changelink support
Date: Sat, 29 Apr 2017 22:48:03 +0300
Message-ID: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net
Cc: Bogdan Mirea <Bogdan-Stefan_mirea@mentor.com>, Eugen Hristev <Eugen_hristev@mentor.com>
List-Id: linux-can.vger.kernel.org

Added rcar_can_set_bittiming as can.do_set_bittiming callback that will
be called from can_changelink generic callback when link state is
changed.

This enables set bittiming support:
	ip link set can0 type can bitrate 500000 triple-sampling on

Signed-off-by: Bogdan Mirea <Bogdan-Stefan_mirea@mentor.com>
Signed-off-by: Eugen Hristev <Eugen_hristev@mentor.com>
---
 drivers/net/can/rcar_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 788459f..cfabb95 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -419,7 +419,7 @@ static irqreturn_t rcar_can_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void rcar_can_set_bittiming(struct net_device *dev)
+static int rcar_can_set_bittiming(struct net_device *dev)
 {
 	struct rcar_can_priv *priv = netdev_priv(dev);
 	struct can_bittiming *bt = &priv->can.bittiming;
@@ -433,6 +433,8 @@ static void rcar_can_set_bittiming(struct net_device *dev)
 	 * read/write (but not on 8-bit, contrary to the manuals)...
 	 */
 	writel((bcr << 8) | priv->clock_select, &priv->regs->bcr);
+
+	return 0;
 }
 
 static void rcar_can_start(struct net_device *ndev)
@@ -809,6 +811,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 	priv->clock_select = clock_select;
 	priv->can.clock.freq = clk_get_rate(priv->can_clk);
 	priv->can.bittiming_const = &rcar_can_bittiming_const;
+	priv->can.do_set_bittiming = &rcar_can_set_bittiming;
 	priv->can.do_set_mode = rcar_can_do_set_mode;
 	priv->can.do_get_berr_counter = rcar_can_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
-- 
1.9.1
