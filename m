From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] can: j1939: fix memory leak if filters was set
Date: Thu, 10 Oct 2019 12:50:31 +0200
Message-ID: <20191010105031.3507-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Filters array is coped from user space and linked to the j1939 socket.
On socket release this memory was not freed.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 5c6eabcb5df1..4d8ba701e15d 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -580,6 +580,7 @@ static int j1939_sk_release(struct socket *sock)
 		j1939_netdev_stop(priv);
 	}
 
+	kfree(jsk->filters);
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-- 
2.23.0
