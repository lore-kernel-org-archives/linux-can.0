From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: sja1000: fix compilation on x86
Date: Fri, 14 Dec 2012 22:29:58 +0100
Message-ID: <1355520598-24109-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58876 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab2LNVaH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 16:30:07 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, rdunlap@infradead.org, Andreas Larsson <andreas@gaisler.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Since commit:
04df251 can: sja1000: Make sja1000_of_platform selectable and compilable on SPARC
the driver can be activated on non powerpc platform like x86 or sparc. Without
this patch the driver fails to compile on platform that don't define NO_IRQ,
like x86.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

compile tested, I'm going to submit a pull-request to David Miller.

regards,
Marc

 drivers/net/can/sja1000/sja1000_of_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000_of_platform.c b/drivers/net/can/sja1000/sja1000_of_platform.c
index 0f59170..38d37c8 100644
--- a/drivers/net/can/sja1000/sja1000_of_platform.c
+++ b/drivers/net/can/sja1000/sja1000_of_platform.c
@@ -121,7 +121,7 @@ static int sja1000_ofp_probe(struct platform_device *ofdev)
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (irq <= 0) {
 		dev_err(&ofdev->dev, "no irq found\n");
 		err = -ENODEV;
 		goto exit_unmap_mem;
-- 
1.7.10.4

