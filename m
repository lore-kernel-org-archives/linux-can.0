From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 28/33] can: j1939: fix resource leak of skb on error return paths
Date: Tue,  5 Nov 2019 17:32:10 +0100
Message-ID: <20191105163215.30194-29-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Colin Ian King <colin.king@canonical.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error return paths do not free skb and this results in a
memory leak. Fix this by freeing them before the return.

Addresses-Coverity: ("Resource leak")
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 37c1040bcb9c..5c6eabcb5df1 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -909,8 +909,10 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	memset(serr, 0, sizeof(*serr));
 	switch (type) {
 	case J1939_ERRQUEUE_ACK:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK))
+		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK)) {
+			kfree_skb(skb);
 			return;
+		}
 
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
@@ -918,8 +920,10 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		state = "ACK";
 		break;
 	case J1939_ERRQUEUE_SCHED:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED))
+		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED)) {
+			kfree_skb(skb);
 			return;
+		}
 
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
-- 
2.24.0.rc1
