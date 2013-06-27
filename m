From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] ARM: imx: flexcan: Remove platform file
Date: Thu, 27 Jun 2013 09:22:11 +0200
Message-ID: <1372317731-24966-4-git-send-email-mkl@pengutronix.de>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33269 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab3F0HWR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2013 03:22:17 -0400
In-Reply-To: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Fabio Estevam <fabio.estevam@freescale.com>

As there are no more users of the flexcan platform file, let's remove it.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/platform/flexcan.h | 20 --------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 include/linux/can/platform/flexcan.h

diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/platform/flexcan.h
deleted file mode 100644
index 72b713a..0000000
--- a/include/linux/can/platform/flexcan.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2010 Marc Kleine-Budde <kernel@pengutronix.de>
- *
- * This file is released under the GPLv2
- *
- */
-
-#ifndef __CAN_PLATFORM_FLEXCAN_H
-#define __CAN_PLATFORM_FLEXCAN_H
-
-/**
- * struct flexcan_platform_data - flex CAN controller platform data
- * @transceiver_enable:         - called to power on/off the transceiver
- *
- */
-struct flexcan_platform_data {
-	void (*transceiver_switch)(int enable);
-};
-
-#endif /* __CAN_PLATFORM_FLEXCAN_H */
-- 
1.8.3.1

