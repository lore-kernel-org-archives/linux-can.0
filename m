From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/9] can: j1939: main: j1939_ndev_to_priv(): avoid crash if can_ml_priv is NULL
Date: Wed, 13 Nov 2019 10:55:44 +0100
Message-ID: <20191113095550.26527-4-mkl@pengutronix.de>
References: <20191113095550.26527-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191113095550.26527-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, syzbot+95c8e0d9dffde15b6c5c@syzkaller.appspotmail.com
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch avoids a NULL pointer deref crash if ndev->ml_priv is NULL.

Reported-by: syzbot+95c8e0d9dffde15b6c5c@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index def2f813ffce..8dc935dc2e54 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -207,6 +207,9 @@ static inline struct j1939_priv *j1939_ndev_to_priv(struct net_device *ndev)
 {
 	struct can_ml_priv *can_ml_priv = ndev->ml_priv;
 
+	if (!can_ml_priv)
+		return NULL;
+
 	return can_ml_priv->j1939_priv;
 }
 
-- 
2.24.0
