From: Davide Massarenti <davide.m@optio3.com>
Subject: [PATCH] can: m_can_platform: restore necessary m_can_class_resume()
 call
Date: Thu, 6 Aug 2020 18:34:54 -0700
Message-ID: <20200807013452.GA122904@optio3.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr760108.outbound.protection.outlook.com ([40.107.76.108]:36736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgHGBe7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 Aug 2020 21:34:59 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dmurphy@ti.com, linux-can@vger.kernel.org

Hi there,

After the last refactoring, m_can_runtime_suspend()/resume() would call
the corresponding m_can_class_suspend() and m_can_class_resume() functions.
That caused a recursion through m_can_clk_start/stop calls, with a deadlock
due to spin_lock_irqsave(&dev->power.lock, flags).

The temporary solution, put in place in 0704c57,
was to remove the call to m_can_runtime_resume().

However, this breaks the driver on SoCs that use pinmux to control
the CAN controller. The controller would be permanently disconnected
from the outside world.

The fix for the recursion is to remove calls to m_can_clk_start/stop()
from resume/suspend, since m_can_clk_start/stop() calls are
what triggered resume/suspend.

Signed-off-by: Davide Massarenti <davide.m@optio3.com>
---
 drivers/net/can/m_can/m_can.c          | 7 -------
 drivers/net/can/m_can/m_can_platform.c | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..f801205fff78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1866,7 +1866,6 @@ int m_can_class_suspend(struct device *dev)
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
 		m_can_stop(ndev);
-		m_can_clk_stop(cdev);
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1887,12 +1886,6 @@ int m_can_class_resume(struct device *dev)
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
-		int ret;
-
-		ret = m_can_clk_start(cdev);
-		if (ret)
-			return ret;
-
 		m_can_init_ram(cdev);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..51497410c4c1 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -166,6 +166,9 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 	if (err)
 		clk_disable_unprepare(mcan_class->hclk);
 
+	if (!err)
+		m_can_class_resume(dev);
+
 	return err;
 }
 
-- 
2.17.1
