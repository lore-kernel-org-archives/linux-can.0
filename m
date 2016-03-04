From: Ed Spiridonov <edo.rus@gmail.com>
Subject: [PATCH] can: mcp251x: avoid write to error flag register if it's unnecessary
Date: Fri,  4 Mar 2016 09:07:27 +0300
Message-ID: <1457071647-17098-1-git-send-email-edo.rus@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33340 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbcCDGIW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Mar 2016 01:08:22 -0500
Received: by mail-lb0-f173.google.com with SMTP id k15so49516586lbg.0
        for <linux-can@vger.kernel.org>; Thu, 03 Mar 2016 22:08:22 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, celston@katalix.com, chripell@evolware.org, sbabic@denx.de, Ed Spiridonov <edo.rus@gmail.com>

Only two bits (RX0OVR and RX1OVR) are writable in EFLG, write is useless if these bits aren't set.

Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 575790e..74a7dfe 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -843,7 +843,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		if (clear_intf)
 			mcp251x_write_bits(spi, CANINTF, clear_intf, 0x00);
 
-		if (eflag)
+		if (eflag & (EFLG_RX0OVR | EFLG_RX1OVR))
 			mcp251x_write_bits(spi, EFLG, eflag, 0x00);
 
 		/* Update can state */
-- 
2.7.0

