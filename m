From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/17] can: xilinx_can: fix comparison of unsigned variable
Date: Tue, 18 Nov 2014 21:37:36 +0100
Message-ID: <1416343067-9810-7-git-send-email-mkl@pengutronix.de>
References: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Sudip Mukherjee <sudip@vectorindia.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The variable err was of the type u32. It was being compared with < 0, and being
an unsigned variable the comparison would have been always false.

Moreover, err was getting the return value from set_reset_mode() and
xcan_set_bittiming(), and both are returning int.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 5e8b5609c067..47b2f801d127 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -300,7 +300,8 @@ static int xcan_set_bittiming(struct net_device *ndev)
 static int xcan_chip_start(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
-	u32 err, reg_msr, reg_sr_mask;
+	u32 reg_msr, reg_sr_mask;
+	int err;
 	unsigned long timeout;
 
 	/* Check if it is in reset mode */
-- 
2.1.3
