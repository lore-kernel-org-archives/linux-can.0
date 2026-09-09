Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75D3F23AF
	for <linux-can@vger.kernel.org>; Wed,  9 Sep 2026 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947351; cv=none; b=Cr+Ij/JXrkcUhlXsPat1GZM/fBNOUBdr6V4L/g3FB96mMSC4zpMYmyhA46BHIBkFyZD3b4KDbie/H6Z5GAcC3Kv7KJo4wv4OfZ2LbhSiOoiXNFQTEcOFpbhiWOI+R9M8AQFj9/ZyjZkzjcgGwhnnbKetd3JvWNv0+Embnsz15FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947351; c=relaxed/simple;
	bh=Ka9INu9QEblGAhT0GUCsyfryKmBimnyIVeVCtXH3qJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob+Wpg5SeI3DOIHZXm6+X3g3fdpOyKD7T3Xd7qxqsNwCTcGqCkrOEGL8W937jhY8nbuNgd5Yb/Gc6FN+6Zuwkhoz9SGSoqf2B3s6wct4K4Dhyf6SUMrvN3aTZMx5DJ1tVQVdcavabdqQ/32nuenZBt2DXqWjsLuQVELxnDKjiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.112])
	by gateway (Coremail) with SMTP id _____8AxYdGTK6FqYSIKAA--.29626S3;
	Wed, 09 Sep 2026 17:49:07 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.112])
	by front1 (Coremail) with SMTP id qMiowJBxJs2NK6Fq8d4dAA--.22524S4;
	Wed, 09 Sep 2026 17:49:06 +0800 (CST)
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
Subject: [PATCH v8 2/2] can: loongson_canfd: Add RXDMA support
Date: Wed,  9 Sep 2026 17:48:54 +0800
Message-ID: <ff4ef5ee62146dc40c1bcaa4db9e8b31467219ad.1788945497.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788945497.git.zhoubinbin@loongson.cn>
References: <cover.1788945497.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs2NK6Fq8d4dAA--.22524S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEFCGqgvnIHCwAAsH
X-Coremail-Antispam: 1Uk129KBj9fXoW3CF47ZF4rJw4kGr1UZr18WFX_yoW8Gr45Co
	WfWFsIgw4rKw1UJryjqF13Xr17ZF1DurZIyrWSyr1kua90y3WDZrZxGw4fJry8Ka4Fgay5
	ua9YgF4fGw4ftr43l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
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
	xhVjvjDU0xZFpf9x07jwBMNUUUUU=

Extend the driver with an optional DMA engine support for the receive
path. When a DMA channel named `rx` is available (e.g., from the
loongson2-apb-cmc-dma driver), the RX buffer is mapped to a cyclic DMA
transfer that continuously fills a pre-allocated ring buffer. The driver
then readds incoming CAN frames directly from the DMA buffer, reducing
the number of MMIO accesses and improving performance under high
traffic.

Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/net/can/loongson_canfd.c | 250 ++++++++++++++++++++++++++++---
 1 file changed, 228 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
index 6c983987a120..7fb28bd00c14 100644
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
@@ -341,8 +345,10 @@
 #define DEV_NAME			"loongson_canfd"
 #define LOONGSON_CANFD_ID		0xBABE
 #define LOONGSON_CANFD_DW_BYTE		4
+#define LOONGSON_CANFD_RXBUF_SZ		SZ_1K
 #define LOONGSON_CANFD_TXBUF_NUM	8
 #define LOONGSON_CANFD_MAX_RTXTH	0xf
+#define LOONGSON_CANFD_RXDMA_NUM	(LOONGSON_CANFD_RXBUF_SZ / DMA_SLAVE_BUSWIDTH_4_BYTES)
 
 /**
  * struct loongson_canfd_priv - Driver private data
@@ -352,6 +358,13 @@
  * @res: Pointer to the CAN device resource (MMIO region)
  * @tx_lock: Lock for synchronizing TX interrupt handling
  * @stats_lock: Lock for protecting netdev statistics
+ * @rx_ch: DMA receive channel
+ * @rx_cookie: DMA receive cookie
+ * @rx_dma_buf: DMA RX buffer bus address
+ * @rx_buf: DMA RX buffer CPU address
+ * @rx_rd_ptr_dist: Read pointer distance from buffer end (in 32-bit words)
+ * @get_rx_data: Callback for reading RX data (DMA or poll mode)
+ * @get_rxbuf_empty: Callback for checking RX buffer empty state
  */
 struct loongson_canfd_priv {
 	struct can_priv		can;
@@ -360,6 +373,13 @@ struct loongson_canfd_priv {
 	struct resource		*res;
 	spinlock_t		tx_lock;	/* protect the sending queue */
 	spinlock_t		stats_lock;	/* protect the ndev->stats */
+	struct dma_chan		*rx_ch;
+	dma_cookie_t		rx_cookie;
+	dma_addr_t		rx_dma_buf;
+	unsigned int		*rx_buf;
+	u16			rx_rd_ptr_dist;
+	u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
+	bool (*get_rxbuf_empty)(struct loongson_canfd_priv *priv);
 };
 
 /**
@@ -523,12 +543,166 @@ static void loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
 }
 
 /**
- * loongson_canfd_rxbuf_empty() - Check if RX buffer is empty
+ * loongson_canfd_rxdata_dma() - Read RX data in DMA mode
+ * @priv: Driver private data
+ *
+ * Reads the next 32-bit word from the DMA RX buffer, advancing the read pointer.
+ *
+ * Return: The next 32-bit data word.
+ */
+static u32 loongson_canfd_rxdata_dma(struct loongson_canfd_priv *priv)
+{
+	u32 data = 0;
+
+	data = priv->rx_buf[LOONGSON_CANFD_RXDMA_NUM - priv->rx_rd_ptr_dist--];
+	if (!priv->rx_rd_ptr_dist)
+		priv->rx_rd_ptr_dist = LOONGSON_CANFD_RXDMA_NUM;
+
+	return data;
+}
+
+/**
+ * loongson_canfd_rxbuf_empty_dma() - Check if RX buffer is empty in DMA mode
+ * @priv: Driver private data
+ *
+ * Uses DMA transfer status to compare read and write pointers.
+ * If the write pointer has wrapped past the read pointer, data loss is assumed,
+ * and the read pointer is advanced to the write position.
+ *
+ * Return: true if buffer is empty, false if data is pending.
+ */
+static bool loongson_canfd_rxbuf_empty_dma(struct loongson_canfd_priv *priv)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+	u32 wptr_dist;
+
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
+	if (status != DMA_IN_PROGRESS)
+		return true;
+
+	/* Convert residue from bytes to number of 32-bit words */
+	wptr_dist = state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	/*
+	 * wptr_dist is the write pointer's distance from the buffer end.
+	 * It starts at BUFFER_SIZE (when write pointer is at start) and
+	 * decreases to 0 (when write pointer reaches end), then wraps back.
+	 * priv->rx_rd_ptr_dist is the read pointer's distance from the end.
+	 * If write pointer wraps past read pointer, wptr_dist becomes larger,
+	 * indicating data loss, so we advance read pointer to write position.
+	 */
+	if (priv->rx_rd_ptr_dist < wptr_dist)
+		priv->rx_rd_ptr_dist = wptr_dist;
+
+	return priv->rx_rd_ptr_dist == wptr_dist;
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
+ * loongson_canfd_rxdma_init() - Initialize RX DMA
+ * @ndev: Network device
+ *
+ * Allocates DMA buffer and configures cyclic DMA transfer.
+ *
+ * Return: 0 on success, negative error code on failure.
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
+	priv->rx_buf = dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ,
+					  &priv->rx_dma_buf, GFP_KERNEL);
+	if (!priv->rx_buf) {
+		dma_release_channel(priv->rx_ch);
+		priv->rx_ch = NULL;
+		return -ENOMEM;
+	}
+
+	memset(&config, 0, sizeof(config));
+	config.src_addr = priv->res->start + LOONGSON_CANFD_RX_DATA;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = dmaengine_slave_config(priv->rx_ch, &config);
+	if (ret < 0) {
+		netdev_err(ndev, "RX DMA channel config failed\n");
+		goto err_config;
+	}
+
+	desc = dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
+					 LOONGSON_CANFD_RXBUF_SZ, LOONGSON_CANFD_RXBUF_SZ,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		netdev_err(ndev, "RX DMA cyclic transaction preparation failed\n");
+		ret = -EBUSY;
+		goto err_config;
+	}
+
+	priv->rx_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(priv->rx_cookie);
+	if (ret) {
+		dmaengine_terminate_sync(priv->rx_ch);
+		goto err_config;
+	}
+
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
+ * loongson_canfd_rxdata_poll() - Read RX data in poll mode
+ * @priv: Driver private data
+ *
+ * Return: The next 32-bit data word from the RX data register.
+ */
+static u32 loongson_canfd_rxdata_poll(struct loongson_canfd_priv *priv)
+{
+	u32 data;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+	return data;
+}
+
+/**
+ * loongson_canfd_rxbuf_empty_poll() - Check if RX buffer is empty in poll mode
  * @priv: Driver private data
  *
  * Return: true if buffer is empty, false otherwise.
  */
-static bool loongson_canfd_rxbuf_empty(struct loongson_canfd_priv *priv)
+static bool loongson_canfd_rxbuf_empty_poll(struct loongson_canfd_priv *priv)
 {
 	return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_RX_STAT, REG_RX_STAT_RXE);
 }
@@ -747,8 +921,11 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	loongson_canfd_set_conf_mode(priv);
 
 	/* Configure interrupts */
-	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
-		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	if (priv->rx_ch)
+		int_ena |= REG_INT_STAT_DMADI;
+	else
+		int_ena |= REG_INT_STAT_RBNEI;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		int_ena |= REG_INT_STAT_ALI | REG_INT_STAT_BEI;
@@ -929,14 +1106,14 @@ static int loongson_canfd_rx(struct net_device *ndev)
 {
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-	u32 frame_hdr0, frame_hdr1, dlc, rwcnt, dbcnt, i, data;
+	u32 frame_hdr0, frame_hdr1, dlc, rwcnt, dbcnt, i;
 	struct canfd_frame *cfd;
 	struct can_frame *ccf;
 	struct sk_buff *skb;
 	bool is_can_fd;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr1);
+	frame_hdr0 = priv->get_rx_data(priv);
+	frame_hdr1 = priv->get_rx_data(priv);
 
 	rwcnt = FIELD_GET(REG_FRAME_META1_RWCNT, frame_hdr1);
 	if (rwcnt < 2)
@@ -956,7 +1133,7 @@ static int loongson_canfd_rx(struct net_device *ndev)
 
 	if (unlikely(!skb)) {
 		for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE)
-			regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+			priv->get_rx_data(priv);
 		stats->rx_dropped++;
 		return 1;
 	}
@@ -983,13 +1160,11 @@ static int loongson_canfd_rx(struct net_device *ndev)
 	else
 		can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
 
-	for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
-		put_unaligned_le32(data, cfd->data + i);
-	}
+	for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE)
+		put_unaligned_le32(priv->get_rx_data(priv), cfd->data + i);
 
 	while (unlikely(i < dbcnt)) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		priv->get_rx_data(priv);
 		i += LOONGSON_CANFD_DW_BYTE;
 	}
 
@@ -1204,7 +1379,7 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	u32 sts;
 
 	while (work_done < quota) {
-		if (loongson_canfd_rxbuf_empty(priv)) {
+		if (priv->get_rxbuf_empty(priv)) {
 			no_more_data = true;
 			break;
 		}
@@ -1242,9 +1417,15 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 
 	if (no_more_data) {
 		if (napi_complete_done(napi, work_done)) {
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
-				     REG_INT_STAT_RBNEI << 16);
+			int int_ena;
+
+			if (priv->rx_ch)
+				int_ena = REG_INT_STAT_DMADI;
+			else
+				int_ena = REG_INT_STAT_RBNEI;
+
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));
 		}
 	}
 
@@ -1327,9 +1508,10 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 				return IRQ_NONE;
 		}
 
-		if (isr & REG_INT_STAT_RBNEI) {
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
+		imask = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+		if (isr & imask) {
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, imask);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, imask);
 			napi_schedule(&priv->napi);
 		}
 
@@ -1572,18 +1754,40 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &loongson_canfd_ethtool_ops;
 	SET_NETDEV_DEV(ndev, dev);
 
+	priv->get_rx_data = loongson_canfd_rxdata_poll;
+	priv->get_rxbuf_empty = loongson_canfd_rxbuf_empty_poll;
+
+	priv->rx_ch = dma_request_chan(dev, "rx");
+	if (PTR_ERR(priv->rx_ch) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_candev_free;
+	}
+
+	if (IS_ERR(priv->rx_ch)) {
+		dev_warn(dev, "DMA not available, falling back to poll mode\n");
+		priv->rx_ch = NULL;
+	}
+
+	ret = loongson_canfd_rxdma_init(ndev);
+	if (!ret) {
+		priv->get_rx_data = loongson_canfd_rxdata_dma;
+		priv->get_rxbuf_empty = loongson_canfd_rxbuf_empty_dma;
+		priv->rx_rd_ptr_dist = LOONGSON_CANFD_RXDMA_NUM;
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
@@ -1599,6 +1803,7 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
 	free_candev(ndev);
 }
 
@@ -1618,6 +1823,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0

