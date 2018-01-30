From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Tue, 30 Jan 2018 16:56:48 +0000
Message-ID: <20180130165649.22732-2-andri.yngvason@marel.com>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve1eur01on0089.outbound.protection.outlook.com ([104.47.1.89]:31424
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753494AbeA3Q52 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Jan 2018 11:57:28 -0500
In-Reply-To: <20180130165649.22732-1-andri.yngvason@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com, Andri Yngvason <andri.yngvason@marel.com>

If the queue is not stopped, the start_xmit function will continue to be
called until the driver or the system is reset.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/cc770/cc770.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 9fed163..12d3b89 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -405,6 +405,7 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if ((cc770_read_reg(priv,
 			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
+		netif_stop_queue(dev);
 		netdev_err(dev, "TX register is still occupied!\n");
 		return NETDEV_TX_BUSY;
 	}
-- 
1.9.1

