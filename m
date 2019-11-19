From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH 2/2] can: m_can_platform: remove unnecessary
 m_can_class_resume() call
Date: Tue, 19 Nov 2019 15:50:38 +0530
Message-ID: <1574158838-4616-3-git-send-email-pankj.sharma@samsung.com>
References: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
        <CGME20191119102201epcas5p4e215c25d5d07269a7afb1f86fac0be65@epcas5p4.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, dmurphy@ti.com, rcsekar@samsung.com, pankaj.dubey@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

The function m_can_runtime_resume() is getting recursively called from
m_can_class_resume(). This results in a lock up.

We need not call m_can_class_resume() during m_can_runtime_resume().

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")

Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 drivers/net/can/m_can/m_can_platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 2eaa354..38ea5e6 100644
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
2.7.4
