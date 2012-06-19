From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: af_can: fix sparse warning for can_rx_alldev_list
Date: Tue, 19 Jun 2012 22:05:20 +0200
Message-ID: <1340136320-30840-4-git-send-email-mkl@pengutronix.de>
References: <1340136320-30840-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37996 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab2FSUFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 16:05:23 -0400
In-Reply-To: <1340136320-30840-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Make can_rx_alldev_list static to fix the following sparse warning:
net/can/af_can.c:80:22: warning: symbol 'can_rx_alldev_list' was not
declared. Should it be static?

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 821022a..ccef846 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -78,7 +78,7 @@ module_param(stats_timer, int, S_IRUGO);
 MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:on)");
 
 /* receive filters subscribed for 'all' CAN devices */
-struct dev_rcv_lists can_rx_alldev_list;
+static struct dev_rcv_lists can_rx_alldev_list;
 static DEFINE_SPINLOCK(can_rcvlists_lock);
 
 static struct kmem_cache *rcv_cache __read_mostly;
-- 
1.7.10

