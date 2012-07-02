From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/6] can: fix sparse warning in af_can.c
Date: Mon,  2 Jul 2012 14:40:22 +0200
Message-ID: <1341232825-4604-4-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57318 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2GBMk3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:29 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

Put can_rx_alldev_list into the af_can header to fix the following
sparse warning: net/can/af_can.c:80:22: warning: symbol
'can_rx_alldev_list' was not declared. Should it be static?

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.h |    3 +++
 net/can/proc.c   |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/af_can.h b/net/can/af_can.h
index fd882db..1dccb4c 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -104,6 +104,9 @@ struct s_pstats {
 	unsigned long rcv_entries_max;
 };
 
+/* receive filters subscribed for 'all' CAN devices */
+extern struct dev_rcv_lists can_rx_alldev_list;
+
 /* function prototypes for the CAN networklayer procfs (proc.c) */
 extern void can_init_proc(void);
 extern void can_remove_proc(void);
diff --git a/net/can/proc.c b/net/can/proc.c
index ba873c3..3b6dd31 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -83,9 +83,6 @@ static const char rx_list_name[][8] = {
 	[RX_EFF] = "rx_eff",
 };
 
-/* receive filters subscribed for 'all' CAN devices */
-extern struct dev_rcv_lists can_rx_alldev_list;
-
 /*
  * af_can statistics stuff
  */
-- 
1.7.10

