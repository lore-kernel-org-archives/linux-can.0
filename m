From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 1/3] can: cc770: Remove redundant IRQ ack
Date: Tue, 30 Jan 2018 16:56:47 +0000
Message-ID: <20180130165649.22732-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve1eur01on0089.outbound.protection.outlook.com ([104.47.1.89]:31424
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752104AbeA3Q50 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Jan 2018 11:57:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com, Andri Yngvason <andri.yngvason@marel.com>

This has been reported to cause stalls on rt-linux.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/cc770/cc770.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 1e37313..9fed163 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stats->tx_bytes += dlc;
 
-
-	/*
-	 * HM: We had some cases of repeated IRQs so make sure the
-	 * INT is acknowledged I know it's already further up, but
-	 * doing again fixed the issue
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
-
 	return NETDEV_TX_OK;
 }
 
@@ -684,12 +675,6 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
-	/*
-	 * We had some cases of repeated IRQ so make sure the
-	 * INT is acknowledged
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
 
 	stats->tx_packets++;
 	can_get_echo_skb(dev, 0);
-- 
1.9.1

