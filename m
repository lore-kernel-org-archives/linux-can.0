From: Vincent Prince <vincent.prince.fr@gmail.com>
Subject: [PATCH] net: sch_generic: Use pfifo_fast as fallback scheduler for CAN hardware
Date: Tue, 22 Oct 2019 14:47:28 +0200
Message-ID: <1571748448-11190-1-git-send-email-vincent.prince.fr@gmail.com>
References: <20190327165632.10711-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190327165632.10711-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: dave.taht@gmail.com, davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, Vincent Prince <vincent.prince.fr@gmail.com>
List-Id: linux-can.vger.kernel.org

Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com>
---
 net/sched/sch_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 77b289d..bff43de 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1008,6 +1008,8 @@ static void attach_one_default_qdisc(struct net_device *dev,
 
 	if (dev->priv_flags & IFF_NO_QUEUE)
 		ops = &noqueue_qdisc_ops;
+        else if(dev->type == ARPHRD_CAN)
+		ops = &pfifo_fast_ops;
 
 	qdisc = qdisc_create_dflt(dev_queue, ops, TC_H_ROOT, NULL);
 	if (!qdisc) {
-- 
2.7.4
