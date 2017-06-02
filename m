From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: enable CAN FD for virtual CAN devices by default
Date: Fri,  2 Jun 2017 19:37:30 +0200
Message-ID: <20170602173730.13644-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:35512 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdFBRhj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jun 2017 13:37:39 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

CAN FD capable CAN interfaces can handle (classic) CAN 2.0 frames too.
New users usually fail at their first attempt to explore CAN FD on
virtual CAN interfaces due to the current CAN_MTU default.

Set the MTU to CANFD_MTU by default to reduce this confusion.
If someone *really* needs a 'classic CAN'-only device this can be set
with the 'ip' tool with e.g. 'ip link set vcan0 mtu 16' as before.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vcan.c  | 2 +-
 drivers/net/can/vxcan.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index facca33d53e9..681ba80ed6d4 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -152,7 +152,7 @@ static const struct net_device_ops vcan_netdev_ops = {
 static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CAN_MTU;
+	dev->mtu		= CANFD_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 7fbb24795681..51a31258a0f8 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -150,7 +150,7 @@ static const struct net_device_ops vxcan_netdev_ops = {
 static void vxcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CAN_MTU;
+	dev->mtu		= CANFD_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
-- 
2.11.0

