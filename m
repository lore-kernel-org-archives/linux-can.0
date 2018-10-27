From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
Date: Sat, 27 Oct 2018 16:19:08 +0200
Message-ID: <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010142055.25271-2-dmurphy@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

for the RFC, could you please just do the necessary changes to the
existing code. We can discuss about better names, etc. later. For
the review if the common code I quickly did:

  mv m_can.c m_can_platform.c
  mv m_can_core.c m_can.c

The file names are similar to what we have for the C_CAN driver.

  s/classdev/priv/
  variable name s/m_can_dev/priv/

Then your patch 1/3 looks as shown below. I'm going to comment on that
one. The comments start with "***"....

From 9966873dc261b2703e0545718222874ba1b88638 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 10 Oct 2018 09:20:53 -0500
Subject: [PATCH] can: m_can: Create m_can core to leverage common code

Create a common code base that can be leveraged by other
devices that use the Bosch MCAN IP.

The common code manages the MCAN IP as well as registering
the CAN device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/Kconfig          |  12 +
 drivers/net/can/m_can/Makefile         |   3 +-
 drivers/net/can/m_can/m_can.c          | 385 +++++++++++++++------------------
 drivers/net/can/m_can/m_can_core.h     | 100 +++++++++
 drivers/net/can/m_can/m_can_platform.c | 168 ++++++++++++++
 5 files changed, 461 insertions(+), 207 deletions(-)
 create mode 100644 drivers/net/can/m_can/m_can_core.h
 create mode 100644 drivers/net/can/m_can/m_can_platform.c

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 04f20dd..b1a9358 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -1,5 +1,17 @@
 config CAN_M_CAN
+	tristate "Bosch M_CAN support"
+	---help---
+	  Say Y here if you want to support for Bosch M_CAN controller.
+
+config CAN_M_CAN_CORE
+	depends on CAN_M_CAN
+	tristate "Bosch M_CAN Core support"
+	---help---
+	  Say Y here if you want to support for Bosch M_CAN controller.
+
+config CAN_M_CAN_PLATFORM
 	depends on HAS_IOMEM
+	depends on CAN_M_CAN_CORE
 	tristate "Bosch M_CAN devices"
 	---help---
 	  Say Y here if you want to support for Bosch M_CAN controller.
diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
index 8bbd7f2..e013d6f 100644
--- a/drivers/net/can/m_can/Makefile
+++ b/drivers/net/can/m_can/Makefile
@@ -2,4 +2,5 @@
 #  Makefile for the Bosch M_CAN controller driver.
 #
 
-obj-$(CONFIG_CAN_M_CAN) += m_can.o
+obj-$(CONFIG_CAN_M_CAN_CORE) += m_can_core.o
+obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can.o

*** I haven't updated Kconfig and Makefile... it needs some adoptions anyway.

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b44940..4fb4269 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -28,6 +28,8 @@
 #include <linux/can/dev.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "m_can_core.h"
+
 /* napi related */
 #define M_CAN_NAPI_WEIGHT	64
 
@@ -86,28 +88,6 @@ enum m_can_reg {
 	M_CAN_TXEFA	= 0xf8,
 };
 
-/* m_can lec values */
-enum m_can_lec_type {
-	LEC_NO_ERROR = 0,
-	LEC_STUFF_ERROR,
-	LEC_FORM_ERROR,
-	LEC_ACK_ERROR,
-	LEC_BIT1_ERROR,
-	LEC_BIT0_ERROR,
-	LEC_CRC_ERROR,
-	LEC_UNUSED,
-};
-
-enum m_can_mram_cfg {
-	MRAM_SIDF = 0,
-	MRAM_XIDF,
-	MRAM_RXF0,
-	MRAM_RXF1,
-	MRAM_RXB,
-	MRAM_TXE,
-	MRAM_TXB,
-	MRAM_CFG_NUM,
-};
 
 /* Core Release Register (CREL) */
 #define CREL_REL_SHIFT		28
@@ -347,68 +327,100 @@ enum m_can_mram_cfg {
 #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
 #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
 
-/* address offset and element number for each FIFO/Buffer in the Message RAM */
-struct mram_cfg {
-	u16 off;
-	u8  num;
-};
-
-/* m_can private data structure */
-struct m_can_priv {
-	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
-	struct net_device *dev;
-	struct device *device;
-	struct clk *hclk;
-	struct clk *cclk;
-	void __iomem *base;
-	u32 irqstatus;
-	int version;
-
-	/* message ram configuration */
-	void __iomem *mram_base;
-	struct mram_cfg mcfg[MRAM_CFG_NUM];
-};
-
 static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
 {
-	return readl(priv->base + reg);
+	u32 ret;
+
+	if (priv->m_can_write)
+		ret = priv->m_can_read(priv, priv->reg_offset + reg);
+	else
+		ret = readl(priv->base + reg);

*** Why not just

       return priv->m_can_read(priv, priv->reg_offset, reg);

for both cases. Do we need "reg_offset" here or is it only needed in
platform code?

+
+	return ret;
 }
 
-static inline void m_can_write(const struct m_can_priv *priv,
+static inline int m_can_write(const struct m_can_priv *priv,
 			       enum m_can_reg reg, u32 val)
 {
-	writel(val, priv->base + reg);
+	int ret = 0;
+
+	if (priv->m_can_write)
+		ret = priv->m_can_write(priv, priv->reg_offset + reg, val);
+	else
+		writel(val, priv->base + reg);

*** Ditto.

+
+	return ret;
 }
 
 static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
 				  u32 fgi, unsigned int offset)
 {
-	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
-		     fgi * RXF0_ELEMENT_SIZE + offset);
+	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE + offset;
+	u32 read_fifo_addr; /* need to take into account iomem cases */
+	u32 ret = 0;
+
+	if (priv->mram_start)
+		read_fifo_addr = priv->mram_start + addr_offset;
+	else
+		read_fifo_addr = priv->mram_base + addr_offset;

*** Why do we need two platform-specific variables here? Couldn't it
be hidden in platform-specific code?

+	if (priv->m_can_fifo_read)
+		ret = priv->m_can_read(priv, read_fifo_addr);

*** Shouldn't that use "priv->m_can_fifo_read"? Looking to "tcan4x5x.c",
the functions "m_can_read" and "m_can_fifo_read" are identical.

+	else
+		ret = readl(read_fifo_addr);
+
+	return ret;
 }
 
 static inline void m_can_fifo_write(const struct m_can_priv *priv,
 				    u32 fpi, unsigned int offset, u32 val)
 {
-	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
-	       fpi * TXB_ELEMENT_SIZE + offset);
+	u32 addr_offset =  priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE + offset;
+	u32 write_fifo_addr;
+	u32 ret;
+
+	if (priv->mram_start)
+		write_fifo_addr = priv->mram_start + addr_offset;
+	else
+		write_fifo_addr = priv->mram_base + addr_offset;
+
+	if (priv->m_can_write)
+		ret = priv->m_can_write(priv, write_fifo_addr, val);
+	else
+		writel(val, write_fifo_addr);
+
+	return ret;
 }
 
 static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
 				      u32 fgi,
-				      u32 offset) {
-	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
-			fgi * TXE_ELEMENT_SIZE + offset);
+				      u32 offset)
+{
+	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE + offset;
+	u32 read_fifo_addr;
+	u32 ret = 0;
+
+printk("%s: Here\n", __func__);
+	if (priv->mram_start)
+		read_fifo_addr = priv->mram_start + addr_offset;
+	else
+		read_fifo_addr = priv->mram_base + addr_offset;
+
+	if (priv->m_can_fifo_read)
+		ret = priv->m_can_read(priv, read_fifo_addr);
+	else
+		ret = readl(read_fifo_addr);
+
+	return ret;
 }
 
 static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
 {
+printk("%s: Here\n", __func__);
 		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
 }
 
-static inline void m_can_config_endisable(const struct m_can_priv *priv,
-					  bool enable)
+void m_can_config_endisable(const struct m_can_priv *priv, bool enable)
 {
 	u32 cccr = m_can_read(priv, M_CAN_CCCR);
 	u32 timeout = 10;
@@ -430,7 +442,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 
 	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
 		if (timeout == 0) {
-			netdev_warn(priv->dev, "Failed to init module\n");
+			netdev_warn(priv->net, "Failed to init module\n");
 			return;
 		}
 		timeout--;
@@ -457,7 +469,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
 	int i;
-
+printk("%s: Here\n", __func__);
 	/* calculate the fifo get index for where to read data */
 	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_SHIFT;
 	dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
@@ -512,7 +524,7 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	struct m_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0;
 	u32 rxfs;
-
+printk("%s: Here\n", __func__);
 	rxfs = m_can_read(priv, M_CAN_RXF0S);
 	if (!(rxfs & RXFS_FFL_MASK)) {
 		netdev_dbg(dev, "no messages in fifo0\n");
@@ -541,7 +553,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *frame;
-
+printk("%s: Here\n", __func__);
 	netdev_err(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
@@ -566,7 +578,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-
+printk("%s: Here\n", __func__);
 	priv->can.can_stats.bus_error++;
 	stats->rx_errors++;
 
@@ -633,9 +645,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
 {
 	int err;
 
-	err = pm_runtime_get_sync(priv->device);
+	if (priv->pm_clock_support == 0)
+		return 0;
+
+	err = pm_runtime_get_sync(priv->dev);
 	if (err < 0) {
-		pm_runtime_put_noidle(priv->device);
+		pm_runtime_put_noidle(priv->dev);
 		return err;
 	}
 
@@ -644,7 +659,8 @@ static int m_can_clk_start(struct m_can_priv *priv)
 
 static void m_can_clk_stop(struct m_can_priv *priv)
 {
-	pm_runtime_put_sync(priv->device);
+	if (priv->pm_clock_support)
+		pm_runtime_put_sync(priv->dev);
 }
 
 static int m_can_get_berr_counter(const struct net_device *dev,
@@ -1150,17 +1166,17 @@ static void m_can_chip_config(struct net_device *dev)
 
 	/* route all interrupts to INT0 */
 	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
-
+printk("%s: Bit timing\n", __func__);
 	/* set bittiming params */
 	m_can_set_bittiming(dev);
-
+printk("%s: out\n", __func__);
 	m_can_config_endisable(priv, false);
 }
 
 static void m_can_start(struct net_device *dev)
 {
 	struct m_can_priv *priv = netdev_priv(dev);
-
+printk("%s: Hear\n", __func__);
 	/* basic m_can configuration */
 	m_can_chip_config(dev);
 
@@ -1171,6 +1187,7 @@ static void m_can_start(struct net_device *dev)
 
 static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
 {
+printk("%s: Hear\n", __func__);
 	switch (mode) {
 	case CAN_MODE_START:
 		m_can_start(dev);
@@ -1188,20 +1205,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
  * else it returns the release and step coded as:
  * return value = 10 * <release> + 1 * <step>
  */
-static int m_can_check_core_release(void __iomem *m_can_base)
+static int m_can_check_core_release(struct m_can_priv *priv)
 {
 	u32 crel_reg;
 	u8 rel;
 	u8 step;
 	int res;
-	struct m_can_priv temp_priv = {
-		.base = m_can_base
-	};
 
 	/* Read Core Release Version and split into version number
 	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
 	 */
-	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
+	crel_reg = m_can_read(priv, M_CAN_CREL);
 	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
 	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
 
@@ -1222,47 +1236,45 @@ static int m_can_check_core_release(void __iomem *m_can_base)
 static bool m_can_niso_supported(const struct m_can_priv *priv)
 {
 	u32 cccr_reg, cccr_poll;
-	int niso_timeout;
+	int niso_timeout = 0;
 
 	m_can_config_endisable(priv, true);
 	cccr_reg = m_can_read(priv, M_CAN_CCCR);
 	cccr_reg |= CCCR_NISO;
 	m_can_write(priv, M_CAN_CCCR, cccr_reg);
-
-	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
-					  (cccr_poll == cccr_reg), 0, 10);
+printk("%s: Fix readl poll timeout\n", __func__);
+/*	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
+					  (cccr_poll == cccr_reg), 0, 10);*/
 
 	/* Clear NISO */
 	cccr_reg &= ~(CCCR_NISO);
 	m_can_write(priv, M_CAN_CCCR, cccr_reg);
 
 	m_can_config_endisable(priv, false);
-
+printk("%s: out\n", __func__);
 	/* return false if time out (-ETIMEDOUT), else return true */
 	return !niso_timeout;
 }
 
-static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
-			   void __iomem *addr)
+static int m_can_dev_setup(struct net_device *dev)
 {
 	struct m_can_priv *priv;
 	int m_can_version;
 
-	m_can_version = m_can_check_core_release(addr);
+	priv = netdev_priv(dev);
+
+	m_can_version = m_can_check_core_release(priv);
 	/* return if unsupported version */
 	if (!m_can_version) {
-		dev_err(&pdev->dev, "Unsupported version number: %2d",
+		dev_err(priv->dev, "Unsupported version number: %2d",
 			m_can_version);
 		return -EINVAL;
 	}
 
-	priv = netdev_priv(dev);
 	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
 
 	/* Shared properties of all M_CAN versions */
 	priv->version = m_can_version;
-	priv->dev = dev;
-	priv->base = addr;
 	priv->can.do_set_mode = m_can_set_mode;
 	priv->can.do_get_berr_counter = m_can_get_berr_counter;
 
@@ -1297,7 +1309,7 @@ static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
 						: 0);
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported version number: %2d",
+		dev_err(priv->dev, "Unsupported version number: %2d",
 			priv->version);
 		return -EINVAL;
 	}
@@ -1515,20 +1527,6 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
-static void m_can_init_ram(struct m_can_priv *priv)
-{
-	int end, i, start;
-
-	/* initialize the entire Message RAM in use to avoid possible
-	 * ECC/parity checksum errors when reading an uninitialized buffer
-	 */
-	start = priv->mcfg[MRAM_SIDF].off;
-	end = priv->mcfg[MRAM_TXB].off +
-		priv->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
-	for (i = start; i < end; i += 4)
-		writel(0x0, priv->mram_base + i);
-}
-
 static void m_can_of_parse_mram(struct m_can_priv *priv,
 				const u32 *mram_config_vals)
 {
@@ -1556,7 +1554,7 @@ static void m_can_of_parse_mram(struct m_can_priv *priv,
 	priv->mcfg[MRAM_TXB].num = mram_config_vals[7] &
 			(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
 
-	dev_dbg(priv->device,
+	dev_dbg(priv->dev,
 		"mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
 		priv->mram_base,
 		priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
@@ -1566,63 +1564,57 @@ static void m_can_of_parse_mram(struct m_can_priv *priv,
 		priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
 		priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
 		priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
-
-	m_can_init_ram(priv);
 }
 
-static int m_can_plat_probe(struct platform_device *pdev)
+void m_can_init_ram(struct m_can_priv *priv)
 {
-	struct net_device *dev;
-	struct m_can_priv *priv;
-	struct resource *res;
-	void __iomem *addr;
-	void __iomem *mram_addr;
-	struct clk *hclk, *cclk;
-	int irq, ret;
-	struct device_node *np;
-	u32 mram_config_vals[MRAM_CFG_LEN];
-	u32 tx_fifo_size;
-
-	np = pdev->dev.of_node;
+	int end, i, start;
 
-	hclk = devm_clk_get(&pdev->dev, "hclk");
-	cclk = devm_clk_get(&pdev->dev, "cclk");
+	/* initialize the entire Message RAM in use to avoid possible
+	 * ECC/parity checksum errors when reading an uninitialized buffer
+	 */
+	start = priv->mcfg[MRAM_SIDF].off;
+	end = priv->mcfg[MRAM_TXB].off +
+		priv->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
 
-	if (IS_ERR(hclk) || IS_ERR(cclk)) {
-		dev_err(&pdev->dev, "no clock found\n");
-		ret = -ENODEV;
-		goto failed_ret;
+	for (i = start; i < end; i += 4) {
+		if (priv->mram_start)
+			m_can_write(priv, priv->mram_start + i, 0x0);
+		else
+			writel(0x0, priv->mram_base + i);

*** See my comments above.

 	}
+}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
-	addr = devm_ioremap_resource(&pdev->dev, res);
-	irq = platform_get_irq_byname(pdev, "int0");
+int m_can_core_get_clocks(struct m_can_priv *priv)
+{
+	int ret = 0;
 
-	if (IS_ERR(addr) || irq < 0) {
-		ret = -EINVAL;
-		goto failed_ret;
-	}
+	priv->hclk = devm_clk_get(priv->dev, "hclk");
+	priv->cclk = devm_clk_get(priv->dev, "cclk");
 
-	/* message ram could be shared */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
-	if (!res) {
+	if (IS_ERR(priv->cclk)) {
+		dev_err(priv->dev, "no clock found\n");
 		ret = -ENODEV;
-		goto failed_ret;
 	}
 
-	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!mram_addr) {
-		ret = -ENOMEM;
-		goto failed_ret;
-	}
+	return ret;
+}
 
-	/* get message ram configuration */
-	ret = of_property_read_u32_array(np, "bosch,mram-cfg",
-					 mram_config_vals,
-					 sizeof(mram_config_vals) / 4);
+struct m_can_priv *m_can_core_allocate_dev(struct device *dev)
+{
+	struct m_can_priv *class_dev = NULL;
+	u32 mram_config_vals[MRAM_CFG_LEN];
+	struct net_device *net_dev;
+	u32 tx_fifo_size;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(dev_fwnode(dev),
+					     "bosch,mram-cfg",
+					     mram_config_vals,
+					     sizeof(mram_config_vals) / 4);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
-		goto failed_ret;
+		dev_err(dev, "Could not get Message RAM configuration.");
+		goto out;
 	}
 
 	/* Get TX FIFO size
@@ -1631,50 +1623,57 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	tx_fifo_size = mram_config_vals[7];
 
 	/* allocate the m_can device */
-	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto failed_ret;
+	net_dev = alloc_candev(sizeof(*class_dev), tx_fifo_size);
+	if (!net_dev) {
+		dev_err(dev, "Failed to allocate CAN device");
+		goto out;
 	}
 
-	priv = netdev_priv(dev);
-	dev->irq = irq;
-	priv->device = &pdev->dev;
-	priv->hclk = hclk;
-	priv->cclk = cclk;
-	priv->can.clock.freq = clk_get_rate(cclk);
-	priv->mram_base = mram_addr;
-
-	platform_set_drvdata(pdev, dev);
-	SET_NETDEV_DEV(dev, &pdev->dev);
-
-	/* Enable clocks. Necessary to read Core Release in order to determine
-	 * M_CAN version
-	 */
-	pm_runtime_enable(&pdev->dev);
-	ret = m_can_clk_start(priv);
-	if (ret)
-		goto pm_runtime_fail;
+	class_dev = netdev_priv(net_dev);
+	if (!class_dev) {
+		dev_err(dev, "Failed to init netdev private");
+		goto out;
+	}
+
+	class_dev->net = net_dev;
+	class_dev->dev = dev;
+	SET_NETDEV_DEV(net_dev, dev);
+
+	m_can_of_parse_mram(class_dev, mram_config_vals);
+out:
+	return class_dev;
+}
+
+int m_can_core_register(struct m_can_priv *priv)
+{
+	int ret;
 
-	ret = m_can_dev_setup(pdev, dev, addr);
+	if (priv->pm_clock_support) {
+		pm_runtime_enable(priv->dev);
+		ret = m_can_clk_start(priv);
+		if (ret)
+			goto pm_runtime_fail;
+	}
+
+	ret = priv_setup(priv->net);
 	if (ret)
 		goto clk_disable;
 
-	ret = register_m_can_dev(dev);
+	ret = register_priv(priv->net);
 	if (ret) {
-		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
-			KBUILD_MODNAME, ret);
+		dev_err(priv->dev, "registering %s failed (err=%d)\n",
+			priv->net->name, ret);
 		goto clk_disable;
 	}
 
-	m_can_of_parse_mram(priv, mram_config_vals);
+	devm_can_led_init(priv->net);
 
-	devm_can_led_init(dev);
+	of_can_transceiver(priv->net);
 
-	of_can_transceiver(dev);
+	dev_info(priv->dev, "%s device registered (irq=%d, version=%d)\n",
+		 KBUILD_MODNAME, priv->net->irq, priv->version);
 
-	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
-		 KBUILD_MODNAME, dev->irq, priv->version);
+	m_can_set_bittiming(priv->net);
 
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
@@ -1683,14 +1682,14 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	m_can_clk_stop(priv);
 pm_runtime_fail:
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		free_candev(dev);
+		pm_runtime_disable(priv->dev);
+		free_candev(priv->net);
 	}
-failed_ret:
+
 	return ret;
 }
 
-static __maybe_unused int m_can_suspend(struct device *dev)
+int m_can_core_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
@@ -1709,7 +1708,7 @@ static __maybe_unused int m_can_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int m_can_resume(struct device *dev)
+int m_can_core_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_priv *priv = netdev_priv(ndev);
@@ -1747,8 +1746,6 @@ static int m_can_plat_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	free_candev(dev);
 
 	return 0;
@@ -1782,30 +1779,6 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 	return err;
 }
 
-static const struct dev_pm_ops m_can_pmops = {
-	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
-			   m_can_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
-};
-
-static const struct of_device_id m_can_of_table[] = {
-	{ .compatible = "bosch,m_can", .data = NULL },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, m_can_of_table);
-
-static struct platform_driver m_can_plat_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-		.of_match_table = m_can_of_table,
-		.pm     = &m_can_pmops,
-	},
-	.probe = m_can_plat_probe,
-	.remove = m_can_plat_remove,
-};
-
-module_platform_driver(m_can_plat_driver);
-
 MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");

*** I didn't review the rest of the patch for now.

Looking to the generic code, you didn't really change the way
the driver is accessing the registers. Also the interrupt handling
and rx polling is as it was before. Does that work properly using
the SPI interface of the TCAN4x5x?

I was also thinking about optimized read/write functions handling
more than 4 bytes of data, e.g. for the CAN payload data. That
would speed-up SPI transfers, I think. But that could also be
introduced later-on.

Wolfgang.
