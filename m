From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: dev: remove do_get_state() callback from struct can_priv
Date: Mon,  7 Oct 2013 16:46:08 +0200
Message-ID: <1381157168-24588-4-git-send-email-mkl@pengutronix.de>
References: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51927 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab3JGOqP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:46:15 -0400
In-Reply-To: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

As there are no users of the do_get_state() callback it is removed from the
struct can_priv.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..b0a429e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -46,8 +46,6 @@ struct can_priv {
 
 	int (*do_set_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
-	int (*do_get_state)(const struct net_device *dev,
-			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
 				   struct can_berr_counter *bec);
 
-- 
1.8.4.rc3

