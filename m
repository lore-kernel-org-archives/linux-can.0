From: Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] can: enable multi-queue for SocketCAN devices
Date: Wed, 14 Mar 2018 11:33:16 +0100
Message-ID: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, Zhu Yi <yi.zhu5@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
List-Id: linux-can.vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The existing SocketCAN implementation provides alloc_candev() to
allocate a CAN device using a single Tx and Rx queue. This can lead to
priority inversion in case the single Tx queue is already full with low
priority messages and a high priority message needs to be sent while the
bus is fully loaded with medium priority messages.

This problem can be solved by using the existing multi-queue support of
the network subsystem. The commit makes it possible to use multi-queue in
the CAN subsystem in the same way it is used in the Ethernet subsystem
by adding an alloc_candev_mqs() call and accompanying macros. With this
support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
the aforementioned priority inversion.

The existing functionality of alloc_candev() is the same as before.

CAN devices need to have prioritized multiple hardware queues or are
able to abort waiting for arbitration to make sensible use of
multi-queues.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/can/dev.c   | 8 +++++---
 include/linux/can/dev.h | 7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b177956..636f853 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -703,7 +703,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /*
  * Allocate and setup space for the CAN network device
  */
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
 	struct can_priv *priv;
@@ -715,7 +716,8 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	else
 		size = sizeof_priv;
 
-	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
+	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+			       txqs, rxqs);
 	if (!dev)
 		return NULL;
 
@@ -734,7 +736,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(alloc_candev);
+EXPORT_SYMBOL_GPL(alloc_candev_mqs);
 
 /*
  * Free space of the CAN network device
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 055aaf5..a83e1f6 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -143,7 +143,12 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs);
+#define alloc_candev(sizeof_priv, echo_skb_max) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
+#define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-- 
2.7.4
