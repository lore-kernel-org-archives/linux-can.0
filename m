From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 04/12] can: flexcan: make declaration of devtype_data const
Date: Mon,  4 Jul 2016 20:32:09 +0200
Message-ID: <1467657137-18891-5-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53867 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734AbcGDScW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:32:22 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch changes the declaration of the devtype data to const.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index dea2bf27cfc4..617e723de909 100644
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
2.8.1

