From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] can: m_can: mark runtime-PM handlers as __maybe_unused
Date: Thu, 18 Jan 2018 14:04:42 +0100
Message-ID: <20180118130513.506569-1-arnd@arndb.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Quentin Schulz <quentin.schulz@free-electrons.com>, Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Building without CONFIG_PM results in a harmless warning:

drivers/net/can/m_can/m_can.c:1763:12: error: 'm_can_runtime_resume' defined but not used [-Werror=unused-function]
drivers/net/can/m_can/m_can.c:1752:12: error: 'm_can_runtime_suspend' defined but not used [-Werror=unused-function]

Marking the functions as __maybe_unused lets the compiler
silently drop them instead.

Fixes: cdf8259d6573 ("can: m_can: Add PM Support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 49ed8737871f..2594f7779c6f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1749,7 +1749,7 @@ static int m_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int m_can_runtime_suspend(struct device *dev)
+static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
@@ -1760,7 +1760,7 @@ static int m_can_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int m_can_runtime_resume(struct device *dev)
+static int __maybe_unused m_can_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
-- 
2.9.0
