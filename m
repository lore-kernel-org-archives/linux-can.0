From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH RFC 1/2] can: Limit default size of CAN_RAW socket send queue
Date: Thu, 16 Jan 2014 20:58:20 +0100
Message-ID: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:53383 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbaAPUGz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 16 Jan 2014 15:06:55 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: yegorslists@googlemail.com, Michal Sojka <sojkam1@fel.cvut.cz>

This fixes the infamous ENOBUFS problem, which appears when an
application sends CAN frames faster than they leave the system.

Packets for sending can be queued at three places: socket, queueing
discipline and device driver. Only the socket queue is able to block
the sender; other queues are non-blocking. Since the size of the qdisc
queue was set by default to 10 packets, this queue was full much
earlier than the socket queue and this resulted in ENOBUFS error.

This patch limits the default size of the socket send queue to
approximately 3 CAN frames and increases the size of the qdisc queue
to 100 frames. This setting allows for at least 33 CAN_RAW sockets to
be used simultaneously in the system without getting ENOBUFS errors.

Note that the size of the socket queue is only approximate, because it
is counted in bytes and the realy allocated memory (skb->truesize) can
be bigger than what is reported by SKB_TRUESIZE(). For example, on my
32 bit PowerPC system, SKB_TRUESIZE() = 408, but skb->truesize = 448.

Open issues:
- Will this work with CANFD?
- What about other AF_CAN protocols?

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 drivers/net/can/dev.c | 2 +-
 net/can/raw.c         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 1870c47..a0bce83 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -492,7 +492,7 @@ static void can_setup(struct net_device *dev)
 	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
-	dev->tx_queue_len = 10;
+	dev->tx_queue_len = 100;
 
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
diff --git a/net/can/raw.c b/net/can/raw.c
index fdda5f6..4ad0bb2 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -291,6 +291,10 @@ static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
 
+	/* allow at most 3 frames to wait for transmission in socket queue */
+	sk->sk_sndbuf = 3 * SKB_TRUESIZE(sizeof(struct can_frame) +
+					 sizeof(struct can_skb_priv));
+
 	ro->bound            = 0;
 	ro->ifindex          = 0;
 
-- 
1.8.5.2

