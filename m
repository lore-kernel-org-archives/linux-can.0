From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] can-gw: add a per rule limitation of frame hops
Date: Mon, 26 Aug 2013 15:05:36 +0200
Message-ID: <521B52A0.1050702@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:24642 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab3HZNGF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Aug 2013 09:06:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Usually the received CAN frames can be processed/routed as much as 'max_hops'
times (which is given at module load time of the can-gw module).
Introduce a new configuration option to reduce the number of possible hops
for a specific gateway rule to a value smaller then max_hops.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index ae07bec..a9d4363 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -45,6 +45,7 @@ enum {
 	CGW_DST_IF,	/* ifindex of destination network interface */
 	CGW_FILTER,	/* specify struct can_filter on source CAN device */
 	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
+	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
 	__CGW_MAX
 };
 
@@ -116,13 +117,19 @@ enum {
  * Sets a CAN receive filter for the gateway job specified by the
  * struct can_filter described in include/linux/can.h
  *
- * CGW_MOD_XXX (length 17 bytes):
+ * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
  * Specifies a modification that's done to a received CAN frame before it is
  * send out to the destination interface.
  *
  * <struct can_frame> data used as operator
  * <u8> affected CAN frame elements
  *
+ * CGW_LIM_HOPS (length 1 byte):
+ * Limit the number of hops of this specific rule. Usually the received CAN
+ * frame can be processed as much as 'max_hops' times (which is given at module
+ * load time of the can-gw module). This value is used to reduce the number of
+ * possible hops for this gateway rule to a value smaller then max_hops.
+ *
  * CGW_CS_XOR (length 4 bytes):
  * Set a simple XOR checksum starting with an initial value into
  * data[result-idx] using data[start-idx] .. data[end-idx]
diff --git a/net/can/gw.c b/net/can/gw.c
index 2f291f9..3f9b0f3 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -146,6 +146,7 @@ struct cgw_job {
 		/* tbc */
 	};
 	u8 gwtype;
+	u8 limit_hops;
 	u16 flags;
 };
 
@@ -402,6 +403,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* put the incremented hop counter in the cloned skb */
 	cgw_hops(nskb) = cgw_hops(skb) + 1;
+
+	/* first processing of this CAN frame -> adjust to private hop limit */
+	if (gwj->limit_hops && cgw_hops(nskb) == 1)
+		cgw_hops(nskb) = max_hops - gwj->limit_hops + 1;
+
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
@@ -509,6 +515,11 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 
 	/* check non default settings of attributes */
 
+	if (gwj->limit_hops) {
+		if (nla_put_u8(skb, CGW_LIM_HOPS, gwj->limit_hops) < 0)
+			goto cancel;
+	}
+
 	if (gwj->mod.modtype.and) {
 		memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
 		mb.modtype = gwj->mod.modtype.and;
@@ -606,11 +617,12 @@ static const struct nla_policy cgw_policy[CGW_MAX+1] = {
 	[CGW_SRC_IF]	= { .type = NLA_U32 },
 	[CGW_DST_IF]	= { .type = NLA_U32 },
 	[CGW_FILTER]	= { .len = sizeof(struct can_filter) },
+	[CGW_LIM_HOPS]	= { .type = NLA_U8 },
 };
 
 /* check for common and gwtype specific attributes */
 static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
-			  u8 gwtype, void *gwtypeattr)
+			  u8 gwtype, void *gwtypeattr, u8 *limhops)
 {
 	struct nlattr *tb[CGW_MAX+1];
 	struct cgw_frame_mod mb;
@@ -625,6 +637,13 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	if (err < 0)
 		return err;
 
+	if (tb[CGW_LIM_HOPS]) {
+		*limhops = nla_get_u8(tb[CGW_LIM_HOPS]);
+
+		if (*limhops < 1 || *limhops > max_hops)
+			return -EINVAL;
+	}
+
 	/* check for AND/OR/XOR/SET modifications */
 
 	if (tb[CGW_MOD_AND]) {
@@ -782,6 +801,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 {
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
+	u8 limhops = 0;
 	int err = 0;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -808,7 +828,8 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 
-	err = cgw_parse_attr(nlh, &gwj->mod, CGW_TYPE_CAN_CAN, &gwj->ccgw);
+	err = cgw_parse_attr(nlh, &gwj->mod, CGW_TYPE_CAN_CAN, &gwj->ccgw,
+			     &limhops);
 	if (err < 0)
 		goto out;
 
@@ -836,6 +857,8 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (gwj->dst.dev->type != ARPHRD_CAN || gwj->dst.dev->header_ops)
 		goto put_src_dst_out;
 
+	gwj->limit_hops = limhops;
+
 	ASSERT_RTNL();
 
 	err = cgw_register_filter(gwj);
@@ -867,13 +890,14 @@ static void cgw_remove_all_jobs(void)
 	}
 }
 
-static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
+static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
 	struct cgw_job *gwj = NULL;
 	struct hlist_node *nx;
 	struct rtcanmsg *r;
 	struct cf_mod mod;
 	struct can_can_gw ccgw;
+	u8 limhops = 0;
 	int err = 0;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -890,7 +914,7 @@ static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
-	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw);
+	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
 	if (err < 0)
 		return err;
 
@@ -910,6 +934,9 @@ static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 		if (gwj->flags != r->flags)
 			continue;
 
+		if (gwj->limit_hops != limhops)
+			continue;
+
 		if (memcmp(&gwj->mod, &mod, sizeof(mod)))
 			continue;
 

