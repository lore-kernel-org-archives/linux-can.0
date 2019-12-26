From: Florian Faber <faber@faberman.de>
Subject: [PATCH] mscan: fix rx path lockup when returning from polling to irq
 mode
Date: Thu, 26 Dec 2019 19:51:24 +0100
Message-ID: <860de41f-bb60-728b-7602-90dced920c27@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Under load, the RX side of the mscan driver can get stuck while TX still
works. Restarting the interface locks up the system. This behaviour 
could be reproduced reliably on a MPC5121e based system.

The patch fixes the return value of the NAPI polling function (should be
the number of processed packets, not constant 1) and the condition under
which IRQs are enabled again after polling is finished.

With this patch, no more lockups were observed over a test period of ten 
days.

Signed-off-by: Florian Faber <faber@faberman.de>
---
diff -uprN a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -381,10 +381,9 @@ static int mscan_rx_poll(struct napi_str
         struct net_device *dev = napi->dev;
         struct mscan_regs __iomem *regs = priv->reg_base;
         struct net_device_stats *stats = &dev->stats;
-       int npackets = 0;
-       int ret = 1;
+	int work_done = 0;
         struct sk_buff *skb;
         struct can_frame *frame;
         u8 canrflg;

-       while (npackets < quota) {
+	while (work_done < quota) {
		canrflg = in_8(&regs->canrflg);
		if (!(canrflg & (MSCAN_RXF | MSCAN_ERR_IF)))
@@ -408,15 +409,16 @@ static int mscan_rx_poll(struct napi_str

                 stats->rx_packets++;
                 stats->rx_bytes += frame->can_dlc;
-               npackets++;
+		work_done++;
                 netif_receive_skb(skb);
         }

-       if (!(in_8(&regs->canrflg) & (MSCAN_RXF | MSCAN_ERR_IF))) {
-               napi_complete(&priv->napi);
-               clear_bit(F_RX_PROGRESS, &priv->flags);
-               if (priv->can.state < CAN_STATE_BUS_OFF)
-                       out_8(&regs->canrier, priv->shadow_canrier);
-               ret = 0;
+	if (work_done < quota) {
+		if (likely(napi_complete_done(&priv->napi, work_done))) {
+			clear_bit(F_RX_PROGRESS, &priv->flags);
+			if (priv->can.state < CAN_STATE_BUS_OFF)
+				out_8(&regs->canrier, priv->shadow_canrier);
+		}
         }
-       return ret;
+
+	return work_done;
}
-- 
Machines can do the work, so people have time to think.
