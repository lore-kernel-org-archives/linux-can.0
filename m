From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/14] can: raw: raw_bind: bail out if can_family is not AF_CAN
Date: Wed,  2 Aug 2017 19:44:30 +0200
Message-ID: <20170802174434.4689-11-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44835 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752518AbdHBRon (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:43 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

Until now CAN raw's bind() doesn't check if the can_familiy in the
struct sockaddr_can is set to AF_CAN. This patch adds the missing check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/raw.c b/net/can/raw.c
index 80a1545bf51a..014874b11def 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -399,6 +399,8 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 	if (len < sizeof(*addr))
 		return -EINVAL;
+	if (addr->can_family != AF_CAN)
+		return -EINVAL;
 
 	lock_sock(sk);
 
-- 
2.13.2

