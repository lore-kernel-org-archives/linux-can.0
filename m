From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH net-next] can: fix build error without CONFIG_PROC_FS
Date: Thu, 27 Apr 2017 16:21:37 +0200
Message-ID: <20170427142146.3107957-1-arnd@arndb.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50746 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939379AbdD0OV4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Apr 2017 10:21:56 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Cong Wang <xiyou.wangcong@gmail.com>, Mario Kicherer <dev@kicherer.org>, Eric Dumazet <edumazet@google.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

The procfs dir entry was added inside of an #ifdef, causing a build error
when we try to access it without CONFIG_PROC_FS set:

net/can/bcm.c:1541:14: error: 'struct netns_can' has no member named 'bcmproc_dir'
net/can/bcm.c: In function 'bcm_connect':
net/can/bcm.c:1601:14: error: 'struct netns_can' has no member named 'bcmproc_dir'
net/can/bcm.c: In function 'canbcm_pernet_init':
net/can/bcm.c:1696:11: error: 'struct netns_can' has no member named 'bcmproc_dir'
net/can/bcm.c: In function 'canbcm_pernet_exit':
net/can/bcm.c:1707:15: error: 'struct netns_can' has no member named 'bcmproc_dir'

This adds the same #ifdef around all users of the pointer. Alternatively
we could move the pointer outside of the #ifdef.

Fixes: 384317ef4187 ("can: network namespace support for CAN_BCM protocol")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/can/bcm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0e855917b7e1..e6d9df27400b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1538,8 +1538,10 @@ static int bcm_release(struct socket *sock)
 	}
 
 	/* remove procfs entry */
+#ifdef CONFIG_PROC_FS
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif
 
 	/* remove device reference */
 	if (bo->bound) {
@@ -1597,7 +1599,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 		/* no interface reference for ifindex = 0 ('any' CAN device) */
 		bo->ifindex = 0;
 	}
-
+#ifdef CONFIG_PROC_FS
 	if (net->can.bcmproc_dir) {
 		/* unique socket address as filename */
 		sprintf(bo->procname, "%lu", sock_i_ino(sk));
@@ -1609,6 +1611,7 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 			goto fail;
 		}
 	}
+#endif
 
 	bo->bound = 1;
 
@@ -1691,22 +1694,23 @@ static const struct can_proto bcm_can_proto = {
 
 static int canbcm_pernet_init(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
 	/* create /proc/net/can-bcm directory */
-	if (IS_ENABLED(CONFIG_PROC_FS)) {
-		net->can.bcmproc_dir =
-			proc_net_mkdir(net, "can-bcm", net->proc_net);
-	}
+	net->can.bcmproc_dir = proc_net_mkdir(net, "can-bcm", net->proc_net);
+#endif
 
 	return 0;
 }
 
 static void canbcm_pernet_exit(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
 	/* remove /proc/net/can-bcm directory */
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		if (net->can.bcmproc_dir)
 			remove_proc_entry("can-bcm", net->proc_net);
 	}
+#endif
 }
 
 static struct pernet_operations canbcm_pernet_ops __read_mostly = {
-- 
2.9.0

