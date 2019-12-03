From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] can: xilinx_can: skip error message on deferred probe
Date: Tue,  3 Dec 2019 11:47:02 +0100
Message-ID: <20191203104703.14620-6-mkl@pengutronix.de>
References: <20191203104703.14620-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191203104703.14620-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>, Srinivas Neeli <srinivas.neeli@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>

When the CAN bus clock is provided from the clock wizard, clock wizard
driver may not be available when can driver probes resulting to the
error message "bus clock not found error".

As this error message is not very useful to the end user, skip printing
in the case of deferred probe.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4a96e2dd7d77..c5f05b994435 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1772,7 +1772,8 @@ static int xcan_probe(struct platform_device *pdev)
 
 	priv->bus_clk = devm_clk_get(&pdev->dev, devtype->bus_clk_name);
 	if (IS_ERR(priv->bus_clk)) {
-		dev_err(&pdev->dev, "bus clock not found\n");
+		if (PTR_ERR(priv->bus_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "bus clock not found\n");
 		ret = PTR_ERR(priv->bus_clk);
 		goto err_free;
 	}
-- 
2.24.0
