From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] can: gw: use kmem_cache_free() instead of kfree()
Date: Tue, 9 Apr 2013 14:16:04 +0800
Message-ID: <CAPgLHd9eAfwJMJ9P5RqOKNP5kq87y61V7CTw2J--Ld8uHT0RrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:53295 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759044Ab3DIGQG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Apr 2013 02:16:06 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, davem@davemloft.net
Cc: yongjun_wei@trendmicro.com.cn, linux-can@vger.kernel.org, netdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

memory allocated by kmem_cache_alloc() should be freed using
kmem_cache_free(), not kfree().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 net/can/gw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 2d117dc..117814a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -466,7 +466,7 @@ static int cgw_notifier(struct notifier_block *nb,
 			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
 				hlist_del(&gwj->list);
 				cgw_unregister_filter(gwj);
-				kfree(gwj);
+				kmem_cache_free(cgw_cache, gwj);
 			}
 		}
 	}
@@ -864,7 +864,7 @@ static void cgw_remove_all_jobs(void)
 	hlist_for_each_entry_safe(gwj, nx, &cgw_list, list) {
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(gwj);
-		kfree(gwj);
+		kmem_cache_free(cgw_cache, gwj);
 	}
 }
 
@@ -920,7 +920,7 @@ static int cgw_remove_job(struct sk_buff *skb,  struct nlmsghdr *nlh, void *arg)
 
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(gwj);
-		kfree(gwj);
+		kmem_cache_free(cgw_cache, gwj);
 		err = 0;
 		break;
 	}

