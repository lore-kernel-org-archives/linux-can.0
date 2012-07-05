From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 2/4] can: Use nla_policy to validate netlink attributes
Date: Thu,  5 Jul 2012 14:19:56 +0200
Message-ID: <37037b761cf14a1923f0dff794a0b1de45757d6e.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab2GEMUD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jul 2012 08:20:03 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK2m5030870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:03 -0400
Received: from localhost (vpn1-4-18.ams2.redhat.com [10.36.4.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q65CK1jm019551
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:02 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Also use nla_get_u32() instead of nla_memcpy() to access u32 attribtues.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 net/can/gw.c |   47 +++++++++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index a3ff980..a1c639c 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -558,6 +558,18 @@ cont:
 	return skb->len;
 }
 
+static const struct nla_policy cgw_policy[CGW_MAX+1] = {
+	[CGW_MOD_AND]	= { .len = sizeof(struct cgw_frame_mod) },
+	[CGW_MOD_OR]	= { .len = sizeof(struct cgw_frame_mod) },
+	[CGW_MOD_XOR]	= { .len = sizeof(struct cgw_frame_mod) },
+	[CGW_MOD_SET]	= { .len = sizeof(struct cgw_frame_mod) },
+	[CGW_CS_XOR]	= { .len = sizeof(struct cgw_csum_xor) },
+	[CGW_CS_CRC8]	= { .len = sizeof(struct cgw_csum_crc8) },
+	[CGW_SRC_IF]	= { .type = NLA_U32 },
+	[CGW_DST_IF]	= { .type = NLA_U32 },
+	[CGW_FILTER]	= { .len = sizeof(struct can_filter) },
+};
+
 /* check for common and gwtype specific attributes */
 static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			  u8 gwtype, void *gwtypeattr)
@@ -570,14 +582,14 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	/* initialize modification & checksum data space */
 	memset(mod, 0, sizeof(*mod));
 
-	err = nlmsg_parse(nlh, sizeof(struct rtcanmsg), tb, CGW_MAX, NULL);
+	err = nlmsg_parse(nlh, sizeof(struct rtcanmsg), tb, CGW_MAX,
+			  cgw_policy);
 	if (err < 0)
 		return err;
 
 	/* check for AND/OR/XOR/SET modifications */
 
-	if (tb[CGW_MOD_AND] &&
-	    nla_len(tb[CGW_MOD_AND]) == CGW_MODATTR_LEN) {
+	if (tb[CGW_MOD_AND]) {
 		nla_memcpy(&mb, tb[CGW_MOD_AND], CGW_MODATTR_LEN);
 
 		canframecpy(&mod->modframe.and, &mb.cf);
@@ -593,8 +605,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modfunc[modidx++] = mod_and_data;
 	}
 
-	if (tb[CGW_MOD_OR] &&
-	    nla_len(tb[CGW_MOD_OR]) == CGW_MODATTR_LEN) {
+	if (tb[CGW_MOD_OR]) {
 		nla_memcpy(&mb, tb[CGW_MOD_OR], CGW_MODATTR_LEN);
 
 		canframecpy(&mod->modframe.or, &mb.cf);
@@ -610,8 +621,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modfunc[modidx++] = mod_or_data;
 	}
 
-	if (tb[CGW_MOD_XOR] &&
-	    nla_len(tb[CGW_MOD_XOR]) == CGW_MODATTR_LEN) {
+	if (tb[CGW_MOD_XOR]) {
 		nla_memcpy(&mb, tb[CGW_MOD_XOR], CGW_MODATTR_LEN);
 
 		canframecpy(&mod->modframe.xor, &mb.cf);
@@ -627,8 +637,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			mod->modfunc[modidx++] = mod_xor_data;
 	}
 
-	if (tb[CGW_MOD_SET] &&
-	    nla_len(tb[CGW_MOD_SET]) == CGW_MODATTR_LEN) {
+	if (tb[CGW_MOD_SET]) {
 		nla_memcpy(&mb, tb[CGW_MOD_SET], CGW_MODATTR_LEN);
 
 		canframecpy(&mod->modframe.set, &mb.cf);
@@ -647,9 +656,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	/* check for checksum operations after CAN frame modifications */
 	if (modidx) {
 
-		if (tb[CGW_CS_CRC8] &&
-		    nla_len(tb[CGW_CS_CRC8]) == CGW_CS_CRC8_LEN) {
-
+		if (tb[CGW_CS_CRC8]) {
 			struct cgw_csum_crc8 *c = (struct cgw_csum_crc8 *)\
 				nla_data(tb[CGW_CS_CRC8]);
 
@@ -674,9 +681,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 				mod->csumfunc.crc8 = cgw_csum_crc8_neg;
 		}
 
-		if (tb[CGW_CS_XOR] &&
-		    nla_len(tb[CGW_CS_XOR]) == CGW_CS_XOR_LEN) {
-
+		if (tb[CGW_CS_XOR]) {
 			struct cgw_csum_xor *c = (struct cgw_csum_xor *)\
 				nla_data(tb[CGW_CS_XOR]);
 
@@ -710,8 +715,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 		memset(ccgw, 0, sizeof(*ccgw));
 
 		/* check for can_filter in attributes */
-		if (tb[CGW_FILTER] &&
-		    nla_len(tb[CGW_FILTER]) == sizeof(struct can_filter))
+		if (tb[CGW_FILTER])
 			nla_memcpy(&ccgw->filter, tb[CGW_FILTER],
 				   sizeof(struct can_filter));
 
@@ -721,13 +725,8 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 		if (!tb[CGW_SRC_IF] || !tb[CGW_DST_IF])
 			return err;
 
-		if (nla_len(tb[CGW_SRC_IF]) == sizeof(u32))
-			nla_memcpy(&ccgw->src_idx, tb[CGW_SRC_IF],
-				   sizeof(u32));
-
-		if (nla_len(tb[CGW_DST_IF]) == sizeof(u32))
-			nla_memcpy(&ccgw->dst_idx, tb[CGW_DST_IF],
-				   sizeof(u32));
+		ccgw->src_idx = nla_get_u32(tb[CGW_SRC_IF]);
+		ccgw->dst_idx = nla_get_u32(tb[CGW_DST_IF]);
 
 		/* both indices set to 0 for flushing all routing entries */
 		if (!ccgw->src_idx && !ccgw->dst_idx)
-- 
1.7.7.6

