Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F1F3EFD15
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920178; cv=none; b=CMKiaL6rTEuj4XotHzf7lYi+Y7AjNwfT1uNpusjgbyKmgGbWDHFcGvnBGCWh5RtF7HUi6AFQWfwT5hHkhvO80FvbJ3nYIVRPJYPPPOo8ftYOZ7qG9pBVmEpJI9Y/UtdGtBGhLlJI9LuuOfZtTpaE5rZTdQPZaEH8uzNGCFampmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920178; c=relaxed/simple;
	bh=a7sVJwIU9oaLwL0dd1j1Im/J4ox507/K1ePY3CDizCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU5LKuqSVwudtQeUH1FFr/znKCMLcg2cE0MNo8o5NBstRjvTLJGMD/2yqd3zmxBzUerBawmYVFhTSrwQ48rIxhyK5+CSDDF0XQSExiUKjL1WRhv3nxlQLpVyXAeuIHaFbQW9mxI7PyXEPV/0NFB/dFYdnmRBGqJY/+d1JhL9jjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8CxLJut+nJqcJcKAA--.11173S3;
	Wed, 05 Aug 2026 16:56:13 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJAxTsWo+nJq4YckAA--.1238S4;
	Wed, 05 Aug 2026 16:56:12 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-can@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v7 2/2] can: loongson_canfd: Add RXDMA support
Date: Wed,  5 Aug 2026 16:56:00 +0800
Message-ID: <965b460722a9256fc045a69ddac049fb40b2cba1.1785898181.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785898181.git.zhoubinbin@loongson.cn>
References: <cover.1785898181.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTsWo+nJq4YckAA--.1238S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGpyv68E7QAAsg
X-Coremail-Antispam: 1Uk129KBj9fXoW3CF47CFW3Cr4kCFWDAr15WrX_yoW8GrW3uo
	WfWFsxKw4rCw18Jr1UKF13Xr17Z3WDZrsxArZakr4kGa90v3WDArWDWa13Jr18ta4Fqa15
	uayrWF4xGw4ftr43l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jz2NtUUUUU=

Extend the driver with an optional DMA engine support for the receive
path. When a DMA channel named `rx` is available (e.g., from the
loongson2-apb-cmc-dma driver), the RX buffer is mapped to a cyclic DMA
transfer that continuously fills a pre-allocated ring buffer. The driver
then readds incoming CAN frames directly from the DMA buffer, reducing
the number of MMIO accesses and improving performance under high
traffic.

The DMA mode is completely transparent to the under networking stack;
the driver automatically selects the appropriate RX data reading method
based on the availability of the DMA channel.

Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/net/can/Kconfig          |   2 +-
 drivers/net/can/loongson_canfd.c | 231 ++++++++++++++++++++++++++++---
 2 files changed, 212 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 95a0f898959c..07a51aed54d0 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -188,7 +188,7 @@ config CAN_KVASER_PCIEFD
 
 config CAN_LOONGSON_CANFD
 	tristate "Loongson CAN-FD controller"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)
 	select REGMAP_MMIO
 	help
 	  This is a canfd driver switch for the Loongson platform,
diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
index dbb8bd434080..714c7706f355 100644
--- a/drivers/net/can/loongson_canfd.c
+++ b/drivers/net/can/loongson_canfd.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_dma.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/cleanup.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -340,8 +344,10 @@
 #define DEV_NAME			"loongson_canfd"
 #define LOONGSON_CANFD_ID		0xBABE
 #define LOONGSON_CANFD_DW_BYTE		4
+#define LOONGSON_CANFD_RXBUF_SZ		SZ_1K
 #define LOONGSON_CANFD_TXBUF_NUM	8
 #define LOONGSON_CANFD_MAX_RTXTH	0xf
+#define LOONGSON_CANFD_RXDMA_NUM	(LOONGSON_CANFD_RXBUF_SZ / DMA_SLAVE_BUSWIDTH_4_BYTES)
 
 /**
  * struct loongson_canfd_priv - This definition define CAN driver instance
@@ -351,6 +357,13 @@
  * @res: Pointer to the CAN device respurce
  * @tx_lock: Lock for synchronizing TX interrupt handling
  * @stats_lock: Lock for netdev->stats
+ * @rx_ch: CAN DMA rx channel
+ * @rx_cookie: CAN DMA rx cookie
+ * @rx_dma_buf: CAN DMA rx buffer bus address
+ * @rx_buf: CAN DMA rx buffer cpu address
+ * @last_res: Last rx data in DMA route
+ * @get_rx_data:  Callback of reading CAN rx data
+ * @get_rxbuf_empty: Callback of gets the RX buffer is empty in dma mode
  */
 struct loongson_canfd_priv {
 	struct can_priv		can;		/* must be first member! */
@@ -359,6 +372,13 @@ struct loongson_canfd_priv {
 	struct resource		*res;
 	spinlock_t		tx_lock;	/* protect the sending queue */
 	spinlock_t		stats_lock;	/* protect the ndev->stats */
+	struct dma_chan		*rx_ch;
+	dma_cookie_t		rx_cookie;
+	dma_addr_t		rx_dma_buf;	/* dma rx buffer bus address */
+	unsigned int		*rx_buf;	/* dma rx buffer cpu address */
+	u16			last_res;
+	u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
+	bool (*get_rxbuf_empty)(struct loongson_canfd_priv *priv);
 };
 
 /**
@@ -524,13 +544,150 @@ static void loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
 }
 
 /**
- * loongson_canfd_rxbuf_empty() - Gets the RX buffer is empty
+ * loongson_canfd_get_rxdata_in_dma() - Reading RX data in DMA mode
+ * @priv: Pointer to private data
+ *
+ * Return: The CANFD RX data.
+ */
+static u32 loongson_canfd_get_rxdata_in_dma(struct loongson_canfd_priv *priv)
+{
+	u32 data = 0;
+
+	data = priv->rx_buf[LOONGSON_CANFD_RXDMA_NUM - priv->last_res--];
+	if (!priv->last_res)
+		priv->last_res = LOONGSON_CANFD_RXDMA_NUM;
+
+	return data;
+}
+
+/**
+ * loongson_canfd_get_rxbuf_empty_in_dma() - Gets the RX buffer is empty in dma mode
  * @priv: Pointer to private data
  *
  * Return: True - RX buffer is empty.
  *	   False - RX buffer is processing
  */
-static bool loongson_canfd_rxbuf_empty(struct loongson_canfd_priv *priv)
+static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_priv *priv)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
+	if (status != DMA_IN_PROGRESS)
+		return true;
+
+	return priv->last_res == (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES);
+}
+
+static void loongson_canfd_rxdma_free(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	if (!priv->rx_buf)
+		return;
+
+	dma_free_coherent(dev, LOONGSON_CANFD_RXBUF_SZ, priv->rx_buf, priv->rx_dma_buf);
+	priv->rx_buf = NULL;
+}
+
+static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	if (!priv->rx_ch)
+		return;
+
+	dmaengine_terminate_sync(priv->rx_ch);
+	loongson_canfd_rxdma_free(priv, dev);
+	dma_release_channel(priv->rx_ch);
+	priv->rx_ch = NULL;
+}
+
+/**
+ * loongson_canfd_rxdma_init() - Loongson canfd RXDMA initialization
+ * @ndev: Pointer to net_device structure
+ *
+ * Return: The number of messages in the receive buffer
+ */
+static int loongson_canfd_rxdma_init(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct device *dev = ndev->dev.parent;
+	struct dma_slave_config config;
+	int ret;
+
+	if (!priv->rx_ch)
+		return -EINVAL;
+
+	priv->rx_buf = dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ, &priv->rx_dma_buf,
+					  GFP_KERNEL);
+	if (!priv->rx_buf) {
+		dma_release_channel(priv->rx_ch);
+		priv->rx_ch = NULL;
+		return -ENOMEM;
+	}
+
+	/* Configure DMA channel */
+	memset(&config, 0, sizeof(config));
+	config.src_addr = priv->res->start + LOONGSON_CANFD_RX_DATA;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = dmaengine_slave_config(priv->rx_ch, &config);
+	if (ret < 0) {
+		netdev_err(ndev, "Loongson canfd rxdma channel config failed\n");
+		goto err_config;
+	}
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
+					 LOONGSON_CANFD_RXBUF_SZ, LOONGSON_CANFD_RXBUF_SZ,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		netdev_err(ndev, "Loongson canfd rxdma cyclic transaction failed\n");
+		ret = -EBUSY;
+		goto err_config;
+	}
+
+	/* Push current dma transaction in the pending queue */
+	priv->rx_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(priv->rx_cookie);
+	if (ret) {
+		dmaengine_terminate_sync(priv->rx_ch);
+		goto err_config;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(priv->rx_ch);
+
+	return 0;
+
+err_config:
+	loongson_canfd_rxdma_free(priv, dev);
+	dma_release_channel(priv->rx_ch);
+	priv->rx_ch = NULL;
+	return ret;
+}
+
+/**
+ * loongson_canfd_get_rxdata_in_poll() - Reading RX data in poll mode
+ * @priv: Pointer to private data
+ *
+ * Return: The CANFD RX data.
+ */
+static u32 loongson_canfd_get_rxdata_in_poll(struct loongson_canfd_priv *priv)
+{
+	u32 data;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+
+	return data;
+}
+
+/**
+ * loongson_canfd_get_rxbuf_empty_in_poll() - Gets the RX buffer is empty in poll mode
+ * @priv: Pointer to private data
+ *
+ * Return: True - RX buffer is empty.
+ *	   False - RX buffer is processing
+ */
+static bool loongson_canfd_get_rxbuf_empty_in_poll(struct loongson_canfd_priv *priv)
 {
 	return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_RX_STAT, REG_RX_STAT_RXE);
 }
@@ -755,8 +912,11 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	loongson_canfd_set_conf_mode(priv);
 
 	/* Configure interrupts */
-	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
-		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	if (priv->rx_ch)
+		int_ena |= REG_INT_STAT_DMADI;
+	else
+		int_ena |= REG_INT_STAT_RBNEI;
 
 	/* Bus error reporting */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
@@ -957,14 +1117,14 @@ static int loongson_canfd_rx(struct net_device *ndev)
 {
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-	u32 meta0, meta1, dlc, rwcnt, dbcnt, i, data;
+	u32 meta0, meta1, dlc, rwcnt, dbcnt, i;
 	struct canfd_frame *cfd;
 	struct can_frame *ccf;
 	struct sk_buff *skb;
 	bool is_can_fd;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+	meta0 = priv->get_rx_data(priv);
+	meta1 = priv->get_rx_data(priv);
 
 	/* Number of characters received */
 	rwcnt = FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
@@ -986,7 +1146,7 @@ static int loongson_canfd_rx(struct net_device *ndev)
 
 	if (unlikely(!skb)) {
 		for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE)
-			regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+			priv->get_rx_data(priv);
 		stats->rx_dropped++;
 		return 1;
 	}
@@ -1019,11 +1179,11 @@ static int loongson_canfd_rx(struct net_device *ndev)
 
 	/* Copy payload */
 	for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE)
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + i));
+		*(u32 *)(cfd->data + i) = priv->get_rx_data(priv);
 
 	/* Drain any residual (should not happen) */
 	while (unlikely(i < dbcnt)) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		priv->get_rx_data(priv);
 		i += LOONGSON_CANFD_DW_BYTE;
 	}
 
@@ -1250,7 +1410,7 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	u32 sts;
 
 	while (work_done < quota) {
-		if (loongson_canfd_rxbuf_empty(priv)) {
+		if (priv->get_rxbuf_empty(priv)) {
 			no_more_data = true;
 			break;
 		}
@@ -1296,13 +1456,19 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	/* Complete NAPI and re-enable interrupts only when `no more data` is detected */
 	if (no_more_data) {
 		if (napi_complete_done(napi, work_done)) {
+			int int_ena;
+
+			if (priv->rx_ch)
+				int_ena = REG_INT_STAT_DMADI;
+			else
+				int_ena = REG_INT_STAT_RBNEI;
+
 			/*
-			 * Clear and enable RBNEI. It is level-triggered,
+			 * Clear and enable RBNEI/DMADI. It is level-triggered,
 			 * so there is no race condition.
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
-				     (REG_INT_STAT_RBNEI << 16));
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));
 		}
 	}
 
@@ -1409,13 +1575,14 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 		}
 
 		/* Receive Buffer Not Empty Interrupt */
-		if (isr & REG_INT_STAT_RBNEI) {
+		imask = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+		if (isr & imask) {
 			/*
 			 * Mask RXBNEI the first, then clear interrupt and schedule NAPI.
 			 * Even if another IRQ fires, RBNEI will always be 0 (masked).
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, imask);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, imask);
 			napi_schedule(&priv->napi);
 		}
 
@@ -1669,18 +1836,40 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &loongson_canfd_ethtool_ops;
 	SET_NETDEV_DEV(ndev, dev);
 
+	priv->get_rx_data = loongson_canfd_get_rxdata_in_poll;
+	priv->get_rxbuf_empty = loongson_canfd_get_rxbuf_empty_in_poll;
+
+	priv->rx_ch = dma_request_chan(dev, "rx");
+	if (PTR_ERR(priv->rx_ch) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_candev_free;
+	}
+
+	if (IS_ERR(priv->rx_ch)) {
+		dev_warn(dev, "Fall back in poll mode for any non-deferral error.\n");
+		priv->rx_ch = NULL;
+	}
+
+	ret = loongson_canfd_rxdma_init(ndev);
+	if (!ret) {
+		priv->get_rx_data = loongson_canfd_get_rxdata_in_dma;
+		priv->get_rxbuf_empty = loongson_canfd_get_rxbuf_empty_in_dma;
+		priv->last_res = LOONGSON_CANFD_RXDMA_NUM;
+	}
 	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
 
 	ret = register_candev(ndev);
 	if (ret) {
 		dev_err(dev, "register_candev failed with %d\n", ret);
-		goto err_candev_free;
+		goto err_napi_del;
 	}
 
 	return 0;
 
-err_candev_free:
+err_napi_del:
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
+err_candev_free:
 	free_candev(ndev);
 	return ret;
 }
@@ -1698,6 +1887,7 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
 	free_candev(ndev);
 }
 
@@ -1717,6 +1907,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0

