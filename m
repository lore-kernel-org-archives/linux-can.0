From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/2] can: flexcan: fix mx28 detection by rearanging OF match table
Date: Mon,  7 Oct 2013 16:25:33 +0200
Message-ID: <1381155933-21820-3-git-send-email-mkl@pengutronix.de>
References: <1381155933-21820-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50726 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3JGOZh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:25:37 -0400
In-Reply-To: <1381155933-21820-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, LW@KARO-electronics.de, Marc Kleine-Budde <mkl@pengutronix.de>

The current implemetation of of_match_device() relies that the of_device_id
table in the driver is sorted from most specific to least specific compatible.

Without this patch the mx28 is detected as the less specific p1010. This leads
to a p1010 specific workaround is activated on the mx28, which is not needed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f028c5d..8f5ce74 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -985,9 +985,9 @@ static void unregister_flexcandev(struct net_device *dev)
 }
 
 static const struct of_device_id flexcan_of_match[] = {
-	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
-	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
+	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
+	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
1.8.4.rc3

