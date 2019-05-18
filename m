From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] can: gw: Fix error path of cgw_module_init
Date: Sat, 18 May 2019 17:35:43 +0800
Message-ID: <20190518093543.11016-1-yuehaibing@huawei.com>
References: <80ca1430-da86-42c3-75c7-eadf91b20220@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80ca1430-da86-42c3-75c7-eadf91b20220@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

This patch add error path for cgw_module_init
to avoid possible crash if some error occurs.

Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/can/gw.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 53859346..bd21614 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1046,32 +1046,50 @@ static __init int cgw_module_init(void)
 	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=%d\n",
 		max_hops);
 
-	register_pernet_subsys(&cangw_pernet_ops);
+	ret = register_pernet_subsys(&cangw_pernet_ops);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
 	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
 				      0, 0, NULL);
-
 	if (!cgw_cache)
-		return -ENOMEM;
+		goto out_cache_create;
 
 	/* set notifier */
 	notifier.notifier_call = cgw_notifier;
-	register_netdevice_notifier(&notifier);
+	ret = register_netdevice_notifier(&notifier);
+	if (ret)
+		goto out_register_notifier;
 
 	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_GETROUTE,
 				   NULL, cgw_dump_jobs, 0);
-	if (ret) {
-		unregister_netdevice_notifier(&notifier);
-		kmem_cache_destroy(cgw_cache);
-		return -ENOBUFS;
-	}
-
-	/* Only the first call to rtnl_register_module can fail */
-	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
-			     cgw_create_job, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
-			     cgw_remove_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register1;
+
+	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
+				   cgw_create_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register2;
+	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
+				   cgw_remove_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register3;
 
 	return 0;
+
+out_rtnl_register3:
+	rtnl_unregister(PF_CAN, RTM_NEWROUTE);
+out_rtnl_register2:
+	rtnl_unregister(PF_CAN, RTM_GETROUTE);
+out_rtnl_register1:
+	unregister_netdevice_notifier(&notifier);
+out_register_notifier:
+	kmem_cache_destroy(cgw_cache);
+out_cache_create:
+	unregister_pernet_subsys(&cangw_pernet_ops);
+
+	return ret;
 }
 
 static __exit void cgw_module_exit(void)
-- 
1.8.3.1
