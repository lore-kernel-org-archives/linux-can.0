From: Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] can: flexcan: add support for ISO CAN-FD
Date: Mon, 29 Jun 2020 20:18:09 +0200
Message-ID: <20200629181809.25338-3-michael@walle.cc>
References: <20200629181809.25338-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629181809.25338-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Michael Walle <michael@walle.cc>
List-Id: linux-can.vger.kernel.org

Up until now, the controller used non-ISO CAN-FD mode, although it
supports it. Add support for ISO mode, too. By default the hardware
is in non-ISO mode and an enable bit has to be explicitly set.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/can/flexcan.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 183e094f8d66..a92d3cdf4195 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -94,6 +94,7 @@
 #define FLEXCAN_CTRL2_MRP		BIT(18)
 #define FLEXCAN_CTRL2_RRS		BIT(17)
 #define FLEXCAN_CTRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN	BIT(12)
 
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -1344,14 +1345,25 @@ static int flexcan_chip_start(struct net_device *dev)
 	else
 		reg_mcr |= FLEXCAN_MCR_SRX_DIS;
 
-	/* MCR - CAN-FD */
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	/* MCR, CTRL2
+	 *
+	 * CAN-FD mode
+	 * ISO CAN-FD mode
+	 */
+	reg_ctrl2 = priv->read(&regs->ctrl2);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		reg_mcr |= FLEXCAN_MCR_FDEN;
-	else
+		reg_ctrl2 |= FLEXCAN_CTRL2_ISOCANFDEN;
+	} else {
 		reg_mcr &= ~FLEXCAN_MCR_FDEN;
+	}
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+		reg_ctrl2 &= ~FLEXCAN_CTRL2_ISOCANFDEN;
 
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
+	priv->write(reg_ctrl2, &regs->ctrl2);
 
 	/* CTRL
 	 *
@@ -1952,6 +1964,7 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
 		priv->can.bittiming_const = &flexcan_fd_bittiming_const;
 		priv->can.data_bittiming_const =
 			&flexcan_fd_data_bittiming_const;
-- 
2.20.1
