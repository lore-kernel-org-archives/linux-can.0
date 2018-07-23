From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/12] can: m_can: Fix runtime resume call
Date: Mon, 23 Jul 2018 14:58:35 +0200
Message-ID: <20180723125843.391-5-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Faiz Abbas <faiz_abbas@ti.com>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

pm_runtime_get_sync() returns a 1 if the state of the device is already
'active'. This is not a failure case and should return a success.

Therefore fix error handling for pm_runtime_get_sync() call such that
it returns success when the value is 1.

Also cleanup the TODO for using runtime PM for sleep mode as that is
implemented.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8e2b7f873c4d..e2f965c2e3aa 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -634,10 +634,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
 	int err;
 
 	err = pm_runtime_get_sync(priv->device);
-	if (err)
+	if (err < 0) {
 		pm_runtime_put_noidle(priv->device);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static void m_can_clk_stop(struct m_can_priv *priv)
@@ -1688,8 +1690,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	return ret;
 }
 
-/* TODO: runtime PM with power down or sleep mode  */
-
 static __maybe_unused int m_can_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-- 
2.18.0
