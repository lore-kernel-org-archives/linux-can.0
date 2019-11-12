From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 3/9] can: j1939: main: j1939_ndev_to_priv(): avoid crash if can_ml_priv is NULL
Date: Tue, 12 Nov 2019 12:15:54 +0100
Message-ID: <20191112111600.18719-4-o.rempel@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112111600.18719-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, syzbot+95c8e0d9dffde15b6c5c@syzkaller.appspotmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

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
2.24.0.rc1
