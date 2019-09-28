From: Wen Yang <wenyang@linux.alibaba.com>
Subject: [PATCH] can: dev: add missing of_node_put after calling of_get_child_by_name
Date: Sat, 28 Sep 2019 22:29:05 +0800
Message-ID: <20190928142905.34832-1-wenyang@linux.alibaba.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_get_child_by_name finished using.

fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index ac86be5..1c88c36 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -848,6 +848,7 @@ void of_can_transceiver(struct net_device *dev)
 		return;
 
 	ret = of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
+	of_node_put(dn);
 	if ((ret && ret != -EINVAL) || (!ret && !priv->bitrate_max))
 		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
 }
-- 
1.8.3.1
