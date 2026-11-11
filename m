Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378552;
	b=YuQo/o7tV1aBnkX+86s7AJ26cHXsWF5srPnJef9y2BMAOvRf0r5iJyawYFr+FgAhTL1A
	 NZHz/FtuaXKMOSPX09/fpDDXb331VDlQZK8smjAE3WkF5U2Z6fz0HxzA5MFXZbmGRT03v
	 rCD9h419f+mvz06Nsw5KSYhQ86QV69JflA0xbhGivRiaC/opswGCHcSHL9DMeGqjVo5D8
	 Agv4xtI1WxAxnkoiVsZ+NF+he/Fh2IFSHdRqw1hbxmaAtUBDzlnV6Ijhw4zZMej6C/YCs
	 jmmgkwxNlVnoRY9l3txE8Tr1bPxTULXLmL5kY+2KrlKYDSFQp6v1eROzvwIkjlqf9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378552;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eJz7atVcjox5iJ5MMjd33M3oJPbkBzC+EXdgItO6XeI=;
	b=DUJ2VIo5bmCpfXAp/ENDj+KhduU+x+dYVIr4fDWIodBg1t/uruW9FHq7cbeZ6XUy/1Qp
	 w79qwMsnAlC+3zrKbgFPRYsZIMz/XRNZ8L9AOD/wHpcj9ToUtDFlEGaK+UU7SOw0j53Ii
	 eZwlvO8FoADZexZgQ7XaE6wuY2XAm7TJdEw6u6hBCDJlfnYMeOBaBZd3sJsu4Urt8GSM8
	 bg1PuWB7Y0EZjUwZYuhaY7zE0xY2nczOb+sJAduvmPicTEpC8JCT2+epuIoa1wmZeFoCz
	 5Un6pbYw+N2XQ2V/x2UC+peooHi6Rsnrq2v4C8M2ebxQEnR1j+U5hAWsmtzfF34Bwsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=L4YQsXmA;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB33606A31C;
	Wed, 11 Nov 2026 06:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=L4YQsXmA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=L4YQsXmAJ1JE3lbLNOSLdSu8b5HhIDSXakNh7oxnSKaAt/yrNsh9ozW8FOTdyZ4BSZ7Zvp5KL47uD
	 tXITVote5NrH2Wx69Korr5+DpOZ2ULsms/wrue219n+R2swhVorPzbqA2dcnbcrUrO6hodWpDO/siE
	 Cms1WYuTW8bXr0o8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af40b35d5d-74ec6;
	Wed, 11 Nov 2026 14:29:09 +0800 (CST)
X-RM-TRANSID:2ee86af40b35d5d-74ec6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af40b3360f-d0794;
	Wed, 11 Nov 2026 14:29:09 +0800 (CST)
X-RM-TRANSID:2ee36af40b3360f-d0794
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a6205fafcbfe69a5fd67@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] can: gw: avoid losing statistics updates on concurrent receive
Date: Wed, 11 Nov 2026 14:29:07 +0800
Message-ID: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_can_gw_rcv() can run on multiple CPUs for the same gateway job. RCU
protects the job's lifetime, but does not serialize its frame counters.
Concurrent plain increments can lose updates, and netlink dumps race
with the counter updates as well.

Use atomic counters for handled, dropped and deleted frames. Read each
counter once into a u32 for the netlink dump, preserving the existing
32-bit attributes and their wraparound behavior.

Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 net/can/gw.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 8a5327d8a00e..a5233b4606da 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -40,6 +40,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -129,9 +130,9 @@ struct can_can_gw {
 struct cgw_job {
 	struct hlist_node list;
 	struct rcu_head rcu;
-	u32 handled_frames;
-	u32 dropped_frames;
-	u32 deleted_frames;
+	atomic_t handled_frames;
+	atomic_t dropped_frames;
+	atomic_t deleted_frames;
 	struct cf_mod __rcu *cf_mod;
 	union {
 		/* CAN frame data source */
@@ -484,12 +485,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 */
 	if (csx->can_gw_hops >= max_hops) {
 		/* indicate deleted frames due to misconfiguration */
-		gwj->deleted_frames++;
+		atomic_inc(&gwj->deleted_frames);
 		return;
 	}
 
 	if (!(gwj->dst.dev->flags & IFF_UP)) {
-		gwj->dropped_frames++;
+		atomic_inc(&gwj->dropped_frames);
 		return;
 	}
 
@@ -510,7 +511,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		nskb = skb_clone(skb, GFP_ATOMIC);
 
 	if (!nskb) {
-		gwj->dropped_frames++;
+		atomic_inc(&gwj->dropped_frames);
 		return;
 	}
 
@@ -521,7 +522,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	ncsx = skb_ext_add(nskb, SKB_EXT_CAN);
 	if (!ncsx) {
 		kfree_skb(nskb);
-		gwj->dropped_frames++;
+		atomic_inc(&gwj->dropped_frames);
 		return;
 	}
 
@@ -552,7 +553,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		/* dlc may have changed, make sure it fits to the CAN frame */
 		if (cf->len > max_len) {
 			/* delete frame due to misconfiguration */
-			gwj->deleted_frames++;
+			atomic_inc(&gwj->deleted_frames);
 			kfree_skb(nskb);
 			return;
 		}
@@ -571,9 +572,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* send to netdevice */
 	if (can_send(nskb, gwj->flags & CGW_FLAGS_CAN_ECHO))
-		gwj->dropped_frames++;
+		atomic_inc(&gwj->dropped_frames);
 	else
-		gwj->handled_frames++;
+		atomic_inc(&gwj->handled_frames);
 }
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
@@ -640,6 +641,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
 	struct cf_mod *mod;
+	u32 handled, dropped, deleted;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -652,18 +654,21 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 
 	/* add statistics if available */
 
-	if (gwj->handled_frames) {
-		if (nla_put_u32(skb, CGW_HANDLED, gwj->handled_frames) < 0)
+	handled = atomic_read(&gwj->handled_frames);
+	if (handled) {
+		if (nla_put_u32(skb, CGW_HANDLED, handled) < 0)
 			goto cancel;
 	}
 
-	if (gwj->dropped_frames) {
-		if (nla_put_u32(skb, CGW_DROPPED, gwj->dropped_frames) < 0)
+	dropped = atomic_read(&gwj->dropped_frames);
+	if (dropped) {
+		if (nla_put_u32(skb, CGW_DROPPED, dropped) < 0)
 			goto cancel;
 	}
 
-	if (gwj->deleted_frames) {
-		if (nla_put_u32(skb, CGW_DELETED, gwj->deleted_frames) < 0)
+	deleted = atomic_read(&gwj->deleted_frames);
+	if (deleted) {
+		if (nla_put_u32(skb, CGW_DELETED, deleted) < 0)
 			goto cancel;
 	}
 
@@ -1146,9 +1151,9 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 		goto out_free_cf;
 	}
 
-	gwj->handled_frames = 0;
-	gwj->dropped_frames = 0;
-	gwj->deleted_frames = 0;
+	atomic_set(&gwj->handled_frames, 0);
+	atomic_set(&gwj->dropped_frames, 0);
+	atomic_set(&gwj->deleted_frames, 0);
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 	gwj->limit_hops = limhops;
-- 
2.51.0


