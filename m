From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH] can: flexcan: fix bus-off error state handling.
Date: Tue, 17 Mar 2015 13:03:09 +0000
Message-ID: <40e1c77d-546d-48b6-b4bd-fe76f7692e90@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0095.outbound.protection.outlook.com ([157.55.234.95]:55852
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753645AbbCQNDN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 17 Mar 2015 09:03:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Making sure that the bus-off state gets passed to can_change_state().

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/flexcan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 80c46ad..ee944ae 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -592,13 +592,12 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 		rx_state = unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
 			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
 		new_state = max(tx_state, rx_state);
-	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
+	} else {
 		__flexcan_get_berr_counter(dev, &bec);
-		new_state = CAN_STATE_ERROR_PASSIVE;
+		new_state = flt == FLEXCAN_ESR_FLT_CONF_PASSIVE ?
+			    CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
 		rx_state = bec.rxerr >= bec.txerr ? new_state : 0;
 		tx_state = bec.rxerr <= bec.txerr ? new_state : 0;
-	} else {
-		new_state = CAN_STATE_BUS_OFF;
 	}
 
 	/* state hasn't changed */
-- 
1.9.1

