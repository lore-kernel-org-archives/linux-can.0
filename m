From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] can: flexcan: Add check for transceiver maximum bitrate
 limitation
Date: Wed, 30 Oct 2019 06:45:57 +0000
Message-ID: <20191030064245.12923-2-qiangqing.zhang@nxp.com>
References: <20191030064245.12923-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191030064245.12923-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

CAN FD can transmit up to 8Mbps, but some transceivers only can support
5Mbps, so add check in driver.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c5d53edb17ad..ee2d57b5a382 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1626,6 +1626,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 		goto failed_register;
 	}
=20
+	of_can_transceiver(dev);
 	devm_can_led_init(dev);
=20
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
--=20
2.17.1
