From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC PATCH] can: sja1000: use common prefix for all sja1000 defines
Date: Wed,  3 Apr 2013 09:42:09 +0200
Message-ID: <1364974929-14702-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58533 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763077Ab3DCHmN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Apr 2013 03:42:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>

This is a follow up patch to:

    f901b6b can: sja1000: fix define conflict on SH

That patch fixed a define conflict between the SH architecture and the sja1000
driver, by addind a prefix to one macro only. This patch add the prefix
("SJA1000_") to all remaining macros in the sja1000.h.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Oliver,

as David has merged net back to net-next, here is my RFC to use SJA1000_ as a
common prefix for all defines in the sja1000.h. You're right, there were some
linebreaks necessary, but checkpatch is happy now.

regards,
Marc

 drivers/net/can/sja1000/ems_pci.c     |   6 +-
 drivers/net/can/sja1000/ems_pcmcia.c  |   6 +-
 drivers/net/can/sja1000/kvaser_pci.c  |   8 +-
 drivers/net/can/sja1000/peak_pci.c    |   4 +-
 drivers/net/can/sja1000/peak_pcmcia.c |  10 +-
 drivers/net/can/sja1000/plx_pci.c     |   8 +-
 drivers/net/can/sja1000/sja1000.c     | 180 ++++++++++++++++++----------------
 drivers/net/can/sja1000/sja1000.h     | 136 ++++++++++++-------------
 8 files changed, 183 insertions(+), 175 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 36d298d..1ab8eac 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -168,12 +168,12 @@ static inline int ems_pci_check_chan(const struct sja1000_priv *priv)
 	unsigned char res;
 
 	/* Make sure SJA1000 is in reset mode */
-	priv->write_reg(priv, REG_MOD, 1);
+	priv->write_reg(priv, SJA1000_REG_MOD, 1);
 
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	res = priv->read_reg(priv, REG_CDR);
+	res = priv->read_reg(priv, SJA1000_REG_CDR);
 
 	if (res == CDR_PELICAN)
 		return 1;
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 5c2f3fb..ffed81e 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -126,11 +126,11 @@ static irqreturn_t ems_pcmcia_interrupt(int irq, void *dev_id)
 static inline int ems_pcmcia_check_chan(struct sja1000_priv *priv)
 {
 	/* Make sure SJA1000 is in reset mode */
-	ems_pcmcia_write_reg(priv, REG_MOD, 1);
-	ems_pcmcia_write_reg(priv, REG_CDR, CDR_PELICAN);
+	ems_pcmcia_write_reg(priv, SJA1000_REG_MOD, 1);
+	ems_pcmcia_write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	if (ems_pcmcia_read_reg(priv, REG_CDR) == CDR_PELICAN)
+	if (ems_pcmcia_read_reg(priv, SJA1000_REG_CDR) == CDR_PELICAN)
 		return 1;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 37b0381..fb34008 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -158,12 +158,12 @@ static int number_of_sja1000_chip(void __iomem *base_addr)
 
 	for (i = 0; i < MAX_NO_OF_CHANNELS; i++) {
 		/* reset chip */
-		iowrite8(MOD_RM, base_addr +
-			 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+		iowrite8(SJA1000_MOD_RM, base_addr +
+			 (i * KVASER_PCI_PORT_BYTES) + SJA1000_REG_MOD);
 		status = ioread8(base_addr +
-				 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+				 (i * KVASER_PCI_PORT_BYTES) + SJA1000_REG_MOD);
 		/* check reset bit */
-		if (!(status & MOD_RM))
+		if (!(status & SJA1000_MOD_RM))
 			break;
 	}
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index d1e7f10..889c9f3 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -402,9 +402,9 @@ static void peak_pciec_write_reg(const struct sja1000_priv *priv,
 	int c = (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA1000_REG_MOD)
 		switch (val) {
-		case MOD_RM:
+		case SJA1000_MOD_RM:
 			/* Reset Mode: set led on */
 			peak_pciec_set_leds(card, PCA9553_LED(c), PCA9553_ON);
 			break;
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 1a7020b..28a749f 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -196,9 +196,9 @@ static void pcan_write_canreg(const struct sja1000_priv *priv, int port, u8 v)
 	int c = (priv->reg_base - card->ioport_addr) / PCC_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA1000_REG_MOD)
 		switch (v) {
-		case MOD_RM:
+		case SJA1000_MOD_RM:
 			/* Reset Mode: set led on */
 			pcan_set_leds(card, PCC_LED(c), PCC_LED_ON);
 			break;
@@ -509,11 +509,11 @@ static void pcan_free_channels(struct pcan_pccard *card)
 static inline int pcan_channel_present(struct sja1000_priv *priv)
 {
 	/* make sure SJA1000 is in reset mode */
-	pcan_write_canreg(priv, REG_MOD, 1);
-	pcan_write_canreg(priv, REG_CDR, CDR_PELICAN);
+	pcan_write_canreg(priv, SJA1000_REG_MOD, 1);
+	pcan_write_canreg(priv, SJA1000_REG_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	if (pcan_read_canreg(priv, REG_CDR) == CDR_PELICAN)
+	if (pcan_read_canreg(priv, SJA1000_REG_CDR) == CDR_PELICAN)
 		return 1;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 3c18d7d..ad9e271 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -349,19 +349,19 @@ static inline int plx_pci_check_sja1000(const struct sja1000_priv *priv)
 	if ((priv->read_reg(priv, REG_CR) & REG_CR_BASICCAN_INITIAL_MASK) ==
 	    REG_CR_BASICCAN_INITIAL &&
 	    (priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_BASICCAN_INITIAL) &&
-	    (priv->read_reg(priv, REG_IR) == REG_IR_BASICCAN_INITIAL))
+	    (priv->read_reg(priv, SJA1000_REG_IR) == REG_IR_BASICCAN_INITIAL))
 		flag = 1;
 
 	/* Bring the SJA1000 into the PeliCAN mode*/
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);
 
 	/*
 	 * Check registers after reset in the PeliCAN mode.
 	 * See states on p. 23 of the Datasheet.
 	 */
-	if (priv->read_reg(priv, REG_MOD) == REG_MOD_PELICAN_INITIAL &&
+	if (priv->read_reg(priv, SJA1000_REG_MOD) == REG_MOD_PELICAN_INITIAL &&
 	    priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_PELICAN_INITIAL &&
-	    priv->read_reg(priv, REG_IR) == REG_IR_PELICAN_INITIAL)
+	    priv->read_reg(priv, SJA1000_REG_IR) == REG_IR_PELICAN_INITIAL)
 		return flag;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index e4df307..ced668d 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -91,14 +91,14 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
 	 * the write_reg() operation - especially on SMP systems.
 	 */
 	spin_lock_irqsave(&priv->cmdreg_lock, flags);
-	priv->write_reg(priv, REG_CMR, val);
+	priv->write_reg(priv, SJA1000_REG_CMR, val);
 	priv->read_reg(priv, SJA1000_REG_SR);
 	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
 }
 
 static int sja1000_is_absent(struct sja1000_priv *priv)
 {
-	return (priv->read_reg(priv, REG_MOD) == 0xFF);
+	return (priv->read_reg(priv, SJA1000_REG_MOD) == 0xFF);
 }
 
 static int sja1000_probe_chip(struct net_device *dev)
@@ -116,22 +116,23 @@ static int sja1000_probe_chip(struct net_device *dev)
 static void set_reset_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA1000_REG_MOD);
 	int i;
 
 	/* disable interrupts */
-	priv->write_reg(priv, REG_IER, IRQ_OFF);
+	priv->write_reg(priv, SJA1000_REG_IER, SJA1000_IRQ_OFF);
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
-		if (status & MOD_RM) {
+		if (status & SJA1000_MOD_RM) {
 			priv->can.state = CAN_STATE_STOPPED;
 			return;
 		}
 
-		priv->write_reg(priv, REG_MOD, MOD_RM);	/* reset chip */
+		/* reset chip */
+		priv->write_reg(priv, SJA1000_REG_MOD, SJA1000_MOD_RM);
 		udelay(10);
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA1000_REG_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into reset mode failed!\n");
@@ -140,31 +141,33 @@ static void set_reset_mode(struct net_device *dev)
 static void set_normal_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA1000_REG_MOD);
 	int i;
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
-		if ((status & MOD_RM) == 0) {
+		if ((status & SJA1000_MOD_RM) == 0) {
 			priv->can.state = CAN_STATE_ERROR_ACTIVE;
 			/* enable interrupts */
 			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-				priv->write_reg(priv, REG_IER, IRQ_ALL);
+				priv->write_reg(priv, SJA1000_REG_IER,
+						SJA1000_IRQ_ALL);
 			else
-				priv->write_reg(priv, REG_IER,
-						IRQ_ALL & ~IRQ_BEI);
+				priv->write_reg(priv, SJA1000_REG_IER,
+						SJA1000_IRQ_ALL &
+						~SJA1000_IRQ_BEI);
 			return;
 		}
 
 		/* set chip to normal mode */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-			priv->write_reg(priv, REG_MOD, MOD_LOM);
+			priv->write_reg(priv, SJA1000_REG_MOD, SJA1000_MOD_LOM);
 		else
-			priv->write_reg(priv, REG_MOD, 0x00);
+			priv->write_reg(priv, SJA1000_REG_MOD, 0x00);
 
 		udelay(10);
 
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA1000_REG_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into normal mode failed!\n");
@@ -179,9 +182,9 @@ static void sja1000_start(struct net_device *dev)
 		set_reset_mode(dev);
 
 	/* Clear error counters and error code capture */
-	priv->write_reg(priv, REG_TXERR, 0x0);
-	priv->write_reg(priv, REG_RXERR, 0x0);
-	priv->read_reg(priv, REG_ECC);
+	priv->write_reg(priv, SJA1000_REG_TXERR, 0x0);
+	priv->write_reg(priv, SJA1000_REG_RXERR, 0x0);
+	priv->read_reg(priv, SJA1000_REG_ECC);
 
 	/* leave reset mode */
 	set_normal_mode(dev);
@@ -217,8 +220,8 @@ static int sja1000_set_bittiming(struct net_device *dev)
 
 	netdev_info(dev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
-	priv->write_reg(priv, REG_BTR0, btr0);
-	priv->write_reg(priv, REG_BTR1, btr1);
+	priv->write_reg(priv, SJA1000_REG_BTR0, btr0);
+	priv->write_reg(priv, SJA1000_REG_BTR1, btr1);
 
 	return 0;
 }
@@ -228,8 +231,8 @@ static int sja1000_get_berr_counter(const struct net_device *dev,
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	bec->txerr = priv->read_reg(priv, REG_TXERR);
-	bec->rxerr = priv->read_reg(priv, REG_RXERR);
+	bec->txerr = priv->read_reg(priv, SJA1000_REG_TXERR);
+	bec->rxerr = priv->read_reg(priv, SJA1000_REG_RXERR);
 
 	return 0;
 }
@@ -247,20 +250,20 @@ static void chipset_init(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	/* set clock divider and output control register */
-	priv->write_reg(priv, REG_CDR, priv->cdr | CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_REG_CDR, priv->cdr | CDR_PELICAN);
 
 	/* set acceptance filter (accept all) */
-	priv->write_reg(priv, REG_ACCC0, 0x00);
-	priv->write_reg(priv, REG_ACCC1, 0x00);
-	priv->write_reg(priv, REG_ACCC2, 0x00);
-	priv->write_reg(priv, REG_ACCC3, 0x00);
+	priv->write_reg(priv, SJA1000_REG_ACCC0, 0x00);
+	priv->write_reg(priv, SJA1000_REG_ACCC1, 0x00);
+	priv->write_reg(priv, SJA1000_REG_ACCC2, 0x00);
+	priv->write_reg(priv, SJA1000_REG_ACCC3, 0x00);
 
-	priv->write_reg(priv, REG_ACCM0, 0xFF);
-	priv->write_reg(priv, REG_ACCM1, 0xFF);
-	priv->write_reg(priv, REG_ACCM2, 0xFF);
-	priv->write_reg(priv, REG_ACCM3, 0xFF);
+	priv->write_reg(priv, SJA1000_REG_ACCM0, 0xFF);
+	priv->write_reg(priv, SJA1000_REG_ACCM1, 0xFF);
+	priv->write_reg(priv, SJA1000_REG_ACCM2, 0xFF);
+	priv->write_reg(priv, SJA1000_REG_ACCM3, 0xFF);
 
-	priv->write_reg(priv, REG_OCR, priv->ocr | OCR_MODE_NORMAL);
+	priv->write_reg(priv, SJA1000_REG_OCR, priv->ocr | OCR_MODE_NORMAL);
 }
 
 /*
@@ -289,21 +292,23 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	id = cf->can_id;
 
 	if (id & CAN_RTR_FLAG)
-		fi |= FI_RTR;
+		fi |= SJA1000_FI_RTR;
 
 	if (id & CAN_EFF_FLAG) {
-		fi |= FI_FF;
-		dreg = EFF_BUF;
-		priv->write_reg(priv, REG_FI, fi);
-		priv->write_reg(priv, REG_ID1, (id & 0x1fe00000) >> (5 + 16));
-		priv->write_reg(priv, REG_ID2, (id & 0x001fe000) >> (5 + 8));
-		priv->write_reg(priv, REG_ID3, (id & 0x00001fe0) >> 5);
-		priv->write_reg(priv, REG_ID4, (id & 0x0000001f) << 3);
+		fi |= SJA1000_FI_FF;
+		dreg = SJA1000_EFF_BUF;
+		priv->write_reg(priv, SJA1000_REG_FI, fi);
+		priv->write_reg(priv, SJA1000_REG_ID1,
+				(id & 0x1fe00000) >> (5 + 16));
+		priv->write_reg(priv, SJA1000_REG_ID2,
+				(id & 0x001fe000) >> (5 + 8));
+		priv->write_reg(priv, SJA1000_REG_ID3, (id & 0x00001fe0) >> 5);
+		priv->write_reg(priv, SJA1000_REG_ID4, (id & 0x0000001f) << 3);
 	} else {
-		dreg = SFF_BUF;
-		priv->write_reg(priv, REG_FI, fi);
-		priv->write_reg(priv, REG_ID1, (id & 0x000007f8) >> 3);
-		priv->write_reg(priv, REG_ID2, (id & 0x00000007) << 5);
+		dreg = SJA1000_SFF_BUF;
+		priv->write_reg(priv, SJA1000_REG_FI, fi);
+		priv->write_reg(priv, SJA1000_REG_ID1, (id & 0x000007f8) >> 3);
+		priv->write_reg(priv, SJA1000_REG_ID2, (id & 0x00000007) << 5);
 	}
 
 	for (i = 0; i < dlc; i++)
@@ -312,9 +317,9 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	can_put_echo_skb(skb, dev, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
-		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
+		sja1000_write_cmdreg(priv, SJA1000_CMD_TR | SJA1000_CMD_AT);
 	else
-		sja1000_write_cmdreg(priv, CMD_TR);
+		sja1000_write_cmdreg(priv, SJA1000_CMD_TR);
 
 	return NETDEV_TX_OK;
 }
@@ -335,25 +340,25 @@ static void sja1000_rx(struct net_device *dev)
 	if (skb == NULL)
 		return;
 
-	fi = priv->read_reg(priv, REG_FI);
+	fi = priv->read_reg(priv, SJA1000_REG_FI);
 
-	if (fi & FI_FF) {
+	if (fi & SJA1000_FI_FF) {
 		/* extended frame format (EFF) */
-		dreg = EFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << (5 + 16))
-		    | (priv->read_reg(priv, REG_ID2) << (5 + 8))
-		    | (priv->read_reg(priv, REG_ID3) << 5)
-		    | (priv->read_reg(priv, REG_ID4) >> 3);
+		dreg = SJA1000_EFF_BUF;
+		id = (priv->read_reg(priv, SJA1000_REG_ID1) << (5 + 16))
+		    | (priv->read_reg(priv, SJA1000_REG_ID2) << (5 + 8))
+		    | (priv->read_reg(priv, SJA1000_REG_ID3) << 5)
+		    | (priv->read_reg(priv, SJA1000_REG_ID4) >> 3);
 		id |= CAN_EFF_FLAG;
 	} else {
 		/* standard frame format (SFF) */
-		dreg = SFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << 3)
-		    | (priv->read_reg(priv, REG_ID2) >> 5);
+		dreg = SJA1000_SFF_BUF;
+		id = (priv->read_reg(priv, SJA1000_REG_ID1) << 3)
+		    | (priv->read_reg(priv, SJA1000_REG_ID2) >> 5);
 	}
 
 	cf->can_dlc = get_can_dlc(fi & 0x0F);
-	if (fi & FI_RTR) {
+	if (fi & SJA1000_FI_RTR) {
 		id |= CAN_RTR_FLAG;
 	} else {
 		for (i = 0; i < cf->can_dlc; i++)
@@ -363,7 +368,7 @@ static void sja1000_rx(struct net_device *dev)
 	cf->can_id = id;
 
 	/* release receive buffer */
-	sja1000_write_cmdreg(priv, CMD_RRB);
+	sja1000_write_cmdreg(priv, SJA1000_CMD_RRB);
 
 	netif_rx(skb);
 
@@ -386,69 +391,69 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (skb == NULL)
 		return -ENOMEM;
 
-	if (isrc & IRQ_DOI) {
+	if (isrc & SJA1000_IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_over_errors++;
 		stats->rx_errors++;
-		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
+		sja1000_write_cmdreg(priv, SJA1000_CMD_CDO);	/* clear bit */
 	}
 
-	if (isrc & IRQ_EI) {
+	if (isrc & SJA1000_IRQ_EI) {
 		/* error warning interrupt */
 		netdev_dbg(dev, "error warning interrupt\n");
 
-		if (status & SR_BS) {
+		if (status & SJA1000_SR_BS) {
 			state = CAN_STATE_BUS_OFF;
 			cf->can_id |= CAN_ERR_BUSOFF;
 			can_bus_off(dev);
-		} else if (status & SR_ES) {
+		} else if (status & SJA1000_SR_ES) {
 			state = CAN_STATE_ERROR_WARNING;
 		} else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (isrc & IRQ_BEI) {
+	if (isrc & SJA1000_IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
 
-		ecc = priv->read_reg(priv, REG_ECC);
+		ecc = priv->read_reg(priv, SJA1000_REG_ECC);
 
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		switch (ecc & ECC_MASK) {
-		case ECC_BIT:
+		switch (ecc & SJA1000_ECC_MASK) {
+		case SJA1000_ECC_BIT:
 			cf->data[2] |= CAN_ERR_PROT_BIT;
 			break;
-		case ECC_FORM:
+		case SJA1000_ECC_FORM:
 			cf->data[2] |= CAN_ERR_PROT_FORM;
 			break;
-		case ECC_STUFF:
+		case SJA1000_ECC_STUFF:
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 			break;
 		default:
 			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
-			cf->data[3] = ecc & ECC_SEG;
+			cf->data[3] = ecc & SJA1000_ECC_SEG;
 			break;
 		}
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
+		if ((ecc & SJA1000_ECC_DIR) == 0)
 			cf->data[2] |= CAN_ERR_PROT_TX;
 	}
-	if (isrc & IRQ_EPI) {
+	if (isrc & SJA1000_IRQ_EPI) {
 		/* error passive interrupt */
 		netdev_dbg(dev, "error passive interrupt\n");
-		if (status & SR_ES)
+		if (status & SJA1000_SR_ES)
 			state = CAN_STATE_ERROR_PASSIVE;
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (isrc & IRQ_ALI) {
+	if (isrc & SJA1000_IRQ_ALI) {
 		/* arbitration lost interrupt */
 		netdev_dbg(dev, "arbitration lost interrupt\n");
-		alc = priv->read_reg(priv, REG_ALC);
+		alc = priv->read_reg(priv, SJA1000_REG_ALC);
 		priv->can.can_stats.arbitration_lost++;
 		stats->tx_errors++;
 		cf->can_id |= CAN_ERR_LOSTARB;
@@ -457,8 +462,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
 					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, REG_RXERR);
-		uint8_t txerr = priv->read_reg(priv, REG_TXERR);
+		uint8_t rxerr = priv->read_reg(priv, SJA1000_REG_RXERR);
+		uint8_t txerr = priv->read_reg(priv, SJA1000_REG_TXERR);
 		cf->can_id |= CAN_ERR_CRTL;
 		if (state == CAN_STATE_ERROR_WARNING) {
 			priv->can.can_stats.error_warning++;
@@ -494,41 +499,43 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	int n = 0;
 
 	/* Shared interrupts and IRQ off? */
-	if (priv->read_reg(priv, REG_IER) == IRQ_OFF)
+	if (priv->read_reg(priv, SJA1000_REG_IER) == SJA1000_IRQ_OFF)
 		return IRQ_NONE;
 
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
 
-	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
+	while ((isrc = priv->read_reg(priv, SJA1000_REG_IR)) &&
+	       (n < SJA1000_MAX_IRQ)) {
 		n++;
 		status = priv->read_reg(priv, SJA1000_REG_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
 			return IRQ_NONE;
 
-		if (isrc & IRQ_WUI)
+		if (isrc & SJA1000_IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
 
-		if (isrc & IRQ_TI) {
+		if (isrc & SJA1000_IRQ_TI) {
 			/* transmission buffer released */
 			if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
-			    !(status & SR_TCS)) {
+			    !(status & SJA1000_SR_TCS)) {
 				stats->tx_errors++;
 				can_free_echo_skb(dev, 0);
 			} else {
 				/* transmission complete */
 				stats->tx_bytes +=
-					priv->read_reg(priv, REG_FI) & 0xf;
+					priv->read_reg(priv, SJA1000_REG_FI)
+					& 0xf;
 				stats->tx_packets++;
 				can_get_echo_skb(dev, 0);
 			}
 			netif_wake_queue(dev);
 			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
-		if (isrc & IRQ_RI) {
+		if (isrc & SJA1000_IRQ_RI) {
 			/* receive interrupt */
-			while (status & SR_RBS) {
+			while (status & SJA1000_SR_RBS) {
 				sja1000_rx(dev);
 				status = priv->read_reg(priv, SJA1000_REG_SR);
 				/* check for absent controller */
@@ -536,7 +543,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 					return IRQ_NONE;
 			}
 		}
-		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
+		if (isrc & (SJA1000_IRQ_DOI | SJA1000_IRQ_EI | SJA1000_IRQ_BEI |
+			    SJA1000_IRQ_EPI | SJA1000_IRQ_ALI)) {
 			/* error interrupt */
 			if (sja1000_err(dev, isrc, status))
 				break;
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index aa48e05..c5ca3f9 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -54,93 +54,93 @@
 #define SJA1000_MAX_IRQ 20	/* max. number of interrupts handled in ISR */
 
 /* SJA1000 registers - manual section 6.4 (Pelican Mode) */
-#define REG_MOD		0x00
-#define REG_CMR		0x01
+#define SJA1000_REG_MOD		0x00
+#define SJA1000_REG_CMR		0x01
 #define SJA1000_REG_SR		0x02
-#define REG_IR		0x03
-#define REG_IER		0x04
-#define REG_ALC		0x0B
-#define REG_ECC		0x0C
-#define REG_EWL		0x0D
-#define REG_RXERR	0x0E
-#define REG_TXERR	0x0F
-#define REG_ACCC0	0x10
-#define REG_ACCC1	0x11
-#define REG_ACCC2	0x12
-#define REG_ACCC3	0x13
-#define REG_ACCM0	0x14
-#define REG_ACCM1	0x15
-#define REG_ACCM2	0x16
-#define REG_ACCM3	0x17
-#define REG_RMC		0x1D
-#define REG_RBSA	0x1E
+#define SJA1000_REG_IR		0x03
+#define SJA1000_REG_IER		0x04
+#define SJA1000_REG_ALC		0x0B
+#define SJA1000_REG_ECC		0x0C
+#define SJA1000_REG_EWL		0x0D
+#define SJA1000_REG_RXERR	0x0E
+#define SJA1000_REG_TXERR	0x0F
+#define SJA1000_REG_ACCC0	0x10
+#define SJA1000_REG_ACCC1	0x11
+#define SJA1000_REG_ACCC2	0x12
+#define SJA1000_REG_ACCC3	0x13
+#define SJA1000_REG_ACCM0	0x14
+#define SJA1000_REG_ACCM1	0x15
+#define SJA1000_REG_ACCM2	0x16
+#define SJA1000_REG_ACCM3	0x17
+#define SJA1000_REG_RMC		0x1D
+#define SJA1000_REG_RBSA	0x1E
 
 /* Common registers - manual section 6.5 */
-#define REG_BTR0	0x06
-#define REG_BTR1	0x07
-#define REG_OCR		0x08
-#define REG_CDR		0x1F
+#define SJA1000_REG_BTR0	0x06
+#define SJA1000_REG_BTR1	0x07
+#define SJA1000_REG_OCR		0x08
+#define SJA1000_REG_CDR		0x1F
 
-#define REG_FI		0x10
-#define SFF_BUF		0x13
-#define EFF_BUF		0x15
+#define SJA1000_REG_FI		0x10
+#define SJA1000_SFF_BUF		0x13
+#define SJA1000_EFF_BUF		0x15
 
-#define FI_FF		0x80
-#define FI_RTR		0x40
+#define SJA1000_FI_FF		0x80
+#define SJA1000_FI_RTR		0x40
 
-#define REG_ID1		0x11
-#define REG_ID2		0x12
-#define REG_ID3		0x13
-#define REG_ID4		0x14
+#define SJA1000_REG_ID1		0x11
+#define SJA1000_REG_ID2		0x12
+#define SJA1000_REG_ID3		0x13
+#define SJA1000_REG_ID4		0x14
 
-#define CAN_RAM		0x20
+#define SJA1000_CAN_RAM		0x20
 
 /* mode register */
-#define MOD_RM		0x01
-#define MOD_LOM		0x02
-#define MOD_STM		0x04
-#define MOD_AFM		0x08
-#define MOD_SM		0x10
+#define SJA1000_MOD_RM		0x01
+#define SJA1000_MOD_LOM		0x02
+#define SJA1000_MOD_STM		0x04
+#define SJA1000_MOD_AFM		0x08
+#define SJA1000_MOD_SM		0x10
 
 /* commands */
-#define CMD_SRR		0x10
-#define CMD_CDO		0x08
-#define CMD_RRB		0x04
-#define CMD_AT		0x02
-#define CMD_TR		0x01
+#define SJA1000_CMD_SRR		0x10
+#define SJA1000_CMD_CDO		0x08
+#define SJA1000_CMD_RRB		0x04
+#define SJA1000_CMD_AT		0x02
+#define SJA1000_CMD_TR		0x01
 
 /* interrupt sources */
-#define IRQ_BEI		0x80
-#define IRQ_ALI		0x40
-#define IRQ_EPI		0x20
-#define IRQ_WUI		0x10
-#define IRQ_DOI		0x08
-#define IRQ_EI		0x04
-#define IRQ_TI		0x02
-#define IRQ_RI		0x01
-#define IRQ_ALL		0xFF
-#define IRQ_OFF		0x00
+#define SJA1000_IRQ_BEI		0x80
+#define SJA1000_IRQ_ALI		0x40
+#define SJA1000_IRQ_EPI		0x20
+#define SJA1000_IRQ_WUI		0x10
+#define SJA1000_IRQ_DOI		0x08
+#define SJA1000_IRQ_EI		0x04
+#define SJA1000_IRQ_TI		0x02
+#define SJA1000_IRQ_RI		0x01
+#define SJA1000_IRQ_ALL		0xFF
+#define SJA1000_IRQ_OFF		0x00
 
 /* status register content */
-#define SR_BS		0x80
-#define SR_ES		0x40
-#define SR_TS		0x20
-#define SR_RS		0x10
-#define SR_TCS		0x08
-#define SR_TBS		0x04
-#define SR_DOS		0x02
-#define SR_RBS		0x01
+#define SJA1000_SR_BS		0x80
+#define SJA1000_SR_ES		0x40
+#define SJA1000_SR_TS		0x20
+#define SJA1000_SR_RS		0x10
+#define SJA1000_SR_TCS		0x08
+#define SJA1000_SR_TBS		0x04
+#define SJA1000_SR_DOS		0x02
+#define SJA1000_SR_RBS		0x01
 
 #define SR_CRIT (SR_BS|SR_ES)
 
 /* ECC register */
-#define ECC_SEG		0x1F
-#define ECC_DIR		0x20
-#define ECC_ERR		6
-#define ECC_BIT		0x00
-#define ECC_FORM	0x40
-#define ECC_STUFF	0x80
-#define ECC_MASK	0xc0
+#define SJA1000_ECC_SEG		0x1F
+#define SJA1000_ECC_DIR		0x20
+#define SJA1000_ECC_ERR		6
+#define SJA1000_ECC_BIT		0x00
+#define SJA1000_ECC_FORM	0x40
+#define SJA1000_ECC_STUFF	0x80
+#define SJA1000_ECC_MASK	0xc0
 
 /*
  * Flags for sja1000priv.flags
-- 
1.8.2.rc2

