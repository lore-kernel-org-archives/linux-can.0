From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 1/4] can: Don't bump nlmsg_len manually
Date: Thu,  5 Jul 2012 14:19:55 +0200
Message-ID: <39152af25ab31194fe281c1bf9d96c8473ee7477.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2GEMUB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jul 2012 08:20:01 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK1vE019434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:01 -0400
Received: from localhost (vpn1-4-18.ams2.redhat.com [10.36.4.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q65CK03Z019545
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:01 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

nlmsg_end() will take care of this when we finalize the message.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 net/can/gw.c |   27 +--------------------------
 1 files changed, 1 insertions(+), 26 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index b41acf2..a3ff980 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -462,15 +462,11 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 	if (gwj->handled_frames) {
 		if (nla_put_u32(skb, CGW_HANDLED, gwj->handled_frames) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(u32));
 	}
 
 	if (gwj->dropped_frames) {
 		if (nla_put_u32(skb, CGW_DROPPED, gwj->dropped_frames) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(u32));
 	}
 
 	/* check non default settings of attributes */
@@ -480,8 +476,6 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 		mb.modtype = gwj->mod.modtype.and;
 		if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(mb));
 	}
 
 	if (gwj->mod.modtype.or) {
@@ -489,8 +483,6 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 		mb.modtype = gwj->mod.modtype.or;
 		if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(mb));
 	}
 
 	if (gwj->mod.modtype.xor) {
@@ -498,8 +490,6 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 		mb.modtype = gwj->mod.modtype.xor;
 		if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(mb));
 	}
 
 	if (gwj->mod.modtype.set) {
@@ -507,26 +497,18 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 		mb.modtype = gwj->mod.modtype.set;
 		if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(mb));
 	}
 
 	if (gwj->mod.csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
 			    &gwj->mod.csum.crc8) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + \
-				NLA_ALIGN(CGW_CS_CRC8_LEN);
 	}
 
 	if (gwj->mod.csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
 			    &gwj->mod.csum.xor) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + \
-				NLA_ALIGN(CGW_CS_XOR_LEN);
 	}
 
 	if (gwj->gwtype == CGW_TYPE_CAN_CAN) {
@@ -535,23 +517,16 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
 			if (nla_put(skb, CGW_FILTER, sizeof(struct can_filter),
 				    &gwj->ccgw.filter) < 0)
 				goto cancel;
-			else
-				nlh->nlmsg_len += NLA_HDRLEN +
-					NLA_ALIGN(sizeof(struct can_filter));
 		}
 
 		if (nla_put_u32(skb, CGW_SRC_IF, gwj->ccgw.src_idx) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(u32));
 
 		if (nla_put_u32(skb, CGW_DST_IF, gwj->ccgw.dst_idx) < 0)
 			goto cancel;
-		else
-			nlh->nlmsg_len += NLA_HDRLEN + NLA_ALIGN(sizeof(u32));
 	}
 
-	return skb->len;
+	return nlmsg_end(skb, nlh);
 
 cancel:
 	nlmsg_cancel(skb, nlh);
-- 
1.7.7.6

