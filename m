From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH v2 1/4] can: sja1000: Add support for CAN_CTRLMODE_LOOPBACK
Date: Fri, 11 Jul 2014 16:13:20 +0400
Message-ID: <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
References: <53BEA26D.2040007@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:43398 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaGKMNl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 08:13:41 -0400
Received: by mail-lb0-f176.google.com with SMTP id w7so822135lbi.35
        for <linux-can@vger.kernel.org>; Fri, 11 Jul 2014 05:13:39 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id kh4sm3015648lbc.29.2014.07.11.05.13.37
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 05:13:38 -0700 (PDT)
In-Reply-To: <53BEA26D.2040007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This adds support for hardware loopback in SJA1000 by utilising its self
reception request (SRR) feature. Upon SRR the message is transmitted and
received simultaneously, meaning you can't have hardware loopback
without actually sending a message to the CAN bus in case of SJA1000.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 drivers/net/can/sja1000/sja1000.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index f31499a..45400d9 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -278,6 +278,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	uint8_t dlc;
 	canid_t id;
 	uint8_t dreg;
+	u8 cmd_reg_val = 0x00;
 	int i;
 
 	if (can_dropped_invalid_skb(dev, skb))
@@ -312,9 +313,14 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	can_put_echo_skb(skb, dev, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
-		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
+		cmd_reg_val |= CMD_AT;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		cmd_reg_val |= CMD_SRR;
 	else
-		sja1000_write_cmdreg(priv, CMD_TR);
+		cmd_reg_val |= CMD_TR;
+
+	sja1000_write_cmdreg(priv, cmd_reg_val);
 
 	return NETDEV_TX_OK;
 }
@@ -622,9 +628,11 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 	priv->can.do_set_bittiming = sja1000_set_bittiming;
 	priv->can.do_set_mode = sja1000_set_mode;
 	priv->can.do_get_berr_counter = sja1000_get_berr_counter;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_ONE_SHOT;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+				       CAN_CTRLMODE_LISTENONLY |
+				       CAN_CTRLMODE_3_SAMPLES |
+				       CAN_CTRLMODE_ONE_SHOT |
+				       CAN_CTRLMODE_BERR_REPORTING;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
-- 
2.0.1

