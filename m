From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] can: Propagate SO_PRIORITY of raw sockets to skbs
Date: Fri, 24 Jan 2014 13:17:37 +0100
Message-ID: <1390565857-10417-1-git-send-email-sojkam1@fel.cvut.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:36140 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbaAXMSD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Jan 2014 07:18:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, lisovy@gmail.com, Michal Sojka <sojkam1@fel.cvut.cz>

From: Rostislav Lisovy <lisovy@gmail.com>

This allows controlling certain queueing disciplines by setting the
socket's SO_PRIORITY option.

For example, with the default pfifo_fast queueing discipline, which
provides three priorities, socket priority TC_PRIO_CONTROL means
higher than default and TC_PRIO_BULK means lower than default.

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 net/can/raw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/raw.c b/net/can/raw.c
index 641e1c8..01c5fbf 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -716,6 +716,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	skb->dev = dev;
 	skb->sk  = sk;
+	skb->priority = sk->sk_priority;
 
 	err = can_send(skb, ro->loopback);
 
-- 
1.8.5.2

