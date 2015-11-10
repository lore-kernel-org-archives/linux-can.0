From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: [PATCH 1/1] can: sja1000: clear interrupts on start
Date: Tue, 10 Nov 2015 14:59:34 +0100
Message-ID: <1447163974-24514-1-git-send-email-mirza.krak@hostmobility.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: andri.yngvason@marel.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mirza Krak <mirza.krak@hostmobility.com>
List-Id: linux-can.vger.kernel.org

From: Mirza Krak <mirza.krak@hostmobility.com>

According to SJA1000 data sheet error-warning (EI) interrupt is not
cleared by setting the controller in to reset-mode.

Then if we have the following case:
- system is suspended (echo mem > /sys/power/state) and SJA1000 is left
in operating state
- A bus error condition occurs which activates EI interrupt, system is
still suspended which means EI interrupt will be not be handled nor
cleared.

If the above two events occur, on resume there is no way to return the
SJA1000 to operating state, except to cycle power to it.

By simply reading the IR register on start we will clear any previous
conditions that could be present.

Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
---
 drivers/net/can/sja1000/sja1000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7b92e911a616..f10834be48a5 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -218,6 +218,9 @@ static void sja1000_start(struct net_device *dev)
 	priv->write_reg(priv, SJA1000_RXERR, 0x0);
 	priv->read_reg(priv, SJA1000_ECC);
 
+	/* clear interrupt flags */
+	priv->read_reg(priv, SJA1000_IR);
+
 	/* leave reset mode */
 	set_normal_mode(dev);
 }
-- 
2.1.0
