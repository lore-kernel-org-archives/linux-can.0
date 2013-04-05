From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: sja1000: use common prefix for all sja1000 defines
Date: Fri, 05 Apr 2013 20:24:55 +0200
Message-ID: <515F16F7.7020508@hartkopp.net>
References: <1364974929-14702-1-git-send-email-mkl@pengutronix.de> <515C8834.7040006@hartkopp.net> <515E84AF.303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:63406 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162370Ab3DESY7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Apr 2013 14:24:59 -0400
In-Reply-To: <515E84AF.303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On 05.04.2013 10:00, Marc Kleine-Budde wrote:

> On 04/03/2013 09:51 PM, Oliver Hartkopp wrote:
>> Hello Marc,
>>
>> On 03.04.2013 09:42, Marc Kleine-Budde wrote:
>>
>>
>>> -	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
>>> +	priv->write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);
>>
>>
>> What about CDR_PELICAN here?
> 
> It's from a different file, IIRC.


Yes, it is.


>>
>>> +	priv->write_reg(priv, SJA1000_REG_OCR, priv->ocr | OCR_MODE_NORMAL);
>>
>>
>> and OCR_MODE_NORMAL here?
> 
> same here.
> 


dito.

But when we add to each register *content* definition the SJA1000_ prefix ...
why not adding this for the OCR and CDR register content too then?

>>
>> All the defines from include/linux/can/platform/sja1000.h are not unified too.
>>
>> What about this patch?
>>
>> I used SJA_ as prefix for all relevant defines - even for SJA1000_ defines:
> 
> I like SJA1000_ more then SJA_, but I don't insist on that... :)


Wolfgang too :-)

What about only changing the REG_ defines to SJA1000_ and let the register
content values as-is?


 ems_pci.c     |    6 +-
 ems_pcmcia.c  |    6 +-
 kvaser_pci.c  |    4 -
 peak_pci.c    |    2 
 peak_pcmcia.c |    8 +--
 plx_pci.c     |   12 ++---
 sja1000.c     |  126 +++++++++++++++++++++++++++++-----------------------------
 sja1000.h     |   68 +++++++++++++++----------------
 8 files changed, 117 insertions(+), 115 deletions(-)



diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 36d298d..3752342 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -168,12 +168,12 @@ static inline int ems_pci_check_chan(const struct sja1000_priv *priv)
 	unsigned char res;
 
 	/* Make sure SJA1000 is in reset mode */
-	priv->write_reg(priv, REG_MOD, 1);
+	priv->write_reg(priv, SJA1000_MOD, 1);
 
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	res = priv->read_reg(priv, REG_CDR);
+	res = priv->read_reg(priv, SJA1000_CDR);
 
 	if (res == CDR_PELICAN)
 		return 1;
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 5c2f3fb..a3aa681 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -126,11 +126,11 @@ static irqreturn_t ems_pcmcia_interrupt(int irq, void *dev_id)
 static inline int ems_pcmcia_check_chan(struct sja1000_priv *priv)
 {
 	/* Make sure SJA1000 is in reset mode */
-	ems_pcmcia_write_reg(priv, REG_MOD, 1);
-	ems_pcmcia_write_reg(priv, REG_CDR, CDR_PELICAN);
+	ems_pcmcia_write_reg(priv, SJA1000_MOD, 1);
+	ems_pcmcia_write_reg(priv, SJA1000_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	if (ems_pcmcia_read_reg(priv, REG_CDR) == CDR_PELICAN)
+	if (ems_pcmcia_read_reg(priv, SJA1000_CDR) == CDR_PELICAN)
 		return 1;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 37b0381..217585b 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -159,9 +159,9 @@ static int number_of_sja1000_chip(void __iomem *base_addr)
 	for (i = 0; i < MAX_NO_OF_CHANNELS; i++) {
 		/* reset chip */
 		iowrite8(MOD_RM, base_addr +
-			 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+			 (i * KVASER_PCI_PORT_BYTES) + SJA1000_MOD);
 		status = ioread8(base_addr +
-				 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+				 (i * KVASER_PCI_PORT_BYTES) + SJA1000_MOD);
 		/* check reset bit */
 		if (!(status & MOD_RM))
 			break;
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index d1e7f10..6b6f0ad 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -402,7 +402,7 @@ static void peak_pciec_write_reg(const struct sja1000_priv *priv,
 	int c = (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA1000_MOD)
 		switch (val) {
 		case MOD_RM:
 			/* Reset Mode: set led on */
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 1a7020b..977901a 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -196,7 +196,7 @@ static void pcan_write_canreg(const struct sja1000_priv *priv, int port, u8 v)
 	int c = (priv->reg_base - card->ioport_addr) / PCC_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA1000_MOD)
 		switch (v) {
 		case MOD_RM:
 			/* Reset Mode: set led on */
@@ -509,11 +509,11 @@ static void pcan_free_channels(struct pcan_pccard *card)
 static inline int pcan_channel_present(struct sja1000_priv *priv)
 {
 	/* make sure SJA1000 is in reset mode */
-	pcan_write_canreg(priv, REG_MOD, 1);
-	pcan_write_canreg(priv, REG_CDR, CDR_PELICAN);
+	pcan_write_canreg(priv, SJA1000_MOD, 1);
+	pcan_write_canreg(priv, SJA1000_CDR, CDR_PELICAN);
 
 	/* read reset-values */
-	if (pcan_read_canreg(priv, REG_CDR) == CDR_PELICAN)
+	if (pcan_read_canreg(priv, SJA1000_CDR) == CDR_PELICAN)
 		return 1;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 3c18d7d..c52c1e9 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -348,20 +348,20 @@ static inline int plx_pci_check_sja1000(const struct sja1000_priv *priv)
 	 */
 	if ((priv->read_reg(priv, REG_CR) & REG_CR_BASICCAN_INITIAL_MASK) ==
 	    REG_CR_BASICCAN_INITIAL &&
-	    (priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_BASICCAN_INITIAL) &&
-	    (priv->read_reg(priv, REG_IR) == REG_IR_BASICCAN_INITIAL))
+	    (priv->read_reg(priv, SJA1000_SR) == REG_SR_BASICCAN_INITIAL) &&
+	    (priv->read_reg(priv, SJA1000_IR) == REG_IR_BASICCAN_INITIAL))
 		flag = 1;
 
 	/* Bring the SJA1000 into the PeliCAN mode*/
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_CDR, CDR_PELICAN);
 
 	/*
 	 * Check registers after reset in the PeliCAN mode.
 	 * See states on p. 23 of the Datasheet.
 	 */
-	if (priv->read_reg(priv, REG_MOD) == REG_MOD_PELICAN_INITIAL &&
-	    priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_PELICAN_INITIAL &&
-	    priv->read_reg(priv, REG_IR) == REG_IR_PELICAN_INITIAL)
+	if (priv->read_reg(priv, SJA1000_MOD) == REG_MOD_PELICAN_INITIAL &&
+	    priv->read_reg(priv, SJA1000_SR) == REG_SR_PELICAN_INITIAL &&
+	    priv->read_reg(priv, SJA1000_IR) == REG_IR_PELICAN_INITIAL)
 		return flag;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index e4df307..7164a99 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -91,14 +91,14 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
 	 * the write_reg() operation - especially on SMP systems.
 	 */
 	spin_lock_irqsave(&priv->cmdreg_lock, flags);
-	priv->write_reg(priv, REG_CMR, val);
-	priv->read_reg(priv, SJA1000_REG_SR);
+	priv->write_reg(priv, SJA1000_CMR, val);
+	priv->read_reg(priv, SJA1000_SR);
 	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
 }
 
 static int sja1000_is_absent(struct sja1000_priv *priv)
 {
-	return (priv->read_reg(priv, REG_MOD) == 0xFF);
+	return (priv->read_reg(priv, SJA1000_MOD) == 0xFF);
 }
 
 static int sja1000_probe_chip(struct net_device *dev)
@@ -116,11 +116,11 @@ static int sja1000_probe_chip(struct net_device *dev)
 static void set_reset_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA1000_MOD);
 	int i;
 
 	/* disable interrupts */
-	priv->write_reg(priv, REG_IER, IRQ_OFF);
+	priv->write_reg(priv, SJA1000_IER, IRQ_OFF);
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
@@ -129,9 +129,10 @@ static void set_reset_mode(struct net_device *dev)
 			return;
 		}
 
-		priv->write_reg(priv, REG_MOD, MOD_RM);	/* reset chip */
+		/* reset chip */
+		priv->write_reg(priv, SJA1000_MOD, MOD_RM);
 		udelay(10);
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA1000_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into reset mode failed!\n");
@@ -140,7 +141,7 @@ static void set_reset_mode(struct net_device *dev)
 static void set_normal_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA1000_MOD);
 	int i;
 
 	for (i = 0; i < 100; i++) {
@@ -149,22 +150,22 @@ static void set_normal_mode(struct net_device *dev)
 			priv->can.state = CAN_STATE_ERROR_ACTIVE;
 			/* enable interrupts */
 			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-				priv->write_reg(priv, REG_IER, IRQ_ALL);
+				priv->write_reg(priv, SJA1000_IER, IRQ_ALL);
 			else
-				priv->write_reg(priv, REG_IER,
+				priv->write_reg(priv, SJA1000_IER,
 						IRQ_ALL & ~IRQ_BEI);
 			return;
 		}
 
 		/* set chip to normal mode */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-			priv->write_reg(priv, REG_MOD, MOD_LOM);
+			priv->write_reg(priv, SJA1000_MOD, MOD_LOM);
 		else
-			priv->write_reg(priv, REG_MOD, 0x00);
+			priv->write_reg(priv, SJA1000_MOD, 0x00);
 
 		udelay(10);
 
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA1000_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into normal mode failed!\n");
@@ -179,9 +180,9 @@ static void sja1000_start(struct net_device *dev)
 		set_reset_mode(dev);
 
 	/* Clear error counters and error code capture */
-	priv->write_reg(priv, REG_TXERR, 0x0);
-	priv->write_reg(priv, REG_RXERR, 0x0);
-	priv->read_reg(priv, REG_ECC);
+	priv->write_reg(priv, SJA1000_TXERR, 0x0);
+	priv->write_reg(priv, SJA1000_RXERR, 0x0);
+	priv->read_reg(priv, SJA1000_ECC);
 
 	/* leave reset mode */
 	set_normal_mode(dev);
@@ -217,8 +218,8 @@ static int sja1000_set_bittiming(struct net_device *dev)
 
 	netdev_info(dev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
-	priv->write_reg(priv, REG_BTR0, btr0);
-	priv->write_reg(priv, REG_BTR1, btr1);
+	priv->write_reg(priv, SJA1000_BTR0, btr0);
+	priv->write_reg(priv, SJA1000_BTR1, btr1);
 
 	return 0;
 }
@@ -228,8 +229,8 @@ static int sja1000_get_berr_counter(const struct net_device *dev,
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	bec->txerr = priv->read_reg(priv, REG_TXERR);
-	bec->rxerr = priv->read_reg(priv, REG_RXERR);
+	bec->txerr = priv->read_reg(priv, SJA1000_TXERR);
+	bec->rxerr = priv->read_reg(priv, SJA1000_RXERR);
 
 	return 0;
 }
@@ -247,20 +248,20 @@ static void chipset_init(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	/* set clock divider and output control register */
-	priv->write_reg(priv, REG_CDR, priv->cdr | CDR_PELICAN);
+	priv->write_reg(priv, SJA1000_CDR, priv->cdr | CDR_PELICAN);
 
 	/* set acceptance filter (accept all) */
-	priv->write_reg(priv, REG_ACCC0, 0x00);
-	priv->write_reg(priv, REG_ACCC1, 0x00);
-	priv->write_reg(priv, REG_ACCC2, 0x00);
-	priv->write_reg(priv, REG_ACCC3, 0x00);
+	priv->write_reg(priv, SJA1000_ACCC0, 0x00);
+	priv->write_reg(priv, SJA1000_ACCC1, 0x00);
+	priv->write_reg(priv, SJA1000_ACCC2, 0x00);
+	priv->write_reg(priv, SJA1000_ACCC3, 0x00);
 
-	priv->write_reg(priv, REG_ACCM0, 0xFF);
-	priv->write_reg(priv, REG_ACCM1, 0xFF);
-	priv->write_reg(priv, REG_ACCM2, 0xFF);
-	priv->write_reg(priv, REG_ACCM3, 0xFF);
+	priv->write_reg(priv, SJA1000_ACCM0, 0xFF);
+	priv->write_reg(priv, SJA1000_ACCM1, 0xFF);
+	priv->write_reg(priv, SJA1000_ACCM2, 0xFF);
+	priv->write_reg(priv, SJA1000_ACCM3, 0xFF);
 
-	priv->write_reg(priv, REG_OCR, priv->ocr | OCR_MODE_NORMAL);
+	priv->write_reg(priv, SJA1000_OCR, priv->ocr | OCR_MODE_NORMAL);
 }
 
 /*
@@ -289,21 +290,21 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
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
+		priv->write_reg(priv, SJA1000_FI, fi);
+		priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
+		priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
+		priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
+		priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
 	} else {
-		dreg = SFF_BUF;
-		priv->write_reg(priv, REG_FI, fi);
-		priv->write_reg(priv, REG_ID1, (id & 0x000007f8) >> 3);
-		priv->write_reg(priv, REG_ID2, (id & 0x00000007) << 5);
+		dreg = SJA1000_SFF_BUF;
+		priv->write_reg(priv, SJA1000_FI, fi);
+		priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >> 3);
+		priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) << 5);
 	}
 
 	for (i = 0; i < dlc; i++)
@@ -335,25 +336,25 @@ static void sja1000_rx(struct net_device *dev)
 	if (skb == NULL)
 		return;
 
-	fi = priv->read_reg(priv, REG_FI);
+	fi = priv->read_reg(priv, SJA1000_FI);
 
-	if (fi & FI_FF) {
+	if (fi & SJA1000_FI_FF) {
 		/* extended frame format (EFF) */
-		dreg = EFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << (5 + 16))
-		    | (priv->read_reg(priv, REG_ID2) << (5 + 8))
-		    | (priv->read_reg(priv, REG_ID3) << 5)
-		    | (priv->read_reg(priv, REG_ID4) >> 3);
+		dreg = SJA1000_EFF_BUF;
+		id = (priv->read_reg(priv, SJA1000_ID1) << 21)
+		    | (priv->read_reg(priv, SJA1000_ID2) << 13)
+		    | (priv->read_reg(priv, SJA1000_ID3) << 5)
+		    | (priv->read_reg(priv, SJA1000_ID4) >> 3);
 		id |= CAN_EFF_FLAG;
 	} else {
 		/* standard frame format (SFF) */
-		dreg = SFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << 3)
-		    | (priv->read_reg(priv, REG_ID2) >> 5);
+		dreg = SJA1000_SFF_BUF;
+		id = (priv->read_reg(priv, SJA1000_ID1) << 3)
+		    | (priv->read_reg(priv, SJA1000_ID2) >> 5);
 	}
 
 	cf->can_dlc = get_can_dlc(fi & 0x0F);
-	if (fi & FI_RTR) {
+	if (fi & SJA1000_FI_RTR) {
 		id |= CAN_RTR_FLAG;
 	} else {
 		for (i = 0; i < cf->can_dlc; i++)
@@ -414,7 +415,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
 
-		ecc = priv->read_reg(priv, REG_ECC);
+		ecc = priv->read_reg(priv, SJA1000_ECC);
 
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -448,7 +449,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
 		netdev_dbg(dev, "arbitration lost interrupt\n");
-		alc = priv->read_reg(priv, REG_ALC);
+		alc = priv->read_reg(priv, SJA1000_ALC);
 		priv->can.can_stats.arbitration_lost++;
 		stats->tx_errors++;
 		cf->can_id |= CAN_ERR_LOSTARB;
@@ -457,8 +458,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
 					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, REG_RXERR);
-		uint8_t txerr = priv->read_reg(priv, REG_TXERR);
+		uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
+		uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
 		cf->can_id |= CAN_ERR_CRTL;
 		if (state == CAN_STATE_ERROR_WARNING) {
 			priv->can.can_stats.error_warning++;
@@ -494,15 +495,16 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	int n = 0;
 
 	/* Shared interrupts and IRQ off? */
-	if (priv->read_reg(priv, REG_IER) == IRQ_OFF)
+	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
 		return IRQ_NONE;
 
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
 
-	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
+	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
+	       (n < SJA1000_MAX_IRQ)) {
 		n++;
-		status = priv->read_reg(priv, SJA1000_REG_SR);
+		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
 			return IRQ_NONE;
@@ -519,7 +521,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			} else {
 				/* transmission complete */
 				stats->tx_bytes +=
-					priv->read_reg(priv, REG_FI) & 0xf;
+					priv->read_reg(priv, SJA1000_FI) & 0xf;
 				stats->tx_packets++;
 				can_get_echo_skb(dev, 0);
 			}
@@ -530,7 +532,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			/* receive interrupt */
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
-				status = priv->read_reg(priv, SJA1000_REG_SR);
+				status = priv->read_reg(priv, SJA1000_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
 					return IRQ_NONE;
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index aa48e05..fcb9aef 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -54,46 +54,46 @@
 #define SJA1000_MAX_IRQ 20	/* max. number of interrupts handled in ISR */
 
 /* SJA1000 registers - manual section 6.4 (Pelican Mode) */
-#define REG_MOD		0x00
-#define REG_CMR		0x01
-#define SJA1000_REG_SR		0x02
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
+#define SJA1000_MOD		0x00
+#define SJA1000_CMR		0x01
+#define SJA1000_SR		0x02
+#define SJA1000_IR		0x03
+#define SJA1000_IER		0x04
+#define SJA1000_ALC		0x0B
+#define SJA1000_ECC		0x0C
+#define SJA1000_EWL		0x0D
+#define SJA1000_RXERR	0x0E
+#define SJA1000_TXERR	0x0F
+#define SJA1000_ACCC0	0x10
+#define SJA1000_ACCC1	0x11
+#define SJA1000_ACCC2	0x12
+#define SJA1000_ACCC3	0x13
+#define SJA1000_ACCM0	0x14
+#define SJA1000_ACCM1	0x15
+#define SJA1000_ACCM2	0x16
+#define SJA1000_ACCM3	0x17
+#define SJA1000_RMC		0x1D
+#define SJA1000_RBSA	0x1E
 
 /* Common registers - manual section 6.5 */
-#define REG_BTR0	0x06
-#define REG_BTR1	0x07
-#define REG_OCR		0x08
-#define REG_CDR		0x1F
+#define SJA1000_BTR0	0x06
+#define SJA1000_BTR1	0x07
+#define SJA1000_OCR		0x08
+#define SJA1000_CDR		0x1F
 
-#define REG_FI		0x10
-#define SFF_BUF		0x13
-#define EFF_BUF		0x15
+#define SJA1000_FI		0x10
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
+#define SJA1000_ID1		0x11
+#define SJA1000_ID2		0x12
+#define SJA1000_ID3		0x13
+#define SJA1000_ID4		0x14
 
-#define CAN_RAM		0x20
+#define SJA1000_CAN_RAM		0x20
 
 /* mode register */
 #define MOD_RM		0x01



