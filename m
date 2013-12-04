From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: gw: remove obsolete checks
Date: Wed, 04 Dec 2013 19:52:36 +0100
Message-ID: <529F79F4.3060107@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:50576 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010Ab3LDSwi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Dec 2013 13:52:38 -0500
Received: from [192.168.178.64] (p5B0B100E.dip0.t-ipconnect.de [91.11.16.14])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (TLSv1:DHE-RSA-AES256-SHA encrypted) ESMTPSA id 007be2pB4IqaPqy
	for <linux-can@vger.kernel.org>; Wed, 4 Dec 2013 19:52:36 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

In commit be286bafe1f4069094865264f29805854c5788bf ("can: gw: add a variable
limit for CAN frame routings") the detection of the frame routing has been
changed. The former solution required dev->header_ops to be unused (== NULL).

I missed to remove the obsolete checks in the original commit - so here it is.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/net/can/gw.c b/net/can/gw.c
index 3f9b0f3..88c8a39 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -844,8 +844,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (!gwj->src.dev)
 		goto out;
 
-	/* check for CAN netdev not using header_ops - see gw_rcv() */
-	if (gwj->src.dev->type != ARPHRD_CAN || gwj->src.dev->header_ops)
+	if (gwj->src.dev->type != ARPHRD_CAN)
 		goto put_src_out;
 
 	gwj->dst.dev = dev_get_by_index(&init_net, gwj->ccgw.dst_idx);
@@ -853,8 +852,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (!gwj->dst.dev)
 		goto put_src_out;
 
-	/* check for CAN netdev not using header_ops - see gw_rcv() */
-	if (gwj->dst.dev->type != ARPHRD_CAN || gwj->dst.dev->header_ops)
+	if (gwj->dst.dev->type != ARPHRD_CAN)
 		goto put_src_dst_out;
 
 	gwj->limit_hops = limhops;

