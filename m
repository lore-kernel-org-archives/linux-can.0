From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/12] can: m_can: Move accessing of message ram to after clocks are enabled
Date: Mon, 23 Jul 2018 14:58:36 +0200
Message-ID: <20180723125843.391-6-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Faiz Abbas <faiz_abbas@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

MCAN message ram should only be accessed once clocks are enabled.
Therefore, move the call to parse/init the message ram to after
clocks are enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e2f965c2e3aa..9b449400376b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1645,8 +1645,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(cclk);
 	priv->mram_base = mram_addr;
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -1669,6 +1667,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	m_can_of_parse_mram(priv, mram_config_vals);
+
 	devm_can_led_init(dev);
 
 	of_can_transceiver(dev);
@@ -1716,8 +1716,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	m_can_init_ram(priv);
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
@@ -1727,6 +1725,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		m_can_init_ram(priv);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
 		netif_start_queue(ndev);
-- 
2.18.0
