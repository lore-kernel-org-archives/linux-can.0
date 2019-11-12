From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 9/9] can: j1939: warn if resources are still linked on destroy
Date: Tue, 12 Nov 2019 12:16:00 +0100
Message-ID: <20191112111600.18719-10-o.rempel@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112111600.18719-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

j1939_session_destroy() and __j1939_priv_release() should be called only
if session, ecu or socket are not linked or used by any one else. If at
least one of these resources is linked, then the reference counting is
broken somewhere.

This warning will be triggered before KASAN will do, and will make it
easier to debug initial issue. This works on platforms without KASAN
support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c      | 4 ++++
 net/can/j1939/transport.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 2afcf27c72c8..137054bff9ec 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -152,6 +152,10 @@ static void __j1939_priv_release(struct kref *kref)
 
 	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
 
+	WARN_ON_ONCE(!list_empty(&priv->active_session_list));
+	WARN_ON_ONCE(!list_empty(&priv->ecus));
+	WARN_ON_ONCE(!list_empty(&priv->j1939_socks));
+
 	dev_put(ndev);
 	kfree(priv);
 }
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0c62b8fc4b20..9f99af5b0b11 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -267,6 +267,9 @@ static void j1939_session_destroy(struct j1939_session *session)
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
+	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
+
 	skb_queue_purge(&session->skb_queue);
 	__j1939_session_drop(session);
 	j1939_priv_put(session->priv);
-- 
2.24.0.rc1
