From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/20] can: raw: check for CAN FD capable netdev in raw_sendmsg()
Date: Mon, 12 Nov 2018 12:57:09 +0100
Message-ID: <20181112115728.18331-2-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

When the socket is CAN FD enabled it can handle CAN FD frame
transmissions.  Add an additional check in raw_sendmsg() as a CAN2.0 CAN
driver (non CAN FD) should never see a CAN FD frame. Due to the commonly
used can_dropped_invalid_skb() function the CAN 2.0 driver would drop
that CAN FD frame anyway - but with this patch the user gets a proper
-EINVAL return code.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 1051eee82581..3aab7664933f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -745,18 +745,19 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	} else
 		ifindex = ro->ifindex;
 
-	if (ro->fd_frames) {
+	dev = dev_get_by_index(sock_net(sk), ifindex);
+	if (!dev)
+		return -ENXIO;
+
+	err = -EINVAL;
+	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
 		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	} else {
 		if (unlikely(size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	}
 
-	dev = dev_get_by_index(sock_net(sk), ifindex);
-	if (!dev)
-		return -ENXIO;
-
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
-- 
2.19.1
