From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH 3/5] net: can: flexcan: handle state passive -> warning transition
Date: Fri, 25 Jul 2014 20:16:40 +0200
Message-ID: <1406312202-2542-3-git-send-email-matthias.klein@optimeas.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:60847 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbaGYSYF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:24:05 -0400
In-Reply-To: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Once the CAN-bus is open and a packet is sent, the controller switches
into the PASSIVE state. Once the BUS is closed again it goes the back
err-warning. The TX error counter goes 0 -> 0x80 -> 0x7f.
This patch makes sure that the user learns about this state chang
(CAN_STATE_ERROR_WARNING => CAN_STATE_ERROR_PASSIVE)

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2b98da2..f6f95ae 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -493,6 +493,13 @@ static void do_state(struct net_device *dev,
 
 	/* process state changes depending on the new state */
 	switch (new_state) {
+	case CAN_STATE_ERROR_WARNING:
+		netdev_dbg(dev, "Error Warning\n");
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (bec.txerr > bec.rxerr) ?
+			CAN_ERR_CRTL_TX_WARNING :
+			CAN_ERR_CRTL_RX_WARNING;
+		break;
 	case CAN_STATE_ERROR_ACTIVE:
 		netdev_dbg(dev, "Error Active\n");
 		cf->can_id |= CAN_ERR_PROT;
-- 
2.0.1

