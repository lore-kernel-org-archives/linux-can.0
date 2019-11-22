From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: m_can_platform: remove unnecessary m_can_class_resume() call
Date: Fri, 22 Nov 2019 15:52:51 +0100
Message-ID: <20191122145251.9775-3-mkl@pengutronix.de>
References: <20191122145251.9775-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191122145251.9775-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>, Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Pankaj Sharma <pankj.sharma@samsung.com>

The function m_can_runtime_resume() is getting recursively called from
m_can_class_resume(). This results in a lock up.

We need not call m_can_class_resume() during m_can_runtime_resume().

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can_platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 2eaa3543d233..38ea5e600fb8 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -166,8 +166,6 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 	if (err)
 		clk_disable_unprepare(mcan_class->hclk);
 
-	m_can_class_resume(dev);
-
 	return err;
 }
 
-- 
2.24.0
