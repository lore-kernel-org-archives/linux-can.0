From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] can: remove obsolete pernet_operations definitions
Date: Mon, 24 Apr 2017 15:09:00 +0200
Message-ID: <20170424130900.2284-2-socketcan@hartkopp.net>
References: <20170424130900.2284-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:30084 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170743AbdDXNJp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Apr 2017 09:09:45 -0400
In-Reply-To: <20170424130900.2284-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 4 ----
 net/can/bcm.c    | 4 ----
 net/can/gw.c     | 3 ---
 3 files changed, 11 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index e53030289531..3521f9477dd4 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -75,8 +75,6 @@ static int stats_timer __read_mostly = 1;
 module_param(stats_timer, int, S_IRUGO);
 MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:on)");
 
-static int can_net_id;
-
 static struct kmem_cache *rcv_cache __read_mostly;
 
 /* table of registered CAN protocols */
@@ -953,8 +951,6 @@ static struct notifier_block can_netdev_notifier __read_mostly = {
 static struct pernet_operations can_pernet_ops __read_mostly = {
 	.init = can_pernet_init,
 	.exit = can_pernet_exit,
-	.id = &can_net_id,
-	.size = 0,
 };
 
 static __init int can_init(void)
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7fd9d283d66f..50ffbbb78934 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -84,8 +84,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-proto-2");
 
-static int canbcm_net_id;
-
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
@@ -1714,8 +1712,6 @@ static void canbcm_pernet_exit(struct net *net)
 static struct pernet_operations canbcm_pernet_ops __read_mostly = {
 	.init = canbcm_pernet_init,
 	.exit = canbcm_pernet_exit,
-	.id = &canbcm_net_id,
-	.size = 0,
 };
 
 static int __init bcm_module_init(void)
diff --git a/net/can/gw.c b/net/can/gw.c
index e2935d9c1ef3..10307adc8549 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -79,7 +79,6 @@ MODULE_PARM_DESC(max_hops,
 		 __stringify(CGW_MAX_HOPS) " hops, "
 		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
 
-static int cangw_net_id;
 static struct notifier_block notifier;
 static struct kmem_cache *cgw_cache __read_mostly;
 
@@ -1009,8 +1008,6 @@ static void __net_exit cangw_pernet_exit(struct net *net)
 static struct pernet_operations cangw_pernet_ops = {
 	.init = cangw_pernet_init,
 	.exit = cangw_pernet_exit,
-	.id = &cangw_net_id,
-	.size = 0,
 };
 
 static __init int cgw_module_init(void)
-- 
2.11.0

