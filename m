From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] can: flexcan: add PM support
Date: Tue,  8 May 2012 17:12:17 +0200
Message-ID: <1336489937-29645-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:51283 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755966Ab2EHPMf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 May 2012 11:12:35 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

tested on an i.MX257

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/net/can/flexcan.c |   38 +++++++++++++++++++++++++++++++++++++=
+
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1efb083..0d058b0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1050,6 +1050,42 @@ static struct of_device_id flexcan_of_match[] =3D=
 {
 	{},
 };
=20
+#ifdef CONFIG_PM
+static int flexcan_suspend(struct platform_device *pdev, pm_message_t =
state)
+{
+	struct net_device *dev =3D platform_get_drvdata(pdev);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	flexcan_chip_disable(priv);
+
+	if (netif_running(dev)) {
+		netif_stop_queue(dev);
+		netif_device_detach(dev);
+	}
+	priv->can.state =3D CAN_STATE_SLEEPING;
+
+	return 0;
+}
+
+static int flexcan_resume(struct platform_device *pdev)
+{
+	struct net_device *dev =3D platform_get_drvdata(pdev);
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+
+	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+	if (netif_running(dev)) {
+		netif_device_attach(dev);
+		netif_start_queue(dev);
+	}
+	flexcan_chip_enable(priv);
+
+	return 0;
+}
+#else
+#define flexcan_suspend NULL
+#define flexcan_resume NULL
+#endif
+
 static struct platform_driver flexcan_driver =3D {
 	.driver =3D {
 		.name =3D DRV_NAME,
@@ -1058,6 +1094,8 @@ static struct platform_driver flexcan_driver =3D =
{
 	},
 	.probe =3D flexcan_probe,
 	.remove =3D __devexit_p(flexcan_remove),
+	.suspend =3D flexcan_suspend,
+	.resume =3D flexcan_resume,
 };
=20
 module_platform_driver(flexcan_driver);
--=20
1.7.7.6

