From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: j1939: j1939_can_recv(): add priv refcounting
Date: Wed, 13 Nov 2019 10:55:49 +0100
Message-ID: <20191113095550.26527-9-mkl@pengutronix.de>
References: <20191113095550.26527-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191113095550.26527-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com, syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com, syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

j1939_can_recv() can be called in parallel with socket release. In this
case sk_release and sk_destruct can be done earlier than
j1939_can_recv() is processed.

Reported-by: syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com
Reported-by: syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com
Reported-by: syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 8dc935dc2e54..2afcf27c72c8 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -51,6 +51,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	if (!skb)
 		return;
 
+	j1939_priv_get(priv);
 	can_skb_set_owner(skb, iskb->sk);
 
 	/* get a pointer to the header of the skb
@@ -104,6 +105,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	j1939_simple_recv(priv, skb);
 	j1939_sk_recv(priv, skb);
  done:
+	j1939_priv_put(priv);
 	kfree_skb(skb);
 }
 
-- 
2.24.0
