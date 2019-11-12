From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 2/9] can: j1939: move j1939_priv_put() into sk_destruct callback
Date: Tue, 12 Nov 2019 12:15:53 +0100
Message-ID: <20191112111600.18719-3-o.rempel@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112111600.18719-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This patch delays the j1939_priv_put() until the socket is destroyed via
the sk_destruct callback, to avoid use-after-free problems.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 4d8ba701e15d..aee94b09ef08 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -78,7 +78,6 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
 	jsk->state |= J1939_SOCK_BOUND;
 	j1939_priv_get(priv);
-	jsk->priv = priv;
 
 	spin_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
@@ -91,7 +90,6 @@ static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 	list_del_init(&jsk->list);
 	spin_unlock_bh(&priv->j1939_socks_lock);
 
-	jsk->priv = NULL;
 	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
 }
@@ -349,6 +347,34 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	spin_unlock_bh(&priv->j1939_socks_lock);
 }
 
+static void j1939_sk_sock_destruct(struct sock *sk)
+{
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	/* This function will be call by the generic networking code, when then
+	 * the socket is ultimately closed (sk->sk_destruct).
+	 *
+	 * The race between
+	 * - processing a received CAN frame
+	 *   (can_receive -> j1939_can_recv)
+	 *   and accessing j1939_priv
+	 * ... and ...
+	 * - closing a socket
+	 *   (j1939_can_rx_unregister -> can_rx_unregister)
+	 *   and calling the final j1939_priv_put()
+	 *
+	 * is avoided by calling the final j1939_priv_put() from this
+	 * RCU deferred cleanup call.
+	 */
+	if (jsk->priv) {
+		j1939_priv_put(jsk->priv);
+		jsk->priv = NULL;
+	}
+
+	/* call generic CAN sock destruct */
+	can_sock_destruct(sk);
+}
+
 static int j1939_sk_init(struct sock *sk)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
@@ -371,6 +397,7 @@ static int j1939_sk_init(struct sock *sk)
 	atomic_set(&jsk->skb_pending, 0);
 	spin_lock_init(&jsk->sk_session_queue_lock);
 	INIT_LIST_HEAD(&jsk->sk_session_queue);
+	sk->sk_destruct = j1939_sk_sock_destruct;
 
 	return 0;
 }
@@ -443,6 +470,12 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		}
 
 		jsk->ifindex = addr->can_ifindex;
+
+		/* the corresponding j1939_priv_put() is called via
+		 * sk->sk_destruct, which points to j1939_sk_sock_destruct()
+		 */
+		j1939_priv_get(priv);
+		jsk->priv = priv;
 	}
 
 	/* set default transmit pgn */
-- 
2.24.0.rc1
