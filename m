From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/12] can: flexcan: remove unused header files
Date: Tue,  1 Sep 2015 11:29:06 +0200
Message-ID: <1441099755-8601-4-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46469 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch removes unused header files from the flexcan driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e9e8f095461c..83ea6f4f7164 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -26,12 +26,8 @@
 #include <linux/can/led.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/if_arp.h>
-#include <linux/if_ether.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-- 
2.5.0

