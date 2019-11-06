From: Jaroslav Beran <jara.beran@gmail.com>
Subject: [PATCH] can: return error from can_send() in BUS-OFF state
Date: Wed,  6 Nov 2019 23:03:02 +0100
Message-ID: <20191106220302.27698-1-jara.beran@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaroslav Beran <jara.beran@gmail.com>
List-Id: linux-can.vger.kernel.org

When a CAN node reaches BUS-OFF state, its netdev state
is set to __LINK_STATE_NOCARRIER and qdisc ->enqueue() starts
dropping frames and returning NET_XMIT_CN that is turned to 0
by net_xmit_errno(). So can_send() returns success to a sender
even if his frame is lost.

As this behavior is inappropriate for a node in BUS-OFF state,
this patch adds a check for no-carrier condition and returns
-ENETUNREACH in such case.

Signed-off-by: Jaroslav Beran <jara.beran@gmail.com>
---
 net/can/af_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 5518a7d9eed9..68c56241733b 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -189,6 +189,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  * Return:
  *  0 on success
  *  -ENETDOWN when the selected interface is down
+ *  -ENETUNREACH when the node is in BUS-OFF state
  *  -ENOBUFS on full driver queue (see net_xmit_errno())
  *  -ENOMEM when local loopback failed at calling skb_clone()
  *  -EPERM when trying to send on a non-CAN interface
@@ -233,6 +234,11 @@ int can_send(struct sk_buff *skb, int loop)
 		goto inval_skb;
 	}
 
+	if (unlikely(!netif_carrier_ok(skb->dev))) {
+		err = -ENETUNREACH;
+		goto inval_skb;
+	}
+
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	skb_reset_mac_header(skb);
-- 
2.23.0
