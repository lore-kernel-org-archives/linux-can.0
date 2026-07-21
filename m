Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08403FF1D0
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634281; cv=none; b=LvN3qEVSbUVj3BtRnyrM6v6UJ4FsRIh0IjQhggK23dWyYEmkgBgDLEkmSuf2cN9wwZYLsyaAS9tBaCB0k+MNERigPyaZo3nv9o7gvGjXjB04+VtpR1qjkjUjIN+zxY+5kVhz2c6tr/FXRMDR6a7xpa3frydyXQ9Mm8XD7589glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634281; c=relaxed/simple;
	bh=FJgSSV+Bs46VpI6V9zFRIsOywHwXdGdGDifymtL1ork=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spQaCSoJomQtJWvGIF5uvgvpjSM3AUvmDt5v/wz0NZrLKJA9pXkGmkmzpSc3xsfVI0/yWgWiHeiefbsnYusky7eKJHnoDTE0dxkMQpqk3GtwCCSUITgdXV5ygIK1FmXthEpQf+0iWx0fQeVsKYHA2wrXZIYeCraXyrgh7/Y3H0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8BxGfClW19qZJ4FAA--.22181S3;
	Tue, 21 Jul 2026 19:44:37 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJAxTsWfW19qyPATAA--.39150S2;
	Tue, 21 Jul 2026 19:44:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-can@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v6 0/2] Add Loongson CAN-FD controller driver
Date: Tue, 21 Jul 2026 19:44:15 +0800
Message-ID: <cover.1784597141.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTsWfW19qyPATAA--.39150S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEPCGpdp60VcwABse
X-Coremail-Antispam: 1Uk129KBj93XoWxCryDuFWkGr47KF18trW5urX_yoWrZryxpF
	4rC3srur1DKr18Zrs3JayrCF15Aa1fJr13WFZIyw10kas8Zw1jq3yFk3W5WryUurWrCF4I
	v3yrurWFk3Z8uFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2MKZDUUUU

Hi all:

This patchset adds support for the CAN-FD controller found on Loongson
CPUs.

Patch 1 introduces the basic CAN-FD controller driver with support
for classic CAN and CAN FD, including bit timing, error handling,
NAPI-based RX, and multiple TX buffers.

Patch 2 adds optional DMA support for RX path using the Loongson APB
CMC DMA engine, which significantly reduces CPU load under high
receive throughput.

The driver has been tested on Loongson-2K3000 platforms with various
CAN/CAN FD traffic patterns.

Finally, I'd like to thank Bingxiong, the original author of this driver,
for his efforts in working on the patch.

Thanks.
Binbin

=========
V6:
- Rebase on linux-can/master;
Patch (1/2):
 - Drop CAN_CTRLMODE_3_SAMPLES ctrlmode;
 - Replace kfree_skb() with dev_kfree_skb_any();
 - Drop REG_CMD_ERCRST operation;
 - Rewrite `loongson_canfd_tx_interrupt()` to prevent duplicate handling
   of TX completion';
Patch (2/2):
 - Added a fallback to true when dmaengine_tx_status() returns an error;
 - Replaced all direct regmap_read() from LOONGSON_CANFD_RX_DATA with
   the priv->get_rx_data() callback;
 - Release the DMA channel and clear priv->rx_ch on dma_alloc_coherent()
   failure;

Link to V5:
https://lore.kernel.org/all/cover.1783670733.git.zhoubinbin@loongson.cn/

V5:
Patch (1/2):
 - Fix tseg1_max const value;
 - Empty FIFO when SKB allocate failed.
 - Use REG_FRAME_META1_RWCNT as the playload read count value;
 - Only clean processed interrupt flags in
   loongson_canfd_err_interrupt();
 - Refact loongson_canfd_tx_interrupt();
 - Add LOONGSON_CANFD_TRV_DLY into loongson_canfd_volatile_reg();
Patch (2/2):
 - Fix dma_request_chan() error path;
 - Fix build error;
 - Fix loongson_canfd_rxdma_init() error path;

Link to V4:
https://lore.kernel.org/all/cover.1783391759.git.zhoubinbin@loongson.cn/

V4:
- Fix some issues from sashiko.
Patch (1/2):
 - Update commit message;
 - Use common APIs to calculate DLC;
 - Correct CAN_RTR_FLAG judgement;
 - Add skb check for CAN_STATE_ERROR_ACTIVE case;
 - Use regmap_write() rather than regmap_update_bits() to
   disable all interrupts;
 - Add napi_disable() in error paths;
 - Add `clock-frequency` return value check;
 - More comments for macros.

Link to V3:
https://lore.kernel.org/all/cover.1782787997.git.zhoubinbin@loongson.cn/

V3:
Patch (1/2):
 - Replace the switch-case statement with a calculated mask in
   `loongson_canfd_get_txbuf_sts()`;
 - Change `loongson_canfd_reset()` return type to `void`;
 - Drop old code in `loongson_canfd_set_btr()`;
 - Rename `loongson_canfd_set_mode()` to `loongson_canfd_set_conf_mode()`;
 - Drop `cf->__res*` usage;
 - Drop unnecessary macro definitions;
 - Add `netif_napi_del()` in probe error route path;
 - Replace ternary operator with `if-else`;
 - Drop stats->rx_packets and stats->rx_bytes count in CAN error frames;
 - Add ethtool_ops;
 - Add CAN_CTRLMODE_CC_LEN8_DLC;

Patch (2/2):
 - Fix W=2 warning;
 - Rename get_rx_frc() -> get_rxbuf_empty();
 - Put `loongson_canfd_rxdma_remove()` before free_candev();
 - Adjust the RXDMA probe process.

Link to V2:
https://lore.kernel.org/all/cover.1780908445.git.zhoubinbin@loongson.cn/

V2:
Patch (1/2):
 - Put all code into one file;
 - Add COMPILE_TEST Kconfig option;
 - Rewrite Kconfig description;
 - Use `regmap_test_bits()` to simplify bit field checks;
 - Drop odd FIELD_GET() usage;
 - Don't use FIELD_GET() for a single bit;
 - Use an if/else instead of the ternary operator;
 - Use the CAN TDC framework to get the SSP value;
 - Use guard(spinlock)/scoped_guard(spinlock);
 - Use netdev_debug() to be less verboss;
 - Check for memory allocation failure;
 - Add CAN_ERR_CNT flag;
 - Drop unused REG_DATA_xx_yy_W_DATA_yy definition;
 - Add more function comment;

Link to V1:
https://lore.kernel.org/all/cover.1777273055.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  can: Add Loongson CAN-FD controller driver
  can: loongson_canfd: Add RXDMA support

 MAINTAINERS                      |    7 +
 drivers/net/can/Kconfig          |   11 +
 drivers/net/can/Makefile         |    1 +
 drivers/net/can/loongson_canfd.c | 1877 ++++++++++++++++++++++++++++++
 4 files changed, 1896 insertions(+)
 create mode 100644 drivers/net/can/loongson_canfd.c


base-commit: 1cb8553c02e93e5a150cebd42f9ee3db0ece4707
-- 
2.52.0

