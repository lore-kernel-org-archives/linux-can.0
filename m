From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 16/16] can: flexcan: switch imx6 and vf610 to timestamp based offloading
Date: Wed, 18 Jan 2017 15:52:27 +0100
Message-ID: <20170118145227.24916-17-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52211 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751997AbdARPaU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:30:20 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch switches the imx6 and vf610 based SoCs from the hardware FIFO
to the timestamp based rx offloading.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 6c84afed5e6c..ea57fed375c6 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -287,12 +287,13 @@ static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 static const struct flexcan_devtype_data fsl_imx28_devtype_data;
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_DISABLE_MECR,
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
-- 
2.11.0

