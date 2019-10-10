From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 28/29] can: j1939: fix memory leak if filters was set
Date: Thu, 10 Oct 2019 14:17:49 +0200
Message-ID: <20191010121750.27237-29-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Filters array is coped from user space and linked to the j1939 socket.
On socket release this memory was not freed.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
