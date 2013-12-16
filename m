From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 07/11] sllin: Do not set SLF_MSGEVENT flag
Date: Mon, 16 Dec 2013 08:54:10 +0100
Message-ID: <1387180454-1738-8-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46050 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab3LPHzy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:54 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is only used if there is some Tx CAN frame.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index c5e1749..457788c 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -771,7 +771,6 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 			if (sce->dlc > 0) {
 				sl->rx_expect += sce->dlc + 1; /* + checksum */
 				sl->rx_len_unknown = false;
-				set_bit(SLF_MSGEVENT, &sl->flags);
 				wake_up(&sl->kwt_wq);
 			} else {
 				sl->rx_expect += SLLIN_DATA_MAX + 1; /* + checksum */
@@ -1001,9 +1000,9 @@ static int sllin_kwthread(void *ptr)
 			test_bit(SLF_TXEVENT, &sl->flags) ||
 			test_bit(SLF_TMOUTEVENT, &sl->flags) ||
 			test_bit(SLF_ERROR, &sl->flags) ||
+			(sl->lin_state == SLSTATE_ID_RECEIVED) ||
 			(((sl->lin_state == SLSTATE_IDLE) ||
-				(sl->lin_state == SLSTATE_RESPONSE_WAIT) ||
-				(sl->lin_state == SLSTATE_ID_RECEIVED))
+				(sl->lin_state == SLSTATE_RESPONSE_WAIT))
 				&& test_bit(SLF_MSGEVENT, &sl->flags)));
 
 		if (test_and_clear_bit(SLF_RXEVENT, &sl->flags)) {
@@ -1201,8 +1200,7 @@ slstate_response_wait:
 			spin_lock_irqsave(&sl->linfr_lock, flags);
 
 			if ((sce->frame_fl & LIN_CACHE_RESPONSE)
-					&& (sce->dlc > 0)
-					&& (test_bit(SLF_MSGEVENT, &sl->flags))) {
+					&& (sce->dlc > 0)) {
 				int mode;
 
 				netdev_dbg(sl->dev, "Sending LIN response from linfr_cache\n");
@@ -1234,7 +1232,6 @@ slstate_response_wait:
 					sllin_send_tx_buff(sl);
 				}
 
-				clear_bit(SLF_MSGEVENT, &sl->flags);
 				kfree_skb(sl->tx_req_skb);
 				netif_wake_queue(sl->dev);
 				hrtimer_start(&sl->rx_timer,
-- 
1.8.3.2

