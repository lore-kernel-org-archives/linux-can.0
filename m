From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once
Date: Thu, 18 Jan 2018 11:15:06 +0100
Message-ID: <20180118101507.17943-2-mkl@pengutronix.de>
References: <20180118101507.17943-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755557AbeARKPg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jan 2018 05:15:36 -0500
In-Reply-To: <20180118101507.17943-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>

If an invalid CAN frame is received, from a driver or from a tun
interface, a Kernel warning is generated.

This patch replaces the WARN_ONCE by a simple pr_warn_once, so that a
kernel, bootet with panic_on_warn, does not panic. A printk seems to be
more appropriate here.

Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 003b2d6d655f..ae835382e678 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -721,20 +721,16 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != CAN_MTU ||
-		      cfd->len > CAN_MAX_DLEN,
-		      "PF_CAN: dropped non conform CAN skbuf: "
-		      "dev type %d, len %d, datalen %d\n",
-		      dev->type, skb->len, cfd->len))
-		goto drop;
+	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CAN_MTU ||
+		     cfd->len > CAN_MAX_DLEN)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN skbuf: dev type %d, len %d, datalen %d\n",
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
 
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
-- 
2.15.1

