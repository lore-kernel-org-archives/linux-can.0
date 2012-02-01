From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] can: ti_hecc: use netif_rx in the interrupt
Date: Wed, 01 Feb 2012 10:50:23 +0100
Message-ID: <4F290ADF.90204@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55565 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2BAJuZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 04:50:25 -0500
Received: from [10.0.30.2] (pD9E16ABA.dip.t-dialin.net [217.225.106.186])
	(authenticated as wg with PLAIN)
	by ngcobalt02.manitu.net (8.10.2/8.10.2) with ESMTP id q119oPF29825
	for <linux-can@vger.kernel.org>; Wed, 1 Feb 2012 10:50:25 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-CAN <linux-can@vger.kernel.org>

This patch fixes locking problems by using netif_rx() instead of
netif_receive_skb() in ti_hecc_error() called from the interrupt
context.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ti_hecc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index df809e3..5a2e1e3 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -745,9 +745,10 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 		}
 	}
 
-	netif_receive_skb(skb);
+	netif_rx(skb);
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+
 	return 0;
 }
 
-- 
1.7.4.1

