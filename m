From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 25/25] can: mpc5xxx_can: make data used as *of_device_id.data const
Date: Mon, 23 Jul 2012 11:13:30 +0200
Message-ID: <1343034810-3386-26-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36055 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab2GWJO1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jul 2012 05:14:27 -0400
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

=46rom: Arnd Bergmann <arnd@arndb.de>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msca=
n/mpc5xxx_can.c
index 06adf88..8a8df82 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -380,12 +380,12 @@ static int mpc5xxx_can_resume(struct platform_dev=
ice *ofdev)
 }
 #endif
=20
-static struct mpc5xxx_can_data __devinitdata mpc5200_can_data =3D {
+static const struct mpc5xxx_can_data __devinitdata mpc5200_can_data =3D=
 {
 	.type =3D MSCAN_TYPE_MPC5200,
 	.get_clock =3D mpc52xx_can_get_clock,
 };
=20
-static struct mpc5xxx_can_data __devinitdata mpc5121_can_data =3D {
+static const struct mpc5xxx_can_data __devinitdata mpc5121_can_data =3D=
 {
 	.type =3D MSCAN_TYPE_MPC5121,
 	.get_clock =3D mpc512x_can_get_clock,
 };
--=20
1.7.10.4

