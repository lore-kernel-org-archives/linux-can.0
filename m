From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 4/5] can: xilinx_can: only report warning and passive states on state changes
Date: Mon, 13 Feb 2017 15:12:07 +0200
Message-ID: <20170213131208.20227-5-anssi.hannula@bitwise.fi>
References: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:41150 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbdBMNbE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 13 Feb 2017 08:31:04 -0500
In-Reply-To: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>

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

I'm not 100% sure what the expected behavior here is. Another
alternative option would be to keep the code so that CAN_ERR_CRTL etc
is always set in the error frame (as the error frame is generated
anyway), and just make the statistics increment only on state changes.


 drivers/net/can/xilinx_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e02fabf..392be77 100644
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

