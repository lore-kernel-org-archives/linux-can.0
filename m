From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can: fix initial calculation of total rx/tx rate in CAN statistics
Date: Wed,  6 Jul 2016 10:00:48 +0200
Message-ID: <1467792048-1157-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:23896 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbcGFIBA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Jul 2016 04:01:00 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The total rx/tx rate (TXR and RXR) only start working after a statistic reset.
This patch initializes the referenced timer value to provide proper values
for the total rx/tx rate directly from the start.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1108079..1319ee8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -917,6 +917,7 @@ static __init int can_init(void)
 			setup_timer(&can_stattimer, can_stat_update, 0);
 			mod_timer(&can_stattimer, round_jiffies(jiffies + HZ));
 		}
+		can_stats.jiffies_init = jiffies;
 		can_init_proc();
 	}
 
-- 
2.8.1

