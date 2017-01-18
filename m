From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 06/16] can: flexcan: flexcan_poll_state(): no need to initialize new_state, rx_state, tx_state
Date: Wed, 18 Jan 2017 15:52:17 +0100
Message-ID: <20170118145227.24916-7-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50879 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753173AbdARPEQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:16 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch removed the not needed initialisation from the new_state,
rx_state, tx_state variabled.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index bd780bbf4f1a..62180b486272 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -584,7 +584,7 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	enum can_state new_state = 0, rx_state = 0, tx_state = 0;
+	enum can_state new_state, rx_state, tx_state;
 	int flt;
 	struct can_berr_counter bec;
 
-- 
2.11.0

