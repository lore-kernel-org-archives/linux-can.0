From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/3] can: ti_hecc: remove priv->can.do_get_state() callback
Date: Mon,  7 Oct 2013 16:46:06 +0200
Message-ID: <1381157168-24588-2-git-send-email-mkl@pengutronix.de>
References: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51925 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab3JGOqP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:46:15 -0400
In-Reply-To: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This is a preparation patch to remove the priv->can.do_get_state() callback
completely.

This patch removes the priv->can.do_get_state() callback, as just returns
priv->can.state. The only user can_fill_info() already has direct access to
priv->can.state.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index beb5ef8..60d95b4 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -286,15 +286,6 @@ static inline u32 hecc_get_bit(struct ti_hecc_priv *priv, int reg, u32 bit_mask)
 	return (hecc_read(priv, reg) & bit_mask) ? 1 : 0;
 }
 
-static int ti_hecc_get_state(const struct net_device *ndev,
-	enum can_state *state)
-{
-	struct ti_hecc_priv *priv = netdev_priv(ndev);
-
-	*state = priv->can.state;
-	return 0;
-}
-
 static int ti_hecc_set_btc(struct ti_hecc_priv *priv)
 {
 	struct can_bittiming *bit_timing = &priv->can.bittiming;
@@ -940,7 +931,6 @@ static int ti_hecc_probe(struct platform_device *pdev)
 
 	priv->can.bittiming_const = &ti_hecc_bittiming_const;
 	priv->can.do_set_mode = ti_hecc_do_set_mode;
-	priv->can.do_get_state = ti_hecc_get_state;
 	priv->can.do_get_berr_counter = ti_hecc_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
-- 
1.8.4.rc3

