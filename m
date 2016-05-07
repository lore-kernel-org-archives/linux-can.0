From: Marek Vasut <marex@denx.de>
Subject: [PATCH 3/6] net: can: ifi: Unify timing constants
Date: Sun,  8 May 2016 00:34:13 +0200
Message-ID: <1462660456-6179-3-git-send-email-marex@denx.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59051 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbcEGWee (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2016 18:34:34 -0400
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

There is no distinction between bittiming constants for the slow and
fast part of the CANFD operation on this controller, so just use one
single bittiming constant set.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index b9efd6e..30dc3b6 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -544,18 +544,6 @@ static const struct can_bittiming_const ifi_canfd_bittiming_const = {
 	.brp_inc	= 1,
 };
 
-static const struct can_bittiming_const ifi_canfd_data_bittiming_const = {
-	.name		= KBUILD_MODNAME,
-	.tseg1_min	= 1,	/* Time segment 1 = prop_seg + phase_seg1 */
-	.tseg1_max	= 256,
-	.tseg2_min	= 2,	/* Time segment 2 = phase_seg2 */
-	.tseg2_max	= 256,
-	.sjw_max	= 128,
-	.brp_min	= 2,
-	.brp_max	= 512,
-	.brp_inc	= 1,
-};
-
 static void ifi_canfd_set_bittiming(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
@@ -866,7 +854,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	priv->can.clock.freq = readl(addr + IFI_CANFD_CANCLOCK);
 
 	priv->can.bittiming_const	= &ifi_canfd_bittiming_const;
-	priv->can.data_bittiming_const	= &ifi_canfd_data_bittiming_const;
+	priv->can.data_bittiming_const	= &ifi_canfd_bittiming_const;
 	priv->can.do_set_mode		= ifi_canfd_set_mode;
 	priv->can.do_get_berr_counter	= ifi_canfd_get_berr_counter;
 
-- 
2.7.0

