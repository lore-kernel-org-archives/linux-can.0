From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 18/25] can: mpc5xxx_can: make data in mpc5xxx_can_probe const
Date: Mon, 23 Jul 2012 11:13:23 +0200
Message-ID: <1343034810-3386-19-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35886 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2GWJOH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jul 2012 05:14:07 -0400
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

=46rom: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
index 5caa572..06adf88 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
 static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
-	struct mpc5xxx_can_data *data;
+	const struct mpc5xxx_can_data *data;
 	struct device_node *np =3D ofdev->dev.of_node;
 	struct net_device *dev;
 	struct mscan_priv *priv;
--=20
1.7.10.4

