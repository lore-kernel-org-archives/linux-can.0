From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: af_can: canfd_rcv(): replace WARN_ONCE by pr_warn_once
Date: Tue, 16 Jan 2018 19:42:15 +0100
Message-ID: <20180116184215.8456-2-mkl@pengutronix.de>
References: <20180116184215.8456-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180116184215.8456-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

If an invalid CANFD frame is received, from a driver or from a tun
interface, a Kernel warning is generated.

This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
kernel, bootet with panic_on_warn, does not panic. A printk seems to be
more appropriate here.

Reported-by: syzbot+e3b775f40babeff6e68b@syzkaller.appspotmail.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index ae835382e678..4d7f988a3130 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -738,20 +738,16 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != CANFD_MTU ||
-		      cfd->len > CANFD_MAX_DLEN,
-		      "PF_CAN: dropped non conform CAN FD skbuf: "
-		      "dev type %d, len %d, datalen %d\n",
-		      dev->type, skb->len, cfd->len))
-		goto drop;
+	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CANFD_MTU ||
+		     cfd->len > CANFD_MAX_DLEN)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuf: dev type %d, len %d, datalen %d\n",
+			     dev->type, skb->len, cfd->len);
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
-
-drop:
-	kfree_skb(skb);
-	return NET_RX_DROP;
 }
 
 /*
-- 
2.15.1
