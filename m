From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 4/4] can: Remove pointless casts
Date: Thu,  5 Jul 2012 14:19:58 +0200
Message-ID: <bf8c9bfa3b54af6fcfd19ab9ab8fbfabf684a3e2.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035Ab2GEMUF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jul 2012 08:20:05 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK5kY032083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:05 -0400
Received: from localhost (vpn1-4-18.ams2.redhat.com [10.36.4.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q65CK4lf019558
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:05 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

No need to cast return value of nla_data()

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 net/can/gw.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 20c36e1..b54d5e6 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -661,8 +661,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	if (modidx) {
 
 		if (tb[CGW_CS_CRC8]) {
-			struct cgw_csum_crc8 *c = (struct cgw_csum_crc8 *)\
-				nla_data(tb[CGW_CS_CRC8]);
+			struct cgw_csum_crc8 *c = nla_data(tb[CGW_CS_CRC8]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
 						 c->result_idx);
@@ -686,8 +685,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 		}
 
 		if (tb[CGW_CS_XOR]) {
-			struct cgw_csum_xor *c = (struct cgw_csum_xor *)\
-				nla_data(tb[CGW_CS_XOR]);
+			struct cgw_csum_xor *c = nla_data(tb[CGW_CS_XOR]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
 						 c->result_idx);
-- 
1.7.7.6

