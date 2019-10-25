From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1] j1939: transport: make sure EOMA is send with the total message size set
Date: Fri, 25 Oct 2019 11:30:15 +0200
Message-ID: <20191025093015.24506-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

We was sending malformed EOMA with total message size set to 0. So, fix this
bug and add sanity check to the RX path.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe000ea757ea..a82097427642 100644
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
+		netdev_warn(session->priv->ndev, "%s: 0x%p: Incorrect size. Expected: %i; got: %i.\n",
+			    __func__, session, session->total_message_size,
+			    len);
+		return;
+	}
+
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
 	session->pkt.tx_acked = session->pkt.total;
@@ -1432,7 +1450,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
-	session = j1939_session_new(priv, skb, skb->len);
+	session = j1939_session_new(priv, skb, size);
 	if (!session) {
 		kfree_skb(skb);
 		return NULL;
-- 
2.23.0
