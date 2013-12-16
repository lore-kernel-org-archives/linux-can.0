From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 09/11] sllin: Don't fiddle with netdev queue and skb in slave receive mode
Date: Mon, 16 Dec 2013 08:54:12 +0100
Message-ID: <1387180454-1738-10-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46056 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689Ab3LPHzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:55 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

The queue and stored skb is only used for master mode.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index ffbdf01..c922b84 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -1241,8 +1241,6 @@ slstate_response_wait:
 					sllin_send_tx_buff(sl);
 				}
 
-				kfree_skb(sl->tx_req_skb);
-				netif_wake_queue(sl->dev);
 				hrtimer_start(&sl->rx_timer,
 					ktime_add(ktime_get(), sl->rx_timer_timeout),
 					HRTIMER_MODE_ABS);
-- 
1.8.3.2

