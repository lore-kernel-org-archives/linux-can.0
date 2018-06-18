From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 133/189] can: dev: increase bus-off message severity
Date: Mon, 18 Jun 2018 10:13:49 +0200
Message-ID: <20180618081214.568513882@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Sasha Levin <alexander.levin@microsoft.com>
List-Id: linux-can.vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

[ Upstream commit 71c23a821c6bcacba71a094efe49ee689605906b ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -604,7 +604,7 @@ void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	netdev_dbg(dev, "bus-off\n");
+	netdev_info(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
 
