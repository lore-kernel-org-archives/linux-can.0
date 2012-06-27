From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 16:19:19 +0800
Message-ID: <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:36767 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2F0ITp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:19:45 -0400
In-Reply-To: <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

At least in the i.MX series, the flexcan contrller divides into ver_3
and ver_10, current driver is for ver_3 controller.

i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
Its reset value is 0xffffffff, this means ID Filter Table must be
checked when receive a packet, but the driver is designed to accept
everything during the chip start, we need to clear this register to
follow this design.

Add a hw_ver entry in the device tree, this can let us distinguish
which version the controller is, if we don't set value to this entry,
the hw_ver is 3 by default, this is backward compatible for existing
platforms like powerpc and imx35.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    3 +++
 drivers/net/can/flexcan.c                          |   20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index f31b686..19952cd 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -12,6 +12,8 @@ Required properties:
 - reg : Offset and length of the register set for this device
 - interrupts : Interrupt tuple for this device
 - clock-frequency : The oscillator frequency driving the flexcan device
+- hw-version : The controller version, for imx25, imx35 and imx53, the version
+               is 3, for imx6, the version is 10
 
 Example:
 
@@ -21,4 +23,5 @@ Example:
 		interrupts = <48 0x2>;
 		interrupt-parent = <&mpic>;
 		clock-frequency = <200000000>; // filled in by bootloader
+		hw-version = <10>;
 	};
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 81d4741..9d024a4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -165,7 +165,13 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 _reserved2[19];
+	u32 crl2;		/* 0x34 */
+	u32 esr2;		/* 0x38 */
+	u32 _reserved2[2];
+	u32 crcr;		/* 0x44 */
+	u32 rxfgmask;		/* 0x48 */
+	u32 rxfir;		/* 0x4c */
+	u32 _reserved3[12];
 	struct flexcan_mb cantxfg[64];
 };
 
@@ -177,6 +183,7 @@ struct flexcan_priv {
 	void __iomem *base;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
+	u32 hw_ver;
 
 	struct clk *clk;
 	struct flexcan_platform_data *pdata;
@@ -750,6 +757,9 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(0x0, &regs->rx14mask);
 	flexcan_write(0x0, &regs->rx15mask);
 
+	if (priv->hw_ver >= 10)
+		flexcan_write(0x0, &regs->rxfgmask);
+
 	flexcan_transceiver_switch(priv, 1);
 
 	/* synchronize with the can bus */
@@ -933,6 +943,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	resource_size_t mem_size;
 	int err, irq;
 	u32 clock_freq = 0;
+	u32 hw_ver = 3;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
@@ -940,11 +951,17 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		const __be32 *clock_freq_p;
+		const __be32 *hw_ver_p;
 
 		clock_freq_p = of_get_property(pdev->dev.of_node,
 						"clock-frequency", NULL);
 		if (clock_freq_p)
 			clock_freq = be32_to_cpup(clock_freq_p);
+
+		hw_ver_p = of_get_property(pdev->dev.of_node,
+						"hw-version", NULL);
+		if (hw_ver_p)
+			hw_ver = be32_to_cpup(hw_ver_p);
 	}
 
 	if (!clock_freq) {
@@ -997,6 +1014,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	priv->base = base;
 	priv->dev = dev;
 	priv->clk = clk;
+	priv->hw_ver = hw_ver;
 	priv->pdata = pdev->dev.platform_data;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
-- 
1.7.6

