From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: flexcan: switch imx6 and vf610 to software based fifo
Date: Tue,  1 Sep 2015 12:32:01 +0200
Message-ID: <1441103522-15593-8-git-send-email-mkl@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbbIAKcL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 06:32:11 -0400
In-Reply-To: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 415459030b60..50b15ef0ac4a 100644
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
2.5.0

