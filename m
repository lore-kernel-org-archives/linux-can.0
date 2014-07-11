From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH v2 4/4] can: sja1000: Add support for CAN_CTRLMODE_PRESUME_ACK
Date: Fri, 11 Jul 2014 16:13:23 +0400
Message-ID: <1405080803-5604-4-git-send-email-nebaruzdin@gmail.com>
References: <53BEA26D.2040007@pengutronix.de>
 <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59975 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaGKMNp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 08:13:45 -0400
Received: by mail-lb0-f179.google.com with SMTP id z11so775026lbi.24
        for <linux-can@vger.kernel.org>; Fri, 11 Jul 2014 05:13:44 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id kh4sm3015648lbc.29.2014.07.11.05.13.42
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 05:13:43 -0700 (PDT)
In-Reply-To: <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

SJA1000 has a self test mode (STM) which does not require
acknowledgement for the successful message transmission. In this mode a
node test is possible without any other active node on the bus.

This patch adds a possibility to set STM for SJA1000 controller through
specifying the corresponding CAN_CTRLMODE_PRESUME_ACK netlink flag.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 drivers/net/can/sja1000/sja1000.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 45400d9..d169215 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 	unsigned char status = priv->read_reg(priv, SJA1000_MOD);
+	u8 mod_reg_val = 0x00;
 	int i;
 
 	for (i = 0; i < 100; i++) {
@@ -158,9 +159,10 @@ static void set_normal_mode(struct net_device *dev)
 
 		/* set chip to normal mode */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-			priv->write_reg(priv, SJA1000_MOD, MOD_LOM);
-		else
-			priv->write_reg(priv, SJA1000_MOD, 0x00);
+			mod_reg_val |= MOD_LOM;
+		if (priv->can.ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
+			mod_reg_val |= MOD_STM;
+		priv->write_reg(priv, SJA1000_MOD, mod_reg_val);
 
 		udelay(10);
 
@@ -632,7 +634,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 				       CAN_CTRLMODE_LISTENONLY |
 				       CAN_CTRLMODE_3_SAMPLES |
 				       CAN_CTRLMODE_ONE_SHOT |
-				       CAN_CTRLMODE_BERR_REPORTING;
+				       CAN_CTRLMODE_BERR_REPORTING |
+				       CAN_CTRLMODE_PRESUME_ACK;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
-- 
2.0.1

