From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/10] can: flexcan: switch imx6 and vf610 to software based fifo
Date: Mon,  9 May 2016 12:52:34 +0200
Message-ID: <1462791154-13375-11-git-send-email-mkl@pengutronix.de>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40146 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbcEIKwr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:52:47 -0400
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch switches the imx6 and vf610 based SoCs from the hardware to
the software based rx-fifo.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 9c7a9ce5b308..24879a227781 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -291,12 +291,13 @@ static struct flexcan_devtype_data fsl_p1010_devtype_data = {
 static struct flexcan_devtype_data fsl_imx28_devtype_data;
 
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS,
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_SW_FIFO,
 };
 
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_DISABLE_MECR,
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_SW_FIFO,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
-- 
2.8.1

