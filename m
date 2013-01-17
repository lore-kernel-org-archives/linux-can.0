From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 3/4] can-gw: add a variable limit for CAN frame routings
Date: Thu, 17 Jan 2013 18:43:44 +0100
Message-ID: <50F83850.20807@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:45347 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab3AQRnq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 12:43:46 -0500
Received: from [192.168.178.31] (p5B0B0333.dip0.t-ipconnect.de [91.11.3.51])
	by smtp.strato.de (jored mo12) (RZmta 31.12 DYNA|AUTH)
	with ESMTPA id N01986p0HHXCPy for <linux-can@vger.kernel.org>;
	Thu, 17 Jan 2013 18:43:44 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From 3ff1cd7a9c4c3b823b2444f64e09fd58cf507732 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 17 Jan 2013 07:27:10 +0100
Subject: [PATCH 3/4] can-gw: add a variable limit for CAN frame routings

To prevent a possible misconfiguration (e.g. circular CAN frame routings)
limit the number of routings of a single CAN frame to a small variable value.

The limit can be specified by the module parameter 'max_hops' (1..6).
The default value is 1 (one hop), according to the original can-gw behaviour.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c |   56 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37a3efb..81f4b49 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -42,6 +42,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
@@ -58,14 +59,25 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#define CAN_GW_VERSION "20101209"
-static __initconst const char banner[] =
-	KERN_INFO "can: netlink gateway (rev " CAN_GW_VERSION ")\n";
+#define CAN_GW_VERSION "20130117"
+#define CAN_GW_NAME "can-gw"
 
 MODULE_DESCRIPTION("PF_CAN netlink gateway");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
-MODULE_ALIAS("can-gw");
+MODULE_ALIAS(CAN_GW_NAME);
+
+#define CGW_MIN_HOPS 1
+#define CGW_MAX_HOPS 6
+#define CGW_DEFAULT_HOPS 1
+
+static unsigned int max_hops __read_mostly = CGW_DEFAULT_HOPS;
+module_param(max_hops, uint, S_IRUGO);
+MODULE_PARM_DESC(max_hops,
+		 "maximum " CAN_GW_NAME " routing hops for CAN frames "
+		 "(valid values: " __stringify(CGW_MIN_HOPS) "-"
+		 __stringify(CGW_MAX_HOPS) " hops, "
+		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
 
 static HLIST_HEAD(cgw_list);
 static struct notifier_block notifier;
@@ -339,8 +351,23 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct sk_buff *nskb;
 	int modidx = 0;
 
-	/* do not handle already routed frames - see comment below */
-	if (skb_mac_header_was_set(skb))
+	/*
+	 * Do not handle CAN frames routed more than 'max_hops' times.
+	 * In general we should never catch this delimiter which is intended
+	 * to cover a misconfiguration protection (e.g. circular CAN routes).
+	 *
+	 * The Controller Area Network controllers only accept CAN frames with
+	 * correct CRCs - which are not visible in the controller registers.
+	 * According to skbuff.h documentation the csum element for IP checksums
+	 * is undefined/unsued when ip_summed == CHECKSUM_UNNECESSARY. Only
+	 * CAN skbs can be processed here which already have this property.
+	 */
+
+#define cgw_hops(skb) ((skb)->csum)
+
+	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
+
+	if (cgw_hops(skb) >= max_hops)
 		return;
 
 	if (!(gwj->dst.dev->flags & IFF_UP)) {
@@ -371,15 +398,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
-	/*
-	 * Mark routed frames by setting some mac header length which is
-	 * not relevant for the CAN frames located in the skb->data section.
-	 *
-	 * As dev->header_ops is not set in CAN netdevices no one is ever
-	 * accessing the various header offsets in the CAN skbuffs anyway.
-	 * E.g. using the packet socket to read CAN frames is still working.
-	 */
-	skb_set_mac_header(nskb, 8);
+	/* put the incremented hop counter in the cloned skb */
+	cgw_hops(nskb) = cgw_hops(skb) + 1;
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
@@ -903,7 +923,11 @@ static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh, void *arg)
 
 static __init int cgw_module_init(void)
 {
-	printk(banner);
+	/* sanitize given module parameter */
+	max_hops = clamp_t(unsigned int, max_hops, CGW_MIN_HOPS, CGW_MAX_HOPS);
+
+	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=%d\n",
+		max_hops);
 
 	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
 				      0, 0, NULL);
-- 
1.7.10.4

