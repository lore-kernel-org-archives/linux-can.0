From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: use devm_platform_ioremap_resource() to
 simplify code
Date: Sun, 29 Sep 2019 08:32:09 +0000
Message-ID: <20190929082854.11952-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together to simplify
the code.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b3edaf6a5a61..3cfa6037f03c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1507,7 +1507,6 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct regulator *reg_xceiver;
-	struct resource *mem;
 	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
 	struct flexcan_regs __iomem *regs;
 	int err, irq;
@@ -1538,12 +1537,11 @@ static int flexcan_probe(struct platform_device *pd=
ev)
 		clock_freq =3D clk_get_rate(clk_per);
 	}
=20
-	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0)
 		return -ENODEV;
=20
-	regs =3D devm_ioremap_resource(&pdev->dev, mem);
+	regs =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
=20
--=20
2.17.1
