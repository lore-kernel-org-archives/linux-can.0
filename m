From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: dev:  use skb_put_zero to simplfy code
Date: Sat, 28 Apr 2018 15:49:57 +0800
Message-ID: <20180428074957.17084-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

use helper skb_put_zero to replace the pattern of skb_put() && memset()

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b177956..d8140a9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -649,8 +649,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
-	*cf = skb_put(skb, sizeof(struct can_frame));
-	memset(*cf, 0, sizeof(struct can_frame));
+	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -678,8 +677,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
-	*cfd = skb_put(skb, sizeof(struct canfd_frame));
-	memset(*cfd, 0, sizeof(struct canfd_frame));
+	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	return skb;
 }
-- 
2.7.0
