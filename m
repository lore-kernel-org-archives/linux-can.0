From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 7/9] can: j1939: transport: j1939_cancel_active_session(): use hrtimer_try_to_cancel() instead of hrtimer_cancel()
Date: Tue, 12 Nov 2019 12:15:58 +0100
Message-ID: <20191112111600.18719-8-o.rempel@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112111600.18719-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

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
2.24.0.rc1
