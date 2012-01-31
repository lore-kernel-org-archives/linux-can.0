From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/12] can: cc770: store echo skb before starting the transfer
Date: Tue, 31 Jan 2012 22:46:39 +0100
Message-ID: <1328046410-21392-2-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44829 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2AaVqy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:46:54 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Wolfgang Grandegger <wg@grandegger.com>

On slow systems and high CAN bitrates, the error message
"can_put_echo_skb: BUG! echo_skb is occupied!" did show up because
can_put_echo_skb() was called after starting the transfer.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 7668967..c30f0e6 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -440,12 +440,14 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < dlc; i++)
 		cc770_write_reg(priv, msgobj[mo].data[i], cf->data[i]);
 
+	/* Store echo skb before starting the transfer */
+	can_put_echo_skb(skb, dev, 0);
+
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
 
 	stats->tx_bytes += dlc;
 
-	can_put_echo_skb(skb, dev, 0);
 
 	/*
 	 * HM: We had some cases of repeated IRQs so make sure the
-- 
1.7.4.1

