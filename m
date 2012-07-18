From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 2/6] can: janz-ican3: drop invalid skbs
Date: Wed, 18 Jul 2012 15:33:14 -0700
Message-ID: <1342650798-2991-3-git-send-email-iws@ovro.caltech.edu>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:50095 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2GRWdW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 18:33:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 81B2F21FA4
	for <linux-can@vger.kernel.org>; Wed, 18 Jul 2012 15:33:22 -0700 (PDT)
In-Reply-To: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The commit which added the janz-ican3 driver and commit
3ccd4c61 "can: Unify droping of invalid tx skbs and netdev stats" were
committed into mainline Linux during the same merge window.

Therefore, the addition of this code to the janz-ican3 driver was
forgotten. This patch adds the expected code.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/net/can/janz-ican3.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 020055e..ea1919e 100644
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
1.7.8.6

