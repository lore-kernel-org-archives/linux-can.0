From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] net: add comment for sock_efree() usage
Date: Tue, 10 Mar 2015 18:19:57 +0100
Message-ID: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:65312 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbbCJRUT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Mar 2015 13:20:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: eric.dumazet@gmail.com, alexander.h.duyck@redhat.com, Oliver Hartkopp <socketcan@hartkopp.net>

In opposite to sock_rfree() and sock_wfree() the function sock_efree() does
not need to change the sk_[rw]_mem_alloc length. Add the comment to point out
the idea for using sock_efree() in the _e_rror handler or e.g. timestamp path.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/core/sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 93c8b20..7a1eac8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1655,6 +1655,10 @@ void sock_rfree(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(sock_rfree);
 
+/*
+ * Buffer destructor for skbs that don't have sk_[rw]_mem_alloc accounting.
+ * E.g. error handler / timestamp path. Automatically called from kfree_skb.
+ */
 void sock_efree(struct sk_buff *skb)
 {
 	sock_put(skb->sk);
-- 
2.1.4

