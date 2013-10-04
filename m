From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: flexcan: fix mx28 detection by rearanging OF match table
Date: Fri,  4 Oct 2013 12:48:53 +0200
Message-ID: <1380883733-11995-3-git-send-email-mkl@pengutronix.de>
References: <1380883733-11995-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59323 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3JDKtP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2013 06:49:15 -0400
In-Reply-To: <1380883733-11995-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Marc Kleine-Budde <mkl@pengutronix.de>

The current implemetation of of_match_device() relies that the of_device_id
table in the driver is sorted from most specific to least specific compatible.

Without this patch the mx28 is detected as the less specific p1010. This leads
to a p1010 specific workaround is activated on the mx28, which is not needed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 82a23dd..a3fdd22 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -983,9 +983,9 @@ static void unregister_flexcandev(struct net_device *dev)
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

