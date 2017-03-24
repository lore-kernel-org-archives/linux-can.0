From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v3 4/6] can: m_can: Enable M_CAN version dependent initialization
Date: Fri, 24 Mar 2017 17:49:29 +0100
Message-ID: <1490374171-15190-4-git-send-email-mario.huettel@de.bosch.com>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39180 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757825AbdCXQtq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2017 12:49:46 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id D0CBD1580169
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:38 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id 4B0F12E405A4
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:38 +0100 (CET)
In-Reply-To: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch adapts the initialization of the M_CAN. So it can be used with
all versions >= 3.0.x.

Changes:
* Added version element to m_can_priv structure to hold M_CAN version.
* Renamed bittiming structs for version 3.0.x
* Added new bittiming structs for version >= 3.1.x
* Function alloc_m_can_dev takes 2 new arguments. The TX FIFO size and the
  base address of the module.
* Chip configuration for CAN_CTRLMODE_LOOPBACK is changed: Enabled
  CCCR_MON bit. In combination with TEST_LBCK it activates the internal
  loopback mode. Leaving CCCR_MON '0' results in external loopback mode.
* Clocks are temporarily enabled by platform_propbe function in order to
  allow read access to the Core Release register and the Control Register.
  Registers are used to detect M_CAN version and optional Non-ISO Feature.

Initialization of M_CAN for version >= 3.1.x:
* TX FIFO of M_CAN is used to transmit frames. The driver does not need to
  stop the tx queue after each frame sent.
* Initialization of TX Event FIFO is added.
* NON-ISO is fixed for all M_CAN versions < 3.2.x. Version 3.2.x _can_ have
  the NISO (Non-ISO) bit which can switch the mode of the M_CAN to Non-ISO
  mode. This bit does not have to be writeable. Therefore it is checked.
  If it is writable Non-ISO support is added to the controllers supported
  CAN modes.

New Functions:
* Function to check the Core Release version. The read value determines the
  behaviour of the driver.
* Function to check if the NISO bit for version >= 3.2.x is implemented.

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 336 +++++++++++++++++++++++++++++++++---------
 1 file changed, 267 insertions(+), 69 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f2656a3..7f19ce5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,7 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-
+#include <linux/iopoll.h>
 #include <linux/can/dev.h>
 
 /* napi related */
@@ -107,6 +107,14 @@ enum m_can_mram_cfg {
 	MRAM_CFG_NUM,
 };
 
+/* Core Release Register (CREL) */
+#define CREL_REL_SHIFT		28
+#define CREL_REL_MASK		(0xF << CREL_REL_SHIFT)
+#define CREL_STEP_SHIFT		24
+#define CREL_STEP_MASK		(0xF << CREL_STEP_SHIFT)
+#define CREL_SUBSTEP_SHIFT	20
+#define CREL_SUBSTEP_MASK	(0xF << CREL_SUBSTEP_SHIFT)
+
 /* Data Bit Timing & Prescaler Register (DBTP) */
 #define DBTP_TDC		BIT(23)
 #define DBTP_DBRP_SHIFT		16
@@ -342,6 +350,7 @@ struct m_can_priv {
 	struct clk *cclk;
 	void __iomem *base;
 	u32 irqstatus;
+	int version;
 
 	/* message ram configuration */
 	void __iomem *mram_base;
@@ -833,7 +842,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static const struct can_bittiming_const m_can_bittiming_const = {
+static const struct can_bittiming_const m_can_bittiming_const_30X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 64,
@@ -845,7 +854,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	.brp_inc = 1,
 };
 
-static const struct can_bittiming_const m_can_data_bittiming_const = {
+static const struct can_bittiming_const m_can_data_bittiming_const_30X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 16,
@@ -857,6 +866,30 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const m_can_bittiming_const_31X = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
+	.tseg1_max = 256,
+	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 1,		/* Time segment 1 = prop_seg + phase_seg1 */
+	.tseg1_max = 32,
+	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 32,
+	.brp_inc = 1,
+};
+
 static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_priv *priv = netdev_priv(dev);
@@ -928,29 +961,58 @@ static void m_can_chip_config(struct net_device *dev)
 		     priv->mcfg[MRAM_RXF1].off);
 
 	cccr = m_can_read(priv, M_CAN_CCCR);
-	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
-		(CCCR_CME_MASK << CCCR_CME_SHIFT));
 	test = m_can_read(priv, M_CAN_TEST);
 	test &= ~TEST_LBCK;
+	if (priv->version == 30) {
+	/* Version 3.0.x */
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		cccr |= CCCR_MON;
+		cccr &= ~(CCCR_TEST | CCCR_MON |
+			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
+			(CCCR_CME_MASK << CCCR_CME_SHIFT));
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+			cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+
+	} else {
+	/* Version 3.1.x or 3.2.x */
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
+
+		/* Only 3.2.x has NISO Bit implemented */
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+			cccr |= CCCR_NISO;
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+			cccr |= CCCR_TEST | CCCR_MON;
+			test |= TEST_LBCK;
+		}
 
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+			cccr |= (CCCR_BRSE | CCCR_FDOE);
+	}
+
+	/* Loopback Mode */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
-		cccr |= CCCR_TEST;
+		cccr |= CCCR_TEST | CCCR_MON;
 		test |= TEST_LBCK;
 	}
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+	/* Enable Monitoring (all versions) */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		cccr |= CCCR_MON;
 
+	/* Write config */
 	m_can_write(priv, M_CAN_CCCR, cccr);
 	m_can_write(priv, M_CAN_TEST, test);
 
-	/* enable interrupts */
+	/* Enable interrupts */
 	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
-		m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC_30X);
+		if (priv->version == 30)
+			m_can_write(priv, M_CAN_IE, IR_ALL_INT &
+				    ~(IR_ERR_LEC_30X));
+		else
+			m_can_write(priv, M_CAN_IE, IR_ALL_INT &
+				    ~(IR_ERR_LEC_31X));
 	else
 		m_can_write(priv, M_CAN_IE, IR_ALL_INT);
 
@@ -994,33 +1056,135 @@ static void free_m_can_dev(struct net_device *dev)
 	free_candev(dev);
 }
 
-static struct net_device *alloc_m_can_dev(void)
+/* Checks core release number of M_CAN
+ * returns 0 if an unsupported device is detected
+ * else it returns the release and step coded as:
+ * return value = 10 * <release> + 1 * <step>
+ */
+static int m_can_check_core_release(void * __iomem m_can_base)
+{
+	u32 crel_reg;
+	u8 rel;
+	u8 step;
+	int res;
+	struct m_can_priv temp_priv = {
+		.base = m_can_base
+	};
+
+	/* Read Core Release Version and split into version number
+	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
+	 */
+	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
+	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
+	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
+
+	if (rel == 3) {
+		/* M_CAN v3.x.y: create return value */
+		res = 30 + step;
+	} else {
+		/* Unsupported M_CAN version */
+		res = 0;
+	}
+
+	return res;
+}
+
+/* Selectable Non ISO support only in version 3.2.x
+ * This function checks if the bit is writable.
+ */
+static bool m_can_niso_supported(const struct m_can_priv *priv)
+{
+	u32 cccr_reg, cccr_poll;
+	int niso_timeout;
+
+	m_can_config_endisable(priv, true);
+	cccr_reg = m_can_read(priv, M_CAN_CCCR);
+	cccr_reg |= CCCR_NISO;
+	m_can_write(priv, M_CAN_CCCR, cccr_reg);
+
+	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
+					  (cccr_poll == cccr_reg), 0, 10);
+
+	/* Clear NISO */
+	cccr_reg &= ~(CCCR_NISO);
+	m_can_write(priv, M_CAN_CCCR, cccr_reg);
+
+	m_can_config_endisable(priv, false);
+
+	/* return false if time out (-ETIMEDOUT), else return true */
+	return !niso_timeout;
+}
+
+static struct net_device *alloc_m_can_dev(void __iomem *addr, u32 tx_fifo_size)
 {
 	struct net_device *dev;
 	struct m_can_priv *priv;
+	int m_can_version;
+	unsigned int echo_buffer_count;
+
+	m_can_version = m_can_check_core_release(addr);
+	/* return if unsupported version */
+	if (!m_can_version) {
+		dev = NULL;
+		goto return_dev;
+	}
 
-	dev = alloc_candev(sizeof(*priv), 1);
-	if (!dev)
-		return NULL;
+	/* If version < 3.1.x, then only one echo buffer is used */
+	echo_buffer_count = ((m_can_version == 30)
+				? 1U
+				: (unsigned int)tx_fifo_size);
 
+	dev = alloc_candev(sizeof(*priv), echo_buffer_count);
+	if (!dev) {
+		dev = NULL;
+		goto return_dev;
+	}
 	priv = netdev_priv(dev);
 	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
 
+	/* Shared properties of all M_CAN versions */
+	priv->version = m_can_version;
 	priv->dev = dev;
-	priv->can.bittiming_const = &m_can_bittiming_const;
-	priv->can.data_bittiming_const = &m_can_data_bittiming_const;
+	priv->base = addr;
 	priv->can.do_set_mode = m_can_set_mode;
 	priv->can.do_get_berr_counter = m_can_get_berr_counter;
 
-	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
-	can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
-
-	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */
+	/* Set M_CAN supported operations */
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING |
 					CAN_CTRLMODE_FD;
 
+	/* Set properties depending on M_CAN version */
+	switch (priv->version) {
+	case 30:
+		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
+		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
+		priv->can.bittiming_const = &m_can_bittiming_const_30X;
+		priv->can.data_bittiming_const =
+				&m_can_data_bittiming_const_30X;
+		break;
+	case 31:
+		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
+		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
+		priv->can.bittiming_const = &m_can_bittiming_const_31X;
+		priv->can.data_bittiming_const =
+				&m_can_data_bittiming_const_31X;
+		break;
+	case 32:
+		priv->can.bittiming_const = &m_can_bittiming_const_31X;
+		priv->can.data_bittiming_const =
+				&m_can_data_bittiming_const_31X;
+		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
+						? CAN_CTRLMODE_FD_NON_ISO
+						: 0);
+		break;
+	default:
+		/* This does not happen */
+		break;
+	}
+
+return_dev:
 	return dev;
 }
 
@@ -1167,58 +1331,37 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
-static int m_can_of_parse_mram(struct platform_device *pdev,
-			       struct m_can_priv *priv)
+static void m_can_of_parse_mram(struct m_can_priv *priv,
+				const u32 *mram_config_vals)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
-	void __iomem *addr;
-	u32 out_val[MRAM_CFG_LEN];
-	int i, start, end, ret;
-
-	/* message ram could be shared */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
-	if (!res)
-		return -ENODEV;
+	int i, start, end;
 
-	addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!addr)
-		return -ENOMEM;
-
-	/* get message ram configuration */
-	ret = of_property_read_u32_array(np, "bosch,mram-cfg",
-					 out_val, sizeof(out_val) / 4);
-	if (ret) {
-		dev_err(&pdev->dev, "can not get message ram configuration\n");
-		return -ENODEV;
-	}
-
-	priv->mram_base = addr;
-	priv->mcfg[MRAM_SIDF].off = out_val[0];
-	priv->mcfg[MRAM_SIDF].num = out_val[1];
+	priv->mcfg[MRAM_SIDF].off = mram_config_vals[0];
+	priv->mcfg[MRAM_SIDF].num = mram_config_vals[1];
 	priv->mcfg[MRAM_XIDF].off = priv->mcfg[MRAM_SIDF].off +
 			priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
-	priv->mcfg[MRAM_XIDF].num = out_val[2];
+	priv->mcfg[MRAM_XIDF].num = mram_config_vals[2];
 	priv->mcfg[MRAM_RXF0].off = priv->mcfg[MRAM_XIDF].off +
 			priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
-	priv->mcfg[MRAM_RXF0].num = out_val[3] &
+	priv->mcfg[MRAM_RXF0].num = mram_config_vals[3] &
 			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
 	priv->mcfg[MRAM_RXF1].off = priv->mcfg[MRAM_RXF0].off +
 			priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
-	priv->mcfg[MRAM_RXF1].num = out_val[4] &
+	priv->mcfg[MRAM_RXF1].num = mram_config_vals[4] &
 			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
 	priv->mcfg[MRAM_RXB].off = priv->mcfg[MRAM_RXF1].off +
 			priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
-	priv->mcfg[MRAM_RXB].num = out_val[5];
+	priv->mcfg[MRAM_RXB].num = mram_config_vals[5];
 	priv->mcfg[MRAM_TXE].off = priv->mcfg[MRAM_RXB].off +
 			priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
-	priv->mcfg[MRAM_TXE].num = out_val[6];
+	priv->mcfg[MRAM_TXE].num = mram_config_vals[6];
 	priv->mcfg[MRAM_TXB].off = priv->mcfg[MRAM_TXE].off +
 			priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
-	priv->mcfg[MRAM_TXB].num = out_val[7] &
+	priv->mcfg[MRAM_TXB].num = mram_config_vals[7] &
 			(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
 
-	dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
+	dev_dbg(priv->device,
+		"mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
 		priv->mram_base,
 		priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
 		priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
@@ -1237,7 +1380,6 @@ static int m_can_of_parse_mram(struct platform_device *pdev,
 	for (i = start; i < end; i += 4)
 		writel(0x0, priv->mram_base + i);
 
-	return 0;
 }
 
 static int m_can_plat_probe(struct platform_device *pdev)
@@ -1246,38 +1388,86 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	struct m_can_priv *priv;
 	struct resource *res;
 	void __iomem *addr;
+	void __iomem *mram_addr;
 	struct clk *hclk, *cclk;
 	int irq, ret;
+	struct device_node *np;
+	u32 mram_config_vals[MRAM_CFG_LEN];
+	u32 tx_fifo_size;
+
+	np = pdev->dev.of_node;
 
 	hclk = devm_clk_get(&pdev->dev, "hclk");
 	cclk = devm_clk_get(&pdev->dev, "cclk");
+
 	if (IS_ERR(hclk) || IS_ERR(cclk)) {
 		dev_err(&pdev->dev, "no clock found\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto failed_ret;
 	}
 
+	/* Enable clocks. Necessary to read Core Release in order to determine
+	 * M_CAN version
+	 */
+	ret = clk_prepare_enable(hclk);
+	if (ret)
+		goto disable_hclk_ret;
+
+	ret = clk_prepare_enable(cclk);
+	if (ret)
+		goto disable_cclk_ret;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
 	irq = platform_get_irq_byname(pdev, "int0");
-	if (IS_ERR(addr) || irq < 0)
-		return -EINVAL;
 
-	/* allocate the m_can device */
-	dev = alloc_m_can_dev();
-	if (!dev)
-		return -ENOMEM;
+	if (IS_ERR(addr) || irq < 0) {
+		ret = -EINVAL;
+		goto disable_cclk_ret;
+	}
 
+	/* message ram could be shared */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
+	if (!res) {
+		ret = -ENODEV;
+		goto disable_cclk_ret;
+	}
+
+	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!mram_addr) {
+		ret = -ENOMEM;
+		goto disable_cclk_ret;
+	}
+
+	/* get message ram configuration */
+	ret = of_property_read_u32_array(np, "bosch,mram-cfg",
+					 mram_config_vals,
+					 sizeof(mram_config_vals) / 4);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
+		goto disable_cclk_ret;
+	}
+
+	/* Get TX FIFO size
+	 * Defines the total amount of echo buffers for loopback
+	 */
+	tx_fifo_size = mram_config_vals[7];
+
+	/* allocate the m_can device */
+	dev = alloc_m_can_dev(addr, tx_fifo_size);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto disable_cclk_ret;
+	}
 	priv = netdev_priv(dev);
 	dev->irq = irq;
-	priv->base = addr;
 	priv->device = &pdev->dev;
 	priv->hclk = hclk;
 	priv->cclk = cclk;
 	priv->can.clock.freq = clk_get_rate(cclk);
+	priv->mram_base = mram_addr;
 
-	ret = m_can_of_parse_mram(pdev, priv);
-	if (ret)
-		goto failed_free_dev;
+	m_can_of_parse_mram(priv, mram_config_vals);
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -1294,10 +1484,18 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
 		 KBUILD_MODNAME, priv->base, dev->irq);
 
-	return 0;
+	/* Probe finished
+	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 */
+	goto disable_cclk_ret;
 
 failed_free_dev:
 	free_m_can_dev(dev);
+disable_cclk_ret:
+	clk_disable_unprepare(cclk);
+disable_hclk_ret:
+	clk_disable_unprepare(hclk);
+failed_ret:
 	return ret;
 }
 
-- 
1.9.1

