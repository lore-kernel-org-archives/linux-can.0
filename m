From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: gw: use kmem_cache_free() instead of kfree()
Date: Tue,  9 Apr 2013 10:13:35 +0200
Message-ID: <1365495215-12081-2-git-send-email-mkl@pengutronix.de>
References: <1365495215-12081-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1365495215-12081-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, davem@davemloft.net, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Memory allocated by kmem_cache_alloc() should be freed using
kmem_cache_free(), not kfree().

Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
-- 
1.8.2.rc2
