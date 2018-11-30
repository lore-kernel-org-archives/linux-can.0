From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4] can: flexcan: implement can Runtime PM
Date: Fri, 30 Nov 2018 08:53:26 +0000
Message-ID: <20181130085119.7948-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Flexcan will be disabled during suspend if no wakeup function required and
enabled after resume accordingly. During this period, we could explicitly
disable clocks.
Since PM is optional, the clock is enabled at probe to guarante the
clock is running when PM is not enabled in the kernel.

Implement Runtime PM which will:
1) Without CONFIG_PM, clock is running whether Flexcan up or down.
2) With CONFIG_PM, clock enabled while Flexcan up and disabled when
   Flexcan down.
3) Disable clock when do system suspend and enable clock while system
   resume.
4) Make Power Domain framework be able to shutdown the corresponding
   power domain of this device.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*rebased on patch "can: flexcan: add self wakeup support".
V2->V3:
	*fix device fails to probe without CONFIG_PM.
V3->V4:
	*runtime pm enable should ahead of registering device.
	*disable device even if keeping the clocks on.
---
 drivers/net/can/flexcan.c | 111 +++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..cad42f20cfe5 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
=20
@@ -277,6 +278,7 @@ struct flexcan_priv {
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
=20
+	struct device *dev;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	const struct flexcan_devtype_data *devtype_data;
@@ -444,6 +446,27 @@ static inline void flexcan_error_irq_disable(const str=
uct flexcan_priv *priv)
 	priv->write(reg_ctrl, &regs->ctrl);
 }
=20
+static int flexcan_clks_enable(const struct flexcan_priv *priv)
+{
+	int err;
+
+	err =3D clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err =3D clk_prepare_enable(priv->clk_per);
+	if (err)
+		clk_disable_unprepare(priv->clk_ipg);
+
+	return err;
+}
+
+static void flexcan_clks_disable(const struct flexcan_priv *priv)
+{
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
+}
+
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *pr=
iv)
 {
 	if (!priv->reg_xceiver)
@@ -570,19 +593,13 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
+	err =3D pm_runtime_get_sync(priv->dev);
+	if (err < 0)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	err =3D __flexcan_get_berr_counter(dev, bec);
=20
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1215,17 +1232,13 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
-	if (err)
+	err =3D pm_runtime_get_sync(priv->dev);
+	if (err < 0)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	err =3D open_candev(dev);
 	if (err)
-		goto out_disable_per;
+		goto out_disable_clks;
=20
 	err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
 	if (err)
@@ -1288,10 +1301,8 @@ static int flexcan_open(struct net_device *dev)
 	free_irq(dev->irq, dev);
  out_close:
 	close_candev(dev);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+ out_disable_clks:
+	pm_runtime_put(priv->dev);
=20
 	return err;
 }
@@ -1306,10 +1317,9 @@ static int flexcan_close(struct net_device *dev)
=20
 	can_rx_offload_del(&priv->offload);
 	free_irq(dev->irq, dev);
-	clk_disable_unprepare(priv->clk_per);
-	clk_disable_unprepare(priv->clk_ipg);
=20
 	close_candev(dev);
+	pm_runtime_put(priv->dev);
=20
 	can_led_event(dev, CAN_LED_EVENT_STOP);
=20
@@ -1349,18 +1359,14 @@ static int register_flexcandev(struct net_device *d=
ev)
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg, err;
=20
-	err =3D clk_prepare_enable(priv->clk_ipg);
+	err =3D flexcan_clks_enable(priv);
 	if (err)
 		return err;
=20
-	err =3D clk_prepare_enable(priv->clk_per);
-	if (err)
-		goto out_disable_ipg;
-
 	/* select "bus clock", chip must be disabled */
 	err =3D flexcan_chip_disable(priv);
 	if (err)
-		goto out_disable_per;
+		goto out_disable_clks;
 	reg =3D priv->read(&regs->ctrl);
 	reg |=3D FLEXCAN_CTRL_CLK_SRC;
 	priv->write(reg, &regs->ctrl);
@@ -1389,14 +1395,13 @@ static int register_flexcandev(struct net_device *d=
ev)
=20
 	err =3D register_candev(dev);
=20
-	/* disable core and turn off clocks */
- out_chip_disable:
 	flexcan_chip_disable(priv);
- out_disable_per:
-	clk_disable_unprepare(priv->clk_per);
- out_disable_ipg:
-	clk_disable_unprepare(priv->clk_ipg);
+	return 0;
=20
+ out_chip_disable:
+	flexcan_chip_disable(priv);
+ out_disable_clks:
+	flexcan_clks_disable(priv);
 	return err;
 }
=20
@@ -1556,6 +1561,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->dev =3D &pdev->dev;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
@@ -1569,6 +1575,10 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
=20
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	err =3D register_flexcandev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
@@ -1586,6 +1596,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",
 		 priv->regs, dev->irq);
=20
+	pm_runtime_put(&pdev->dev);
 	return 0;
=20
  failed_register:
@@ -1598,6 +1609,7 @@ static int flexcan_remove(struct platform_device *pde=
v)
 	struct net_device *dev =3D platform_get_drvdata(pdev);
=20
 	unregister_flexcandev(dev);
+	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
=20
 	return 0;
@@ -1607,7 +1619,7 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	if (netif_running(dev)) {
 		/* if wakeup is enabled, enter stop mode
@@ -1620,20 +1632,22 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 			err =3D flexcan_chip_disable(priv);
 			if (err)
 				return err;
+
+			err =3D pm_runtime_force_suspend(device);
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
 	priv->can.state =3D CAN_STATE_SLEEPING;
=20
-	return 0;
+	return err;
 }
=20
 static int __maybe_unused flexcan_resume(struct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
+	int err =3D 0;
=20
 	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
@@ -1642,14 +1656,34 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 		if (device_may_wakeup(device)) {
 			disable_irq_wake(dev->irq);
 		} else {
-			err =3D flexcan_chip_enable(priv);
+			err =3D pm_runtime_force_resume(device);
 			if (err)
 				return err;
+
+			err =3D flexcan_chip_enable(priv);
 		}
 	}
+	return err;
+}
+
+static int __maybe_unused flexcan_runtime_suspend(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	flexcan_clks_disable(priv);
+
 	return 0;
 }
=20
+static int __maybe_unused flexcan_runtime_resume(struct device *device)
+{
+	struct net_device *dev =3D dev_get_drvdata(device);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	return flexcan_clks_enable(priv);
+}
+
 static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
@@ -1676,6 +1710,7 @@ static int __maybe_unused flexcan_noirq_resume(struct=
 device *device)
=20
 static const struct dev_pm_ops flexcan_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
+	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_resume=
)
 };
=20
--=20
2.17.1
