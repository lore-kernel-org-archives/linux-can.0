From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: avoid unnecessary remove in can_remove_proc
Date: Mon, 30 Dec 2019 17:03:33 +0800
Message-ID: <20191230090333.20664-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

If net->can.proc_dir is null, there is no need to
do cleanup in can_remove_proc.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/can/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/proc.c b/net/can/proc.c
index e6881bf..f84e977 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -471,6 +471,9 @@ void can_init_proc(struct net *net)
  */
 void can_remove_proc(struct net *net)
 {
+	if (!net->can.proc_dir)
+		return;
+
 	if (net->can.pde_version)
 		remove_proc_entry(CAN_PROC_VERSION, net->can.proc_dir);
 
-- 
2.7.4
