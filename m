From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/14] can: af_can: can_rx_register(): use max() instead of open coding it
Date: Wed,  2 Aug 2017 19:44:28 +0200
Message-ID: <20170802174434.4689-9-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49505 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752404AbdHBRom (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:42 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch replaces an open coded max by the proper kernel define max().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index cb079d2dcde2..e3df12cd2cae 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -498,8 +498,8 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		dev_rcv_lists->entries++;
 
 		can_pstats->rcv_entries++;
-		if (can_pstats->rcv_entries_max < can_pstats->rcv_entries)
-			can_pstats->rcv_entries_max = can_pstats->rcv_entries;
+		can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
+						  can_pstats->rcv_entries);
 	} else {
 		kmem_cache_free(rcv_cache, rcv);
 		err = -ENODEV;
-- 
2.13.2

