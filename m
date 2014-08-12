From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/4] can: flexcan: Detect error passive state change
Date: Tue, 12 Aug 2014 15:43:05 +0200
Message-ID: <1407850987-26707-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35606 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbaHLNqe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 09:46:34 -0400
In-Reply-To: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

Assuming there is no CAN frame reception or CAN_CTRLMODE_BERR_REPORTING:
If the Tx error counter steps from 127 to 128 the hardware enters error
passive. But in this case the FLEXCAN_ESR_ERR_STATE bits are unset:
TWRN_INT and RWRN_INT are not set during the transition from <96 to >=96.
So we do not schedule NAPI thus not evaluating the error counters.
So we also check TX_WRN and RX_WRN in order to detect error passive.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/flexcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index fd79dd40840b..5e391ec70a2b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -721,7 +721,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	 * - bus error IRQ and bus error reporting is activated
 	 */
 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (reg_esr & (FLEXCAN_ESR_ERR_STATE |
+			FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN)) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/*
 		 * The error bits are cleared on read,
-- 
1.8.5.5

