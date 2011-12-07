From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 10/14] can: sja1000: consolidate bus-off handling
Date: Wed,  7 Dec 2011 15:55:24 +0100
Message-ID: <1323269728-17491-11-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49275 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab1LGOzl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:41 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

A real bus off recovery cycle is triggered by re-setting the init
bit and the netif queue is restarted not before the CAN error state
has returned to error active.

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a bus-off recovery due to a short circiut (restart after 5s) for a
SJA1000 on an EMS PCI card:

 (000.202225)  can0   5F  [8] 07 B4 4F 67 3A 90 D9 E4
 (000.201285)  can0  20000204  [8] 00 08 00 00 00 00 78 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
        error-counter-tx-rx{{120}{0}}
 (000.003249)  can0  20000240  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        bus-off
        state-change{}
 (005.015531)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
        restarted-after-bus-off
        error-counter-tx-rx{{127}{0}}
 (000.000133)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.031612)  can0   79  [5] 79 85 71 34 7A

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/sja1000/sja1000.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index f6a1c74..29af651 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -163,6 +163,13 @@ static void sja1000_start(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
+	if (priv->can.state == CAN_STATE_BUS_OFF) {
+		/* trigger bus-off recovery and restart queue */
+		priv->write_reg(priv, REG_MOD, 0x00);
+		netif_wake_queue(dev);
+		return;
+	}
+
 	/* leave reset mode */
 	if (priv->can.state != CAN_STATE_STOPPED)
 		set_reset_mode(dev);
@@ -393,6 +400,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 		if (status & SR_BS) {
 			state = CAN_STATE_BUS_OFF;
+			netif_stop_queue(dev);
 			can_bus_off(dev);
 		} else if (status & SR_ES) {
 			state = CAN_STATE_ERROR_WARNING;
-- 
1.7.4.1

