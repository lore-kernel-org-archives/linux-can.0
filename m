From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/9] can: janz-ican3: drop invalid skbs
Date: Fri, 20 Jul 2012 13:11:44 +0200
Message-ID: <1342782709-4868-5-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42085 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab2GTLLz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:55 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The commit which added the janz-ican3 driver and commit
3ccd4c61 "can: Unify droping of invalid tx skbs and netdev stats" were
committed into mainline Linux during the same merge window.

Therefore, the addition of this code to the janz-ican3 driver was
forgotten. This patch adds the expected code.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index f41623d..754b803 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1420,6 +1420,9 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	void __iomem *desc_addr;
 	unsigned long flags;
 
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
 	spin_lock_irqsave(&mod->lock, flags);
 
 	/* check that we can actually transmit */
-- 
1.7.10

