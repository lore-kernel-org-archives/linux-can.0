From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 4/5] can: xilinx_can: only report warning and passive states on state changes
Date: Fri, 26 Jan 2018 16:27:22 +0200
Message-ID: <20180126142723.3212-5-anssi.hannula@bitwise.fi>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:60714 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752382AbeAZOhs (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 26 Jan 2018 09:37:48 -0500
In-Reply-To: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>

The xilinx_can driver currently increments error-warning and
error-passive statistics on every error interrupt regardless of whether
the interface was already in the same state. Similarly, the error frame
sent on error interrupts is always sent with
CAN_ERR_CRTL_(RX|TX)_(PASSIVE|WARNING) bit set.

To make the error-warning and error-passive statistics more useful, add
a check to only set the error state when the state has actually been
changed.

Tested with the integrated CAN on Zynq-7000 SoC.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/net/can/xilinx_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 763408a..862c12bb 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -680,7 +680,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 	} else {
 		enum can_state new_state = xcan_current_error_state(ndev);
 
-		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
+		if (new_state != priv->can.state)
+			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
 	}
 
 	/* Check for Arbitration lost interrupt */
-- 
2.8.3

