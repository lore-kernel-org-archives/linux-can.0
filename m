From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5/6] vcan: add CAN FD support
Date: Mon, 18 Jun 2012 19:39:59 +0200
Message-ID: <4FDF67EF.70906@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:50869 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab2FRRj6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:39:58 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

- move the length calculation from dlc to real length (using canfd_frame)
- allow to switch the driver between CAN and CAN FD (change of MTU)

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vcan.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index ea2d942..4f93c0b 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -70,13 +70,12 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
  static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
  	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
+	stats->rx_bytes += cfd->len;
 -	skb->protocol  = htons(ETH_P_CAN);
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -86,7 +85,7 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
  static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
 	int loop;
 @@ -94,7 +93,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
  	stats->tx_packets++;
-	stats->tx_bytes += cf->can_dlc;
+	stats->tx_bytes += cfd->len;
  	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -108,7 +107,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 			 * CAN core already did the echo for us
 			 */
 			stats->rx_packets++;
-			stats->rx_bytes += cf->can_dlc;
+			stats->rx_bytes += cfd->len;
 		}
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
@@ -133,14 +132,28 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 +static int vcan_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/* Do not allow changing the MTU while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU)
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
 static const struct net_device_ops vcan_netdev_ops = {
 	.ndo_start_xmit = vcan_tx,
+	.ndo_change_mtu = vcan_change_mtu,
 };
  static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= sizeof(struct can_frame);
+	dev->mtu		= CAN_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
-- 
1.7.10.4

