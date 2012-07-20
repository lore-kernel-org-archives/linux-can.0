From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/9] can: janz-ican3: remove dead code
Date: Fri, 20 Jul 2012 13:11:43 +0200
Message-ID: <1342782709-4868-4-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42083 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2GTLLz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:55 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The code which used this variable was removed during review, before the
driver was added to mainline Linux. It is now dead code, and can be
removed.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index e7d1532..f41623d 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -235,7 +235,6 @@ struct ican3_dev {
 
 	/* fast host interface */
 	unsigned int fastrx_start;
-	unsigned int fastrx_int;
 	unsigned int fastrx_num;
 	unsigned int fasttx_start;
 	unsigned int fasttx_num;
@@ -454,7 +453,6 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start recv page */
 	mod->fastrx_start = mod->free_page;
 	mod->fastrx_num = 0;
-	mod->fastrx_int = 0;
 
 	/* build a single fast tohost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
-- 
1.7.10

