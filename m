From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH linux-can-next/flexcan] can: flexcan: fix TDC feature
Date: Thu, 16 Apr 2020 17:31:26 +0800
Message-ID: <20200416093126.15242-2-qiangqing.zhang@nxp.com>
References: <20200416093126.15242-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200416093126.15242-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-imx@nxp.com, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

We enable TDC feature in flexcan_set_bittiming when loopback off, but
disable it by mistake after calling flexcan_set_bittiming.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b16b8abc1c2c..27f4541d9400 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1202,6 +1202,8 @@ static void flexcan_set_bittiming(struct net_device *dev)
 				/* for the TDC to work reliably, the offset has to use optimal settings */
 				reg_fdctrl |= FLEXCAN_FDCTRL_TDCOFF(((dbt->phase_seg1 - 1) + dbt->prop_seg + 2) *
 								    ((dbt->brp -1) + 1));
+			} else {
+				reg_fdctrl &= ~FLEXCAN_FDCTRL_TDCEN;
 			}
 			priv->write(reg_fdctrl, &regs->fdctrl);
 
@@ -1354,7 +1356,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* FDCTRL */
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 		reg_fdctrl = priv->read(&regs->fdctrl) & ~FLEXCAN_FDCTRL_FDRATE;
-		reg_fdctrl &= ~FLEXCAN_FDCTRL_TDCEN;
 		reg_fdctrl &= ~(FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3));
 		reg_mcr = priv->read(&regs->mcr) & ~FLEXCAN_MCR_FDEN;
 		reg_ctrl2 = priv->read(&regs->ctrl2) & ~FLEXCAN_CTRL2_ISOCANFDEN;
-- 
2.17.1
