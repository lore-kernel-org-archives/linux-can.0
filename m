From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] can: j1939: make sure socket is held as long as session exists
Date: Wed, 13 Nov 2019 10:55:47 +0100
Message-ID: <20191113095550.26527-7-mkl@pengutronix.de>
References: <20191113095550.26527-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191113095550.26527-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

We link the socket to the session to be able provide socket specific
notifications. For example messages over error queue.

We need to keep the socket held, while we have a reference to it.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ecdedfc0b10c..afc2adfd97e4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -255,6 +255,7 @@ static void __j1939_session_drop(struct j1939_session *session)
 		return;
 
 	j1939_sock_pending_del(session->sk);
+	sock_put(session->sk);
 }
 
 static void j1939_session_destroy(struct j1939_session *session)
@@ -1875,6 +1876,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 
 	/* skb is recounted in j1939_session_new() */
+	sock_hold(skb->sk);
 	session->sk = skb->sk;
 	session->transmission = true;
 	session->pkt.total = (size + 6) / 7;
-- 
2.24.0
