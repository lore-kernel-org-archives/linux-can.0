From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 04/16] can: flexcan: make declaration of devtype_data const
Date: Wed, 18 Jan 2017 15:52:15 +0100
Message-ID: <20170118145227.24916-5-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49715 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753148AbdARPEJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:09 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch changes the declaration of the devtype data to const.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4c3173f32114..409f924e46ea 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -261,17 +261,17 @@ struct flexcan_priv {
 	struct regulator *reg_xceiver;
 };
 
-static struct flexcan_devtype_data fsl_p1010_devtype_data = {
+static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_ERR_STATE,
 };
 
-static struct flexcan_devtype_data fsl_imx28_devtype_data;
+static const struct flexcan_devtype_data fsl_imx28_devtype_data;
 
-static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
+static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG,
 };
 
-static struct flexcan_devtype_data fsl_vf610_devtype_data = {
+static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
 };
 
-- 
2.11.0

