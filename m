From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/2] pch_can: Stop netif queue if last message buffer is filled
Date: Tue, 21 Feb 2012 17:00:01 +0100
Message-ID: <1329840002-20746-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53704 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab2BUQAJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2012 11:00:09 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

If all Tx buffers are empty and we start queuing frames (more than Tx
buffer size) beginning at the last message buffer we will override the
first inserted entry if it doesn't get sent meanwhile, e.g. low priority
or ACK error. There is no stop condition when all buffers are used.
We will get get awoken by pch_can_tx_complete when the last entry is sent.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/pch_can.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 6edc25e..3af5341 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -903,9 +903,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	tx_obj_no = priv->tx_obj;
 	if (priv->tx_obj == PCH_TX_OBJ_END) {
-		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
-			netif_stop_queue(ndev);
-
+		netif_stop_queue(ndev);
 		priv->tx_obj = PCH_TX_OBJ_START;
 	} else {
 		priv->tx_obj++;
-- 
1.7.3.4

