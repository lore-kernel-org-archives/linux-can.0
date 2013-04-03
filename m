From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: sja1000: use common prefix for all sja1000 defines
Date: Wed, 03 Apr 2013 21:51:16 +0200
Message-ID: <515C8834.7040006@hartkopp.net>
References: <1364974929-14702-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:60837 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543Ab3DCTvV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Apr 2013 15:51:21 -0400
In-Reply-To: <1364974929-14702-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

On 03.04.2013 09:42, Marc Kleine-Budde wrote:


> -	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
> +	priv->write_reg(priv, SJA1000_REG_CDR, CDR_PELICAN);


What about CDR_PELICAN here?


> +	priv->write_reg(priv, SJA1000_REG_OCR, priv->ocr | OCR_MODE_NORMAL);


and OCR_MODE_NORMAL here?

All the defines from include/linux/can/platform/sja1000.h are not unified too.

What about this patch?

I used SJA_ as prefix for all relevant defines - even for SJA1000_ defines:


 drivers/net/can/sja1000/ems_pci.c             |   12 -
 drivers/net/can/sja1000/ems_pcmcia.c          |   12 -
 drivers/net/can/sja1000/kvaser_pci.c          |   12 -
 drivers/net/can/sja1000/peak_pci.c            |   10 -
 drivers/net/can/sja1000/peak_pcmcia.c         |   20 +-
 drivers/net/can/sja1000/plx_pci.c             |   37 ++---
 drivers/net/can/sja1000/sja1000.c             |  187 +++++++++++++-------------
 drivers/net/can/sja1000/sja1000.h             |  146 ++++++++++----------
 drivers/net/can/sja1000/sja1000_isa.c         |   28 +--
 drivers/net/can/sja1000/sja1000_of_platform.c |   22 +--
 drivers/net/can/sja1000/tscan1.c              |   16 +-
 include/linux/can/platform/sja1000.h          |   40 ++---
 12 files changed, 272 insertions(+), 270 deletions(-)


diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 36d298d..c814330 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -83,7 +83,7 @@ struct ems_pci_card {
  * Setting the OCR register to 0xDA is a good idea.
  * This means normal output mode, push-pull and the correct polarity.
  */
-#define EMS_PCI_OCR         (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
+#define EMS_PCI_OCR         (SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -91,7 +91,7 @@ struct ems_pci_card {
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
  */
-#define EMS_PCI_CDR             (CDR_CBP | CDR_CLKOUT_MASK)
+#define EMS_PCI_CDR             (SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
 
 #define EMS_PCI_V1_BASE_BAR     1
 #define EMS_PCI_V1_CONF_SIZE    4096 /* size of PITA control area */
@@ -168,14 +168,14 @@ static inline int ems_pci_check_chan(const struct sja1000_priv *priv)
 	unsigned char res;
 
 	/* Make sure SJA1000 is in reset mode */
-	priv->write_reg(priv, REG_MOD, 1);
+	priv->write_reg(priv, SJA_REG_MOD, 1);
 
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA_REG_CDR, SJA_CDR_PELICAN);
 
 	/* read reset-values */
-	res = priv->read_reg(priv, REG_CDR);
+	res = priv->read_reg(priv, SJA_REG_CDR);
 
-	if (res == CDR_PELICAN)
+	if (res == SJA_CDR_PELICAN)
 		return 1;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 5c2f3fb..894913e 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -51,7 +51,7 @@ struct ems_pcmcia_card {
  * Setting the OCR register to 0xDA is a good idea.
  * This means  normal output mode , push-pull and the correct polarity.
  */
-#define EMS_PCMCIA_OCR (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
+#define EMS_PCMCIA_OCR (SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -59,7 +59,7 @@ struct ems_pcmcia_card {
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
  */
-#define EMS_PCMCIA_CDR (CDR_CBP | CDR_CLKOUT_MASK)
+#define EMS_PCMCIA_CDR (SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
 #define EMS_PCMCIA_MEM_SIZE 4096 /* Size of the remapped io-memory */
 #define EMS_PCMCIA_CAN_BASE_OFFSET 0x100 /* Offset where controllers starts */
 #define EMS_PCMCIA_CAN_CTRL_SIZE 0x80 /* Memory size for each controller */
@@ -126,11 +126,11 @@ static irqreturn_t ems_pcmcia_interrupt(int irq, void *dev_id)
 static inline int ems_pcmcia_check_chan(struct sja1000_priv *priv)
 {
 	/* Make sure SJA1000 is in reset mode */
-	ems_pcmcia_write_reg(priv, REG_MOD, 1);
-	ems_pcmcia_write_reg(priv, REG_CDR, CDR_PELICAN);
+	ems_pcmcia_write_reg(priv, SJA_REG_MOD, 1);
+	ems_pcmcia_write_reg(priv, SJA_REG_CDR, SJA_CDR_PELICAN);
 
 	/* read reset-values */
-	if (ems_pcmcia_read_reg(priv, REG_CDR) == CDR_PELICAN)
+	if (ems_pcmcia_read_reg(priv, SJA_REG_CDR) == SJA_CDR_PELICAN)
 		return 1;
 
 	return 0;
@@ -224,7 +224,7 @@ static int ems_pcmcia_add_card(struct pcmcia_device *pdev, unsigned long base)
 			priv->can.clock.freq = EMS_PCMCIA_CAN_CLOCK;
 			priv->ocr = EMS_PCMCIA_OCR;
 			priv->cdr = EMS_PCMCIA_CDR;
-			priv->flags |= SJA1000_CUSTOM_IRQ_HANDLER;
+			priv->flags |= SJA_CUSTOM_IRQ_HANDLER;
 
 			/* Register SJA1000 device */
 			err = register_sja1000dev(dev);
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 37b0381..fb7dc8a 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -70,7 +70,7 @@ struct kvaser_pci {
  * Setting the OCR register to 0xDA is a good idea.
  * This means  normal output mode , push-pull and the correct polarity.
  */
-#define KVASER_PCI_OCR            (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
+#define KVASER_PCI_OCR            (SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -78,7 +78,7 @@ struct kvaser_pci {
  * (meaning divide-by-2), the Pelican bit, and the clock-off bit
  * (you will have no need for CLKOUT anyway).
  */
-#define KVASER_PCI_CDR            (CDR_CBP | CDR_CLKOUT_MASK)
+#define KVASER_PCI_CDR            (SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
 
 /*
  * These register values are valid for revision 14 of the Xilinx logic.
@@ -158,12 +158,12 @@ static int number_of_sja1000_chip(void __iomem *base_addr)
 
 	for (i = 0; i < MAX_NO_OF_CHANNELS; i++) {
 		/* reset chip */
-		iowrite8(MOD_RM, base_addr +
-			 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+		iowrite8(SJA_MOD_RM, base_addr +
+			 (i * KVASER_PCI_PORT_BYTES) + SJA_REG_MOD);
 		status = ioread8(base_addr +
-				 (i * KVASER_PCI_PORT_BYTES) + REG_MOD);
+				 (i * KVASER_PCI_PORT_BYTES) + SJA_REG_MOD);
 		/* check reset bit */
-		if (!(status & MOD_RM))
+		if (!(status & SJA_MOD_RM))
 			break;
 	}
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index d1e7f10..18731a2 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -48,8 +48,8 @@ struct peak_pci_chan {
 
 #define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
 
-#define PEAK_PCI_CDR		(CDR_CBP | CDR_CLKOUT_MASK)
-#define PEAK_PCI_OCR		OCR_TX0_PUSHPULL
+#define PEAK_PCI_CDR		(SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
+#define PEAK_PCI_OCR		SJA_OCR_TX0_PUSHPULL
 
 /*
  * Important PITA registers
@@ -402,9 +402,9 @@ static void peak_pciec_write_reg(const struct sja1000_priv *priv,
 	int c = (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA_REG_MOD)
 		switch (val) {
-		case MOD_RM:
+		case SJA_MOD_RM:
 			/* Reset Mode: set led on */
 			peak_pciec_set_leds(card, PCA9553_LED(c), PCA9553_ON);
 			break;
@@ -632,7 +632,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		priv->cdr = PEAK_PCI_CDR;
 		/* Neither a slave nor a single device distributes the clock */
 		if (channels == 1 || i > 0)
-			priv->cdr |= CDR_CLK_OFF;
+			priv->cdr |= SJA_CDR_CLK_OFF;
 
 		/* Setup interrupt handling */
 		priv->irq_flags = IRQF_SHARED;
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 1a7020b..e14c41afe 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -125,7 +125,7 @@ MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");
  * Setting the OCR register to 0xDA is a good idea.
  * This means normal output mode, push-pull and the correct polarity.
  */
-#define PCC_OCR			(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
+#define PCC_OCR			(SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -133,7 +133,7 @@ MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
  */
-#define PCC_CDR			(CDR_CBP | CDR_CLKOUT_MASK)
+#define PCC_CDR			(SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
 
 struct pcan_channel {
 	struct net_device *netdev;
@@ -196,9 +196,9 @@ static void pcan_write_canreg(const struct sja1000_priv *priv, int port, u8 v)
 	int c = (priv->reg_base - card->ioport_addr) / PCC_CHAN_SIZE;
 
 	/* sja1000 register changes control the leds state */
-	if (port == REG_MOD)
+	if (port == SJA_REG_MOD)
 		switch (v) {
-		case MOD_RM:
+		case SJA_MOD_RM:
 			/* Reset Mode: set led on */
 			pcan_set_leds(card, PCC_LED(c), PCC_LED_ON);
 			break;
@@ -453,7 +453,7 @@ static irqreturn_t pcan_isr(int irq, void *dev_id)
 			}
 
 			/*
-			 * should check whether all or SJA1000_MAX_IRQ
+			 * should check whether all or SJA_MAX_IRQ
 			 * interrupts have been handled: loop again to be sure.
 			 */
 			netdev = card->channel[i].netdev;
@@ -509,11 +509,11 @@ static void pcan_free_channels(struct pcan_pccard *card)
 static inline int pcan_channel_present(struct sja1000_priv *priv)
 {
 	/* make sure SJA1000 is in reset mode */
-	pcan_write_canreg(priv, REG_MOD, 1);
-	pcan_write_canreg(priv, REG_CDR, CDR_PELICAN);
+	pcan_write_canreg(priv, SJA_REG_MOD, 1);
+	pcan_write_canreg(priv, SJA_REG_CDR, SJA_CDR_PELICAN);
 
 	/* read reset-values */
-	if (pcan_read_canreg(priv, REG_CDR) == CDR_PELICAN)
+	if (pcan_read_canreg(priv, SJA_REG_CDR) == SJA_CDR_PELICAN)
 		return 1;
 
 	return 0;
@@ -570,9 +570,9 @@ static int pcan_add_channels(struct pcan_pccard *card)
 
 		/* Neither a slave device distributes the clock */
 		if (i > 0)
-			priv->cdr |= CDR_CLK_OFF;
+			priv->cdr |= SJA_CDR_CLK_OFF;
 
-		priv->flags |= SJA1000_CUSTOM_IRQ_HANDLER;
+		priv->flags |= SJA_CUSTOM_IRQ_HANDLER;
 
 		/* register SJA1000 device */
 		err = register_sja1000dev(netdev);
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 3c18d7d..ba51a71 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -89,7 +89,7 @@ struct plx_pci_card {
  * Setting the OCR register to 0xDA is a good idea.
  * This means normal output mode, push-pull and the correct polarity.
  */
-#define PLX_PCI_OCR	(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
+#define PLX_PCI_OCR	(SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -97,21 +97,21 @@ struct plx_pci_card {
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
  */
-#define PLX_PCI_CDR			(CDR_CBP | CDR_CLKOUT_MASK)
+#define PLX_PCI_CDR			(SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
 
 /* SJA1000 Control Register in the BasicCAN Mode */
-#define REG_CR				0x00
+#define SJA_REG_CR				0x00
 
 /* States of some SJA1000 registers after hardware reset in the BasicCAN mode*/
-#define REG_CR_BASICCAN_INITIAL		0x21
-#define REG_CR_BASICCAN_INITIAL_MASK	0xa1
-#define REG_SR_BASICCAN_INITIAL		0x0c
-#define REG_IR_BASICCAN_INITIAL		0xe0
+#define SJA_REG_CR_BASICCAN_INITIAL		0x21
+#define SJA_REG_CR_BASICCAN_INITIAL_MASK	0xa1
+#define SJA_REG_SR_BASICCAN_INITIAL		0x0c
+#define SJA_REG_IR_BASICCAN_INITIAL		0xe0
 
 /* States of some SJA1000 registers after hardware reset in the PeliCAN mode*/
-#define REG_MOD_PELICAN_INITIAL		0x01
-#define REG_SR_PELICAN_INITIAL		0x3c
-#define REG_IR_PELICAN_INITIAL		0x00
+#define SJA_REG_MOD_PELICAN_INITIAL		0x01
+#define SJA_REG_SR_PELICAN_INITIAL		0x3c
+#define SJA_REG_IR_PELICAN_INITIAL		0x00
 
 #define ADLINK_PCI_VENDOR_ID		0x144A
 #define ADLINK_PCI_DEVICE_ID		0x7841
@@ -346,22 +346,23 @@ static inline int plx_pci_check_sja1000(const struct sja1000_priv *priv)
 	 * Check registers after hardware reset (the Basic mode)
 	 * See states on p. 10 of the Datasheet.
 	 */
-	if ((priv->read_reg(priv, REG_CR) & REG_CR_BASICCAN_INITIAL_MASK) ==
-	    REG_CR_BASICCAN_INITIAL &&
-	    (priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_BASICCAN_INITIAL) &&
-	    (priv->read_reg(priv, REG_IR) == REG_IR_BASICCAN_INITIAL))
+	if ((priv->read_reg(priv, SJA_REG_CR) &
+	     SJA_REG_CR_BASICCAN_INITIAL_MASK) ==
+	    SJA_REG_CR_BASICCAN_INITIAL &&
+	    (priv->read_reg(priv, SJA_REG_SR) == SJA_REG_SR_BASICCAN_INITIAL) &&
+	    (priv->read_reg(priv, SJA_REG_IR) == SJA_REG_IR_BASICCAN_INITIAL))
 		flag = 1;
 
 	/* Bring the SJA1000 into the PeliCAN mode*/
-	priv->write_reg(priv, REG_CDR, CDR_PELICAN);
+	priv->write_reg(priv, SJA_REG_CDR, SJA_CDR_PELICAN);
 
 	/*
 	 * Check registers after reset in the PeliCAN mode.
 	 * See states on p. 23 of the Datasheet.
 	 */
-	if (priv->read_reg(priv, REG_MOD) == REG_MOD_PELICAN_INITIAL &&
-	    priv->read_reg(priv, SJA1000_REG_SR) == REG_SR_PELICAN_INITIAL &&
-	    priv->read_reg(priv, REG_IR) == REG_IR_PELICAN_INITIAL)
+	if (priv->read_reg(priv, SJA_REG_MOD) == SJA_REG_MOD_PELICAN_INITIAL &&
+	    priv->read_reg(priv, SJA_REG_SR) == SJA_REG_SR_PELICAN_INITIAL &&
+	    priv->read_reg(priv, SJA_REG_IR) == SJA_REG_IR_PELICAN_INITIAL)
 		return flag;
 
 	return 0;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index e4df307..16bb100 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -91,14 +91,14 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
 	 * the write_reg() operation - especially on SMP systems.
 	 */
 	spin_lock_irqsave(&priv->cmdreg_lock, flags);
-	priv->write_reg(priv, REG_CMR, val);
-	priv->read_reg(priv, SJA1000_REG_SR);
+	priv->write_reg(priv, SJA_REG_CMR, val);
+	priv->read_reg(priv, SJA_REG_SR);
 	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
 }
 
 static int sja1000_is_absent(struct sja1000_priv *priv)
 {
-	return (priv->read_reg(priv, REG_MOD) == 0xFF);
+	return (priv->read_reg(priv, SJA_REG_MOD) == 0xFF);
 }
 
 static int sja1000_probe_chip(struct net_device *dev)
@@ -116,22 +116,22 @@ static int sja1000_probe_chip(struct net_device *dev)
 static void set_reset_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA_REG_MOD);
 	int i;
 
 	/* disable interrupts */
-	priv->write_reg(priv, REG_IER, IRQ_OFF);
+	priv->write_reg(priv, SJA_REG_IER, SJA_IRQ_OFF);
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
-		if (status & MOD_RM) {
+		if (status & SJA_MOD_RM) {
 			priv->can.state = CAN_STATE_STOPPED;
 			return;
 		}
 
-		priv->write_reg(priv, REG_MOD, MOD_RM);	/* reset chip */
+		priv->write_reg(priv, SJA_REG_MOD, SJA_MOD_RM);	/* reset chip */
 		udelay(10);
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA_REG_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into reset mode failed!\n");
@@ -140,31 +140,31 @@ static void set_reset_mode(struct net_device *dev)
 static void set_normal_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
-	unsigned char status = priv->read_reg(priv, REG_MOD);
+	unsigned char status = priv->read_reg(priv, SJA_REG_MOD);
 	int i;
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
-		if ((status & MOD_RM) == 0) {
+		if ((status & SJA_MOD_RM) == 0) {
 			priv->can.state = CAN_STATE_ERROR_ACTIVE;
 			/* enable interrupts */
 			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-				priv->write_reg(priv, REG_IER, IRQ_ALL);
+				priv->write_reg(priv, SJA_REG_IER, SJA_IRQ_ALL);
 			else
-				priv->write_reg(priv, REG_IER,
-						IRQ_ALL & ~IRQ_BEI);
+				priv->write_reg(priv, SJA_REG_IER,
+						SJA_IRQ_ALL & ~SJA_IRQ_BEI);
 			return;
 		}
 
 		/* set chip to normal mode */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-			priv->write_reg(priv, REG_MOD, MOD_LOM);
+			priv->write_reg(priv, SJA_REG_MOD, SJA_MOD_LOM);
 		else
-			priv->write_reg(priv, REG_MOD, 0x00);
+			priv->write_reg(priv, SJA_REG_MOD, 0x00);
 
 		udelay(10);
 
-		status = priv->read_reg(priv, REG_MOD);
+		status = priv->read_reg(priv, SJA_REG_MOD);
 	}
 
 	netdev_err(dev, "setting SJA1000 into normal mode failed!\n");
@@ -179,9 +179,9 @@ static void sja1000_start(struct net_device *dev)
 		set_reset_mode(dev);
 
 	/* Clear error counters and error code capture */
-	priv->write_reg(priv, REG_TXERR, 0x0);
-	priv->write_reg(priv, REG_RXERR, 0x0);
-	priv->read_reg(priv, REG_ECC);
+	priv->write_reg(priv, SJA_REG_TXERR, 0x0);
+	priv->write_reg(priv, SJA_REG_RXERR, 0x0);
+	priv->read_reg(priv, SJA_REG_ECC);
 
 	/* leave reset mode */
 	set_normal_mode(dev);
@@ -217,8 +217,8 @@ static int sja1000_set_bittiming(struct net_device *dev)
 
 	netdev_info(dev, "setting BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);
 
-	priv->write_reg(priv, REG_BTR0, btr0);
-	priv->write_reg(priv, REG_BTR1, btr1);
+	priv->write_reg(priv, SJA_REG_BTR0, btr0);
+	priv->write_reg(priv, SJA_REG_BTR1, btr1);
 
 	return 0;
 }
@@ -228,8 +228,8 @@ static int sja1000_get_berr_counter(const struct net_device *dev,
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
-	bec->txerr = priv->read_reg(priv, REG_TXERR);
-	bec->rxerr = priv->read_reg(priv, REG_RXERR);
+	bec->txerr = priv->read_reg(priv, SJA_REG_TXERR);
+	bec->rxerr = priv->read_reg(priv, SJA_REG_RXERR);
 
 	return 0;
 }
@@ -247,20 +247,20 @@ static void chipset_init(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	/* set clock divider and output control register */
-	priv->write_reg(priv, REG_CDR, priv->cdr | CDR_PELICAN);
+	priv->write_reg(priv, SJA_REG_CDR, priv->cdr | SJA_CDR_PELICAN);
 
 	/* set acceptance filter (accept all) */
-	priv->write_reg(priv, REG_ACCC0, 0x00);
-	priv->write_reg(priv, REG_ACCC1, 0x00);
-	priv->write_reg(priv, REG_ACCC2, 0x00);
-	priv->write_reg(priv, REG_ACCC3, 0x00);
+	priv->write_reg(priv, SJA_REG_ACCC0, 0x00);
+	priv->write_reg(priv, SJA_REG_ACCC1, 0x00);
+	priv->write_reg(priv, SJA_REG_ACCC2, 0x00);
+	priv->write_reg(priv, SJA_REG_ACCC3, 0x00);
 
-	priv->write_reg(priv, REG_ACCM0, 0xFF);
-	priv->write_reg(priv, REG_ACCM1, 0xFF);
-	priv->write_reg(priv, REG_ACCM2, 0xFF);
-	priv->write_reg(priv, REG_ACCM3, 0xFF);
+	priv->write_reg(priv, SJA_REG_ACCM0, 0xFF);
+	priv->write_reg(priv, SJA_REG_ACCM1, 0xFF);
+	priv->write_reg(priv, SJA_REG_ACCM2, 0xFF);
+	priv->write_reg(priv, SJA_REG_ACCM3, 0xFF);
 
-	priv->write_reg(priv, REG_OCR, priv->ocr | OCR_MODE_NORMAL);
+	priv->write_reg(priv, SJA_REG_OCR, priv->ocr | SJA_OCR_MODE_NORMAL);
 }
 
 /*
@@ -289,21 +289,21 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	id = cf->can_id;
 
 	if (id & CAN_RTR_FLAG)
-		fi |= FI_RTR;
+		fi |= SJA_FI_RTR;
 
 	if (id & CAN_EFF_FLAG) {
-		fi |= FI_FF;
-		dreg = EFF_BUF;
-		priv->write_reg(priv, REG_FI, fi);
-		priv->write_reg(priv, REG_ID1, (id & 0x1fe00000) >> (5 + 16));
-		priv->write_reg(priv, REG_ID2, (id & 0x001fe000) >> (5 + 8));
-		priv->write_reg(priv, REG_ID3, (id & 0x00001fe0) >> 5);
-		priv->write_reg(priv, REG_ID4, (id & 0x0000001f) << 3);
+		fi |= SJA_FI_FF;
+		dreg = SJA_EFF_BUF;
+		priv->write_reg(priv, SJA_REG_FI, fi);
+		priv->write_reg(priv, SJA_REG_ID1, (id & 0x1fe00000) >> 21);
+		priv->write_reg(priv, SJA_REG_ID2, (id & 0x001fe000) >> 13);
+		priv->write_reg(priv, SJA_REG_ID3, (id & 0x00001fe0) >> 5);
+		priv->write_reg(priv, SJA_REG_ID4, (id & 0x0000001f) << 3);
 	} else {
-		dreg = SFF_BUF;
-		priv->write_reg(priv, REG_FI, fi);
-		priv->write_reg(priv, REG_ID1, (id & 0x000007f8) >> 3);
-		priv->write_reg(priv, REG_ID2, (id & 0x00000007) << 5);
+		dreg = SJA_SFF_BUF;
+		priv->write_reg(priv, SJA_REG_FI, fi);
+		priv->write_reg(priv, SJA_REG_ID1, (id & 0x000007f8) >> 3);
+		priv->write_reg(priv, SJA_REG_ID2, (id & 0x00000007) << 5);
 	}
 
 	for (i = 0; i < dlc; i++)
@@ -312,9 +312,9 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	can_put_echo_skb(skb, dev, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
-		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
+		sja1000_write_cmdreg(priv, SJA_CMD_TR | SJA_CMD_AT);
 	else
-		sja1000_write_cmdreg(priv, CMD_TR);
+		sja1000_write_cmdreg(priv, SJA_CMD_TR);
 
 	return NETDEV_TX_OK;
 }
@@ -335,25 +335,25 @@ static void sja1000_rx(struct net_device *dev)
 	if (skb == NULL)
 		return;
 
-	fi = priv->read_reg(priv, REG_FI);
+	fi = priv->read_reg(priv, SJA_REG_FI);
 
-	if (fi & FI_FF) {
+	if (fi & SJA_FI_FF) {
 		/* extended frame format (EFF) */
-		dreg = EFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << (5 + 16))
-		    | (priv->read_reg(priv, REG_ID2) << (5 + 8))
-		    | (priv->read_reg(priv, REG_ID3) << 5)
-		    | (priv->read_reg(priv, REG_ID4) >> 3);
+		dreg = SJA_EFF_BUF;
+		id = (priv->read_reg(priv, SJA_REG_ID1) << (5 + 16))
+		    | (priv->read_reg(priv, SJA_REG_ID2) << (5 + 8))
+		    | (priv->read_reg(priv, SJA_REG_ID3) << 5)
+		    | (priv->read_reg(priv, SJA_REG_ID4) >> 3);
 		id |= CAN_EFF_FLAG;
 	} else {
 		/* standard frame format (SFF) */
-		dreg = SFF_BUF;
-		id = (priv->read_reg(priv, REG_ID1) << 3)
-		    | (priv->read_reg(priv, REG_ID2) >> 5);
+		dreg = SJA_SFF_BUF;
+		id = (priv->read_reg(priv, SJA_REG_ID1) << 3)
+		    | (priv->read_reg(priv, SJA_REG_ID2) >> 5);
 	}
 
 	cf->can_dlc = get_can_dlc(fi & 0x0F);
-	if (fi & FI_RTR) {
+	if (fi & SJA_FI_RTR) {
 		id |= CAN_RTR_FLAG;
 	} else {
 		for (i = 0; i < cf->can_dlc; i++)
@@ -363,7 +363,7 @@ static void sja1000_rx(struct net_device *dev)
 	cf->can_id = id;
 
 	/* release receive buffer */
-	sja1000_write_cmdreg(priv, CMD_RRB);
+	sja1000_write_cmdreg(priv, SJA_CMD_RRB);
 
 	netif_rx(skb);
 
@@ -386,69 +386,69 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (skb == NULL)
 		return -ENOMEM;
 
-	if (isrc & IRQ_DOI) {
+	if (isrc & SJA_IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_over_errors++;
 		stats->rx_errors++;
-		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
+		sja1000_write_cmdreg(priv, SJA_CMD_CDO);	/* clear bit */
 	}
 
-	if (isrc & IRQ_EI) {
+	if (isrc & SJA_IRQ_EI) {
 		/* error warning interrupt */
 		netdev_dbg(dev, "error warning interrupt\n");
 
-		if (status & SR_BS) {
+		if (status & SJA_SR_BS) {
 			state = CAN_STATE_BUS_OFF;
 			cf->can_id |= CAN_ERR_BUSOFF;
 			can_bus_off(dev);
-		} else if (status & SR_ES) {
+		} else if (status & SJA_SR_ES) {
 			state = CAN_STATE_ERROR_WARNING;
 		} else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (isrc & IRQ_BEI) {
+	if (isrc & SJA_IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
 
-		ecc = priv->read_reg(priv, REG_ECC);
+		ecc = priv->read_reg(priv, SJA_REG_ECC);
 
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		switch (ecc & ECC_MASK) {
-		case ECC_BIT:
+		switch (ecc & SJA_ECC_MASK) {
+		case SJA_ECC_BIT:
 			cf->data[2] |= CAN_ERR_PROT_BIT;
 			break;
-		case ECC_FORM:
+		case SJA_ECC_FORM:
 			cf->data[2] |= CAN_ERR_PROT_FORM;
 			break;
-		case ECC_STUFF:
+		case SJA_ECC_STUFF:
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 			break;
 		default:
 			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
-			cf->data[3] = ecc & ECC_SEG;
+			cf->data[3] = ecc & SJA_ECC_SEG;
 			break;
 		}
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
+		if ((ecc & SJA_ECC_DIR) == 0)
 			cf->data[2] |= CAN_ERR_PROT_TX;
 	}
-	if (isrc & IRQ_EPI) {
+	if (isrc & SJA_IRQ_EPI) {
 		/* error passive interrupt */
 		netdev_dbg(dev, "error passive interrupt\n");
-		if (status & SR_ES)
+		if (status & SJA_SR_ES)
 			state = CAN_STATE_ERROR_PASSIVE;
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (isrc & IRQ_ALI) {
+	if (isrc & SJA_IRQ_ALI) {
 		/* arbitration lost interrupt */
 		netdev_dbg(dev, "arbitration lost interrupt\n");
-		alc = priv->read_reg(priv, REG_ALC);
+		alc = priv->read_reg(priv, SJA_REG_ALC);
 		priv->can.can_stats.arbitration_lost++;
 		stats->tx_errors++;
 		cf->can_id |= CAN_ERR_LOSTARB;
@@ -457,8 +457,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
 					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, REG_RXERR);
-		uint8_t txerr = priv->read_reg(priv, REG_TXERR);
+		uint8_t rxerr = priv->read_reg(priv, SJA_REG_RXERR);
+		uint8_t txerr = priv->read_reg(priv, SJA_REG_TXERR);
 		cf->can_id |= CAN_ERR_CRTL;
 		if (state == CAN_STATE_ERROR_WARNING) {
 			priv->can.can_stats.error_warning++;
@@ -494,49 +494,50 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	int n = 0;
 
 	/* Shared interrupts and IRQ off? */
-	if (priv->read_reg(priv, REG_IER) == IRQ_OFF)
+	if (priv->read_reg(priv, SJA_REG_IER) == SJA_IRQ_OFF)
 		return IRQ_NONE;
 
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
 
-	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
+	while ((isrc = priv->read_reg(priv, SJA_REG_IR)) && (n < SJA_MAX_IRQ)) {
 		n++;
-		status = priv->read_reg(priv, SJA1000_REG_SR);
+		status = priv->read_reg(priv, SJA_REG_SR);
 		/* check for absent controller due to hw unplug */
 		if (status == 0xFF && sja1000_is_absent(priv))
 			return IRQ_NONE;
 
-		if (isrc & IRQ_WUI)
+		if (isrc & SJA_IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
 
-		if (isrc & IRQ_TI) {
+		if (isrc & SJA_IRQ_TI) {
 			/* transmission buffer released */
 			if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
-			    !(status & SR_TCS)) {
+			    !(status & SJA_SR_TCS)) {
 				stats->tx_errors++;
 				can_free_echo_skb(dev, 0);
 			} else {
 				/* transmission complete */
 				stats->tx_bytes +=
-					priv->read_reg(priv, REG_FI) & 0xf;
+					priv->read_reg(priv, SJA_REG_FI) & 0xf;
 				stats->tx_packets++;
 				can_get_echo_skb(dev, 0);
 			}
 			netif_wake_queue(dev);
 			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
-		if (isrc & IRQ_RI) {
+		if (isrc & SJA_IRQ_RI) {
 			/* receive interrupt */
-			while (status & SR_RBS) {
+			while (status & SJA_SR_RBS) {
 				sja1000_rx(dev);
-				status = priv->read_reg(priv, SJA1000_REG_SR);
+				status = priv->read_reg(priv, SJA_REG_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
 					return IRQ_NONE;
 			}
 		}
-		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
+		if (isrc & (SJA_IRQ_DOI | SJA_IRQ_EI | SJA_IRQ_BEI |
+			    SJA_IRQ_EPI | SJA_IRQ_ALI)) {
 			/* error interrupt */
 			if (sja1000_err(dev, isrc, status))
 				break;
@@ -546,7 +547,7 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
-	if (n >= SJA1000_MAX_IRQ)
+	if (n >= SJA_MAX_IRQ)
 		netdev_dbg(dev, "%d messages handled in ISR", n);
 
 	return (n) ? IRQ_HANDLED : IRQ_NONE;
@@ -567,7 +568,7 @@ static int sja1000_open(struct net_device *dev)
 		return err;
 
 	/* register interrupt handler, if not done by the device driver */
-	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER)) {
+	if (!(priv->flags & SJA_CUSTOM_IRQ_HANDLER)) {
 		err = request_irq(dev->irq, sja1000_interrupt, priv->irq_flags,
 				  dev->name, (void *)dev);
 		if (err) {
@@ -593,7 +594,7 @@ static int sja1000_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	set_reset_mode(dev);
 
-	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER))
+	if (!(priv->flags & SJA_CUSTOM_IRQ_HANDLER))
 		free_irq(dev->irq, (void *)dev);
 
 	close_candev(dev);
@@ -609,7 +610,7 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 	struct sja1000_priv *priv;
 
 	dev = alloc_candev(sizeof(struct sja1000_priv) + sizeof_priv,
-		SJA1000_ECHO_SKB_MAX);
+		SJA_ECHO_SKB_MAX);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index aa48e05..936f4d5 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -49,103 +49,103 @@
 #include <linux/can/dev.h>
 #include <linux/can/platform/sja1000.h>
 
-#define SJA1000_ECHO_SKB_MAX	1 /* the SJA1000 has one TX buffer object */
+#define SJA_ECHO_SKB_MAX	1 /* the SJA1000 has one TX buffer object */
 
-#define SJA1000_MAX_IRQ 20	/* max. number of interrupts handled in ISR */
+#define SJA_MAX_IRQ 20	/* max. number of interrupts handled in ISR */
 
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
+#define SJA_REG_MOD		0x00
+#define SJA_REG_CMR		0x01
+#define SJA_REG_SR		0x02
+#define SJA_REG_IR		0x03
+#define SJA_REG_IER		0x04
+#define SJA_REG_ALC		0x0B
+#define SJA_REG_ECC		0x0C
+#define SJA_REG_EWL		0x0D
+#define SJA_REG_RXERR	0x0E
+#define SJA_REG_TXERR	0x0F
+#define SJA_REG_ACCC0	0x10
+#define SJA_REG_ACCC1	0x11
+#define SJA_REG_ACCC2	0x12
+#define SJA_REG_ACCC3	0x13
+#define SJA_REG_ACCM0	0x14
+#define SJA_REG_ACCM1	0x15
+#define SJA_REG_ACCM2	0x16
+#define SJA_REG_ACCM3	0x17
+#define SJA_REG_RMC		0x1D
+#define SJA_REG_RBSA	0x1E
 
 /* Common registers - manual section 6.5 */
-#define REG_BTR0	0x06
-#define REG_BTR1	0x07
-#define REG_OCR		0x08
-#define REG_CDR		0x1F
+#define SJA_REG_BTR0	0x06
+#define SJA_REG_BTR1	0x07
+#define SJA_REG_OCR		0x08
+#define SJA_REG_CDR		0x1F
 
-#define REG_FI		0x10
-#define SFF_BUF		0x13
-#define EFF_BUF		0x15
+#define SJA_REG_FI		0x10
+#define SJA_SFF_BUF		0x13
+#define SJA_EFF_BUF		0x15
 
-#define FI_FF		0x80
-#define FI_RTR		0x40
+#define SJA_FI_FF		0x80
+#define SJA_FI_RTR		0x40
 
-#define REG_ID1		0x11
-#define REG_ID2		0x12
-#define REG_ID3		0x13
-#define REG_ID4		0x14
+#define SJA_REG_ID1		0x11
+#define SJA_REG_ID2		0x12
+#define SJA_REG_ID3		0x13
+#define SJA_REG_ID4		0x14
 
-#define CAN_RAM		0x20
+#define SJA_CAN_RAM		0x20
 
 /* mode register */
-#define MOD_RM		0x01
-#define MOD_LOM		0x02
-#define MOD_STM		0x04
-#define MOD_AFM		0x08
-#define MOD_SM		0x10
+#define SJA_MOD_RM		0x01
+#define SJA_MOD_LOM		0x02
+#define SJA_MOD_STM		0x04
+#define SJA_MOD_AFM		0x08
+#define SJA_MOD_SM		0x10
 
 /* commands */
-#define CMD_SRR		0x10
-#define CMD_CDO		0x08
-#define CMD_RRB		0x04
-#define CMD_AT		0x02
-#define CMD_TR		0x01
+#define SJA_CMD_SRR		0x10
+#define SJA_CMD_CDO		0x08
+#define SJA_CMD_RRB		0x04
+#define SJA_CMD_AT		0x02
+#define SJA_CMD_TR		0x01
 
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
+#define SJA_IRQ_BEI		0x80
+#define SJA_IRQ_ALI		0x40
+#define SJA_IRQ_EPI		0x20
+#define SJA_IRQ_WUI		0x10
+#define SJA_IRQ_DOI		0x08
+#define SJA_IRQ_EI		0x04
+#define SJA_IRQ_TI		0x02
+#define SJA_IRQ_RI		0x01
+#define SJA_IRQ_ALL		0xFF
+#define SJA_IRQ_OFF		0x00
 
 /* status register content */
-#define SR_BS		0x80
-#define SR_ES		0x40
-#define SR_TS		0x20
-#define SR_RS		0x10
-#define SR_TCS		0x08
-#define SR_TBS		0x04
-#define SR_DOS		0x02
-#define SR_RBS		0x01
+#define SJA_SR_BS		0x80
+#define SJA_SR_ES		0x40
+#define SJA_SR_TS		0x20
+#define SJA_SR_RS		0x10
+#define SJA_SR_TCS		0x08
+#define SJA_SR_TBS		0x04
+#define SJA_SR_DOS		0x02
+#define SJA_SR_RBS		0x01
 
-#define SR_CRIT (SR_BS|SR_ES)
+#define SJA_SR_CRIT (SJA_SR_BS | SJA_SR_ES)
 
 /* ECC register */
-#define ECC_SEG		0x1F
-#define ECC_DIR		0x20
-#define ECC_ERR		6
-#define ECC_BIT		0x00
-#define ECC_FORM	0x40
-#define ECC_STUFF	0x80
-#define ECC_MASK	0xc0
+#define SJA_ECC_SEG		0x1F
+#define SJA_ECC_DIR		0x20
+#define SJA_ECC_ERR		6
+#define SJA_ECC_BIT		0x00
+#define SJA_ECC_FORM	0x40
+#define SJA_ECC_STUFF	0x80
+#define SJA_ECC_MASK	0xc0
 
 /*
  * Flags for sja1000priv.flags
  */
-#define SJA1000_CUSTOM_IRQ_HANDLER 0x1
+#define SJA_CUSTOM_IRQ_HANDLER 0x1
 
 /*
  * SJA1000 private data structure
diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
index 5c8da46..a5c23e3 100644
--- a/drivers/net/can/sja1000/sja1000_isa.c
+++ b/drivers/net/can/sja1000/sja1000_isa.c
@@ -37,8 +37,8 @@ MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the ISA bus");
 MODULE_LICENSE("GPL v2");
 
 #define CLK_DEFAULT	16000000	/* 16 MHz */
-#define CDR_DEFAULT	(CDR_CBP | CDR_CLK_OFF)
-#define OCR_DEFAULT	OCR_TX0_PUSHPULL
+#define SJA_CDR_DEFAULT	(SJA_CDR_CBP | SJA_CDR_CLK_OFF)
+#define SJA_OCR_DEFAULT	SJA_OCR_TX0_PUSHPULL
 
 static unsigned long port[MAXDEV];
 static unsigned long mem[MAXDEV];
@@ -66,14 +66,14 @@ MODULE_PARM_DESC(clk, "External oscillator clock frequency "
 
 module_param_array(cdr, byte, NULL, S_IRUGO);
 MODULE_PARM_DESC(cdr, "Clock divider register "
-		 "(default=0x48 [CDR_CBP | CDR_CLK_OFF])");
+		 "(default=0x48 [SJA_CDR_CBP | SJA_CDR_CLK_OFF])");
 
 module_param_array(ocr, byte, NULL, S_IRUGO);
 MODULE_PARM_DESC(ocr, "Output control register "
-		 "(default=0x18 [OCR_TX0_PUSHPULL])");
+		 "(default=0x18 [SJA_OCR_TX0_PUSHPULL])");
 
-#define SJA1000_IOSIZE          0x20
-#define SJA1000_IOSIZE_INDIRECT 0x02
+#define SJA_IOSIZE          0x20
+#define SJA_IOSIZE_INDIRECT 0x02
 
 static struct platform_device *sja1000_isa_devs[MAXDEV];
 
@@ -122,7 +122,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct sja1000_priv *priv;
 	void __iomem *base = NULL;
-	int iosize = SJA1000_IOSIZE;
+	int iosize = SJA_IOSIZE;
 	int idx = pdev->id;
 	int err;
 
@@ -142,7 +142,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 	} else {
 		if (indirect[idx] > 0 ||
 		    (indirect[idx] == -1 && indirect[0] > 0))
-			iosize = SJA1000_IOSIZE_INDIRECT;
+			iosize = SJA_IOSIZE_INDIRECT;
 		if (!request_region(port[idx], iosize, DRV_NAME)) {
 			err = -EBUSY;
 			goto exit;
@@ -167,7 +167,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 		priv->reg_base = (void __iomem *)port[idx];
 		dev->base_addr = port[idx];
 
-		if (iosize == SJA1000_IOSIZE_INDIRECT) {
+		if (iosize == SJA_IOSIZE_INDIRECT) {
 			priv->read_reg = sja1000_isa_port_read_reg_indirect;
 			priv->write_reg = sja1000_isa_port_write_reg_indirect;
 		} else {
@@ -188,14 +188,14 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 	else if (ocr[0] != 0xff)
 		priv->ocr = ocr[0];
 	else
-		priv->ocr = OCR_DEFAULT;
+		priv->ocr = SJA_OCR_DEFAULT;
 
 	if (cdr[idx] != 0xff)
 		priv->cdr = cdr[idx];
 	else if (cdr[0] != 0xff)
 		priv->cdr = cdr[0];
 	else
-		priv->cdr = CDR_DEFAULT;
+		priv->cdr = SJA_CDR_DEFAULT;
 
 	dev_set_drvdata(&pdev->dev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -234,12 +234,12 @@ static int sja1000_isa_remove(struct platform_device *pdev)
 
 	if (mem[idx]) {
 		iounmap(priv->reg_base);
-		release_mem_region(mem[idx], SJA1000_IOSIZE);
+		release_mem_region(mem[idx], SJA_IOSIZE);
 	} else {
 		if (priv->read_reg == sja1000_isa_port_read_reg_indirect)
-			release_region(port[idx], SJA1000_IOSIZE_INDIRECT);
+			release_region(port[idx], SJA_IOSIZE_INDIRECT);
 		else
-			release_region(port[idx], SJA1000_IOSIZE);
+			release_region(port[idx], SJA_IOSIZE);
 	}
 	free_sja1000dev(dev);
 
diff --git a/drivers/net/can/sja1000/sja1000_of_platform.c b/drivers/net/can/sja1000/sja1000_of_platform.c
index 6433b81..83f61d7 100644
--- a/drivers/net/can/sja1000/sja1000_of_platform.c
+++ b/drivers/net/can/sja1000/sja1000_of_platform.c
@@ -54,10 +54,10 @@ MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the OF platform bus");
 MODULE_LICENSE("GPL v2");
 
-#define SJA1000_OFP_CAN_CLOCK  (16000000 / 2)
+#define SJA_OFP_CAN_CLOCK  (16000000 / 2)
 
-#define SJA1000_OFP_OCR        OCR_TX0_PULLDOWN
-#define SJA1000_OFP_CDR        (CDR_CBP | CDR_CLK_OFF)
+#define SJA_OFP_OCR        SJA_OCR_TX0_PULLDOWN
+#define SJA_OFP_CDR        (SJA_CDR_CBP | SJA_CDR_CLK_OFF)
 
 static u8 sja1000_ofp_read_reg(const struct sja1000_priv *priv, int reg)
 {
@@ -142,19 +142,19 @@ static int sja1000_ofp_probe(struct platform_device *ofdev)
 	if (prop && (prop_size ==  sizeof(u32)))
 		priv->can.clock.freq = *prop / 2;
 	else
-		priv->can.clock.freq = SJA1000_OFP_CAN_CLOCK; /* default */
+		priv->can.clock.freq = SJA_OFP_CAN_CLOCK; /* default */
 
 	prop = of_get_property(np, "nxp,tx-output-mode", &prop_size);
 	if (prop && (prop_size == sizeof(u32)))
-		priv->ocr |= *prop & OCR_MODE_MASK;
+		priv->ocr |= *prop & SJA_OCR_MODE_MASK;
 	else
-		priv->ocr |= OCR_MODE_NORMAL; /* default */
+		priv->ocr |= SJA_OCR_MODE_NORMAL; /* default */
 
 	prop = of_get_property(np, "nxp,tx-output-config", &prop_size);
 	if (prop && (prop_size == sizeof(u32)))
-		priv->ocr |= (*prop << OCR_TX_SHIFT) & OCR_TX_MASK;
+		priv->ocr |= (*prop << SJA_OCR_TX_SHIFT) & SJA_OCR_TX_MASK;
 	else
-		priv->ocr |= OCR_TX0_PULLDOWN; /* default */
+		priv->ocr |= SJA_OCR_TX0_PULLDOWN; /* default */
 
 	prop = of_get_property(np, "nxp,clock-out-frequency", &prop_size);
 	if (prop && (prop_size == sizeof(u32)) && *prop) {
@@ -163,14 +163,14 @@ static int sja1000_ofp_probe(struct platform_device *ofdev)
 		if (divider > 1)
 			priv->cdr |= divider / 2 - 1;
 		else
-			priv->cdr |= CDR_CLKOUT_MASK;
+			priv->cdr |= SJA_CDR_CLKOUT_MASK;
 	} else {
-		priv->cdr |= CDR_CLK_OFF; /* default */
+		priv->cdr |= SJA_CDR_CLK_OFF; /* default */
 	}
 
 	prop = of_get_property(np, "nxp,no-comparator-bypass", NULL);
 	if (!prop)
-		priv->cdr |= CDR_CBP; /* default */
+		priv->cdr |= SJA_CDR_CBP; /* default */
 
 	priv->irq_flags = IRQF_SHARED;
 	priv->reg_base = base;
diff --git a/drivers/net/can/sja1000/tscan1.c b/drivers/net/can/sja1000/tscan1.c
index 76513dd..eed415a 100644
--- a/drivers/net/can/sja1000/tscan1.c
+++ b/drivers/net/can/sja1000/tscan1.c
@@ -65,10 +65,10 @@ MODULE_LICENSE("GPL");
 #define TSCAN1_PLD_SIZE 8
 
 /* SJA1000 register space size */
-#define TSCAN1_SJA1000_SIZE 32
+#define TSCAN1_SJA_SIZE 32
 
 /* SJA1000 crystal frequency (16MHz) */
-#define TSCAN1_SJA1000_XTAL 16000000
+#define TSCAN1_SJA_XTAL 16000000
 
 /* SJA1000 IO base addresses */
 static const unsigned short tscan1_sja1000_addresses[] = {
@@ -136,14 +136,14 @@ static int tscan1_probe(struct device *dev, unsigned id)
 	priv = netdev_priv(netdev);
 	priv->read_reg = tscan1_read;
 	priv->write_reg = tscan1_write;
-	priv->can.clock.freq = TSCAN1_SJA1000_XTAL / 2;
-	priv->cdr = CDR_CBP | CDR_CLK_OFF;
-	priv->ocr = OCR_TX0_PUSHPULL;
+	priv->can.clock.freq = TSCAN1_SJA_XTAL / 2;
+	priv->cdr = SJA_CDR_CBP | SJA_CDR_CLK_OFF;
+	priv->ocr = SJA_OCR_TX0_PUSHPULL;
 
 	/* Select the first SJA1000 IO address that is free and that works */
 	for (i = 0; i < ARRAY_SIZE(tscan1_sja1000_addresses); i++) {
 		sja1000_base = tscan1_sja1000_addresses[i];
-		if (!request_region(sja1000_base, TSCAN1_SJA1000_SIZE,
+		if (!request_region(sja1000_base, TSCAN1_SJA_SIZE,
 								dev_name(dev)))
 			continue;
 
@@ -161,7 +161,7 @@ static int tscan1_probe(struct device *dev, unsigned id)
 
 		/* SJA1000 probe failed; release and try next address */
 		outb(0, pld_base + TSCAN1_MODE);
-		release_region(sja1000_base, TSCAN1_SJA1000_SIZE);
+		release_region(sja1000_base, TSCAN1_SJA_SIZE);
 	}
 
 	dev_err(dev, "failed to assign SJA1000 IO address\n");
@@ -187,7 +187,7 @@ static int tscan1_remove(struct device *dev, unsigned id /*unused*/)
 
 	outb(0, pld_base + TSCAN1_MODE);	/* disable SJA1000 IO space */
 
-	release_region(sja1000_base, TSCAN1_SJA1000_SIZE);
+	release_region(sja1000_base, TSCAN1_SJA_SIZE);
 	release_region(pld_base, TSCAN1_PLD_SIZE);
 
 	free_sja1000dev(netdev);
diff --git a/include/linux/can/platform/sja1000.h b/include/linux/can/platform/sja1000.h
index 96f8fcc..b963535 100644
--- a/include/linux/can/platform/sja1000.h
+++ b/include/linux/can/platform/sja1000.h
@@ -2,28 +2,28 @@
 #define _CAN_PLATFORM_SJA1000_H_
 
 /* clock divider register */
-#define CDR_CLKOUT_MASK 0x07
-#define CDR_CLK_OFF	0x08 /* Clock off (CLKOUT pin) */
-#define CDR_RXINPEN	0x20 /* TX1 output is RX irq output */
-#define CDR_CBP		0x40 /* CAN input comparator bypass */
-#define CDR_PELICAN	0x80 /* PeliCAN mode */
+#define SJA_CDR_CLKOUT_MASK 0x07
+#define SJA_CDR_CLK_OFF	0x08 /* Clock off (CLKOUT pin) */
+#define SJA_CDR_RXINPEN	0x20 /* TX1 output is RX irq output */
+#define SJA_CDR_CBP		0x40 /* CAN input comparator bypass */
+#define SJA_CDR_PELICAN	0x80 /* PeliCAN mode */
 
 /* output control register */
-#define OCR_MODE_BIPHASE  0x00
-#define OCR_MODE_TEST     0x01
-#define OCR_MODE_NORMAL   0x02
-#define OCR_MODE_CLOCK    0x03
-#define OCR_MODE_MASK     0x07
-#define OCR_TX0_INVERT    0x04
-#define OCR_TX0_PULLDOWN  0x08
-#define OCR_TX0_PULLUP    0x10
-#define OCR_TX0_PUSHPULL  0x18
-#define OCR_TX1_INVERT    0x20
-#define OCR_TX1_PULLDOWN  0x40
-#define OCR_TX1_PULLUP    0x80
-#define OCR_TX1_PUSHPULL  0xc0
-#define OCR_TX_MASK       0xfc
-#define OCR_TX_SHIFT      2
+#define SJA_OCR_MODE_BIPHASE  0x00
+#define SJA_OCR_MODE_TEST     0x01
+#define SJA_OCR_MODE_NORMAL   0x02
+#define SJA_OCR_MODE_CLOCK    0x03
+#define SJA_OCR_MODE_MASK     0x07
+#define SJA_OCR_TX0_INVERT    0x04
+#define SJA_OCR_TX0_PULLDOWN  0x08
+#define SJA_OCR_TX0_PULLUP    0x10
+#define SJA_OCR_TX0_PUSHPULL  0x18
+#define SJA_OCR_TX1_INVERT    0x20
+#define SJA_OCR_TX1_PULLDOWN  0x40
+#define SJA_OCR_TX1_PULLUP    0x80
+#define SJA_OCR_TX1_PUSHPULL  0xc0
+#define SJA_OCR_TX_MASK       0xfc
+#define SJA_OCR_TX_SHIFT      2
 
 struct sja1000_platform_data {
 	u32 osc_freq;	/* CAN bus oscillator frequency in Hz */

