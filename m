From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 3/4] can: Properly fill the netlink header when responding to RTM_GETROUTE
Date: Thu,  5 Jul 2012 14:19:57 +0200
Message-ID: <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035Ab2GEMUE (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jul 2012 08:20:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK4Jk032079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:04 -0400
Received: from localhost (vpn1-4-18.ams2.redhat.com [10.36.4.18])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK30E005751
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:03 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
References: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

 - set message type to RTM_NEWROUTE
 - relate to original request by inheriting the sequence and port number.
 - set NLM_F_MULTI because it's a dump and more messages will follow

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 net/can/gw.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index a1c639c..20c36e1 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -444,11 +444,14 @@ static int cgw_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
+static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
+		       u32 pid, u32 seq, int flags)
 {
 	struct cgw_frame_mod mb;
 	struct rtcanmsg *rtcan;
-	struct nlmsghdr *nlh = nlmsg_put(skb, 0, 0, 0, sizeof(*rtcan), 0);
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
 		return -EMSGSIZE;
 
@@ -546,7 +549,8 @@ static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
 		if (idx < s_idx)
 			goto cont;
 
-		if (cgw_put_job(skb, gwj) < 0)
+		if (cgw_put_job(skb, gwj, RTM_NEWROUTE, NETLINK_CB(cb->skb).pid,
+		    cb->nlh->nlmsg_seq, NLM_F_MULTI) < 0)
 			break;
 cont:
 		idx++;
-- 
1.7.7.6

