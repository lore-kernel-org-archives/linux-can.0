From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/9] can: j1939: transport: j1939_cancel_active_session(): use hrtimer_try_to_cancel() instead of hrtimer_cancel()
Date: Wed, 13 Nov 2019 10:55:48 +0100
Message-ID: <20191113095550.26527-8-mkl@pengutronix.de>
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

This part of the code protected by lock used in the hrtimer as well.
Using hrtimer_cancel() will trigger dead lock.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index afc2adfd97e4..0c62b8fc4b20 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -2039,7 +2039,11 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		if (!sk || sk == session->sk) {
-			j1939_session_timers_cancel(session);
+			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
+				j1939_session_put(session);
+			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+				j1939_session_put(session);
+
 			session->err = ESHUTDOWN;
 			j1939_session_deactivate_locked(session);
 		}
-- 
2.24.0
