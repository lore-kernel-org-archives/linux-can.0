From: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v4 1/6] can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCAN controllers.
Date: Fri, 24 Nov 2017 18:52:08 +0530
Message-ID: <1511529733-27942-2-git-send-email-pankaj.bansal@nxp.com>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-can.vger.kernel.org

The FlexCAN driver assumed that FlexCAN controller is big endian for
powerpc architecture and little endian for other architectures.

But this may not be the case. FlexCAN controller can be little or big
endian on any architecture. For e.g. NXP LS1021A ARM based SOC has big
endian FlexCAN controller.

Therefore, the driver has been modified to add a provision for both
types of controllers using an additional device tree property. On a
"fsl,p1010-flexcan" device BE is default, on all other devices LE is.

Big Endian controllers should have "big-endian" set in the device tree.
check "Documentation/devicetree/bindings/net/can/fsl-flexcan.txt" for
usage.

This is the standard practice followed in linux. for more info check:
Documentation/devicetree/bindings/common-properties.txt

Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Zhengxiong Jin <Jason.Jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
  - Merged device tree changes and driver changes in one series
Changes in v3:
  - Added fsl,imx25-flexcan, fsl,imx35-flexcan and fsl,imx53-flexcan
    support to the driver.
  - Modified patch deciption to state default endianness followed and
    to include fsl-flexcan.txt referance.
Changes in v2:
  - Modified patch deciption to include common-properties.txt reference.
  - Reorder the LE/BE read/write APIs for better readability of code
  - Added an exception to force BE API selection, for powerpc based platform
    P1010. This ensures that new linux kernel works with old P1010
    device-tree, while future powerpc platforms that use big endian
    FlexCAN controller need to specify big-endian in device tree in
    FlexCAN node.
  - Tested on P1010 after backporting to freescale sdk 1.4 linux, without
    any change in device-tree.
  - Tested on NXP LS1021A arm based platform.

 drivers/net/can/flexcan.c | 233 ++++++++++++++++++++----------------
 1 file changed, 131 insertions(+), 102 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a13a489..4c873fb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -279,6 +279,10 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+
+	/* Read and Write APIs */
+	u32 (*read)(void __iomem *addr);
+	void (*write)(u32 val, void __iomem *addr);
 };
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -312,39 +316,45 @@ static const struct can_bittiming_const flexcan_bittiming_const = {
 	.brp_inc = 1,
 };
 
-/* Abstract off the read/write for arm versus ppc. This
- * assumes that PPC uses big-endian registers and everything
- * else uses little-endian registers, independent of CPU
- * endianness.
+/* FlexCAN module is essentially modelled as a little-endian IP in most
+ * SoCs, i.e the registers as well as the message buffer areas are
+ * implemented in a little-endian fashion.
+ *
+ * However there are some SoCs (e.g. LS1021A) which implement the FlexCAN
+ * module in a big-endian fashion (i.e the registers as well as the
+ * message buffer areas are implemented in a big-endian way).
+ *
+ * In addition, the FlexCAN module can be found on SoCs having ARM or
+ * PPC cores. So, we need to abstract off the register read/write
+ * functions, ensuring that these cater to all the combinations of module
+ * endianness and underlying CPU endianness.
  */
-#if defined(CONFIG_PPC)
-static inline u32 flexcan_read(void __iomem *addr)
+static inline u32 flexcan_read_be(void __iomem *addr)
 {
-	return in_be32(addr);
+	return ioread32be(addr);
 }
 
-static inline void flexcan_write(u32 val, void __iomem *addr)
+static inline void flexcan_write_be(u32 val, void __iomem *addr)
 {
-	out_be32(addr, val);
+	iowrite32be(val, addr);
 }
-#else
-static inline u32 flexcan_read(void __iomem *addr)
+
+static inline u32 flexcan_read_le(void __iomem *addr)
 {
-	return readl(addr);
+	return ioread32(addr);
 }
 
-static inline void flexcan_write(u32 val, void __iomem *addr)
+static inline void flexcan_write_le(u32 val, void __iomem *addr)
 {
-	writel(val, addr);
+	iowrite32(val, addr);
 }
-#endif
 
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_ctrl = (priv->reg_ctrl_default | FLEXCAN_CTRL_ERR_MSK);
 
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	priv->write(reg_ctrl, &regs->ctrl);
 }
 
 static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
@@ -352,7 +362,7 @@ static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_ctrl = (priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_MSK);
 
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	priv->write(reg_ctrl, &regs->ctrl);
 }
 
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
@@ -377,14 +387,14 @@ static int flexcan_chip_enable(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	reg &= ~FLEXCAN_MCR_MDIS;
-	flexcan_write(reg, &regs->mcr);
+	priv->write(reg, &regs->mcr);
 
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
+	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -396,14 +406,14 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	reg |= FLEXCAN_MCR_MDIS;
-	flexcan_write(reg, &regs->mcr);
+	priv->write(reg, &regs->mcr);
 
-	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		udelay(10);
 
-	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -415,14 +425,14 @@ static int flexcan_chip_freeze(struct flexcan_priv *priv)
 	unsigned int timeout = 1000 * 1000 * 10 / priv->can.bittiming.bitrate;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	reg |= FLEXCAN_MCR_HALT;
-	flexcan_write(reg, &regs->mcr);
+	priv->write(reg, &regs->mcr);
 
-	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		udelay(100);
 
-	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -434,14 +444,14 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	reg &= ~FLEXCAN_MCR_HALT;
-	flexcan_write(reg, &regs->mcr);
+	priv->write(reg, &regs->mcr);
 
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
+	if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -452,11 +462,11 @@ static int flexcan_chip_softreset(struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 
-	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
+	priv->write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
+	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
+	if (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -467,7 +477,7 @@ static int __flexcan_get_berr_counter(const struct net_device *dev,
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
-	u32 reg = flexcan_read(&regs->ecr);
+	u32 reg = priv->read(&regs->ecr);
 
 	bec->txerr = (reg >> 0) & 0xff;
 	bec->rxerr = (reg >> 8) & 0xff;
@@ -523,24 +533,24 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (cf->can_dlc > 0) {
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
-		flexcan_write(data, &priv->tx_mb->data[0]);
+		priv->write(data, &priv->tx_mb->data[0]);
 	}
 	if (cf->can_dlc > 3) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
-		flexcan_write(data, &priv->tx_mb->data[1]);
+		priv->write(data, &priv->tx_mb->data[1]);
 	}
 
 	can_put_echo_skb(skb, dev, 0);
 
-	flexcan_write(can_id, &priv->tx_mb->can_id);
-	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
+	priv->write(can_id, &priv->tx_mb->can_id);
+	priv->write(ctrl, &priv->tx_mb->can_ctrl);
 
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
 	 */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
 
 	return NETDEV_TX_OK;
@@ -659,7 +669,7 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 		u32 code;
 
 		do {
-			reg_ctrl = flexcan_read(&mb->can_ctrl);
+			reg_ctrl = priv->read(&mb->can_ctrl);
 		} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
 
 		/* is this MB empty? */
@@ -674,17 +684,17 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 			offload->dev->stats.rx_errors++;
 		}
 	} else {
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+		reg_iflag1 = priv->read(&regs->iflag1);
 		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
 			return 0;
 
-		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		reg_ctrl = priv->read(&mb->can_ctrl);
 	}
 
 	/* increase timstamp to full 32 bit */
 	*timestamp = reg_ctrl << 16;
 
-	reg_id = flexcan_read(&mb->can_id);
+	reg_id = priv->read(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -694,19 +704,19 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 		cf->can_id |= CAN_RTR_FLAG;
 	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
 
-	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
-	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(priv->read(&mb->data[0]));
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(priv->read(&mb->data[1]));
 
 	/* mark as read */
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		/* Clear IRQ */
 		if (n < 32)
-			flexcan_write(BIT(n), &regs->iflag1);
+			priv->write(BIT(n), &regs->iflag1);
 		else
-			flexcan_write(BIT(n - 32), &regs->iflag2);
+			priv->write(BIT(n - 32), &regs->iflag2);
 	} else {
-		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-		flexcan_read(&regs->timer);
+		priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+		priv->read(&regs->timer);
 	}
 
 	return 1;
@@ -718,8 +728,8 @@ static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 iflag1, iflag2;
 
-	iflag2 = flexcan_read(&regs->iflag2) & priv->reg_imask2_default;
-	iflag1 = flexcan_read(&regs->iflag1) & priv->reg_imask1_default &
+	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default;
+	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default &
 		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	return (u64)iflag2 << 32 | iflag1;
@@ -735,7 +745,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	u32 reg_iflag1, reg_esr;
 	enum can_state last_state = priv->can.state;
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
+	reg_iflag1 = priv->read(&regs->iflag1);
 
 	/* reception interrupt */
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
@@ -758,7 +768,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		/* FIFO overflow interrupt */
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
 			handled = IRQ_HANDLED;
-			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
+			priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW,
+				    &regs->iflag1);
 			dev->stats.rx_over_errors++;
 			dev->stats.rx_errors++;
 		}
@@ -772,18 +783,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		can_led_event(dev, CAN_LED_EVENT_TX);
 
 		/* after sending a RTR frame MB is in RX mode */
-		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-			      &priv->tx_mb->can_ctrl);
-		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
+		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
+			    &priv->tx_mb->can_ctrl);
+		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
-	reg_esr = flexcan_read(&regs->esr);
+	reg_esr = priv->read(&regs->esr);
 
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
 		handled = IRQ_HANDLED;
-		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 	}
 
 	/* state change interrupt or broken error state quirk fix is enabled */
@@ -845,7 +856,7 @@ static void flexcan_set_bittiming(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg;
 
-	reg = flexcan_read(&regs->ctrl);
+	reg = priv->read(&regs->ctrl);
 	reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
 		 FLEXCAN_CTRL_RJW(0x3) |
 		 FLEXCAN_CTRL_PSEG1(0x7) |
@@ -869,11 +880,11 @@ static void flexcan_set_bittiming(struct net_device *dev)
 		reg |= FLEXCAN_CTRL_SMP;
 
 	netdev_dbg(dev, "writing ctrl=0x%08x\n", reg);
-	flexcan_write(reg, &regs->ctrl);
+	priv->write(reg, &regs->ctrl);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
-		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
+		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
 }
 
 /* flexcan_chip_start
@@ -912,7 +923,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * choose format C
 	 * set max mailbox number
 	 */
-	reg_mcr = flexcan_read(&regs->mcr);
+	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
 		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
@@ -926,7 +937,7 @@ static int flexcan_chip_start(struct net_device *dev)
 			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	}
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
-	flexcan_write(reg_mcr, &regs->mcr);
+	priv->write(reg_mcr, &regs->mcr);
 
 	/* CTRL
 	 *
@@ -939,7 +950,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * enable bus off interrupt
 	 * (== FLEXCAN_CTRL_ERR_STATE)
 	 */
-	reg_ctrl = flexcan_read(&regs->ctrl);
+	reg_ctrl = priv->read(&regs->ctrl);
 	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
 	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
 		FLEXCAN_CTRL_ERR_STATE;
@@ -959,45 +970,45 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* leave interrupts disabled for now */
 	reg_ctrl &= ~FLEXCAN_CTRL_ERR_ALL;
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	priv->write(reg_ctrl, &regs->ctrl);
 
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
-		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 = priv->read(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
-		flexcan_write(reg_ctrl2, &regs->ctrl2);
+		priv->write(reg_ctrl2, &regs->ctrl2);
 	}
 
 	/* clear and invalidate all mailboxes first */
 	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
-		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			      &regs->mb[i].can_ctrl);
+		priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
+			    &regs->mb[i].can_ctrl);
 	}
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++)
-			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
-				      &regs->mb[i].can_ctrl);
+			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
+				    &regs->mb[i].can_ctrl);
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &priv->tx_mb_reserved->can_ctrl);
+	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		    &priv->tx_mb_reserved->can_ctrl);
 
 	/* mark TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &priv->tx_mb->can_ctrl);
+	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		    &priv->tx_mb->can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
-	flexcan_write(0x0, &regs->rxgmask);
-	flexcan_write(0x0, &regs->rx14mask);
-	flexcan_write(0x0, &regs->rx15mask);
+	priv->write(0x0, &regs->rxgmask);
+	priv->write(0x0, &regs->rx14mask);
+	priv->write(0x0, &regs->rx15mask);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
-		flexcan_write(0x0, &regs->rxfgmask);
+		priv->write(0x0, &regs->rxfgmask);
 
 	/* clear acceptance filters */
 	for (i = 0; i < ARRAY_SIZE(regs->mb); i++)
-		flexcan_write(0, &regs->rximr[i]);
+		priv->write(0, &regs->rximr[i]);
 
 	/* On Vybrid, disable memory error detection interrupts
 	 * and freeze mode.
@@ -1010,16 +1021,16 @@ static int flexcan_chip_start(struct net_device *dev)
 		 * and Correction of Memory Errors" to write to
 		 * MECR register
 		 */
-		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 = priv->read(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_ECRWRE;
-		flexcan_write(reg_ctrl2, &regs->ctrl2);
+		priv->write(reg_ctrl2, &regs->ctrl2);
 
-		reg_mecr = flexcan_read(&regs->mecr);
+		reg_mecr = priv->read(&regs->mecr);
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
-		flexcan_write(reg_mecr, &regs->mecr);
+		priv->write(reg_mecr, &regs->mecr);
 		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
 			      FLEXCAN_MECR_FANCEI_MSK);
-		flexcan_write(reg_mecr, &regs->mecr);
+		priv->write(reg_mecr, &regs->mecr);
 	}
 
 	err = flexcan_transceiver_enable(priv);
@@ -1035,14 +1046,14 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	/* enable interrupts atomically */
 	disable_irq(dev->irq);
-	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	flexcan_write(priv->reg_imask1_default, &regs->imask1);
-	flexcan_write(priv->reg_imask2_default, &regs->imask2);
+	priv->write(priv->reg_ctrl_default, &regs->ctrl);
+	priv->write(priv->reg_imask1_default, &regs->imask1);
+	priv->write(priv->reg_imask2_default, &regs->imask2);
 	enable_irq(dev->irq);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
-		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
+		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
 
 	return 0;
 
@@ -1067,10 +1078,10 @@ static void flexcan_chip_stop(struct net_device *dev)
 	flexcan_chip_disable(priv);
 
 	/* Disable all interrupts */
-	flexcan_write(0, &regs->imask2);
-	flexcan_write(0, &regs->imask1);
-	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		      &regs->ctrl);
+	priv->write(0, &regs->imask2);
+	priv->write(0, &regs->imask1);
+	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+		    &regs->ctrl);
 
 	flexcan_transceiver_disable(priv);
 	priv->can.state = CAN_STATE_STOPPED;
@@ -1185,26 +1196,26 @@ static int register_flexcandev(struct net_device *dev)
 	err = flexcan_chip_disable(priv);
 	if (err)
 		goto out_disable_per;
-	reg = flexcan_read(&regs->ctrl);
+	reg = priv->read(&regs->ctrl);
 	reg |= FLEXCAN_CTRL_CLK_SRC;
-	flexcan_write(reg, &regs->ctrl);
+	priv->write(reg, &regs->ctrl);
 
 	err = flexcan_chip_enable(priv);
 	if (err)
 		goto out_chip_disable;
 
 	/* set freeze, halt and activate FIFO, restrict register access */
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
-	flexcan_write(reg, &regs->mcr);
+	priv->write(reg, &regs->mcr);
 
 	/* Currently we only support newer versions of this core
 	 * featuring a RX hardware FIFO (although this driver doesn't
 	 * make use of it on some cores). Older cores, found on some
 	 * Coldfire derivates are not tested.
 	 */
-	reg = flexcan_read(&regs->mcr);
+	reg = priv->read(&regs->mcr);
 	if (!(reg & FLEXCAN_MCR_FEN)) {
 		netdev_err(dev, "Could not enable RX FIFO, unsupported core\n");
 		err = -ENODEV;
@@ -1232,6 +1243,9 @@ static void unregister_flexcandev(struct net_device *dev)
 static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
+	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_p1010_devtype_data, },
+	{ .compatible = "fsl,imx35-flexcan", .data = &fsl_p1010_devtype_data, },
+	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ /* sentinel */ },
@@ -1313,6 +1327,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
+
+	if (of_property_read_bool(pdev->dev.of_node, "big-endian")) {
+		priv->read = flexcan_read_be;
+		priv->write = flexcan_write_be;
+	} else {
+		if (of_device_is_compatible(pdev->dev.of_node,
+					    "fsl,p1010-flexcan")) {
+			priv->read = flexcan_read_be;
+			priv->write = flexcan_write_be;
+		} else {
+			priv->read = flexcan_read_le;
+			priv->write = flexcan_write_le;
+		}
+	}
+
 	priv->can.clock.freq = clock_freq;
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
