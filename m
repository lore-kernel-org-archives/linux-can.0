From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4 1/1] can: flexcan: add self wakeup support
Date: Wed, 21 Nov 2018 12:32:08 +0000
Message-ID: <20181121122957.2684-2-qiangqing.zhang@nxp.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

If wakeup is enabled, enter stop mode, else enter disabled mode. Self wake
can only work on stop mode.

Starting from IMX6, the flexcan stop mode control bits is SoC specific,
move it out of IP driver and parse it from devicetree.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 154 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 8e972ef08637..83431810316e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -19,11 +19,14 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
=20
 #define DRV_NAME			"flexcan"
=20
@@ -131,7 +134,8 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
+	FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
+	FLEXCAN_ESR_WAK_INT)
=20
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -190,6 +194,7 @@
 #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offl=
oading */
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error p=
assive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register =
access */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to suppor=
t wakeup */
=20
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -254,6 +259,14 @@ struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
 };
=20
+struct flexcan_stop_mode {
+	struct regmap *gpr;
+	u8 req_gpr;
+	u8 req_bit;
+	u8 ack_gpr;
+	u8 ack_bit;
+};
+
 struct flexcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -270,6 +283,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	struct flexcan_stop_mode stm;
=20
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
@@ -293,7 +307,8 @@ static const struct flexcan_devtype_data fsl_imx28_devt=
ype_data =3D {
=20
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
@@ -353,6 +368,35 @@ static inline void flexcan_write_le(u32 val, void __io=
mem *addr)
 	iowrite32(val, addr);
 }
=20
+static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enab=
le)
+{
+	struct flexcan_regs __iomem *regs =3D priv->regs;
+	u32 reg_mcr;
+
+	reg_mcr =3D priv->read(&regs->mcr);
+
+	if (enable)
+		reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
+	else
+		reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
+
+	priv->write(reg_mcr, &regs->mcr);
+}
+
+static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
+{
+	/* enable stop request */
+	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+}
+
+static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
+{
+	/* remove stop request */
+	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			   1 << priv->stm.req_bit, 0);
+}
+
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *pri=
v)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
@@ -940,6 +984,10 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mcr |=3D FLEXCAN_MCR_FEN |
 			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	}
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE)
+		reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
+
 	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
=20
@@ -1244,6 +1292,58 @@ static void unregister_flexcandev(struct net_device =
*dev)
 	unregister_candev(dev);
 }
=20
+static int flexcan_setup_stop_mode(struct platform_device *pdev)
+{
+	struct net_device *dev =3D platform_get_drvdata(pdev);
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *gpr_np;
+	struct flexcan_priv *priv;
+	phandle phandle;
+	u32 out_val[5];
+	int ret;
+
+	if (!np)
+		return -EINVAL;
+
+	/* stop mode property format is:
+	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
+	 */
+	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);
+	if (ret) {
+		dev_dbg(&pdev->dev, "no stop-mode property\n");
+		return ret;
+	}
+	phandle =3D *out_val;
+
+	gpr_np =3D of_find_node_by_phandle(phandle);
+	if (!gpr_np) {
+		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
+		return PTR_ERR(gpr_np);
+	}
+
+	priv =3D netdev_priv(dev);
+	priv->stm.gpr =3D syscon_node_to_regmap(gpr_np);
+	if (IS_ERR(priv->stm.gpr)) {
+		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
+		return PTR_ERR(priv->stm.gpr);
+	}
+
+	of_node_put(gpr_np);
+
+	priv->stm.req_gpr =3D out_val[1];
+	priv->stm.req_bit =3D out_val[2];
+	priv->stm.ack_gpr =3D out_val[3];
+	priv->stm.ack_bit =3D out_val[4];
+
+	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x ack_bit =
%u\n",
+		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit, priv->stm.ack_g=
pr,
+		priv->stm.ack_bit);
+
+	device_set_wakeup_capable(&pdev->dev, true);
+
+	return 0;
+}
+
 static const struct of_device_id flexcan_of_match[] =3D {
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
@@ -1396,6 +1496,12 @@ static int flexcan_probe(struct platform_device *pde=
v)
=20
 	devm_can_led_init(dev);
=20
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
+		err =3D flexcan_setup_stop_mode(pdev);
+		if (err)
+			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
+	}
+
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
@@ -1426,9 +1532,17 @@ static int __maybe_unused flexcan_suspend(struct dev=
ice *device)
 	int err;
=20
 	if (netif_running(dev)) {
-		err =3D flexcan_chip_disable(priv);
-		if (err)
-			return err;
+		/* if wakeup is enabled, enter stop mode
+		 * else enter disabled mode.
+		 */
+		if (device_may_wakeup(device)) {
+			enable_irq_wake(dev->irq);
+			flexcan_enter_stop_mode(priv);
+		} else {
+			err =3D flexcan_chip_disable(priv);
+			if (err)
+				return err;
+		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
@@ -1447,14 +1561,45 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
-		err =3D flexcan_chip_enable(priv);
-		if (err)
-			return err;
+		if (device_may_wakeup(device)) {
+			flexcan_enable_wakeup_irq(priv, false);
+		} else {
+			err =3D flexcan_chip_enable(priv);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int __maybe_unused flexcan_noirq_suspend(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (netif_running(dev) && device_may_wakeup(device))
+		flexcan_enable_wakeup_irq(priv, true);
+
+	return 0;
+}
+
+static int __maybe_unused flexcan_noirq_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	if (netif_running(dev) && device_may_wakeup(device)) {
+		disable_irq_wake(dev->irq);
+		flexcan_exit_stop_mode(priv);
 	}
+
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resume);
+static const struct dev_pm_ops flexcan_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_resume=
)
+};
=20
 static struct platform_driver flexcan_driver =3D {
 	.driver =3D {
--=20
2.17.1
