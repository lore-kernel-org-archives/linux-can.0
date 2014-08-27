From: David Jander <david@protonic.nl>
Subject: [PATCH] flexcan.c: avoid calling usleep_range from interrupt context
Date: Wed, 27 Aug 2014 12:02:16 +0200
Message-ID: <1409133736-23526-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17913 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933415AbaH0KTh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Aug 2014 06:19:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, David Jander <david@protonic.nl>

Apparently can_restart() runs from a (timer-) interrupt and can call
flexcan_chip_[en|dis]able(), so avoid using usleep_range()

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3998d4c..bff5a27 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -304,7 +304,7 @@ static int flexcan_chip_enable(struct flexcan_priv *priv)
 	flexcan_write(reg, &regs->mcr);
 
 	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
-		usleep_range(10, 20);
+		udelay(10);
 
 	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
 		return -ETIMEDOUT;
@@ -323,7 +323,7 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 	flexcan_write(reg, &regs->mcr);
 
 	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
-		usleep_range(10, 20);
+		udelay(10);
 
 	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		return -ETIMEDOUT;
@@ -342,7 +342,7 @@ static int flexcan_chip_freeze(struct flexcan_priv *priv)
 	flexcan_write(reg, &regs->mcr);
 
 	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
-		usleep_range(100, 200);
+		udelay(100);
 
 	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		return -ETIMEDOUT;
@@ -361,7 +361,7 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 	flexcan_write(reg, &regs->mcr);
 
 	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
-		usleep_range(10, 20);
+		udelay(10);
 
 	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
 		return -ETIMEDOUT;
@@ -376,7 +376,7 @@ static int flexcan_chip_softreset(struct flexcan_priv *priv)
 
 	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
 	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
-		usleep_range(10, 20);
+		udelay(10);
 
 	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
 		return -ETIMEDOUT;
-- 
1.9.1

