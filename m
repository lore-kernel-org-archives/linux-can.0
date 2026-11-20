Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162125;
	b=wPj+CG+nLA0Wgdpn/eokylZzbBow562M4K8Z53SMb4jDBjMoz7SVAk5XLF6vgbeR4xS3
	 0OTWGg6VGpVAGDPykiO9Mq+RL99l6OMB78tUbUOihyMAsWuB71hsJh9lGD9uSBVBZwMuc
	 8CRTX37QzOhjFsjBKYs+UP8V5As8WZkpO52pDdQXM0ztHQad7c/XkJ6gcUy63X2dakOW5
	 MRwXP1aTTIYb6OyrMC78NpfLUtbFyFXqBo9vY6MrTjIaYIi3ePHOAgcq/Tz0BXwi7chFq
	 LvlSFDimtTHWagB/C8xvRac395/JQNH8lmBmo3yvJ2GP9Eg6QUCk3kcjrevci21ZO1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162125;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=gH4Y2AjkJGwBn2u4qMGGm7+3+DbFhKPvgZPut0mxzas=;
	b=gZ89IgCwPeupSJm0LZhAtlJv/tBFb1VZyupksw5sfjJ8bJNKBEdoEAaimH+XgalTgqb8
	 ABTjLgEDdMeMohukaBG/LOxUlT8osHbFLAbRERsIrPKClZ4DZWPOo73Yo52IKcrpbVwL7
	 pXEyJw4wvqtZIynRQL99Rtl2iSJkNJJMg0D3ZapzbeWcymsPsHlKX2uTSNmglOsl/vc1n
	 yC+Wh93DRVZ/xZJ6q5olQgd4c/1cDdCAW8j3mee5V036mQTYjXbOqEV121F9pCNIoxto9
	 FX6ZZhW8JxUDC8JBNIDFPu9jClcVpbwVQJbFypyisa5c7nmocCdn4gtzNcKCTguNynA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65B606A320;
	Fri, 20 Nov 2026 08:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C65B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 00:08:40 -0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-can@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 2/3] can: amlogic: add driver for Amlogic A9 CAN-FD controller
Date: Fri, 20 Nov 2026 16:08:19 +0800
Message-ID: <20261120080820.3340646-3-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261120080820.3340646-1-zelong.dong@amlogic.com>
References: <20261120080820.3340646-1-zelong.dong@amlogic.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Zelong Dong <zelong.dong@amlogic.com>

Add a driver for the CAN-FD controller found on the Amlogic A9 SoC
family. The controller supports both classic CAN and CAN-FD.

The driver uses the generic RX offload infrastructure with hardware
timestamps, reports bus errors through the CAN berr counter, and
implements suspend/resume support.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 drivers/net/can/Kconfig               |   1 +
 drivers/net/can/Makefile              |   1 +
 drivers/net/can/amlogic/Kconfig       |   9 +
 drivers/net/can/amlogic/Makefile      |   3 +
 drivers/net/can/amlogic/amlogic_can.c | 864 ++++++++++++++++++++++++++
 drivers/net/can/amlogic/amlogic_can.h | 367 +++++++++++
 6 files changed, 1245 insertions(+)
 create mode 100644 drivers/net/can/amlogic/Kconfig
 create mode 100644 drivers/net/can/amlogic/Makefile
 create mode 100644 drivers/net/can/amlogic/amlogic_can.c
 create mode 100644 drivers/net/can/amlogic/amlogic_can.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a8fad6fe5302..fbd7523f38a4 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -257,6 +257,7 @@ source "drivers/net/can/sja1000/Kconfig"
 source "drivers/net/can/softing/Kconfig"
 source "drivers/net/can/spi/Kconfig"
 source "drivers/net/can/usb/Kconfig"
+source "drivers/net/can/amlogic/Kconfig"
 
 endif #CAN_NETLINK
 
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 4010d17f8583..a5cec506bab4 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -35,5 +35,6 @@ obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
 obj-$(CONFIG_CAN_VIRTIO_CAN)	+= virtio_can.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
+obj-$(CONFIG_CAN_AMLOGIC)	+= amlogic/
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
diff --git a/drivers/net/can/amlogic/Kconfig b/drivers/net/can/amlogic/Kconfig
new file mode 100644
index 000000000000..52e5298061f1
--- /dev/null
+++ b/drivers/net/can/amlogic/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+config CAN_AMLOGIC
+        tristate "Amlogic CANBUS Controller"
+	select CAN_RX_OFFLOAD
+	default n
+        help
+          Say Y here if you want to use Amlogic CANBUS Controller.
+
diff --git a/drivers/net/can/amlogic/Makefile b/drivers/net/can/amlogic/Makefile
new file mode 100644
index 000000000000..20a0b33b3098
--- /dev/null
+++ b/drivers/net/can/amlogic/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+obj-$(CONFIG_CAN_AMLOGIC) += amlogic_can.o
diff --git a/drivers/net/can/amlogic/amlogic_can.c b/drivers/net/can/amlogic/amlogic_can.c
new file mode 100644
index 000000000000..261544721e72
--- /dev/null
+++ b/drivers/net/can/amlogic/amlogic_can.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 Amlogic, Inc. All rights reserved
+ */
+#include <linux/bitfield.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "amlogic_can.h"
+
+static const struct regmap_config aml_can_regmap_config = {
+	.name = "amlogic_can",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x3838,
+};
+
+static const struct can_bittiming_const aml_can_fd_bittiming_const = {
+	.name = "amlogic_fd",
+	.tseg1_min = 2,
+	.tseg1_max = 96,
+	.tseg2_min = 2,
+	.tseg2_max = 32,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const aml_can_fd_data_bittiming_const = {
+	.name = "amlogic_fd_data",
+	.tseg1_min = 2,
+	.tseg1_max = 39,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
+static int aml_can_flag_wait(struct aml_can_priv *priv, u32 addr,  u32 flag,
+			     u32 flag_val, int timeout_us)
+{
+	int timeout = timeout_us / 10;
+	u32 val;
+
+	do {
+		usleep_range(10, 15);
+		regmap_read(priv->reg, addr, &val);
+	} while (timeout-- && ((val & flag) != flag_val));
+
+	if (timeout < 0)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static inline int aml_can_low_power_mode_wait(struct aml_can_priv *priv,
+					      bool enter)
+{
+	/* wait to enter/exit low power mode ack */
+	return aml_can_flag_wait(priv, CAN_MCR, CAN_MCR_LPMACK,
+				   enter ? CAN_MCR_LPMACK : 0, 250);
+}
+
+static int aml_can_module_enable(struct aml_can_priv *priv, bool enable)
+{
+	regmap_update_bits(priv->reg, CAN_MCR, CAN_MCR_MDIS,
+			   enable ? 0 : CAN_MCR_MDIS);
+
+	return aml_can_low_power_mode_wait(priv, !enable);
+}
+
+static int aml_can_freeze_mode_enable(struct aml_can_priv *priv, bool enable)
+{
+	unsigned int timeout = 250;
+	u32 bitrate = priv->can.bittiming.bitrate;
+
+	if (enable) {
+		if (bitrate)
+			timeout = 1000 * 1000 / bitrate * 10;
+
+		regmap_update_bits(priv->reg, CAN_MCR, CAN_MCR_FRZ,
+				   CAN_MCR_FRZ);
+	}
+
+	regmap_update_bits(priv->reg, CAN_MCR, CAN_MCR_HALT,
+			   enable ? CAN_MCR_HALT : 0);
+
+	/* wait to enter/exit freeze mode flag */
+	return aml_can_flag_wait(priv, CAN_MCR, CAN_MCR_FRZACK,
+				   enable ? CAN_MCR_FRZACK : 0, timeout);
+}
+
+static void aml_can_interrupts_enable(struct aml_can_priv *priv, bool enable)
+{
+	regmap_update_bits(priv->reg, CAN_CTRL1, CAN_CTRL1_ERR_ALL,
+			   enable ? CAN_CTRL1_ERR_ALL : 0);
+	regmap_write(priv->reg, CAN_IMASK1, enable ? BIT(0) : 0);
+	regmap_write(priv->reg, CAN_IMASK2, enable ? BIT(0) : 0);
+}
+
+static inline int aml_can_soft_reset(struct aml_can_priv *priv)
+{
+	regmap_update_bits(priv->reg, CAN_MCR, CAN_MCR_SOFTRST,
+			   CAN_MCR_SOFTRST);
+
+	/* wait to enter/exit freeze mode flag */
+	return aml_can_flag_wait(priv, CAN_MCR, CAN_MCR_SOFTRST, 0, 250);
+}
+
+static void aml_can_set_bittiming_ctrl(struct aml_can_priv *priv)
+{
+	struct can_bittiming *bt = &priv->can.bittiming;
+	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
+	u32 val;
+
+	if (!(priv->can.ctrlmode_supported & CAN_CTRLMODE_FD)) {
+		val = FIELD_PREP(CAN_CTRL1_PRESDIV, bt->brp - 1) |
+		      FIELD_PREP(CAN_CTRL1_RJW, bt->sjw - 1) |
+		      FIELD_PREP(CAN_CTRL1_PSEG1, bt->phase_seg1 - 1) |
+		      FIELD_PREP(CAN_CTRL1_PSEG2, bt->phase_seg2 - 1) |
+		      FIELD_PREP(CAN_CTRL1_PROPSEG, bt->prop_seg - 1);
+
+		regmap_update_bits(priv->reg, CAN_CTRL1, CAN_CTRL1_CBT, val);
+
+		return;
+	}
+
+	if (bt->phase_seg1 > 0x20) {
+		bt->prop_seg += (bt->phase_seg1 - 0x20);
+		bt->phase_seg1 = 0x20;
+	}
+
+	val = FIELD_PREP(CAN_CBT_EPRESDIV, bt->brp - 1) |
+	      FIELD_PREP(CAN_CBT_ERJW, bt->sjw - 1) |
+	      FIELD_PREP(CAN_CBT_EPSEG1, bt->phase_seg1 - 1) |
+	      FIELD_PREP(CAN_CBT_EPSEG2, bt->phase_seg2 - 1) |
+	      FIELD_PREP(CAN_CBT_EPROPSEG, bt->prop_seg - 1);
+
+	regmap_update_bits(priv->reg, CAN_CBT, CAN_CBT_CBT | CAN_CBT_BTF,
+			   val | CAN_CBT_BTF);
+
+	if (dbt->phase_seg1 > 0x8) {
+		dbt->prop_seg += (dbt->phase_seg1 - 0x8);
+		dbt->phase_seg1 = 0x8;
+	}
+
+	val = FIELD_PREP(CAN_FDCBT_FPRESDIV, dbt->brp - 1) |
+	      FIELD_PREP(CAN_FDCBT_FRJW, dbt->sjw - 1) |
+	      FIELD_PREP(CAN_FDCBT_FPSEG1, dbt->phase_seg1 - 1) |
+	      FIELD_PREP(CAN_FDCBT_FPSEG2, dbt->phase_seg2 - 1) |
+	      FIELD_PREP(CAN_FDCBT_FPROPSEG, dbt->prop_seg);
+
+	regmap_update_bits(priv->reg, CAN_FDCBT, CAN_FDCBT_CBT, val);
+
+	val = CAN_FDCTRL_TDCEN | CAN_FDCTRL_FDRATE |
+	      FIELD_PREP(CAN_FDCTRL_MBDSR3, CAN_FDCTRL_MBDSR_64) |
+	      FIELD_PREP(CAN_FDCTRL_MBDSR2, CAN_FDCTRL_MBDSR_64) |
+	      FIELD_PREP(CAN_FDCTRL_MBDSR1, CAN_FDCTRL_MBDSR_64) |
+	      FIELD_PREP(CAN_FDCTRL_MBDSR0, CAN_FDCTRL_MBDSR_64) |
+	      FIELD_PREP(CAN_FDCTRL_TDCOFF, ((dbt->phase_seg1 - 1) +
+					     dbt->prop_seg + 2) *
+					    ((dbt->brp - 1) + 1));
+	regmap_update_bits(priv->reg, CAN_FDCTRL, CAN_FDCTRL_TDCEN |
+			   CAN_FDCTRL_FDRATE | CAN_FDCTRL_TDCOFF |
+			   CAN_FDCTRL_MBDSR3 | CAN_FDCTRL_MBDSR2 |
+			   CAN_FDCTRL_MBDSR1 | CAN_FDCTRL_MBDSR0, val);
+}
+
+static void aml_can_top_init(struct aml_can_priv *priv)
+{
+	u32 val;
+
+	val = CAN_TMTIK_CFG_TS_HIGH | CAN_TMTIK_CFG_TS_LOW |
+	      FIELD_PREP(CAN_TMTIK_CFG_TICK_VALUE, 10);
+
+	regmap_update_bits(priv->reg, CAN_TMTIK_CFG,
+			   val | CAN_TMTIK_CFG_TICK_VALUE, val);
+
+	val = CAN_TOP_CTRL_GLITCH_FILTER_EN |
+	      FIELD_PREP(CAN_TOP_CTRL_GLITCH_FILTER_SEL, 2);
+
+	regmap_update_bits(priv->reg, CAN_TOP_CTRL,
+			   val | CAN_TOP_CTRL_GLITCH_FILTER_SEL, val);
+}
+
+static void aml_can_ram_init(struct aml_can_priv *priv)
+{
+	int i, j;
+
+	for (i = 0; i < AML_CAN_MB_NUM; i++)
+		for (j = 0; j < 0x10; j += 4)
+			regmap_write(priv->reg, CAN_MB + i * 0x10 + j, 0);
+
+	for (i = 0; i < AML_CAN_MB_NUM; i++)
+		regmap_write(priv->reg, CAN_RXIMR(i), 0);
+
+	for (i = 0; i < AML_CAN_MB_NUM; i++)
+		regmap_write(priv->reg, CAN_HR_TIME_STAMP(i), 0);
+
+	for (i = 0; i < AML_CAN_ERX_FIFO_NUM; i++)
+		for (j = 0; j < 20; j++)
+			regmap_write(priv->reg,
+				     CAN_ENHANCE_RX_FIFO(j) + i * 0x50, 0);
+
+	for (i = 0; i < AML_CAN_MB_NUM; i++)
+		regmap_write(priv->reg, CAN_ERFFEL(i), 0);
+
+	regmap_write(priv->reg, CAN_RXMGMASK, 0);
+	regmap_write(priv->reg, CAN_RX14MASK, 0);
+	regmap_write(priv->reg, CAN_RX15MASK, 0);
+	regmap_write(priv->reg, CAN_RXFGMASK, 0);
+
+	for (i = 0xa80; i < 0xa98; i += 4)
+		regmap_write(priv->reg, i, 0);
+	for (i = 0xab0; i < 0xae0; i += 4)
+		regmap_write(priv->reg, i, 0);
+	for (i = 0xc20; i <= 0xc24; i += 4)
+		regmap_write(priv->reg, i, 0);
+	for (i = 0xf28; i < 0x1000; i += 4)
+		regmap_write(priv->reg, i, 0);
+}
+
+static int aml_can_chip_start(struct aml_can_priv *priv)
+{
+	int ret;
+	u32 val;
+
+	ret = aml_can_module_enable(priv, true);
+	if (ret)
+		return ret;
+
+	ret = aml_can_soft_reset(priv);
+	if (ret)
+		goto err_chip_start;
+
+	ret = aml_can_freeze_mode_enable(priv, true);
+	if (ret)
+		goto err_chip_start;
+
+	val = CAN_MCR_WRNEN | CAN_MCR_WAKSRC | CAN_MCR_IRMQ |
+		CAN_MCR_SRXDIS | CAN_MCR_AEN | CAN_MCR_FDEN |
+		FIELD_PREP(CAN_MCR_IDAM, 2) | FIELD_PREP(CAN_MCR_MAXMB, 1);
+
+	regmap_update_bits(priv->reg, CAN_MCR,
+			   val | CAN_MCR_IDAM | CAN_MCR_MAXMB, val);
+
+	val = CAN_CTRL1_BOFFREC | CAN_CTRL1_LBUF | CAN_CTRL1_ERR_STATE |
+		CAN_CTRL1_ERRMSK;
+
+	regmap_update_bits(priv->reg, CAN_CTRL1, val, val);
+
+	val = CAN_CTRL2_ERRMSK_FAST | CAN_CTRL2_ECRWRE | CAN_CTRL2_WRMFRZ |
+		FIELD_PREP(CAN_CTRL2_RFFN, 11) | CAN_CTRL2_RRS;
+
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+		val |= CAN_CTRL2_ISOCANFDEN;
+
+	regmap_update_bits(priv->reg, CAN_CTRL2, val | CAN_CTRL2_RFFN, val);
+
+	aml_can_ram_init(priv);
+	aml_can_set_bittiming_ctrl(priv);
+
+	val = CAN_ERFCR_ERFEN |
+		FIELD_PREP(CAN_ERFCR_NEXIF, 2) | FIELD_PREP(CAN_ERFCR_NFE, 2) |
+		FIELD_PREP(CAN_ERFCR_ERFWM, AML_CAN_WATERMARK - 1);
+
+	regmap_update_bits(priv->reg, CAN_ERFCR, val | CAN_ERFCR_CFG, val);
+
+	val = CAN_ERFIER_ERFDAIE | CAN_ERFIER_ERFOVFIE | CAN_ERFIER_ERFWMIIE;
+
+	regmap_update_bits(priv->reg, CAN_ERFIER, val, val);
+
+	val = CAN_ERFSR_ERFUFW | CAN_ERFSR_ERFOVF | CAN_ERFSR_ERFWMI |
+		CAN_ERFSR_ERFDA	| CAN_ERFSR_ERFCLR;
+
+	regmap_update_bits(priv->reg, CAN_ERFSR, val, val);
+
+	ret = aml_can_freeze_mode_enable(priv, false);
+	if (ret)
+		goto err_chip_start;
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+
+err_chip_start:
+	aml_can_module_enable(priv, false);
+	return ret;
+}
+
+static int aml_can_chip_stop(struct aml_can_priv *priv)
+{
+	int ret;
+
+	ret = aml_can_freeze_mode_enable(priv, true);
+	if (ret)
+		return ret;
+
+	ret = aml_can_module_enable(priv, false);
+	if (ret)
+		goto err_chip_stop;
+
+	priv->can.state = CAN_STATE_STOPPED;
+
+	return 0;
+
+err_chip_stop:
+	aml_can_freeze_mode_enable(priv, false);
+
+	return ret;
+}
+
+static void aml_can_report_state(struct aml_can_priv *priv, u32 state)
+{
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	enum can_state new_state;
+	int ret;
+
+	switch (state & CAN_ESR1_FLTCONF) {
+	case CAN_ESR1_FLTCONF_ACTIVE:
+		if ((state & CAN_ESR1_TXWRN) || (state & CAN_ESR1_RXWRN))
+			new_state = CAN_STATE_ERROR_WARNING;
+		else
+			new_state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	case CAN_ESR1_FLTCONF_PASSIVE:
+		new_state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	default:			//CAN_ESR1_FLTCONF_BUSOFF
+		new_state = CAN_STATE_BUS_OFF;
+		break;
+	}
+
+	if (likely(new_state == priv->can.state))
+		return;
+
+	dev_err(priv->dev, "can state change %d\n", new_state);
+
+	skb = alloc_can_err_skb(priv->ndev, &cf);
+	if (unlikely(!skb))
+		return;
+
+	can_change_state(priv->ndev, cf, new_state, new_state);
+
+	if (unlikely(new_state == CAN_STATE_BUS_OFF))
+		can_bus_off(priv->ndev);
+
+	ret = can_rx_offload_queue_tail(&priv->offload, skb);
+	if (ret)
+		priv->ndev->stats.rx_fifo_errors++;
+}
+
+static void aml_can_report_error(struct aml_can_priv *priv, u32 state)
+{
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	bool rx_errors = false, tx_errors = false;
+	int ret;
+
+	skb = alloc_can_err_skb(priv->ndev, &cf);
+	if (unlikely(!skb))
+		return;
+
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+	if (state & CAN_ESR1_BIT1ERR) {
+		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		tx_errors = true;
+	}
+	if (state & CAN_ESR1_BIT0ERR) {
+		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		tx_errors = true;
+	}
+	if (state & CAN_ESR1_ACKERR) {
+		cf->can_id |= CAN_ERR_ACK;
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		tx_errors = true;
+	}
+	if (state & CAN_ESR1_CRCERR) {
+		cf->data[2] |= CAN_ERR_PROT_BIT;
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		rx_errors = true;
+	}
+	if (state & CAN_ESR1_FRMERR) {
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		rx_errors = true;
+	}
+	if (state & CAN_ESR1_STFERR) {
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		rx_errors = true;
+	}
+
+	priv->can.can_stats.bus_error++;
+	if (rx_errors)
+		priv->ndev->stats.rx_errors++;
+	if (tx_errors)
+		priv->ndev->stats.tx_errors++;
+
+	ret = can_rx_offload_queue_tail(&priv->offload, skb);
+	if (ret)
+		priv->ndev->stats.rx_fifo_errors++;
+
+	dev_err(priv->dev, "canbus err 0x%x\n", state);
+}
+
+static irqreturn_t aml_can_irq(int irq, void *dev_id)
+{
+	struct aml_can_priv *priv = dev_id;
+	struct net_device_stats *stats = &priv->ndev->stats;
+	u32 val;
+
+	regmap_read(priv->reg, CAN_IFLAG1, &val);
+
+	if (val & CAN_IFLAG_MB(0)) {
+		regmap_write(priv->reg, CAN_IFLAG1, CAN_IFLAG_MB(0));
+
+		val = regmap_read(priv->reg, CAN_MB, &val);
+
+		stats->tx_bytes +=
+		  can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload, 0,
+							      val << 16, NULL);
+		stats->tx_packets++;
+
+		netif_wake_queue(priv->ndev);
+	}
+
+	regmap_read(priv->reg, CAN_ERFSR, &val);
+	if (val & CAN_ERFSR_ERFDA)
+		can_rx_offload_irq_offload_fifo(&priv->offload);
+	if (val & CAN_ERFSR_ERFOVF) {
+		regmap_write(priv->reg, CAN_ERFSR, CAN_ERFSR_ERFOVF);
+
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+
+	regmap_read(priv->reg, CAN_ESR1, &val);
+
+	if (val & CAN_ESR1_STA_INT) {
+		aml_can_report_state(priv, val & CAN_ESR1_ERR_STATE);
+		regmap_write(priv->reg, CAN_ESR1, CAN_ESR1_STA_INT);
+	}
+	if (val & CAN_ESR1_ERRINT) {
+		aml_can_report_error(priv, val & CAN_ESR1_ERR_BUS);
+		regmap_write(priv->reg, CAN_ESR1, CAN_ESR1_ERRINT);
+	}
+	if (val & CAN_ESR1_ERROVR)
+		regmap_write(priv->reg, CAN_ESR1, CAN_ESR1_ERROVR);
+
+	can_rx_offload_irq_finish(&priv->offload);
+
+	return IRQ_HANDLED;
+}
+
+static struct sk_buff *aml_can_mailbox_read(struct can_rx_offload *offload,
+					    unsigned int n, u32 *timestamp,
+					    bool drop)
+{
+	struct aml_can_priv *priv = container_of(offload,
+						struct aml_can_priv, offload);
+	struct sk_buff *skb = NULL;
+	struct canfd_frame *cfd;
+	u32 i, reg_ctrl, reg_id, val;
+
+	regmap_read(priv->reg, CAN_ERFSR, &val);
+	if (!(val & CAN_ERFSR_ERFDA))
+		return NULL;
+
+	if (unlikely(drop)) {
+		regmap_write(priv->reg, CAN_ERFSR, CAN_ERFSR_ERFDA);
+		return ERR_PTR(-ENOBUFS);
+	}
+
+	regmap_read(priv->reg, CAN_ENHANCE_RX_FIFO(0), &reg_ctrl);
+	if (reg_ctrl & CAN_MB_CNT_EDL)
+		skb = alloc_canfd_skb(offload->dev, &cfd);
+	else
+		skb = alloc_can_skb(offload->dev, (struct can_frame **)&cfd);
+
+	if (unlikely(!skb))
+		return ERR_PTR(-ENOMEM);
+
+	*timestamp = reg_ctrl << 16;
+
+	regmap_read(priv->reg, CAN_ENHANCE_RX_FIFO(1), &reg_id);
+	if (reg_ctrl & CAN_MB_CNT_IDE)
+		cfd->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		cfd->can_id = (reg_id >> 18) & CAN_SFF_MASK;
+
+	if (reg_ctrl & CAN_MB_CNT_EDL) {
+		cfd->len = can_fd_dlc2len((reg_ctrl >> 16) & 0xf);
+
+		if (reg_ctrl & CAN_MB_CNT_BRS)
+			cfd->flags |= CANFD_BRS;
+	} else {
+		cfd->len = can_cc_dlc2len((reg_ctrl >> 16) & 0xf);
+
+		if (reg_ctrl & CAN_MB_CNT_RTR)
+			cfd->can_id |= CAN_RTR_FLAG;
+	}
+
+	if (reg_ctrl & CAN_MB_CNT_ESI)
+		cfd->flags |= CANFD_ESI;
+
+	for (i = 0; i < cfd->len; i += sizeof(u32)) {
+		regmap_read(priv->reg, CAN_ENHANCE_RX_FIFO(2) + i, &val);
+		__be32 data = cpu_to_be32(val);
+		*(__be32 *)(cfd->data + i) = data;
+	}
+
+	regmap_write(priv->reg, CAN_ERFSR, CAN_ERFSR_ERFDA);
+
+	return skb;
+}
+
+static int aml_can_open(struct net_device *dev)
+{
+	struct aml_can_priv *priv = netdev_priv(dev);
+	int ret;
+
+	ret = open_candev(dev);
+	if (ret)
+		return ret;
+
+	priv->offload.mailbox_read = aml_can_mailbox_read;
+
+	ret = can_rx_offload_add_fifo(dev, &priv->offload,
+				      AML_CAN_NAPI_WEIGHT);
+	if (ret)
+		goto err_open_offload;
+
+	aml_can_top_init(priv);
+
+	ret = aml_can_chip_start(priv);
+	if (ret)
+		goto err_open_start;
+
+	can_rx_offload_enable(&priv->offload);
+
+	aml_can_interrupts_enable(priv, 1);
+
+	netif_start_queue(dev);
+
+	return 0;
+
+err_open_start:
+	can_rx_offload_del(&priv->offload);
+err_open_offload:
+	close_candev(dev);
+	return ret;
+}
+
+static int aml_can_close(struct net_device *dev)
+{
+	struct aml_can_priv *priv = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+	aml_can_interrupts_enable(priv, 0);
+
+	can_rx_offload_disable(&priv->offload);
+
+	aml_can_chip_stop(priv);
+
+	can_rx_offload_del(&priv->offload);
+	close_candev(dev);
+
+	return 0;
+}
+
+static netdev_tx_t aml_can_start_xmit(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	const struct aml_can_priv *priv = netdev_priv(dev);
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	u32 can_id;
+	u32 data;
+	u32 ctrl = CAN_MB_CODE_TX_DATA | ((can_fd_len2dlc(cfd->len)) << 16);
+	int i;
+
+	if (can_dev_dropped_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	netif_stop_queue(dev);
+
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		can_id = cfd->can_id & CAN_EFF_MASK;
+		ctrl |= CAN_MB_CNT_IDE | CAN_MB_CNT_SRR;
+	} else {
+		can_id = (cfd->can_id & CAN_SFF_MASK) << 18;
+	}
+
+	if (cfd->can_id & CAN_RTR_FLAG)
+		ctrl |= CAN_MB_CNT_RTR;
+
+	if (can_is_canfd_skb(skb)) {
+		ctrl |= CAN_MB_CNT_EDL;
+
+		if (cfd->flags & CANFD_BRS)
+			ctrl |= CAN_MB_CNT_BRS;
+	}
+
+	for (i = 0; i < cfd->len; i += sizeof(u32)) {
+		data = be32_to_cpup((__be32 *)&cfd->data[i]);
+		regmap_write(priv->reg, CAN_MB + 0x8 + i, data);
+	}
+
+	can_put_echo_skb(skb, dev, 0, 0);
+
+	regmap_write(priv->reg, CAN_MB + 0x4, can_id);
+	regmap_write(priv->reg, CAN_MB,       ctrl);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops aml_can_netdev_ops = {
+	.ndo_open	= aml_can_open,
+	.ndo_stop	= aml_can_close,
+	.ndo_start_xmit	= aml_can_start_xmit,
+};
+
+static int aml_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	struct aml_can_priv *priv = netdev_priv(dev);
+	int ret;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		ret = aml_can_chip_start(priv);
+		if (ret)
+			return ret;
+
+		aml_can_interrupts_enable(priv, true);
+
+		netif_wake_queue(dev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int aml_can_get_berr_counter(const struct net_device *dev,
+				    struct can_berr_counter *bec)
+{
+	const struct aml_can_priv *priv = netdev_priv(dev);
+	u32 val;
+
+	regmap_read(priv->reg, CAN_ECR, &val);
+
+	bec->txerr = FIELD_GET(CAN_MCR_TXERRCNT, val);
+	bec->rxerr = FIELD_GET(CAN_MCR_RXERRCNT, val);
+
+	return 0;
+}
+
+static int aml_can_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *net;
+	void __iomem *res_start;
+	struct resource *res_mem;
+	struct aml_can_priv *priv;
+	struct clk *clk_pe, *clk_filter;
+	struct regmap *reg;
+	int irq, ret;
+
+	res_start = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mem);
+	if (IS_ERR(res_start))
+		return PTR_ERR(res_start);
+
+	reg = devm_regmap_init_mmio(dev, res_start, &aml_can_regmap_config);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	clk_pe = devm_clk_get(dev, "can_pe");
+	if (IS_ERR(clk_pe))
+		return dev_err_probe(dev, PTR_ERR(clk_pe),
+				     "Failed to get can_pe clock\n");
+
+	clk_filter = devm_clk_get(dev, "can_filter");
+	if (IS_ERR(clk_filter))
+		return dev_err_probe(dev, PTR_ERR(clk_filter),
+				     "Failed to get can_filter clock\n");
+
+	ret = clk_set_rate(clk_pe, AML_CAN_PE_CLK_RATE);
+	if (ret)
+		dev_err(dev, "Failed to set can_pe rate: %d\n", ret);
+
+	ret = clk_set_rate(clk_filter, AML_CAN_PE_CLK_RATE);
+	if (ret)
+		dev_err(dev, "Failed to set can_filter rate: %d\n", ret);
+
+	ret = clk_prepare_enable(clk_pe);
+	if (ret)
+		return dev_err_probe(dev, PTR_ERR(clk_pe),
+				     "Failed to enable can_pe clock\n");
+
+	ret = clk_prepare_enable(clk_filter);
+	if (ret)
+		return dev_err_probe(dev, PTR_ERR(clk_filter),
+				     "Failed to enable can_filter clock\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq\n");
+
+	net = alloc_candev(sizeof(struct aml_can_priv), 1);
+	if (!net)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(net, dev);
+	platform_set_drvdata(pdev, net);
+
+	net->irq = irq;
+	net->flags |= IFF_ECHO;
+	net->netdev_ops = &aml_can_netdev_ops;
+
+	priv = netdev_priv(net);
+	priv->dev = dev;
+	priv->reg = reg;
+	priv->ndev = net;
+	priv->clk_pe = clk_pe;
+	priv->clk_filter = clk_filter;
+	priv->can.clock.freq = clk_get_rate(priv->clk_pe);
+	priv->can.do_set_mode = aml_can_set_mode;
+	priv->can.do_get_berr_counter = aml_can_get_berr_counter;
+	priv->can.ctrlmode_supported =  CAN_CTRLMODE_FD |
+					CAN_CTRLMODE_BERR_REPORTING |
+					CAN_CTRLMODE_FD_NON_ISO;
+	priv->can.bittiming_const = &aml_can_fd_bittiming_const;
+	priv->can.fd.data_bittiming_const = &aml_can_fd_data_bittiming_const;
+
+	ret = register_candev(net);
+	if (ret) {
+		dev_err(dev, "Failed to register candev %d\n", ret);
+		goto err_register_candev;
+	}
+
+	ret = devm_request_irq(dev, irq, aml_can_irq, 0, "amlogic_can", priv);
+	if (ret) {
+		dev_err(dev, "failed to request irq %d\n", ret);
+		goto err_request_irq;
+	}
+
+	dev_info(dev, "amlogic can initialized (clk %d)\n",
+		 priv->can.clock.freq);
+
+	return 0;
+
+err_request_irq:
+	unregister_candev(net);
+err_register_candev:
+	free_candev(net);
+
+	return ret;
+}
+
+static void aml_can_remove(struct platform_device *pdev)
+{
+	struct net_device *net = platform_get_drvdata(pdev);
+	struct aml_can_priv *priv = netdev_priv(net);
+
+	disable_irq(net->irq);
+	unregister_candev(net);
+	clk_disable_unprepare(priv->clk_filter);
+	clk_disable_unprepare(priv->clk_pe);
+	free_candev(net);
+}
+
+static int aml_can_suspend(struct device *device)
+{
+	struct net_device *net = dev_get_drvdata(device);
+	struct aml_can_priv *priv = netdev_priv(net);
+	int ret;
+
+	if (!netif_running(net))
+		return 0;
+
+	ret = aml_can_chip_stop(priv);
+	if (ret)
+		return ret;
+
+	aml_can_interrupts_enable(priv, 0);
+
+	pinctrl_pm_select_sleep_state(device);
+
+	netif_stop_queue(net);
+	netif_device_detach(net);
+
+	priv->can.state = CAN_STATE_SLEEPING;
+
+	return 0;
+}
+
+static int aml_can_resume(struct device *device)
+{
+	struct net_device *net = dev_get_drvdata(device);
+	struct aml_can_priv *priv = netdev_priv(net);
+	int ret;
+
+	if (!netif_running(net))
+		return 0;
+
+	netif_device_attach(net);
+	netif_start_queue(net);
+
+	pinctrl_pm_select_default_state(device);
+
+	ret = aml_can_chip_start(priv);
+	if (ret)
+		return ret;
+
+	aml_can_interrupts_enable(priv, 1);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+}
+
+static const struct of_device_id aml_can_of_match[] = {
+	{ .compatible = "amlogic,a9-can", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, aml_can_of_match);
+
+static const struct dev_pm_ops aml_can_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(aml_can_suspend, aml_can_resume)
+};
+
+static struct platform_driver aml_can_driver = {
+	.driver = {
+		.name = "amlogic_can",
+		.pm = &aml_can_pm_ops,
+		.of_match_table = aml_can_of_match,
+	},
+	.probe = aml_can_probe,
+	.remove = aml_can_remove,
+};
+
+module_platform_driver(aml_can_driver);
+
+MODULE_AUTHOR("Zelong Dong <zelong.dong@amlogic.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN port driver for Amlogic CAN Controller");
diff --git a/drivers/net/can/amlogic/amlogic_can.h b/drivers/net/can/amlogic/amlogic_can.h
new file mode 100644
index 000000000000..15c86f3c001e
--- /dev/null
+++ b/drivers/net/can/amlogic/amlogic_can.h
@@ -0,0 +1,367 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2026 Amlogic, Inc. All rights reserved
+ */
+
+#ifndef _AMLOGIC_CAN_H
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/can/dev.h>
+#include <linux/clk.h>
+#include <linux/can/rx-offload.h>
+#include <linux/netdevice.h>
+#include <linux/regmap.h>
+
+#define CAN_MCR					0x00
+#define CAN_CTRL1				0x04
+#define CAN_TIMER				0x08
+						/* 0x0C */
+#define CAN_RXMGMASK				0x10
+#define CAN_RX14MASK				0x14
+#define CAN_RX15MASK				0x18
+#define CAN_ECR					0x1C
+#define CAN_ESR1				0x20
+#define CAN_IMASK2				0x24
+#define CAN_IMASK1				0x28
+#define CAN_IFLAG2				0x2C
+#define CAN_IFLAG1				0x30
+#define CAN_CTRL2				0x34
+#define CAN_ESR2				0x38
+						/* 0x3C - 0x40 */
+#define CAN_CRCR				0x44
+#define CAN_RXFGMASK				0x48
+#define CAN_RXFIR				0x4C
+#define CAN_CBT					0x50
+						/* 0x54 - 0x64 */
+#define CAN_IMASK4				0x68
+#define CAN_IMASK3				0x6C
+#define CAN_IFLAG4				0x70
+#define CAN_IFLAG3				0x74
+						/* 0x78 - 0x7C */
+#define CAN_MB					0x80			/* 0x80 - 0x87c */
+#define CAN_RXIMR(n)				(0x880 + 0x4 * (n))	/* 0x880 - 0xA7C */
+						/* 0xA80 - 0xADC */
+#define CAN_MECR				0xAE0
+#define CAN_ERRIAR				0xAE4
+#define CAN_ERRIDPR				0xAE8
+#define CAN_ERRIPPR				0xAEC
+#define CAN_RERRAR				0xAF0
+#define CAN_RERRDR				0xAF4
+#define CAN_RERRSYNR				0xAF8
+#define CAN_ERRSR				0xAFC
+#define CAN_CTRL1_PN				0xB00
+#define CAN_CTRL2_PN				0xB04
+#define CAN_WU_MTC				0xB08
+#define CAN_FLT_ID1				0xB0C
+#define CAN_FLT_DLC				0xB10
+#define CAN_PL1_LO				0xB14
+#define CAN_PL1_HI				0xB18
+#define CAN_FLT_ID2_IDMASK			0xB1C
+#define CAN_PL2_PLMASK_LO			0xB20
+#define CAN_PL2_PLMASK_HI			0xB24
+						/* 0xB28 - 0xB3C */
+/*	CAN_WMB_CS				0xB40 - 0xB7C */
+#define CAN_WMB_CS(n)				(0xB40 + 0x10 * (n))
+#define CAN_WMB_ID(n)				(0xB44 + 0x10 * (n))
+#define CAN_WMB_D03(n)				(0xB48 + 0x10 * (n))
+#define CAN_WMB_D47(n)				(0xB4C + 0x10 * (n))
+						/* 0xB80 - 0xBEC */
+#define CAN_EPRS				0xBF0
+#define CAN_ENCBT				0xBF4
+#define CAN_EDCBT				0xBF8
+#define CAN_ETDC				0xBFC
+#define CAN_FDCTRL				0xC00
+#define CAN_FDCBT				0xC04
+#define CAN_FDCRC				0xC08
+#define CAN_ERFCR				0xC0C
+#define CAN_ERFIER				0xC10
+#define CAN_ERFSR				0xC14
+						/* 0xC18 - 0xC2C */
+#define CAN_HR_TIME_STAMP(n)			(0xC30 + 0x4 * (n))	/* 0xC30 - 0xE2C */
+						/* 0xE30 - 0xFFC */
+#define CAN_ENHANCE_MB				0x1000			/* 0x1000 - 0x17FC */
+						/* 0x1800 - 0x1FFC */
+#define CAN_ENHANCE_RX_FIFO(n)			(0x2000	+ 0x4 * (n))	/* 0x2000 - 0x204C */
+						/* 0x2050 - 0x2FFC */
+#define CAN_ERFFEL(n)				(0x3000 + 0x4 * (n))	/* 0x3000 - 0x31FC */
+						/* 0x3200 - 0x37FC */
+#define CAN_VERSION				0x3800
+#define CAN_TOP_CTRL				0x3804
+#define CAN_DMA_CFG				0x3808
+#define CAN_TMTIK_CFG				0x380C
+#define CAN_TWRAP_INT_CLR			0x3810
+						/* 0x3814 - 0x3818 */
+#define CAN_TIMESTAMP				0x381C
+#define CAN_WARN_INT_STS			0x3820
+#define CAN_MB_INT_STS0				0x3824
+#define CAN_MB_INT_STS1				0x3828
+#define CAN_MB_INT_STS2				0x382C
+#define CAN_MB_INT_STS3				0x3830
+#define CAN_STS_REG				0x3834
+#define CAN_ECC_ERR_ADDR			0x3838
+
+/* CAN_MCR */
+#define CAN_MCR_MDIS			BIT(31)
+#define CAN_MCR_FRZ			BIT(30)
+#define CAN_MCR_RFEN			BIT(29)
+#define CAN_MCR_HALT			BIT(28)
+#define CAN_MCR_NOTRDY			BIT(27)
+#define CAN_MCR_WAKMSK			BIT(26)
+#define CAN_MCR_SOFTRST			BIT(25)
+#define CAN_MCR_FRZACK			BIT(24)
+#define CAN_MCR_SLFWAK			BIT(22)
+#define CAN_MCR_WRNEN			BIT(21)
+#define CAN_MCR_LPMACK			BIT(20)
+#define CAN_MCR_WAKSRC			BIT(19)
+#define CAN_MCR_DOZE			BIT(18)
+#define CAN_MCR_SRXDIS			BIT(17)
+#define CAN_MCR_IRMQ			BIT(16)
+#define CAN_MCR_DMA			BIT(15)
+#define CAN_MCR_PNET_EN			BIT(14)
+#define CAN_MCR_LPRIOEN			BIT(13)
+#define CAN_MCR_AEN			BIT(12)
+#define CAN_MCR_FDEN			BIT(11)
+#define CAN_MCR_IDAM			GENMASK(9, 8)
+#define CAN_MCR_MAXMB			GENMASK(6, 0)
+
+/* CAN_CTRL1 */
+#define CAN_CTRL1_PRESDIV		GENMASK(31, 24)
+#define CAN_CTRL1_RJW			GENMASK(23, 22)
+#define CAN_CTRL1_PSEG1			GENMASK(21, 19)
+#define CAN_CTRL1_PSEG2			GENMASK(18, 16)
+#define CAN_CTRL1_BOFFMSK		BIT(15)
+#define CAN_CTRL1_ERRMSK		BIT(14)
+#define CAN_CTRL1_CLKSRC		BIT(13)
+#define CAN_CTRL1_LPB			BIT(12)
+#define CAN_CTRL1_TWRNMSK		BIT(11)
+#define CAN_CTRL1_RWRNMSK		BIT(10)
+#define CAN_CTRL1_SMP			BIT(7)
+#define CAN_CTRL1_BOFFREC		BIT(6)
+#define CAN_CTRL1_TSYN			BIT(5)
+#define CAN_CTRL1_LBUF			BIT(4)
+#define CAN_CTRL1_LOM			BIT(3)
+#define CAN_CTRL1_PROPSEG		GENMASK(2, 0)
+#define CAN_CTRL1_ERR_BUS		(CAN_CTRL1_ERRMSK)
+#define CAN_CTRL1_ERR_STATE		(CAN_CTRL1_TWRNMSK | \
+					CAN_CTRL1_RWRNMSK | \
+					CAN_CTRL1_BOFFMSK)
+#define CAN_CTRL1_ERR_ALL		(CAN_CTRL1_ERR_BUS | CAN_CTRL1_ERR_STATE)
+#define CAN_CTRL1_CBT			(CAN_CTRL1_PRESDIV | CAN_CTRL1_RJW | \
+					 CAN_CTRL1_PSEG1 | CAN_CTRL1_PSEG2 | \
+					 CAN_CTRL1_PROPSEG)
+
+/* CAN_CTRL2 */
+#define CAN_CTRL2_ERRMSK_FAST		BIT(31)
+#define CAN_CTRL2_BOFFDONEMSK		BIT(30)
+#define CAN_CTRL2_ECRWRE		BIT(29)
+#define CAN_CTRL2_WRMFRZ		BIT(28)
+#define CAN_CTRL2_RFFN			GENMASK(27, 24)
+#define CAN_CTRL2_TASD			GENMASK(23, 19)
+#define CAN_CTRL2_MRP			BIT(18)
+#define CAN_CTRL2_RRS			BIT(17)
+#define CAN_CTRL2_EACEN			BIT(16)
+#define CAN_CTRL2_TIMER_SRC		BIT(15)
+#define CAN_CTRL2_PREXCEN		BIT(14)
+#define CAN_CTRL2_BTE			BIT(13)
+#define CAN_CTRL2_ISOCANFDEN		BIT(12)
+#define CAN_CTRL2_EDFLTDIS		BIT(11)
+#define CAN_CTRL2_MBTSBASE		GENMASK(9, 8)
+#define CAN_CTRL2_TSTAMPCAP		GENMASK(7, 6)
+
+/* CAN_MECR */
+#define CAN_MCR_RXERRCNT		GENMASK(15, 8)
+#define CAN_MCR_TXERRCNT		GENMASK(7, 0)
+
+/* CAN_MECR */
+#define CAN_MECR_ECRWRDIS		BIT(31)
+#define CAN_MECR_HANCEI_MSK		BIT(19)
+#define CAN_MECR_FANCEI_MSK		BIT(18)
+#define CAN_MECR_CEI_MSK		BIT(16)
+#define CAN_MECR_HAERRIE		BIT(15)
+#define CAN_MECR_FAERRIE		BIT(14)
+#define CAN_MECR_EXTERRIE		BIT(13)
+#define CAN_MECR_RERRDIS		BIT(9)
+#define CAN_MECR_ECCDIS			BIT(8)
+#define CAN_MECR_NCEFAFRZ		BIT(7)
+
+/* CAN_ESR1 */
+#define CAN_ESR1_BIT1ERR_FAST		BIT(31)
+#define CAN_ESR1_BIT0ERR_FAST		BIT(30)
+#define CAN_ESR1_CRCERR_FAST		BIT(28)
+#define CAN_ESR1_FRMERR_FAST		BIT(27)
+#define CAN_ESR1_STFERR_FAST		BIT(26)
+#define CAN_ESR1_ERROVR			BIT(21)
+#define CAN_ESR1_ERRINT_FAST		BIT(20)
+#define CAN_ESR1_BOFFDONEINT		BIT(19)
+#define CAN_ESR1_SYNCH			BIT(18)
+#define CAN_ESR1_TWRNINT		BIT(17)
+#define CAN_ESR1_RWRNINT		BIT(16)
+#define CAN_ESR1_BIT1ERR		BIT(15)
+#define CAN_ESR1_BIT0ERR		BIT(14)
+#define CAN_ESR1_ACKERR			BIT(13)
+#define CAN_ESR1_CRCERR			BIT(12)
+#define CAN_ESR1_FRMERR			BIT(11)
+#define CAN_ESR1_STFERR			BIT(10)
+#define CAN_ESR1_TXWRN			BIT(9)
+#define CAN_ESR1_RXWRN			BIT(8)
+#define CAN_ESR1_IDLE			BIT(7)
+#define CAN_ESR1_TX			BIT(6)
+#define CAN_ESR1_FLTCONF		GENMASK(5, 4)
+#define CAN_ESR1_RX			BIT(3)
+#define CAN_ESR1_BOFFINT		BIT(2)
+#define CAN_ESR1_ERRINT			BIT(1)
+#define CAN_ESR1_WAKINT			BIT(0)
+
+#define CAN_ESR1_FLTCONF_ACTIVE		0x0
+#define CAN_ESR1_FLTCONF_PASSIVE	0x1
+//#define CAN_ESR1_FLTCONF_BUSOFF
+
+#define CAN_ESR1_ERR_BUS \
+	(CAN_ESR1_BIT1ERR | CAN_ESR1_BIT0ERR | \
+	 CAN_ESR1_ACKERR | CAN_ESR1_CRCERR | \
+	 CAN_ESR1_FRMERR | CAN_ESR1_STFERR)
+#define CAN_ESR1_STA_INT \
+	(CAN_ESR1_TWRNINT | CAN_ESR1_RWRNINT | CAN_ESR1_BOFFINT)
+#define CAN_ESR1_ERR_STATE \
+	(CAN_ESR1_TXWRN | CAN_ESR1_RXWRN | CAN_ESR1_FLTCONF)
+
+/* CAN_ESR2 */
+#define CAN_ESR2_TWAINT			BIT(31)
+#define CAN_ESR2_LPTM			GENMASK(22, 16)
+#define CAN_ESR2_TWAMSK			BIT(15)
+#define CAN_ESR2_VPS			BIT(14)
+#define CAN_ESR2_IMB			BIT(13)
+
+/* CAN_CBT */
+#define CAN_CBT_BTF			BIT(31)
+#define CAN_CBT_EPRESDIV		GENMASK(30, 21)
+#define CAN_CBT_ERJW			GENMASK(20, 16)
+#define CAN_CBT_EPROPSEG		GENMASK(15, 10)
+#define CAN_CBT_EPSEG1			GENMASK(9, 5)
+#define CAN_CBT_EPSEG2			GENMASK(4, 0)
+#define CAN_CBT_CBT			(CAN_CBT_EPRESDIV | CAN_CBT_ERJW | \
+					 CAN_CBT_EPSEG1 | CAN_CBT_EPSEG2 | \
+					 CAN_CBT_EPROPSEG)
+
+/* CAN_FDCTRL */
+#define CAN_FDCTRL_FDRATE		BIT(31)
+#define CAN_FDCTRL_MBDSR3		GENMASK(26, 25)
+#define CAN_FDCTRL_MBDSR2		GENMASK(23, 22)
+#define CAN_FDCTRL_MBDSR1		GENMASK(20, 19)
+#define CAN_FDCTRL_MBDSR0		GENMASK(17, 16)
+#define CAN_FDCTRL_MBDSR_8		0x0
+#define CAN_FDCTRL_MBDSR_16		0x1
+#define CAN_FDCTRL_MBDSR_32		0x2
+#define CAN_FDCTRL_MBDSR_64		0x3
+#define CAN_FDCTRL_TDCEN		BIT(15)
+#define CAN_FDCTRL_TDCFAIL		BIT(14)
+#define CAN_FDCTRL_TDCOFF		GENMASK(12, 8)
+#define CAN_FDCTRL_TDCVAL		GENMASK(5, 0)
+
+/* CAN_FDCBT */
+#define CAN_FDCBT_FPRESDIV		GENMASK(29, 20)
+#define CAN_FDCBT_FRJW			GENMASK(18, 16)
+#define CAN_FDCBT_FPROPSEG		GENMASK(14, 10)
+#define CAN_FDCBT_FPSEG1		GENMASK(7, 5)
+#define CAN_FDCBT_FPSEG2		GENMASK(2, 0)
+#define CAN_FDCBT_CBT			(CAN_FDCBT_FPRESDIV | CAN_FDCBT_FRJW | \
+					 CAN_FDCBT_FPSEG1 | CAN_FDCBT_FPSEG2 | \
+					 CAN_FDCBT_FPROPSEG)
+
+#define CAN_ERFCR_ERFEN			BIT(31)
+#define CAN_ERFCR_DMALW			GENMASK(30, 26)
+#define CAN_ERFCR_NEXIF			GENMASK(22, 16)
+#define CAN_ERFCR_NFE			GENMASK(13, 8)
+#define CAN_ERFCR_ERFWM			GENMASK(4, 0)
+#define CAN_ERFCR_CFG			(CAN_ERFCR_NEXIF | \
+					 CAN_ERFCR_NFE | CAN_ERFCR_ERFWM)
+
+#define CAN_ERFIER_ERFUFWIE		BIT(31)
+#define CAN_ERFIER_ERFOVFIE		BIT(30)
+#define CAN_ERFIER_ERFWMIIE		BIT(29)
+#define CAN_ERFIER_ERFDAIE		BIT(28)
+
+#define CAN_ERFSR_ERFUFW		BIT(31)
+#define CAN_ERFSR_ERFOVF		BIT(30)
+#define CAN_ERFSR_ERFWMI		BIT(29)
+#define CAN_ERFSR_ERFDA			BIT(28)
+#define CAN_ERFSR_ERFCLR		BIT(27)
+#define CAN_ERFSR_ERFE			BIT(17)
+#define CAN_ERFSR_ERFF			BIT(16)
+#define CAN_ERFSR_ERFEL			GENMASK(5, 0)
+
+/* CAN_IFLAG1 */
+#define CAN_IFLAG_MB(x)			BIT(x)
+#define CAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
+#define CAN_IFLAG_RX_FIFO_WARN		BIT(6)
+#define CAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
+
+/* CAN message buffers */
+#define CAN_MB_CODE			GENMASK(27, 24)
+#define CAN_MB_CODE_RX_BUSY_BIT		FIELD_PREP(CAN_MB_CODE, 0x1)
+#define CAN_MB_CODE_RX_INACTIVE		FIELD_PREP(CAN_MB_CODE, 0x0)
+#define CAN_MB_CODE_RX_EMPTY		FIELD_PREP(CAN_MB_CODE, 0x4)
+#define CAN_MB_CODE_RX_FULL		FIELD_PREP(CAN_MB_CODE, 0x2)
+#define CAN_MB_CODE_RX_OVERRUN		FIELD_PREP(CAN_MB_CODE, 0x6)
+#define CAN_MB_CODE_RX_RANSWER		FIELD_PREP(CAN_MB_CODE, 0xa)
+#define CAN_MB_CODE_TX_INACTIVE		FIELD_PREP(CAN_MB_CODE, 0x8)
+#define CAN_MB_CODE_TX_ABORT		FIELD_PREP(CAN_MB_CODE, 0x9)
+#define CAN_MB_CODE_TX_DATA		FIELD_PREP(CAN_MB_CODE, 0xc)
+#define CAN_MB_CODE_TX_TANSWER		FIELD_PREP(CAN_MB_CODE, 0xe)
+
+#define CAN_MB_CNT_EDL			BIT(31)
+#define CAN_MB_CNT_BRS			BIT(30)
+#define CAN_MB_CNT_ESI			BIT(29)
+#define CAN_MB_CNT_SRR			BIT(22)
+#define CAN_MB_CNT_IDE			BIT(21)
+#define CAN_MB_CNT_RTR			BIT(20)
+#define CAN_MB_CNT_LENGTH		GENMASK(19, 16)
+#define CAN_MB_CNT_TIMESTAMP		GENMASK(15, 0)
+
+#define CAN_TOP_CTRL_GLITCH_FILTER_SEL	GENMASK(19, 17)
+#define CAN_TOP_CTRL_GLITCH_FILTER_EN	BIT(16)
+
+#define CAN_DMA_CFG_SINGLE_MBOX_LEN	GENMASK(29, 24)
+#define CAN_DMA_CFG_ERF_WM		GENMASK(20, 16)
+#define CAN_DMA_CFG_ERF_LW		GENMASK(12, 8)
+#define CAN_DMA_CFG_ERF_EN		BIT(0)
+
+#define CAN_TMTIK_CFG_TS_HIGH		BIT(18)
+#define CAN_TMTIK_CFG_TS_LOW		BIT(17)
+#define CAN_TMTIK_CFG_TICK_VALUE	GENMASK(16, 0)
+
+#define AML_CAN_TIMEOUT_US		250
+#define AML_CAN_MB_NUM		128
+#define AML_CAN_ERX_FIFO_NUM		32
+
+#define AML_CAN_PE_CLK_RATE		80000000
+#define AML_CAN_WATERMARK		4
+#define AML_CAN_DMALW			19
+#define AML_CAN_DMALW2SIZE		(AML_CAN_DMALW * 0x4)
+#define AML_CAN_DMA_BUF_LEN		(AML_CAN_WATERMARK * AML_CAN_DMALW2SIZE)
+
+#define AML_CAN_NAPI_WEIGHT		(8 + 2)
+
+struct aml_can_dma {
+	struct dma_chan *rx_chan;
+	dma_addr_t dma_buf;
+	u32 *buf;
+	unsigned int dma_len;
+};
+
+struct aml_can_priv {
+	struct can_priv can;
+	struct can_rx_offload offload;
+	struct device *dev;
+	struct net_device *ndev;
+
+	struct regmap *reg;
+	struct aml_can_dma can_dma;
+
+	struct clk *clk_pe;
+	struct clk *clk_filter;
+};
+
+#endif
-- 
2.47.1

