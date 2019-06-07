From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net] can: purge socket error queue on sock destruct
Date: Fri,  7 Jun 2019 16:46:07 -0400
Message-ID: <20190607204607.250375-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, patrick.ohly@intel.com, Willem de Bruijn <willemb@google.com>, syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com
List-Id: linux-can.vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

CAN supports software tx timestamps as of the below commit. Purge
any queued timestamp packets on socket destroy.

Fixes: 51f31cabe3ce ("ip: support for TX timestamps on UDP and RAW sockets")
Reported-by: syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index e8fd5dc1780ae..189a6bf8f829c 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -99,6 +99,7 @@ EXPORT_SYMBOL(can_ioctl);
 static void can_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static const struct can_proto *can_get_proto(int protocol)
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
