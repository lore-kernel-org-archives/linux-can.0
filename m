From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: dev: let all CAN devices use pfifo_fast as default scheduler
Date: Wed, 27 Mar 2019 17:56:32 +0100
Message-ID: <20190327165632.10711-3-mkl@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190327165632.10711-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

When using fq_codel and sending raw frames over CAN, which is the common use
case, the user space thinks the package has been sent without problems, because
send() returned without an error. pfifo_fast will drop skbs, if the queue
length exceeds the maximum. But with this scheduler the skbs at the tail are
dropped, an error (-ENOBUFS) is propagated to user space. So that the user
space can slow down the package generation.

On distributions, where fq_codel is made default via CONFIG_DEFAULT_NET_SCH
during compile time, or set default during runtime with sysctl
net.core.default_qdisc (see [1]), we get a bad user experience. In my test case
with pfifo_fast, I can transfer thousands of million CAN frames without a frame
drop. On the other hand with fq_codel there is more then one lost CAN frame per
thousand frames.

This patch sets the flag IFF_FIFO_QUEUE on all CAN devices.

Cc: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d50d43d..34bcabc35127 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -646,6 +646,7 @@ static void can_setup(struct net_device *dev)
 
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
+	dev->priv_flags = IFF_FIFO_QUEUE;
 	dev->features = NETIF_F_HW_CSUM;
 }
 
-- 
2.20.1
