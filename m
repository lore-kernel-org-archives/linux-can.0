From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] cangw: introduce optional uid to reference created routing jobs
Date: Tue,  9 Jun 2015 08:05:10 +0200
Message-ID: <1433829910-7872-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:55775 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbFIGFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Jun 2015 02:05:23 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Similar to referencing iptables rules by their line number this UID allows to
reference created routing jobs, e.g. to alter configured data modifications.

The UID is an optional non-zero value which can be provided at routing job
creation time. When the UID is set the UID replaces the data modification
configuration as job identification attribute e.g. at job removal time.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/gw.h |  5 ++++
 net/can/gw.c                | 68 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 3e6184c..5079b9d 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -78,6 +78,7 @@ enum {
 	CGW_FILTER,	/* specify struct can_filter on source CAN device */
 	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
 	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
+	CGW_MOD_UID,	/* user defined identifier for modification updates */
 	__CGW_MAX
 };
 
@@ -162,6 +163,10 @@ enum {
  * load time of the can-gw module). This value is used to reduce the number of
  * possible hops for this gateway rule to a value smaller then max_hops.
  *
+ * CGW_MOD_UID (length 4 bytes):
+ * Optional non-zero user defined routing job identifier to alter existing
+ * modification settings at runtime.
+ *
  * CGW_CS_XOR (length 4 bytes):
  * Set a simple XOR checksum starting with an initial value into
  * data[result-idx] using data[start-idx] .. data[end-idx]
diff --git a/net/can/gw.c b/net/can/gw.c
index a6f448e..4551687 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -110,6 +110,7 @@ struct cf_mod {
 		void (*xor)(struct can_frame *cf, struct cgw_csum_xor *xor);
 		void (*crc8)(struct can_frame *cf, struct cgw_csum_crc8 *crc8);
 	} csumfunc;
+	u32 uid;
 };
 
 
@@ -548,6 +549,11 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	if (gwj->mod.uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+			goto cancel;
+	}
+
 	if (gwj->mod.csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
 			    &gwj->mod.csum.crc8) < 0)
@@ -619,6 +625,7 @@ static const struct nla_policy cgw_policy[CGW_MAX+1] = {
 	[CGW_DST_IF]	= { .type = NLA_U32 },
 	[CGW_FILTER]	= { .len = sizeof(struct can_filter) },
 	[CGW_LIM_HOPS]	= { .type = NLA_U8 },
+	[CGW_MOD_UID]	= { .type = NLA_U32 },
 };
 
 /* check for common and gwtype specific attributes */
@@ -761,6 +768,10 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			else
 				mod->csumfunc.xor = cgw_csum_xor_neg;
 		}
+
+		if (tb[CGW_MOD_UID]) {
+			nla_memcpy(&mod->uid, tb[CGW_MOD_UID], sizeof(u32));
+		}
 	}
 
 	if (gwtype == CGW_TYPE_CAN_CAN) {
@@ -802,6 +813,8 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 {
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
+	struct cf_mod mod;
+	struct can_can_gw ccgw;
 	u8 limhops = 0;
 	int err = 0;
 
@@ -819,6 +832,36 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
+	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	if (err < 0)
+		return err;
+
+	if (mod.uid) {
+
+		ASSERT_RTNL();
+
+		/* check for updating an existing job with identical uid */
+		hlist_for_each_entry(gwj, &cgw_list, list) {
+
+			if (gwj->mod.uid != mod.uid)
+				continue;
+
+			/* interfaces & filters must be identical */
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
+				return -EINVAL;
+
+			/* update modifications with disabled softirq & quit */
+			local_bh_disable();
+			memcpy(&gwj->mod, &mod, sizeof(mod));
+			local_bh_enable();
+			return 0;
+		}
+	}
+
+	/* ifindex == 0 is not allowed for job creation */
+	if (!ccgw.src_idx || !ccgw.dst_idx)
+		return -ENODEV;
+
 	gwj = kmem_cache_alloc(cgw_cache, GFP_KERNEL);
 	if (!gwj)
 		return -ENOMEM;
@@ -828,18 +871,14 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	gwj->deleted_frames = 0;
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
+	gwj->limit_hops = limhops;
 
-	err = cgw_parse_attr(nlh, &gwj->mod, CGW_TYPE_CAN_CAN, &gwj->ccgw,
-			     &limhops);
-	if (err < 0)
-		goto out;
+	/* insert already parsed information */
+	memcpy(&gwj->mod, &mod, sizeof(mod));
+	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
 
-	/* ifindex == 0 is not allowed for job creation */
-	if (!gwj->ccgw.src_idx || !gwj->ccgw.dst_idx)
-		goto out;
-
 	gwj->src.dev = __dev_get_by_index(&init_net, gwj->ccgw.src_idx);
 
 	if (!gwj->src.dev)
@@ -856,8 +895,6 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (gwj->dst.dev->type != ARPHRD_CAN)
 		goto out;
 
-	gwj->limit_hops = limhops;
-
 	ASSERT_RTNL();
 
 	err = cgw_register_filter(gwj);
@@ -931,8 +968,15 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 		if (gwj->limit_hops != limhops)
 			continue;
 
-		if (memcmp(&gwj->mod, &mod, sizeof(mod)))
-			continue;
+		/* we have a match when uid is enabled and identical */
+		if (gwj->mod.uid || mod.uid) {
+			if (gwj->mod.uid != mod.uid)
+				continue;
+		} else {
+			/* no uid => check for identical modifications */
+			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+				continue;
+		}
 
 		/* if (r->gwtype == CGW_TYPE_CAN_CAN) - is made sure here */
 		if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-- 
2.1.4

