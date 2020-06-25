From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: [PATCH BUGFIX] can: m_can: make m_can driver work with sleep state
 pinconfig
Date: Thu, 25 Jun 2020 14:24:35 +0200
Message-ID: <20200625142435.50371e2f@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Sriram Dash <sriram.dash@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi,

When trying to use the m_can driver on an stm32mp15 based system, I
found that I could not send or receive any data.
Analyzing the pinctrl registers revealed, that the pins were
configured for sleep state even when the can interfaces were in use.

Looking at the m_can_platform.c driver I found that:

commit f524f829b75a ("can: m_can: Create a m_can platform framework")

introduced a call to m_can_class_suspend() in the m_can_runtime_suspend()
function which wasn't there in the original code and which causes the
pins used by the controller to be configured for sleep state.

commit 0704c5743694 ("can: m_can_platform: remove unnecessary m_can_class_resume() call")
already removed a bogus call to m_can_class_resume() from the
m_can_runtime_resume() function, but failed to remove the matching
call to m_can_class_suspend() from the m_can_runtime_suspend() function.

Removing the bogus call to m_can_class_suspend() in the
m_can_runtime_suspend() function fixes this.

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Fixes: 0704c5743694 ("can: m_can_platform: remove unnecessary m_can_class_resume() call")
Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
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
 
-- 
2.11.0



-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
