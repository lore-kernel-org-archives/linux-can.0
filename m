From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent initialization
Date: Fri, 10 Mar 2017 15:00:16 +0100
Message-ID: <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:43956 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbdCJOAr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Mar 2017 09:00:47 -0500
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
        by imta24.fe.bosch.de (Postfix) with ESMTP id 4A449D800EA
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 15:00:25 +0100 (CET)
Received: from SI-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id EBEB92380C2E
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 15:00:24 +0100 (CET)
In-Reply-To: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch adapts the initialization of the M_CAN. So it can be used with
all versions >= 3.0.x.

Changes:
* Implemented new enum that represents the supported core versions.
* Added version element to m_can_priv structure to hold M_CAN version.
* Renamed bittiming structs for version 3.0.x
* Added new bittiming structs for version >= 3.1.x
* Function alloc_m_can_dev takes 2 new arguments. The TX FIFO size and the
  base address of the module.
* Versions >= 3.1.x use multiple echo_skb buffers. This depends on the
  TX FIFO size configured in the device tree. Because this info is needed
  by alloc_m_can_dev, parts of the M_RAM configuration are moved before
  the call of alloc_m_can_dev. This also changes the parameters of the
  m_can_of_parse_mram function.
* Chip configuaration for CAN_CTRLMODE_LOOPBACK is changed: Enabled
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
* Function to read TXE (Transmit Event) FIFO. Will be used later.
* Function to check, if TXE FIFO is full.
* Function to check the Core Release version. The read value determines the
  behaviour of the driver.
* Function to check if the NISO bit for version >= 3.2.x is implemented.

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 418 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 342 insertions(+), 76 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f2656a3..1538944 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -107,6 +107,21 @@ enum m_can_mram_cfg {
 	MRAM_CFG_NUM,
 };
 
+enum m_can_versions {
+	M_CAN_UNKNOWN_VERSION = 0,
+	M_CAN_V30X,
+	M_CAN_V31X,
+	M_CAN_V32X
+};
+
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
@@ -342,6 +357,7 @@ struct m_can_priv {
 	struct clk *cclk;
 	void __iomem *base;
 	u32 irqstatus;
+	enum m_can_versions version;
 
 	/* message ram configuration */
 	void __iomem *mram_base;
@@ -373,6 +389,22 @@ static inline void m_can_fifo_write(const struct m_can_priv *priv,
 	       fpi * TXB_ELEMENT_SIZE + offset);
 }
 
+static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
+				      u32 fgi,
+				      u32 offset) {
+	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
+			fgi * TXE_ELEMENT_SIZE + offset);
+}
+
+/* Check if TX fifo is full
+ * returns 0 if free
+ * returns 1 if occupied
+ */
+static inline int m_can_tx_fifo_full(const struct m_can_priv *priv)
+{
+		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
+}
+
 static inline void m_can_config_endisable(const struct m_can_priv *priv,
 					  bool enable)
 {
@@ -833,7 +865,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static const struct can_bittiming_const m_can_bittiming_const = {
+static const struct can_bittiming_const m_can_30X_bittiming_const = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 64,
@@ -845,7 +877,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	.brp_inc = 1,
 };
 
-static const struct can_bittiming_const m_can_data_bittiming_const = {
+static const struct can_bittiming_const m_can_30X_data_bittiming_const = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
 	.tseg1_max = 16,
@@ -857,6 +889,30 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const m_can_31X_bittiming_const = {
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
+static const struct can_bittiming_const m_can_31X_data_bittiming_const = {
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
@@ -892,6 +948,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  * - configure rx fifo
  * - accept non-matching frame into fifo 0
  * - configure tx buffer
+ *		- >= v3.1.x: TX FIFO is used
  * - configure mode
  * - setup bittiming
  */
@@ -908,15 +965,32 @@ static void m_can_chip_config(struct net_device *dev)
 	/* Accept Non-matching Frames Into FIFO 0 */
 	m_can_write(priv, M_CAN_GFC, 0x0);
 
-	/* only support one Tx Buffer currently */
-	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
-		    priv->mcfg[MRAM_TXB].off);
+	if (priv->version == M_CAN_V30X) {
+		/* only support one Tx Buffer currently */
+		m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
+				priv->mcfg[MRAM_TXB].off);
+	} else if (priv->version == M_CAN_V31X ||
+		   priv->version == M_CAN_V32X) {
+		/* TX FIFO is used for newer IP Core versions */
+		m_can_write(priv, M_CAN_TXBC,
+			    (priv->mcfg[MRAM_TXB].num << TXBC_TFQS_SHIFT) |
+			    (priv->mcfg[MRAM_TXB].off));
+	}
 
 	/* support 64 bytes payload */
 	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_64BYTES);
 
-	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
-		    priv->mcfg[MRAM_TXE].off);
+	/* TX Event FIFO */
+	if (priv->version == M_CAN_V30X) {
+		m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
+				priv->mcfg[MRAM_TXE].off);
+	} else if (priv->version == M_CAN_V31X || priv->version == M_CAN_V32X) {
+		/* Full TX Event FIFO is used */
+		m_can_write(priv, M_CAN_TXEFC,
+			    ((priv->mcfg[MRAM_TXE].num << TXEFC_EFS_SHIFT)
+			     & TXEFC_EFS_MASK) |
+			    priv->mcfg[MRAM_TXE].off);
+	}
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(priv, M_CAN_RXF0C,
@@ -928,22 +1002,50 @@ static void m_can_chip_config(struct net_device *dev)
 		     priv->mcfg[MRAM_RXF1].off);
 
 	cccr = m_can_read(priv, M_CAN_CCCR);
-	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
-		(CCCR_CME_MASK << CCCR_CME_SHIFT));
 	test = m_can_read(priv, M_CAN_TEST);
 	test &= ~TEST_LBCK;
+	if (priv->version == M_CAN_V30X) {
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		cccr |= CCCR_MON;
+		cccr &= ~(CCCR_TEST | CCCR_MON |
+			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
+			(CCCR_CME_MASK << CCCR_CME_SHIFT));
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+			cccr |= CCCR_TEST;
+			cccr |= CCCR_MON;
+			test |= TEST_LBCK;
+		}
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+			cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+
+		m_can_write(priv, M_CAN_CCCR, cccr);
+		m_can_write(priv, M_CAN_TEST, test);
+
+	} else {
+	/* Version 3.1.X or 3.2.X */
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
+
+		/* Only 3.2.X has NISO Bit implemented */
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+			cccr |= CCCR_NISO;
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+			cccr |= CCCR_TEST;
+			cccr |= CCCR_MON;
+			test |= TEST_LBCK;
+		}
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+			cccr |= (CCCR_BRSE | CCCR_FDOE);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
-		cccr |= CCCR_TEST;
-		test |= TEST_LBCK;
 	}
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
+	/* Enable Monitoring (all versions) */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		cccr |= CCCR_MON;
 
+	/* Write config */
 	m_can_write(priv, M_CAN_CCCR, cccr);
 	m_can_write(priv, M_CAN_TEST, test);
 
@@ -957,6 +1059,8 @@ static void m_can_chip_config(struct net_device *dev)
 	/* route all interrupts to INT0 */
 	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
 
+	/* Only 3.2.X has NISO Bit implemented */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
 	/* set bittiming params */
 	m_can_set_bittiming(dev);
 
@@ -994,33 +1098,160 @@ static void free_m_can_dev(struct net_device *dev)
 	free_candev(dev);
 }
 
-static struct net_device *alloc_m_can_dev(void)
+static int m_can_check_core_release(void * __iomem m_can_base)
+{
+	u32 crel_reg = 0;
+	u8 rel = 0;
+	u8 step = 0;
+	int res = 0;
+	struct m_can_priv temp_priv;
+
+	temp_priv.base = m_can_base;
+
+	/* Read Core Release Version and split into version number
+	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
+	 */
+	crel_reg = m_can_read((const struct m_can_priv *)&temp_priv,
+			      M_CAN_CREL);
+	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
+	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
+
+	if (rel == 3) {
+		switch (step) {
+		case 0:
+			/* Version 3.0.x */
+			res = M_CAN_V30X;
+			break;
+		case 1:
+			/* Version 3.1.x */
+			res = M_CAN_V31X;
+			break;
+		case 2:
+			/* Version 3.2.x */
+			res = M_CAN_V32X;
+			break;
+		default:
+			/* Unknown version */
+			res = M_CAN_UNKNOWN_VERSION;
+			break;
+		}
+	} else {
+		res = M_CAN_UNKNOWN_VERSION;
+	}
+
+	return res;
+}
+
+/* Selectable Non ISO support only in version 3.2.x
+ * This function checks if the bit is writable.
+ */
+static int m_can_check_niso_support(const struct m_can_priv *priv)
+{
+	u32 cccr_reg;
+	int timeout = 10;
+	int niso_support = 0;
+
+	m_can_config_endisable(priv, true);
+	cccr_reg = m_can_read(priv, M_CAN_CCCR);
+	cccr_reg |= CCCR_NISO;
+	m_can_write(priv, M_CAN_CCCR, cccr_reg);
+
+	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_NISO)) == 0) {
+		if (timeout == 0) {
+			/* NISO Flag could not be set NONISO not supported */
+			/* Clear NISO to prevent errors */
+			cccr_reg &= ~(CCCR_NISO);
+			m_can_write(priv, M_CAN_CCCR, cccr_reg);
+			niso_support = 0;
+			goto return_niso;
+		}
+		timeout--;
+		udelay(1);
+	}
+	/* NISO Flag is set*/
+	niso_support = 1;
+	/* Clear NISO */
+	cccr_reg &= ~(CCCR_NISO);
+	m_can_write(priv, M_CAN_CCCR, cccr_reg);
+
+return_niso:
+	m_can_config_endisable(priv, false);
+	return niso_support;
+}
+
+static struct net_device *alloc_m_can_dev(void __iomem *addr, u32 tx_fifo_size)
 {
 	struct net_device *dev;
 	struct m_can_priv *priv;
+	int m_can_version = M_CAN_UNKNOWN_VERSION;
+	int niso_bit_supported = 0;
+	unsigned int loopback_buffer_count;
+
+	m_can_version = m_can_check_core_release(addr);
+	/* return if unsupported version */
+	if (m_can_version == M_CAN_UNKNOWN_VERSION) {
+		dev = NULL;
+		goto return_dev;
+	}
 
-	dev = alloc_candev(sizeof(*priv), 1);
-	if (!dev)
-		return NULL;
+	/* If version < 3.1.x, then only one loopback buffer is used */
+	loopback_buffer_count = ((m_can_version == M_CAN_V30X)
+				? 1U
+				: (unsigned int)tx_fifo_size);
 
+	dev = alloc_candev(sizeof(*priv), loopback_buffer_count);
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
 
-	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
-					CAN_CTRLMODE_LISTENONLY |
-					CAN_CTRLMODE_BERR_REPORTING |
-					CAN_CTRLMODE_FD;
 
+	/* Set properties depending on M_CAN version */
+	switch (priv->version) {
+	case M_CAN_V30X:
+		priv->can.bittiming_const = &m_can_30X_bittiming_const;
+		priv->can.data_bittiming_const =
+				&m_can_30X_data_bittiming_const;
+		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
+		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
+		break;
+	case M_CAN_V31X:
+		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
+		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
+		priv->can.bittiming_const = &m_can_31X_bittiming_const;
+		priv->can.data_bittiming_const =
+				&m_can_31X_data_bittiming_const;
+		break;
+	case M_CAN_V32X:
+		priv->can.bittiming_const = &m_can_31X_bittiming_const;
+		priv->can.data_bittiming_const =
+				&m_can_31X_data_bittiming_const;
+		niso_bit_supported = m_can_check_niso_support(priv);
+		break;
+	default:
+		/* This does not happen */
+		break;
+	}
+
+	/* Set M_CAN supported operations */
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			CAN_CTRLMODE_LISTENONLY |
+			CAN_CTRLMODE_BERR_REPORTING |
+			CAN_CTRLMODE_FD |
+			(niso_bit_supported == 1
+			 ? CAN_CTRLMODE_FD_NON_ISO
+			 : 0);
+return_dev:
 	return dev;
 }
 
@@ -1167,58 +1398,39 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
-static int m_can_of_parse_mram(struct platform_device *pdev,
-			       struct m_can_priv *priv)
+static void m_can_of_parse_mram(void __iomem *m_ram_base,
+				const u32 *mram_config_vals,
+				struct m_can_priv *priv)
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
+	priv->mram_base = m_ram_base;
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
@@ -1237,7 +1449,6 @@ static int m_can_of_parse_mram(struct platform_device *pdev,
 	for (i = start; i < end; i += 4)
 		writel(0x0, priv->mram_base + i);
 
-	return 0;
 }
 
 static int m_can_plat_probe(struct platform_device *pdev)
@@ -1246,38 +1457,85 @@ static int m_can_plat_probe(struct platform_device *pdev)
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
+
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
 
-	ret = m_can_of_parse_mram(pdev, priv);
-	if (ret)
-		goto failed_free_dev;
+	m_can_of_parse_mram(mram_addr, mram_config_vals, priv);
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -1294,10 +1552,18 @@ static int m_can_plat_probe(struct platform_device *pdev)
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

