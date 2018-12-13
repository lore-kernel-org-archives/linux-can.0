From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/2] can: flexcan: add support for PE clock source select
Date: Thu, 13 Dec 2018 07:08:00 +0000
Message-ID: <20181213070537.25095-3-qiangqing.zhang@nxp.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Add support to select the clock source for CAN Protocol Engine (PE).
It's Soc Implementation dependent. Refer to RM for detailed definition
of each Soc. We select clock source 1 (peripheral clock) by default in
driver now, this patch add support to prase clock source in DTS file.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..2bca867bcfaa 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -273,6 +273,8 @@ struct flexcan_priv {
 	u8 tx_mb_idx;
 	u8 mb_count;
 	u8 mb_size;
+	/* Select clock source to CAN Protocol Engine */
+	u8 clk_src;
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
@@ -1361,9 +1363,12 @@ static int register_flexcandev(struct net_device *de=
v)
 	err =3D flexcan_chip_disable(priv);
 	if (err)
 		goto out_disable_per;
-	reg =3D priv->read(&regs->ctrl);
-	reg |=3D FLEXCAN_CTRL_CLK_SRC;
-	priv->write(reg, &regs->ctrl);
+
+	if (priv->clk_src) {
+		reg =3D priv->read(&regs->ctrl);
+		reg |=3D FLEXCAN_CTRL_CLK_SRC;
+		priv->write(reg, &regs->ctrl);
+	}
=20
 	err =3D flexcan_chip_enable(priv);
 	if (err)
@@ -1488,6 +1493,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
 	struct flexcan_regs __iomem *regs;
 	int err, irq;
+	u8 clk_src =3D 1;
 	u32 clock_freq =3D 0;
=20
 	reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
@@ -1496,9 +1502,12 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	else if (IS_ERR(reg_xceiver))
 		reg_xceiver =3D NULL;
=20
-	if (pdev->dev.of_node)
+	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 				     "clock-frequency", &clock_freq);
+		of_property_read_u8(pdev->dev.of_node,
+				    "fsl,clk-source", &clk_src);
+	}
=20
 	if (!clock_freq) {
 		clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
@@ -1556,6 +1565,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		priv->write =3D flexcan_write_le;
 	}
=20
+	priv->clk_src =3D clk_src;
 	priv->can.clock.freq =3D clock_freq;
 	priv->can.bittiming_const =3D &flexcan_bittiming_const;
 	priv->can.do_set_mode =3D flexcan_set_mode;
--=20
2.17.1
