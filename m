From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 30/33] can: j1939: transport: j1939_session_fresh_new(): make sure EOMA is send with the total message size set
Date: Tue,  5 Nov 2019 17:32:12 +0100
Message-ID: <20191105163215.30194-31-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

We were sending malformed EOMA messageswith total message size set to 0.

This patch fixes the bug.

Reported-by: https://github.com/linux-can/can-utils/issues/159
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe000ea757ea..06183d6f4fb7 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1432,7 +1432,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
-	session = j1939_session_new(priv, skb, skb->len);
+	session = j1939_session_new(priv, skb, size);
 	if (!session) {
 		kfree_skb(skb);
 		return NULL;
-- 
2.24.0.rc1
