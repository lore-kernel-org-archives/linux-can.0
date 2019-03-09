From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH] net: can: Increase tx queue length
Date: Sat, 9 Mar 2019 19:37:26 +0530
Message-ID: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

While stress testing the CAN interface on xilinx axi can
in loopback mode getting message "write: no buffer space available"
Increasing device tx queue length resolved the above mentioned issue.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
--> Network devices default tx_queue_len is 1000 but for socket
can device it is 10 any reason for it?? 
 
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d5..32bd5be 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
 	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
-	dev->tx_queue_len = 10;
+	dev->tx_queue_len = 500;
 
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
-- 
2.7.4
