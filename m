From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 5/5] can: sja1000: of: add reg-io-width property for 8, 16 and 32-bit register access
Date: Thu,  6 Feb 2014 12:09:56 +0100
Message-ID: <1391684996-612-6-git-send-email-mkl@pengutronix.de>
References: <1391684996-612-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46263 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbaBFLKE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 06:10:04 -0500
In-Reply-To: <1391684996-612-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the 'reg-io-width' property for 8, 16 and 32-bit access, like
what is currently done with IORESOURCE_MEM_{8,16,32}BIT for non-OF
boot.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index b7fbe4f..95a844a 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -101,8 +101,24 @@ static void sp_populate_of(struct sja1000_priv *priv, struct device_node *of)
 	int err;
 	u32 prop;
 
-	priv->read_reg = sp_read_reg8;
-	priv->write_reg = sp_write_reg8;
+	err = of_property_read_u32(of, "reg-io-width", &prop);
+	if (err)
+		prop = 1; /* 8 bit is default */
+
+	switch (prop) {
+	case 4:
+		priv->read_reg = sp_read_reg32;
+		priv->write_reg = sp_write_reg32;
+		break;
+	case 2:
+		priv->read_reg = sp_read_reg16;
+		priv->write_reg = sp_write_reg16;
+		break;
+	case 1:	/* fallthrough */
+	default:
+		priv->read_reg = sp_read_reg8;
+		priv->write_reg = sp_write_reg8;
+	}
 
 	err = of_property_read_u32(of, "nxp,external-clock-frequency", &prop);
 	if (!err)
-- 
1.8.5.3

