From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 3/3] can: gw: add support for CAN FD frames
Date: Thu, 10 Jan 2019 22:02:55 +0100
Message-ID: <20190110210255.4291-4-socketcan@hartkopp.net>
References: <20190110210255.4291-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190110210255.4291-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Introduce CAN FD support which needs an extension of the netlink API to pass
CAN FD type content to the kernel which has a different size to Classic CAN.
Additionally the struct canfd_frame has a new 'flags' element that can now
be modified with can-gw.

The new CGW_FLAGS_CAN_FD option flag defines whether the routing job handles
Classic CAN or CAN FD frames. This setting is very strict at reception time
and enables the new possibilities, e.g. CGW_FDMOD_* and modifying the flags
element of struct canfd_frame, only when CGW_FLAGS_CAN_FD ist set.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/gw.h |  14 ++-
 net/can/gw.c                | 233 ++++++++++++++++++++++++++++++++----
 2 files changed, 220 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index ed811bc463b5..3aea5388c8e4 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -80,6 +80,10 @@ enum {
 	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
 	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
 	CGW_MOD_UID,	/* user defined identifier for modification updates */
+	CGW_FDMOD_AND,	/* CAN FD frame modification binary AND */
+	CGW_FDMOD_OR,	/* CAN FD frame modification binary OR */
+	CGW_FDMOD_XOR,	/* CAN FD frame modification binary XOR */
+	CGW_FDMOD_SET,	/* CAN FD frame modification set alternate values */
 	__CGW_MAX
 };
 
@@ -88,6 +92,7 @@ enum {
 #define CGW_FLAGS_CAN_ECHO 0x01
 #define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
 #define CGW_FLAGS_CAN_IIF_TX_OK 0x04
+#define CGW_FLAGS_CAN_FD 0x08
 
 #define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
 
@@ -96,8 +101,9 @@ enum {
 #define CGW_MOD_DLC	0x02		/* contains the data length in bytes */
 #define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD length representation */
 #define CGW_MOD_DATA	0x04
+#define CGW_MOD_FLAGS	0x08		/* CAN FD flags */
 
-#define CGW_FRAME_MODS 3 /* ID DLC/LEN DATA */
+#define CGW_FRAME_MODS 4 /* ID DLC/LEN DATA FLAGS */
 
 #define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
 
@@ -106,7 +112,13 @@ struct cgw_frame_mod {
 	__u8 modtype;
 } __attribute__((packed));
 
+struct cgw_fdframe_mod {
+	struct canfd_frame cf;
+	__u8 modtype;
+} __attribute__((packed));
+
 #define CGW_MODATTR_LEN sizeof(struct cgw_frame_mod)
+#define CGW_FDMODATTR_LEN sizeof(struct cgw_fdframe_mod)
 
 struct cgw_csum_xor {
 	__s8 from_idx;
diff --git a/net/can/gw.c b/net/can/gw.c
index 609527b7e357..dbe7eae80dcc 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -59,7 +59,7 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#define CAN_GW_VERSION "20170425"
+#define CAN_GW_VERSION "20190105"
 #define CAN_GW_NAME "can-gw"
 
 MODULE_DESCRIPTION("PF_CAN netlink gateway");
@@ -149,6 +149,18 @@ struct cgw_job {
 	u16 flags;
 };
 
+/* make sure we get a valid CAN frame data length after manipulation */
+const u8 validate_len[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
+			   12, 12, 12, 12,			/* 9 - 12 */
+			   16, 16, 16, 16,			/* 13 - 16 */
+			   20, 20, 20, 20,			/* 17 - 20 */
+			   24, 24, 24, 24,			/* 21 - 24 */
+			   32, 32, 32, 32, 32, 32, 32, 32,	/* 25 - 32 */
+			   48, 48, 48, 48, 48, 48, 48, 48,	/* 33 - 40 */
+			   48, 48, 48, 48, 48, 48, 48, 48,	/* 41 - 48 */
+			   64, 64, 64, 64, 64, 64, 64, 64,	/* 49 - 56 */
+			   64, 64, 64, 64, 64, 64, 64, 64};	/* 57 - 64 */
+
 /* modification functions that are invoked in the hot path in can_can_gw_rcv */
 
 #define MODFUNC(func, op) static void func(struct canfd_frame *cf, \
@@ -156,17 +168,56 @@ struct cgw_job {
 
 MODFUNC(mod_and_id, cf->can_id &= mod->modframe.and.can_id)
 MODFUNC(mod_and_len, cf->len &= mod->modframe.and.len)
+MODFUNC(mod_and_flags, cf->flags &= mod->modframe.and.flags)
 MODFUNC(mod_and_data, *(u64 *)cf->data &= *(u64 *)mod->modframe.and.data)
 MODFUNC(mod_or_id, cf->can_id |= mod->modframe.or.can_id)
 MODFUNC(mod_or_len, cf->len |= mod->modframe.or.len)
+MODFUNC(mod_or_flags, cf->flags |= mod->modframe.or.flags)
 MODFUNC(mod_or_data, *(u64 *)cf->data |= *(u64 *)mod->modframe.or.data)
 MODFUNC(mod_xor_id, cf->can_id ^= mod->modframe.xor.can_id)
 MODFUNC(mod_xor_len, cf->len ^= mod->modframe.xor.len)
+MODFUNC(mod_xor_flags, cf->flags ^= mod->modframe.xor.flags)
 MODFUNC(mod_xor_data, *(u64 *)cf->data ^= *(u64 *)mod->modframe.xor.data)
 MODFUNC(mod_set_id, cf->can_id = mod->modframe.set.can_id)
 MODFUNC(mod_set_len, cf->len = mod->modframe.set.len)
+MODFUNC(mod_set_flags, cf->flags = mod->modframe.set.flags)
 MODFUNC(mod_set_data, *(u64 *)cf->data = *(u64 *)mod->modframe.set.data)
 
+static void mod_and_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for(i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) &= *(u64 *)(mod->modframe.and.data + i);
+
+	return;
+}
+
+static void mod_or_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for(i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) |= *(u64 *)(mod->modframe.or.data + i);
+
+	return;
+}
+
+static void mod_xor_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for(i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) ^= *(u64 *)(mod->modframe.xor.data + i);
+
+	return;
+}
+
+static void mod_set_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	memcpy(cf->data, mod->modframe.set.data, CANFD_MAX_DLEN);
+}
+
 static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 {
 	/*
@@ -180,10 +231,27 @@ static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 	*(u64 *)dst->data = *(u64 *)src->data;
 }
 
-static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re)
+static void canfdframecpy(struct canfd_frame *dst, struct canfd_frame *src)
+{
+	/*
+	 * Copy the struct members separately to ensure that no uninitialized
+	 * data are copied in the 2 bytes hole of the struct. This is needed
+	 * to make easy compares of the data in the struct cf_mod.
+	 */
+
+	dst->can_id = src->can_id;
+	dst->flags = src->flags;
+	dst->len = src->len;
+	memcpy(dst->data, src->data, CANFD_MAX_DLEN);
+}
+
+static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re, struct rtcanmsg *r)
 {
 	s8 dlen = CAN_MAX_DLEN;
 
+	if (r->flags & CGW_FLAGS_CAN_FD)
+		dlen = CANFD_MAX_DLEN;
+
 	/*
 	 * absolute dlc values 0 .. 7 => 0 .. 7, e.g. data [0]
 	 * relative to received dlc -1 .. -8 :
@@ -354,6 +422,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct sk_buff *nskb;
 	int modidx = 0;
 
+	/* process strictly Classic CAN or CAN FD frames */
+	if (gwj->flags & CGW_FLAGS_CAN_FD) {
+		if (skb->len != CANFD_MTU)
+			return;
+	} else {
+		if (skb->len != CAN_MTU)
+			return;
+	}
+
 	/*
 	 * Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
@@ -424,23 +501,22 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		int max_len = nskb->len - offsetof(struct canfd_frame, data);
 
 		/* dlc may have changed, make sure it fits to the CAN frame */
-		if (cf->len > max_len)
-			goto out_delete;
+		if (cf->len > max_len) {
+			/* delete frame due to misconfiguration */
+			gwj->deleted_frames++;
+			kfree_skb(nskb);
+			return;
+		}
 
-		/* check for checksum updates in classic CAN length only */
-		if (gwj->mod.csumfunc.crc8) {
-			if (cf->len > 8)
-				goto out_delete;
+		/* ensure a valid CAN (FD) frame data length */
+		cf->len = validate_len[cf->len];
 
+		/* check for checksum updates */
+		if (gwj->mod.csumfunc.crc8)
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
-		}
-
-		if (gwj->mod.csumfunc.xor) {
-			if (cf->len > 8)
-				goto out_delete;
 
+		if (gwj->mod.csumfunc.xor)
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
-		}
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -452,14 +528,6 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		gwj->dropped_frames++;
 	else
 		gwj->handled_frames++;
-
-	return;
-
- out_delete:
-	/* delete frame due to misconfiguration */
-	gwj->deleted_frames++;
-	kfree_skb(nskb);
-	return;
 }
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
@@ -543,7 +611,37 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
-	if (1) {
+	if (gwj->flags & CGW_FLAGS_CAN_FD) {
+		struct cgw_fdframe_mod mb;
+
+		if (gwj->mod.modtype.and) {
+			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.and;
+			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.or) {
+			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.or;
+			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.xor) {
+			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.xor;
+			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.set) {
+			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.set;
+			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+	} else {
 		struct cgw_frame_mod mb;
 
 		if (gwj->mod.modtype.and) {
@@ -653,6 +751,10 @@ static const struct nla_policy cgw_policy[CGW_MAX+1] = {
 	[CGW_FILTER]	= { .len = sizeof(struct can_filter) },
 	[CGW_LIM_HOPS]	= { .type = NLA_U8 },
 	[CGW_MOD_UID]	= { .type = NLA_U32 },
+	[CGW_FDMOD_AND]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_OR]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_XOR]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_SET]	= { .len = sizeof(struct cgw_fdframe_mod) },
 };
 
 /* check for common and gwtype specific attributes */
@@ -660,6 +762,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			  u8 gwtype, void *gwtypeattr, u8 *limhops)
 {
 	struct nlattr *tb[CGW_MAX+1];
+	struct rtcanmsg *r = nlmsg_data(nlh);
 	int modidx = 0;
 	int err = 0;
 
@@ -679,7 +782,85 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	}
 
 	/* check for AND/OR/XOR/SET modifications */
-	if (1) {
+	if (r->flags & CGW_FLAGS_CAN_FD) {
+		struct cgw_fdframe_mod mb;
+
+		if (tb[CGW_FDMOD_AND]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_AND], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.and, &mb.cf);
+			mod->modtype.and = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_and_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_and_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_and_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_and_fddata;
+		}
+
+		if (tb[CGW_FDMOD_OR]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_OR], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.or, &mb.cf);
+			mod->modtype.or = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_or_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_or_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_or_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_or_fddata;
+		}
+
+		if (tb[CGW_FDMOD_XOR]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_XOR], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.xor, &mb.cf);
+			mod->modtype.xor = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_xor_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_xor_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_xor_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_xor_fddata;
+		}
+
+		if (tb[CGW_FDMOD_SET]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_SET], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.set, &mb.cf);
+			mod->modtype.set = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_set_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_set_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_set_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_set_fddata;
+		}
+	} else {
 		struct cgw_frame_mod mb;
 
 		if (tb[CGW_MOD_AND]) {
@@ -754,7 +935,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			struct cgw_csum_crc8 *c = nla_data(tb[CGW_CS_CRC8]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
-						 c->result_idx);
+						 c->result_idx, r);
 			if (err)
 				return err;
 
@@ -778,7 +959,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			struct cgw_csum_xor *c = nla_data(tb[CGW_CS_XOR]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
-						 c->result_idx);
+						 c->result_idx, r);
 			if (err)
 				return err;
 
-- 
2.20.1
