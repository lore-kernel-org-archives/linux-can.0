From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 12/14] can: mscan: consolidate bus-off handling
Date: Wed,  7 Dec 2011 15:55:26 +0100
Message-ID: <1323269728-17491-13-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49279 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318Ab1LGOzm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:42 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

The netif queue is restarted not before the CAN error state
has returned below bus-off (passive, warning or active).

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a MSCAN on a MPC5200 SOC:

 (000.203990)  can2   31  [1] 5D
 (000.204007)  can2  20000204  [8] 00 08 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
 (000.000842)  can2  20000240  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        bus-off
        state-change{}
 (005.010926)  can2  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        restarted-after-bus-off
 (000.002880)  can2  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.085464)  can2   4B  [8] 14 EF 5E D3 43 84 7C 87

And for a MSCAN on a MPC5121 SOC:

 (000.204131)  can0   36  [8] 3B ED 98 76 48 33 1A 13
 (000.203927)  can0  20000204  [8] 00 20 00 00 00 00 94 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
        error-counter-tx-rx{{148}{0}}
 (000.000828)  can0  20000240  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
        bus-off
        state-change{}
        error-counter-tx-rx{{127}{0}}
 (005.006905)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
        restarted-after-bus-off
        error-counter-tx-rx{{127}{0}}
 (000.003043)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.089262)  can0   50  [6] 12 3E 5B 23 15 68

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/mscan/mscan.c     |    7 +++++--
 drivers/net/can/sja1000/sja1000.c |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index e9e6b14..0762093 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -180,7 +180,6 @@ static int mscan_restart(struct net_device *dev)
 	if (priv->type == MSCAN_TYPE_MPC5121) {
 		struct mscan_regs __iomem *regs = priv->reg_base;
 
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 		WARN(!(in_8(&regs->canmisc) & MSCAN_BOHOLD),
 		     "bus-off state expected\n");
 		out_8(&regs->canmisc, MSCAN_BOHOLD);
@@ -374,8 +373,12 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 					setbits8(&regs->canctl0,
 						 MSCAN_SLPRQ | MSCAN_INITRQ);
 				}
+				netif_stop_queue(dev);
 				can_bus_off(dev);
 			}
+			/* Restart TX queue after recovered from bus-off */
+			if (priv->can.state == CAN_STATE_BUS_OFF)
+				netif_wake_queue(dev);
 			can_change_state(dev, frame, state, err_dir);
 		}
 		priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
@@ -507,7 +510,7 @@ static int mscan_do_set_mode(struct net_device *dev, enum can_mode mode)
 		ret = mscan_restart(dev);
 		if (ret)
 			break;
-		if (netif_queue_stopped(dev))
+		if (priv->can.state != CAN_STATE_BUS_OFF)
 			netif_wake_queue(dev);
 		break;
 
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 29af651..e70a966 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -166,7 +166,6 @@ static void sja1000_start(struct net_device *dev)
 	if (priv->can.state == CAN_STATE_BUS_OFF) {
 		/* trigger bus-off recovery and restart queue */
 		priv->write_reg(priv, REG_MOD, 0x00);
-		netif_wake_queue(dev);
 		return;
 	}
 
@@ -458,8 +457,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		cf->data[0] = alc & 0x1f;
 	}
 
-	if (state != priv->can.state)
+	if (state != priv->can.state) {
+		/* Restart TX queue after recovered from bus-off */
+		if (priv->can.state == CAN_STATE_BUS_OFF)
+			netif_wake_queue(dev);
 		can_change_state(dev, cf, state, CAN_ERR_DIR_UNKNOWN);
+	}
 
 	netif_rx(skb);
 
-- 
1.7.4.1

