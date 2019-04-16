From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] can: flexcan: fix deadlock when using self wakeup
Date: Tue, 16 Apr 2019 16:35:11 +0200
Message-ID: <20190416143512.17735-1-sean@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: Sean Nyekjaer <sean@geanix.com>
List-Id: linux-can.vger.kernel.org

When suspending, when there is still can traffic on the
interfaces the flexcan immediately wakes the platform again.
As it should :-)
But it throws this error msg:
[ 3169.378661] PM: noirq suspend of devices failed

On the way down to suspend the interface that throws the error
message does call flexcan_suspend but fails to call
flexcan_noirq_suspend.
That means the flexcan_enter_stop_mode is called, but on the way
out of suspend the driver only calls flexcan_resume and skips
flexcan_noirq_resume, thus it doesn't call flexcan_exit_stop_mode.
This leaves the flexcan in stop mode, and with the current driver
it can't recover from this even with a soft reboot, it requires a
hard reboot.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 78f67f59b165..3fbce94e7ee5 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1588,6 +1588,7 @@ static int __maybe_unused flexcan_resume(struct device *device)
 		netif_start_queue(dev);
 		if (device_may_wakeup(device)) {
 			disable_irq_wake(dev->irq);
+			flexcan_exit_stop_mode(priv);
 		} else {
 			err = flexcan_chip_enable(priv);
 			if (err)
@@ -1615,7 +1616,6 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 
 	if (netif_running(dev) && device_may_wakeup(device)) {
 		flexcan_enable_wakeup_irq(priv, false);
-		flexcan_exit_stop_mode(priv);
 	}
 
 	return 0;
-- 
2.21.0
