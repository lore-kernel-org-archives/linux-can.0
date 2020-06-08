From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] can: m_can_platform: fix m_can_runtime_suspend()
Date: Mon,  8 Jun 2020 11:43:48 +0200
Message-ID: <20200608094348.12650-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-can.vger.kernel.org

Since commit f524f829b75a ("can: m_can: Create a m_can platform
framework"), the can peripheral on STM32MP1 wasn't working anymore.

The reason was a bad copy/paste maneuver that added a call to
m_can_class_suspend() in m_can_runtime_suspend().

Tested on STM32MP157C-DK2 and emSBC-Argon

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/net/can/m_can/m_can_platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..e6d0cb9ee02f 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -144,8 +144,6 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
 
-	m_can_class_suspend(dev);
-
 	clk_disable_unprepare(mcan_class->cclk);
 	clk_disable_unprepare(mcan_class->hclk);
 
