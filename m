From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v2] can-gw: add a variable limit for CAN frame routings
Date: Wed, 09 Jan 2013 18:24:58 +0100
Message-ID: <50EDA7EA.1070206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:19862 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab3AIRZE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jan 2013 12:25:04 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux CAN List <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

To prevent a possible misconfiguration (e.g. circular CAN frame routings)
limit the number of routings of a single CAN frame to a small variable value.

The limit can be specified by the module parameter 'max_hops' (1..6).
The default value is 1 (one hop), according to the original can-gw behaviour.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

Having the possibility of only a single CAN frame routing (one hop) hinders
use-cases for some complex application setups. To enable more than one CAN
frame routing process with a single CAN frame (skb) a counter needed to be
implemented to prevent an endless frame processing (e.g. due to some kind of
misconfiguration).

As the skb control buffer (cb) potentially gets modified by net/sched in the
tx path the csum element for IP checksums is re-used for the counter, as CAN
frame skbs (ARPHRD_CAN) never contain any kind of checksums (see src comment).

v2: use clamp_t() function from kernel.h to sanitize the new module parameter


diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 8e1db18..ba87697 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -44,6 +44,7 @@ enum {
 	CGW_SRC_IF,	/* ifindex of source network interface */
 	CGW_DST_IF,	/* ifindex of destination network interface */
 	CGW_FILTER,	/* specify struct can_filter on source CAN device */
+	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
 	__CGW_MAX
 };
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 574dda78e..c7077b2 100644
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
@@ -57,15 +58,24 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#define CAN_GW_VERSION "20101209"
+#define CAN_GW_VERSION "20130109"
 static __initconst const char banner[] =
-	KERN_INFO "can: netlink gateway (rev " CAN_GW_VERSION ")\n";
+	KERN_INFO "can: netlink gateway (rev " CAN_GW_VERSION ")";
 
 MODULE_DESCRIPTION("PF_CAN netlink gateway");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-gw");
 
+#define CGW_MIN_HOPS 1
+#define CGW_MAX_HOPS 6
+
+static unsigned int max_hops __read_mostly = CGW_MIN_HOPS;
+module_param(max_hops, uint, S_IRUGO);
+MODULE_PARM_DESC(max_hops,
+		 "maximum can-gw routing hops for CAN frames "
+		 "(valid values: 1-6 hops, default: 1)");
+
 static HLIST_HEAD(cgw_list);
 static struct notifier_block notifier;
 
@@ -118,6 +128,7 @@ struct cgw_job {
 	struct rcu_head rcu;
 	u32 handled_frames;
 	u32 dropped_frames;
+	u32 deleted_frames;
 	struct cf_mod mod;
 	union {
 		/* CAN frame data source */
@@ -338,9 +349,27 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
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
+	if (cgw_hops(skb) >= max_hops) {
+		/* indicate deleted frames due to misconfiguration */
+		gwj->deleted_frames++;
 		return;
+	}
 
 	if (!(gwj->dst.dev->flags & IFF_UP)) {
 		gwj->dropped_frames++;
@@ -363,15 +392,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
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
@@ -472,6 +494,11 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	if (gwj->deleted_frames) {
+		if (nla_put_u32(skb, CGW_DELETED, gwj->deleted_frames) < 0)
+			goto cancel;
+	}
+
 	/* check non default settings of attributes */
 
 	if (gwj->mod.modtype.and) {
@@ -771,6 +798,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
+	gwj->deleted_frames = 0;
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 
@@ -895,7 +923,9 @@ static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh, void *arg)
 
 static __init int cgw_module_init(void)
 {
-	printk(banner);
+	/* sanitize given module parameter */
+	max_hops = clamp_t(unsigned int, max_hops, CGW_MIN_HOPS, CGW_MAX_HOPS);
+	printk("%s max_hops=%d\n", banner, max_hops);
 
 	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
 				      0, 0, NULL);


