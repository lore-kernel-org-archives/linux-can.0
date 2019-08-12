From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 5/5] can: xilinx_can: Fix the data phase btr1 calculation
Date: Mon, 12 Aug 2019 12:58:34 +0530
Message-ID: <1565594914-18999-6-git-send-email-appana.durga.rao@xilinx.com>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Srinivas Neeli <srinivas.neeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

While calculating bitrate for the data phase, the driver is using phase
segment 1 of the arbitration phase instead of the data phase.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Acked-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4cb8c1c9..ab26691 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -425,7 +425,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 		btr0 = dbt->brp - 1;
 
 		/* Setting Time Segment 1 in BTR Register */
-		btr1 = dbt->prop_seg + bt->phase_seg1 - 1;
+		btr1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 
 		/* Setting Time Segment 2 in BTR Register */
 		btr1 |= (dbt->phase_seg2 - 1) << priv->devtype.btr_ts2_shift;
-- 
2.7.4
