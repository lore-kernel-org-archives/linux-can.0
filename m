From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/7] can: dev: increase bus-off message severity
Date: Tue,  8 May 2018 11:28:25 +0200
Message-ID: <20180508092831.28247-2-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

bus-off is usually caused by hardware malfunction or configuration error
(baud rate mismatch) and causes a complete loss of communication.

Increase the "bus-off" message's severity from netdev_dbg() to
netdev_info() to make it visible to the user.

A can interface going into bus-off is similar in severity to ethernet's
"Link is Down" message, which is also printed at info level.

It is debatable whether the the "restarted" message should also be
changed to netdev_info() to make the interface state changes
comprehensible from the kernel log. I have chosen to keep the
"restarted" message at dbg for now as the "bus-off" message should be
enough for the user to notice and investigate the problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b1779566c5bb..3c71f1cb205f 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -605,7 +605,7 @@ void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	netdev_dbg(dev, "bus-off\n");
+	netdev_info(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
 
-- 
2.17.0
