From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 31/33] can: j1939: transport: j1939_xtp_rx_eoma_one(): Add sanity check for correct total message size
Date: Tue,  5 Nov 2019 17:32:13 +0100
Message-ID: <20191105163215.30194-32-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

We were sending malformed EOMA with total message size set to 0. This
issue has been fixed in the previous patch.

In this patch a sanity check is added to the RX path and a error message
is displayed.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 06183d6f4fb7..e5f1a56994c6 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1273,9 +1273,27 @@ j1939_xtp_rx_abort(struct j1939_priv *priv, struct sk_buff *skb,
 static void
 j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 {
+	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	const u8 *dat;
+	int len;
+
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
+	dat = skb->data;
+
+	if (skcb->addr.type == J1939_ETP)
+		len = j1939_etp_ctl_to_size(dat);
+	else
+		len = j1939_tp_ctl_to_size(dat);
+
+	if (session->total_message_size != len) {
+		netdev_warn_once(session->priv->ndev,
+				 "%s: 0x%p: Incorrect size. Expected: %i; got: %i.\n",
+				 __func__, session, session->total_message_size,
+				 len);
+	}
+
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
 	session->pkt.tx_acked = session->pkt.total;
-- 
2.24.0.rc1
