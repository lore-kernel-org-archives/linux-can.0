From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: janz-ican3: fix uninitialized variable warnings
Date: Wed, 29 Jan 2014 22:11:03 +0100
Message-ID: <1391029863-23099-4-git-send-email-mkl@pengutronix.de>
References: <1391029863-23099-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49910 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaA2VLO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Jan 2014 16:11:14 -0500
In-Reply-To: <1391029863-23099-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

Analysis of the code shows that the struct ican3_msg variable cannot be
used uninitialized. Error conditions are checked and the loop terminates
before calling the ican3_handle_message() function with an uninitialized
value.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index e24e669..07f0ba0 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1322,7 +1322,7 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 
 	/* process all communication messages */
 	while (true) {
-		struct ican3_msg msg;
+		struct ican3_msg uninitialized_var(msg);
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
-- 
1.8.5.3

