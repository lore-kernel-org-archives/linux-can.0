From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 11/11] can: flexcan: switch imx6 and vf610 to software based fifo
Date: Thu, 10 Dec 2015 13:33:57 +0100
Message-ID: <1449750837-11376-12-git-send-email-mkl@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46611 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753558AbbLJMdu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:33:50 -0500
In-Reply-To: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, bhupesh.sharma@freescale.com, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1482d10917a5..116b8aee9712 100644
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
2.6.2

