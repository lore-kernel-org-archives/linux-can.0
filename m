From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 4/4] can-gw: indicate and count deleted frames due to misconfiguration
Date: Thu, 17 Jan 2013 18:43:46 +0100
Message-ID: <50F83852.6040809@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:27569 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab3AQRns (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 12:43:48 -0500
Received: from [192.168.178.31] (p5B0B0333.dip0.t-ipconnect.de [91.11.3.51])
	by smtp.strato.de (josoe mo48) (RZmta 31.12 DYNA|AUTH)
	with ESMTPA id R07f70p0HG6qAx for <linux-can@vger.kernel.org>;
	Thu, 17 Jan 2013 18:43:46 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From 0cb44d2bda7d3aeb96ce45eb7ee24a139bf40f78 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 17 Jan 2013 07:38:24 +0100
Subject: [PATCH 4/4] can-gw: indicate and count deleted frames due to misconfiguration

Add a statistic counter to detect deleted frames due to misconfiguration with
a new read-only CGW_DELETED netlink attribute for the CAN gateway.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/gw.h |    1 +
 net/can/gw.c                |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 0505c7f..ae07bec 100644
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
index 81f4b49..e12666e 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -131,6 +131,7 @@ struct cgw_job {
 	struct rcu_head rcu;
 	u32 handled_frames;
 	u32 dropped_frames;
+	u32 deleted_frames;
 	struct cf_mod mod;
 	union {
 		/* CAN frame data source */
@@ -367,8 +368,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
 
-	if (cgw_hops(skb) >= max_hops)
+	if (cgw_hops(skb) >= max_hops) {
+		/* indicate deleted frames due to misconfiguration */
+		gwj->deleted_frames++;
 		return;
+	}
 
 	if (!(gwj->dst.dev->flags & IFF_UP)) {
 		gwj->dropped_frames++;
@@ -500,6 +504,11 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	if (gwj->deleted_frames) {
+		if (nla_put_u32(skb, CGW_DELETED, gwj->deleted_frames) < 0)
+			goto cancel;
+	}
+
 	/* check non default settings of attributes */
 
 	if (gwj->mod.modtype.and) {
@@ -799,6 +808,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
+	gwj->deleted_frames = 0;
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 
-- 
1.7.10.4

