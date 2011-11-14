From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: Re: sja1000 BasicCAN mode
Date: Mon, 14 Nov 2011 19:03:38 +0100
Message-ID: <4EC157FA.7080701@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000302090808080800050503"
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Yuriy Kiselev <kiselev.yuriy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: socketcan-users <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is a multi-part message in MIME format.
--------------000302090808080800050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Yuriy,

what's your motivation for the BasicCAN mode support?

My biggest concern is that you leave the driver as a #ifdef hell ...
The second thing, is that you urge all CAN interfaces in the system to be
BasicCAN *or* PeliCAN mode. No chance to mix the hardware and to have a
per-device setting.

If such a functionality is to be implemented (and you have a good reason for
BasicCAN mode), this could be done by creating a new per-device flag.

E.g. 

#define SJA1000_BASIC_CAN 0x02

for sja1000priv.flags

Regards,
Oliver

ps. pls send patches always inline for a review
pps. and no html mails %-)

-------- Original Message --------
Subject: 	[Socketcan-users] sja1000 BasicCAN mode
Date: 	Mon, 14 Nov 2011 21:08:29 +0400
From: 	Yuriy Kiselev <kiselev.yuriy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: 	socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
CC: 	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Hello!
Implementation of BasicCAN mode for SJA1000 is in attachment.
Now SJA1000_PELICAN_MODE macros in sja1000.h is used for definition PeliCAN or
BasicCAN mode. It would be nice to create some menuconfig-wrapper, I think.
I use this code for a few weeks and it looks stable.


diff -ru trunk.orig/kernel/2.6/drivers/net/can/sja1000/sja1000.c trunk/kernel/2.6/drivers/net/can/sja1000/sja1000.c
--- trunk.orig/kernel/2.6/drivers/net/can/sja1000/sja1000.c	2011-11-14 20:46:35.074737955 +0400
+++ trunk/kernel/2.6/drivers/net/can/sja1000/sja1000.c	2011-11-14 20:56:00.083183431 +0400
@@ -117,22 +117,43 @@
 static void set_reset_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
+#ifdef SJA1000_PELICAN_MODE
 	unsigned char status = priv->read_reg(priv, REG_MOD);
+#else
+	unsigned char status = priv->read_reg(priv, REG_CR);
+#endif
 	int i;
 
 	/* disable interrupts */
+#ifdef SJA1000_PELICAN_MODE
 	priv->write_reg(priv, REG_IER, IRQ_OFF);
+#else
+	priv->write_reg(priv, REG_CR, status & IRQ_OFF);
+#endif
 
 	for (i = 0; i < 100; i++) {
-		/* check reset bit */
+		// check reset bit
+#ifdef SJA1000_PELICAN_MODE
 		if (status & MOD_RM) {
+#else
+		if (status & CR_RRQ) {
+#endif
 			priv->can.state = CAN_STATE_STOPPED;
 			return;
 		}
 
-		priv->write_reg(priv, REG_MOD, MOD_RM);	/* reset chip */
+    	/* reset chip */
+#ifdef SJA1000_PELICAN_MODE
+		priv->write_reg(priv, REG_MOD, MOD_RM);
+#else
+		priv->write_reg(priv, REG_CR, CR_RRQ);
+#endif
 		udelay(10);
+#ifdef SJA1000_PELICAN_MODE
 		status = priv->read_reg(priv, REG_MOD);
+#else
+		status = priv->read_reg(priv, REG_CR);
+#endif
 	}
 
 	dev_err(ND2D(dev), "setting SJA1000 into reset mode failed!\n");
@@ -141,26 +162,50 @@
 static void set_normal_mode(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
+#ifdef SJA1000_PELICAN_MODE
 	unsigned char status = priv->read_reg(priv, REG_MOD);
+#else
+	unsigned char status = priv->read_reg(priv, REG_CR);
+#endif
 	int i;
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
+#ifdef SJA1000_PELICAN_MODE
 		if ((status & MOD_RM) == 0) {
+#else
+		if ((status & CR_RRQ) == 0) {
+#endif
 			priv->can.state = CAN_STATE_ERROR_ACTIVE;
 			/* enable interrupts */
+#ifdef SJA1000_PELICAN_MODE
 			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 				priv->write_reg(priv, REG_IER, IRQ_ALL);
+
 			else
 				priv->write_reg(priv, REG_IER,
 						IRQ_ALL & ~IRQ_BEI);
 			return;
+#else
+			priv->write_reg(priv, REG_CR, status | IRQ_ALL);
+			return;
+#endif
 		}
 
+
 		/* set chip to normal mode */
+#ifdef SJA1000_PELICAN_MODE
 		priv->write_reg(priv, REG_MOD, 0x00);
+#else
+		//status = priv->read_reg(priv, REG_CR);
+		priv->write_reg(priv, REG_CR, status & ~CR_RRQ);
+#endif
 		udelay(10);
+#ifdef SJA1000_PELICAN_MODE
 		status = priv->read_reg(priv, REG_MOD);
+#else
+		status = priv->read_reg(priv, REG_CR);
+#endif
 	}
 
 	dev_err(ND2D(dev), "setting SJA1000 into normal mode failed!\n");
@@ -175,9 +220,11 @@
 		set_reset_mode(dev);
 
 	/* Clear error counters and error code capture */
+#ifdef SJA1000_PELICAN_MODE
 	priv->write_reg(priv, REG_TXERR, 0x0);
 	priv->write_reg(priv, REG_RXERR, 0x0);
 	priv->read_reg(priv, REG_ECC);
+#endif
 
 	/* leave reset mode */
 	set_normal_mode(dev);
@@ -230,8 +277,13 @@
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 
+#ifdef SJA1000_PELICAN_MODE
 	bec->txerr = priv->read_reg(priv, REG_TXERR);
 	bec->rxerr = priv->read_reg(priv, REG_RXERR);
+#else
+	bec->txerr = 0;
+	bec->rxerr = 0;
+#endif
 
 	return 0;
 }
@@ -247,11 +299,17 @@
 static void chipset_init(struct net_device *dev)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
+	struct can_bittiming bt;
 
 	/* set clock divider and output control register */
+#ifdef SJA1000_PELICAN_MODE
 	priv->write_reg(priv, REG_CDR, priv->cdr | CDR_PELICAN);
+#else
+	priv->write_reg(priv, REG_CDR, priv->cdr);
+#endif
 
 	/* set acceptance filter (accept all) */
+#ifdef SJA1000_PELICAN_MODE
 	priv->write_reg(priv, REG_ACCC0, 0x00);
 	priv->write_reg(priv, REG_ACCC1, 0x00);
 	priv->write_reg(priv, REG_ACCC2, 0x00);
@@ -261,6 +319,11 @@
 	priv->write_reg(priv, REG_ACCM1, 0xFF);
 	priv->write_reg(priv, REG_ACCM2, 0xFF);
 	priv->write_reg(priv, REG_ACCM3, 0xFF);
+#else
+	priv->write_reg(priv, REG_AC, 0x00);
+	priv->write_reg(priv, REG_AM, 0xFF);
+	
+#endif
 
 	priv->write_reg(priv, REG_OCR, priv->ocr | OCR_MODE_NORMAL);
 }
@@ -298,6 +361,8 @@
 		fi |= FI_RTR;
 
 	if (id & CAN_EFF_FLAG) {
+	    /* Extended frame. Not available in BasicCAN mode. */
+#ifdef SJA1000_PELICAN_MODE
 		fi |= FI_FF;
 		dreg = EFF_BUF;
 		priv->write_reg(priv, REG_FI, fi);
@@ -305,15 +370,26 @@
 		priv->write_reg(priv, REG_ID2, (id & 0x001fe000) >> (5 + 8));
 		priv->write_reg(priv, REG_ID3, (id & 0x00001fe0) >> 5);
 		priv->write_reg(priv, REG_ID4, (id & 0x0000001f) << 3);
+#endif
 	} else {
+	/* Standard frame */
+#ifdef SJA1000_PELICAN_MODE
 		dreg = SFF_BUF;
 		priv->write_reg(priv, REG_FI, fi);
 		priv->write_reg(priv, REG_ID1, (id & 0x000007f8) >> 3);
 		priv->write_reg(priv, REG_ID2, (id & 0x00000007) << 5);
+#else
+		priv->write_reg(priv, REG_TXB, (id & 0x000007f8) >> 3);
+		priv->write_reg(priv, REG_TXB + 1, ((id & 0x00000007) << 5) | fi);
+#endif
 	}
 
 	for (i = 0; i < dlc; i++)
+#ifdef SJA1000_PELICAN_MODE
 		priv->write_reg(priv, dreg++, cf->data[i]);
+#else
+		priv->write_reg(priv, REG_TXB + 2 + i, cf->data[i]);
+#endif
 
 	dev->trans_start = jiffies;
 
@@ -344,8 +420,14 @@
 	if (skb == NULL)
 		return;
 
+#ifdef SJA1000_PELICAN_MODE
 	fi = priv->read_reg(priv, REG_FI);
+#else
+    /* Read RTR & DLC */
+	fi = priv->read_reg(priv, REG_RXB + 1) & 0x1F;
+#endif
 
+#ifdef SJA1000_PELICAN_MODE
 	if (fi & FI_FF) {
 		/* extended frame format (EFF) */
 		dreg = EFF_BUF;
@@ -360,13 +442,22 @@
 		id = (priv->read_reg(priv, REG_ID1) << 3)
 		    | (priv->read_reg(priv, REG_ID2) >> 5);
 	}
+#else
+	id = (priv->read_reg(priv, REG_RXB) << 3)
+		| ((priv->read_reg(priv, REG_RXB + 1) & 0xE0) >> 5);
+#endif
 
 	if (fi & FI_RTR) {
 		id |= CAN_RTR_FLAG;
 	} else {
+		/* DLC field is same in TXB/RXB (basiccan) and FI (pelican) registers */
 		cf->can_dlc = get_can_dlc(fi & 0x0F);
 		for (i = 0; i < cf->can_dlc; i++)
+#ifdef SJA1000_PELICAN_MODE
 			cf->data[i] = priv->read_reg(priv, dreg++);
+#else
+			cf->data[i] = priv->read_reg(priv, REG_RXB + 2 + i);
+#endif
 	}
 
 	cf->can_id = id;
@@ -423,6 +514,7 @@
 		} else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
+#ifdef SJA1000_PELICAN_MODE /* BasicCAN mode doesn't support Bus Error Interrupt */
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
@@ -451,6 +543,9 @@
 		if ((ecc & ECC_DIR) == 0)
 			cf->data[2] |= CAN_ERR_PROT_TX;
 	}
+#endif
+
+#ifdef SJA1000_PELICAN_MODE /* BasicCAN mode doesn't support Error Passive Interrupt */
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
 		dev_dbg(ND2D(dev), "error passive interrupt\n");
@@ -459,6 +554,9 @@
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
+#endif
+
+#ifdef SJA1000_PELICAN_MODE /* BasicCAN mode doesn't support Arbitration Lost Interrupt */
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
 		dev_dbg(ND2D(dev), "arbitration lost interrupt\n");
@@ -468,11 +566,18 @@
 		cf->can_id |= CAN_ERR_LOSTARB;
 		cf->data[0] = alc & 0x1f;
 	}
+#endif
 
 	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
 					 state == CAN_STATE_ERROR_PASSIVE)) {
+#ifdef SJA1000_PELICAN_MODE
 		uint8_t rxerr = priv->read_reg(priv, REG_RXERR);
 		uint8_t txerr = priv->read_reg(priv, REG_TXERR);
+#else
+		uint8_t rxerr = 0;
+		uint8_t txerr = 0;
+#endif
+
 		cf->can_id |= CAN_ERR_CRTL;
 		if (state == CAN_STATE_ERROR_WARNING) {
 			priv->can.can_stats.error_warning++;
@@ -519,7 +624,11 @@
 	int n = 0;
 
 	/* Shared interrupts and IRQ off? */
+#ifdef SJA1000_PELICAN_MODE
 	if (priv->read_reg(priv, REG_IER) == IRQ_OFF)
+#else
+	if ((priv->read_reg(priv, REG_CR) & IRQ_ALL) == 0)
+#endif
 		return IRQ_NONE;
 
 	if (priv->pre_irq)
@@ -534,7 +643,11 @@
 
 		if (isrc & IRQ_TI) {
 			/* transmission complete interrupt */
-			stats->tx_bytes += priv->read_reg(priv, REG_FI) & 0xf;
+#ifdef SJA1000_PELICAN_MODE
+			stats->tx_bytes += priv->read_reg(priv, REG_FI) & 0xF;
+#else
+			stats->tx_bytes += priv->read_reg(priv, REG_TXB + 1) & 0xF;
+#endif
 			stats->tx_packets++;
 			can_get_echo_skb(dev, 0);
 			netif_wake_queue(dev);
@@ -546,7 +659,11 @@
 				status = priv->read_reg(priv, REG_SR);
 			}
 		}
+#ifdef SJA1000_PELICAN_MODE
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
+#else
+		if (isrc & (IRQ_DOI | IRQ_EI)) {
+#endif
 			/* error interrupt */
 			if (sja1000_err(dev, isrc, status))
 				break;
diff -ru trunk.orig/kernel/2.6/drivers/net/can/sja1000/sja1000.h trunk/kernel/2.6/drivers/net/can/sja1000/sja1000.h
--- trunk.orig/kernel/2.6/drivers/net/can/sja1000/sja1000.h	2011-11-14 20:49:44.526408577 +0400
+++ trunk/kernel/2.6/drivers/net/can/sja1000/sja1000.h	2011-11-14 20:50:20.813395105 +0400
@@ -50,10 +50,14 @@
 #include <socketcan/can/dev.h>
 #include <socketcan/can/platform/sja1000.h>
 
+#define SJA1000_PELICAN_MODE /* BasicCAN accepted if not defined */
+
 #define SJA1000_ECHO_SKB_MAX	1 /* the SJA1000 has one TX buffer object */
 
 #define SJA1000_MAX_IRQ 20	/* max. number of interrupts handled in ISR */
 
+#ifdef SJA1000_PELICAN_MODE
+
 /* SJA1000 registers - manual section 6.4 (Pelican Mode) */
 #define REG_MOD		0x00
 #define REG_CMR		0x01
@@ -76,19 +80,10 @@
 #define REG_RMC		0x1D
 #define REG_RBSA	0x1E
 
-/* Common registers - manual section 6.5 */
-#define REG_BTR0	0x06
-#define REG_BTR1	0x07
-#define REG_OCR		0x08
-#define REG_CDR		0x1F
-
 #define REG_FI		0x10
 #define SFF_BUF		0x13
 #define EFF_BUF		0x15
 
-#define FI_FF		0x80
-#define FI_RTR		0x40
-
 #define REG_ID1		0x11
 #define REG_ID2		0x12
 #define REG_ID3		0x13
@@ -96,6 +91,27 @@
 
 #define CAN_RAM		0x20
 
+#else /* SJA1000_PELICAN_MODE */
+
+/* SJA1000 registers - manual section 6.3 (Basiccan Mode) */
+#define REG_CR		0x00
+#define REG_CMR		0x01
+#define REG_SR		0x02
+#define REG_IR		0x03
+#define REG_AC		0x04
+#define REG_AM		0x05
+#define REG_TXB		0x0A
+#define REG_RXB		0x14
+
+#endif /* SJA1000_PELICAN_MODE */
+
+/* Common registers - manual section 6.5 */
+#define REG_BTR0	0x06
+#define REG_BTR1	0x07
+#define REG_OCR		0x08
+#define REG_CDR		0x1F
+
+#ifdef SJA1000_PELICAN_MODE
 /* mode register */
 #define MOD_RM		0x01
 #define MOD_LOM		0x02
@@ -137,11 +153,53 @@
 /* ECC register */
 #define ECC_SEG		0x1F
 #define ECC_DIR		0x20
-#define ECC_ERR		6
+#define ECC_ERR		0x06
 #define ECC_BIT		0x00
 #define ECC_FORM	0x40
 #define ECC_STUFF	0x80
-#define ECC_MASK	0xc0
+#define ECC_MASK	0xC0
+
+#define FI_FF		0x80
+#define FI_RTR		0x40
+
+#else /* SJA1000_PELICAN_MODE */
+
+/* control register */
+#define CR_RRQ		0x01
+#define CR_RIE		0x02
+#define CR_TIE		0x04
+#define CR_EIE		0x08
+#define CR_OIE		0x10
+#define IRQ_OFF		CR_RRQ
+#define IRQ_ALL		(CR_RIE | CR_TIE | CR_EIE | CR_OIE)
+
+/* command register */
+#define CMD_TR		0x01
+#define CMD_AT		0x02
+#define CMD_RRB		0x04
+#define CMD_CDO		0x08
+#define CMD_GTS		0x10
+
+/* status register */
+#define SR_RBS		0x01
+#define SR_DOS		0x02
+#define SR_TBS		0x04
+#define SR_TCS		0x08
+#define SR_RS		0x10
+#define SR_TS		0x20
+#define SR_ES		0x40
+#define SR_BS		0x80
+
+/* interrupt sources */
+#define IRQ_RI		0x01
+#define IRQ_TI		0x02
+#define IRQ_EI		0x04
+#define IRQ_DOI		0x08
+#define IRQ_WUI		0x10
+
+#define FI_RTR		0x10
+
+#endif /* SJA1000_PELICAN_MODE */
 
 /*
  * Flags for sja1000priv.flags

--------------000302090808080800050503
Content-Type: application/octet-stream;
 name="socketcan_sja1000_basicmod_impl.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="socketcan_sja1000_basicmod_impl.patch"

ZGlmZiAtcnUgdHJ1bmsub3JpZy9rZXJuZWwvMi42L2RyaXZlcnMvbmV0L2Nhbi9zamExMDAw
L3NqYTEwMDAuYyB0cnVuay9rZXJuZWwvMi42L2RyaXZlcnMvbmV0L2Nhbi9zamExMDAwL3Nq
YTEwMDAuYwotLS0gdHJ1bmsub3JpZy9rZXJuZWwvMi42L2RyaXZlcnMvbmV0L2Nhbi9zamEx
MDAwL3NqYTEwMDAuYwkyMDExLTExLTE0IDIwOjQ2OjM1LjA3NDczNzk1NSArMDQwMAorKysg
dHJ1bmsva2VybmVsLzIuNi9kcml2ZXJzL25ldC9jYW4vc2phMTAwMC9zamExMDAwLmMJMjAx
MS0xMS0xNCAyMDo1NjowMC4wODMxODM0MzEgKzA0MDAKQEAgLTExNywyMiArMTE3LDQzIEBA
CiBzdGF0aWMgdm9pZCBzZXRfcmVzZXRfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQog
ewogCXN0cnVjdCBzamExMDAwX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihkZXYpOworI2lm
ZGVmIFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAJdW5zaWduZWQgY2hhciBzdGF0dXMgPSBwcml2
LT5yZWFkX3JlZyhwcml2LCBSRUdfTU9EKTsKKyNlbHNlCisJdW5zaWduZWQgY2hhciBzdGF0
dXMgPSBwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdfQ1IpOworI2VuZGlmCiAJaW50IGk7CiAK
IAkvKiBkaXNhYmxlIGludGVycnVwdHMgKi8KKyNpZmRlZiBTSkExMDAwX1BFTElDQU5fTU9E
RQogCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfSUVSLCBJUlFfT0ZGKTsKKyNlbHNlCisJ
cHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19DUiwgc3RhdHVzICYgSVJRX09GRik7CisjZW5k
aWYKIAogCWZvciAoaSA9IDA7IGkgPCAxMDA7IGkrKykgewotCQkvKiBjaGVjayByZXNldCBi
aXQgKi8KKwkJLy8gY2hlY2sgcmVzZXQgYml0CisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01P
REUKIAkJaWYgKHN0YXR1cyAmIE1PRF9STSkgeworI2Vsc2UKKwkJaWYgKHN0YXR1cyAmIENS
X1JSUSkgeworI2VuZGlmCiAJCQlwcml2LT5jYW4uc3RhdGUgPSBDQU5fU1RBVEVfU1RPUFBF
RDsKIAkJCXJldHVybjsKIAkJfQogCi0JCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfTU9E
LCBNT0RfUk0pOwkvKiByZXNldCBjaGlwICovCisgICAgCS8qIHJlc2V0IGNoaXAgKi8KKyNp
ZmRlZiBTSkExMDAwX1BFTElDQU5fTU9ERQorCQlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVH
X01PRCwgTU9EX1JNKTsKKyNlbHNlCisJCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQ1Is
IENSX1JSUSk7CisjZW5kaWYKIAkJdWRlbGF5KDEwKTsKKyNpZmRlZiBTSkExMDAwX1BFTElD
QU5fTU9ERQogCQlzdGF0dXMgPSBwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdfTU9EKTsKKyNl
bHNlCisJCXN0YXR1cyA9IHByaXYtPnJlYWRfcmVnKHByaXYsIFJFR19DUik7CisjZW5kaWYK
IAl9CiAKIAlkZXZfZXJyKE5EMkQoZGV2KSwgInNldHRpbmcgU0pBMTAwMCBpbnRvIHJlc2V0
IG1vZGUgZmFpbGVkIVxuIik7CkBAIC0xNDEsMjYgKzE2Miw1MCBAQAogc3RhdGljIHZvaWQg
c2V0X25vcm1hbF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IHNq
YTEwMDBfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KGRldik7CisjaWZkZWYgU0pBMTAwMF9Q
RUxJQ0FOX01PREUKIAl1bnNpZ25lZCBjaGFyIHN0YXR1cyA9IHByaXYtPnJlYWRfcmVnKHBy
aXYsIFJFR19NT0QpOworI2Vsc2UKKwl1bnNpZ25lZCBjaGFyIHN0YXR1cyA9IHByaXYtPnJl
YWRfcmVnKHByaXYsIFJFR19DUik7CisjZW5kaWYKIAlpbnQgaTsKIAogCWZvciAoaSA9IDA7
IGkgPCAxMDA7IGkrKykgewogCQkvKiBjaGVjayByZXNldCBiaXQgKi8KKyNpZmRlZiBTSkEx
MDAwX1BFTElDQU5fTU9ERQogCQlpZiAoKHN0YXR1cyAmIE1PRF9STSkgPT0gMCkgeworI2Vs
c2UKKwkJaWYgKChzdGF0dXMgJiBDUl9SUlEpID09IDApIHsKKyNlbmRpZgogCQkJcHJpdi0+
Y2FuLnN0YXRlID0gQ0FOX1NUQVRFX0VSUk9SX0FDVElWRTsKIAkJCS8qIGVuYWJsZSBpbnRl
cnJ1cHRzICovCisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01PREUKIAkJCWlmIChwcml2LT5j
YW4uY3RybG1vZGUgJiBDQU5fQ1RSTE1PREVfQkVSUl9SRVBPUlRJTkcpCiAJCQkJcHJpdi0+
d3JpdGVfcmVnKHByaXYsIFJFR19JRVIsIElSUV9BTEwpOworCiAJCQllbHNlCiAJCQkJcHJp
di0+d3JpdGVfcmVnKHByaXYsIFJFR19JRVIsCiAJCQkJCQlJUlFfQUxMICYgfklSUV9CRUkp
OwogCQkJcmV0dXJuOworI2Vsc2UKKwkJCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQ1Is
IHN0YXR1cyB8IElSUV9BTEwpOworCQkJcmV0dXJuOworI2VuZGlmCiAJCX0KIAorCiAJCS8q
IHNldCBjaGlwIHRvIG5vcm1hbCBtb2RlICovCisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01P
REUKIAkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19NT0QsIDB4MDApOworI2Vsc2UKKwkJ
Ly9zdGF0dXMgPSBwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdfQ1IpOworCQlwcml2LT53cml0
ZV9yZWcocHJpdiwgUkVHX0NSLCBzdGF0dXMgJiB+Q1JfUlJRKTsKKyNlbmRpZgogCQl1ZGVs
YXkoMTApOworI2lmZGVmIFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAJCXN0YXR1cyA9IHByaXYt
PnJlYWRfcmVnKHByaXYsIFJFR19NT0QpOworI2Vsc2UKKwkJc3RhdHVzID0gcHJpdi0+cmVh
ZF9yZWcocHJpdiwgUkVHX0NSKTsKKyNlbmRpZgogCX0KIAogCWRldl9lcnIoTkQyRChkZXYp
LCAic2V0dGluZyBTSkExMDAwIGludG8gbm9ybWFsIG1vZGUgZmFpbGVkIVxuIik7CkBAIC0x
NzUsOSArMjIwLDExIEBACiAJCXNldF9yZXNldF9tb2RlKGRldik7CiAKIAkvKiBDbGVhciBl
cnJvciBjb3VudGVycyBhbmQgZXJyb3IgY29kZSBjYXB0dXJlICovCisjaWZkZWYgU0pBMTAw
MF9QRUxJQ0FOX01PREUKIAlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX1RYRVJSLCAweDAp
OwogCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfUlhFUlIsIDB4MCk7CiAJcHJpdi0+cmVh
ZF9yZWcocHJpdiwgUkVHX0VDQyk7CisjZW5kaWYKIAogCS8qIGxlYXZlIHJlc2V0IG1vZGUg
Ki8KIAlzZXRfbm9ybWFsX21vZGUoZGV2KTsKQEAgLTIzMCw4ICsyNzcsMTMgQEAKIHsKIAlz
dHJ1Y3Qgc2phMTAwMF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsKIAorI2lmZGVm
IFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAJYmVjLT50eGVyciA9IHByaXYtPnJlYWRfcmVnKHBy
aXYsIFJFR19UWEVSUik7CiAJYmVjLT5yeGVyciA9IHByaXYtPnJlYWRfcmVnKHByaXYsIFJF
R19SWEVSUik7CisjZWxzZQorCWJlYy0+dHhlcnIgPSAwOworCWJlYy0+cnhlcnIgPSAwOwor
I2VuZGlmCiAKIAlyZXR1cm4gMDsKIH0KQEAgLTI0NywxMSArMjk5LDE3IEBACiBzdGF0aWMg
dm9pZCBjaGlwc2V0X2luaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qg
c2phMTAwMF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsKKwlzdHJ1Y3QgY2FuX2Jp
dHRpbWluZyBidDsKIAogCS8qIHNldCBjbG9jayBkaXZpZGVyIGFuZCBvdXRwdXQgY29udHJv
bCByZWdpc3RlciAqLworI2lmZGVmIFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAJcHJpdi0+d3Jp
dGVfcmVnKHByaXYsIFJFR19DRFIsIHByaXYtPmNkciB8IENEUl9QRUxJQ0FOKTsKKyNlbHNl
CisJcHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19DRFIsIHByaXYtPmNkcik7CisjZW5kaWYK
IAogCS8qIHNldCBhY2NlcHRhbmNlIGZpbHRlciAoYWNjZXB0IGFsbCkgKi8KKyNpZmRlZiBT
SkExMDAwX1BFTElDQU5fTU9ERQogCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQUNDQzAs
IDB4MDApOwogCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQUNDQzEsIDB4MDApOwogCXBy
aXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQUNDQzIsIDB4MDApOwpAQCAtMjYxLDYgKzMxOSwx
MSBAQAogCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfQUNDTTEsIDB4RkYpOwogCXByaXYt
PndyaXRlX3JlZyhwcml2LCBSRUdfQUNDTTIsIDB4RkYpOwogCXByaXYtPndyaXRlX3JlZyhw
cml2LCBSRUdfQUNDTTMsIDB4RkYpOworI2Vsc2UKKwlwcml2LT53cml0ZV9yZWcocHJpdiwg
UkVHX0FDLCAweDAwKTsKKwlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX0FNLCAweEZGKTsK
KwkKKyNlbmRpZgogCiAJcHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19PQ1IsIHByaXYtPm9j
ciB8IE9DUl9NT0RFX05PUk1BTCk7CiB9CkBAIC0yOTgsNiArMzYxLDggQEAKIAkJZmkgfD0g
RklfUlRSOwogCiAJaWYgKGlkICYgQ0FOX0VGRl9GTEFHKSB7CisJICAgIC8qIEV4dGVuZGVk
IGZyYW1lLiBOb3QgYXZhaWxhYmxlIGluIEJhc2ljQ0FOIG1vZGUuICovCisjaWZkZWYgU0pB
MTAwMF9QRUxJQ0FOX01PREUKIAkJZmkgfD0gRklfRkY7CiAJCWRyZWcgPSBFRkZfQlVGOwog
CQlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX0ZJLCBmaSk7CkBAIC0zMDUsMTUgKzM3MCwy
NiBAQAogCQlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX0lEMiwgKGlkICYgMHgwMDFmZTAw
MCkgPj4gKDUgKyA4KSk7CiAJCXByaXYtPndyaXRlX3JlZyhwcml2LCBSRUdfSUQzLCAoaWQg
JiAweDAwMDAxZmUwKSA+PiA1KTsKIAkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19JRDQs
IChpZCAmIDB4MDAwMDAwMWYpIDw8IDMpOworI2VuZGlmCiAJfSBlbHNlIHsKKwkvKiBTdGFu
ZGFyZCBmcmFtZSAqLworI2lmZGVmIFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAJCWRyZWcgPSBT
RkZfQlVGOwogCQlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX0ZJLCBmaSk7CiAJCXByaXYt
PndyaXRlX3JlZyhwcml2LCBSRUdfSUQxLCAoaWQgJiAweDAwMDAwN2Y4KSA+PiAzKTsKIAkJ
cHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19JRDIsIChpZCAmIDB4MDAwMDAwMDcpIDw8IDUp
OworI2Vsc2UKKwkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIFJFR19UWEIsIChpZCAmIDB4MDAw
MDA3ZjgpID4+IDMpOworCQlwcml2LT53cml0ZV9yZWcocHJpdiwgUkVHX1RYQiArIDEsICgo
aWQgJiAweDAwMDAwMDA3KSA8PCA1KSB8IGZpKTsKKyNlbmRpZgogCX0KIAogCWZvciAoaSA9
IDA7IGkgPCBkbGM7IGkrKykKKyNpZmRlZiBTSkExMDAwX1BFTElDQU5fTU9ERQogCQlwcml2
LT53cml0ZV9yZWcocHJpdiwgZHJlZysrLCBjZi0+ZGF0YVtpXSk7CisjZWxzZQorCQlwcml2
LT53cml0ZV9yZWcocHJpdiwgUkVHX1RYQiArIDIgKyBpLCBjZi0+ZGF0YVtpXSk7CisjZW5k
aWYKIAogCWRldi0+dHJhbnNfc3RhcnQgPSBqaWZmaWVzOwogCkBAIC0zNDQsOCArNDIwLDE0
IEBACiAJaWYgKHNrYiA9PSBOVUxMKQogCQlyZXR1cm47CiAKKyNpZmRlZiBTSkExMDAwX1BF
TElDQU5fTU9ERQogCWZpID0gcHJpdi0+cmVhZF9yZWcocHJpdiwgUkVHX0ZJKTsKKyNlbHNl
CisgICAgLyogUmVhZCBSVFIgJiBETEMgKi8KKwlmaSA9IHByaXYtPnJlYWRfcmVnKHByaXYs
IFJFR19SWEIgKyAxKSAmIDB4MUY7CisjZW5kaWYKIAorI2lmZGVmIFNKQTEwMDBfUEVMSUNB
Tl9NT0RFCiAJaWYgKGZpICYgRklfRkYpIHsKIAkJLyogZXh0ZW5kZWQgZnJhbWUgZm9ybWF0
IChFRkYpICovCiAJCWRyZWcgPSBFRkZfQlVGOwpAQCAtMzYwLDEzICs0NDIsMjIgQEAKIAkJ
aWQgPSAocHJpdi0+cmVhZF9yZWcocHJpdiwgUkVHX0lEMSkgPDwgMykKIAkJICAgIHwgKHBy
aXYtPnJlYWRfcmVnKHByaXYsIFJFR19JRDIpID4+IDUpOwogCX0KKyNlbHNlCisJaWQgPSAo
cHJpdi0+cmVhZF9yZWcocHJpdiwgUkVHX1JYQikgPDwgMykKKwkJfCAoKHByaXYtPnJlYWRf
cmVnKHByaXYsIFJFR19SWEIgKyAxKSAmIDB4RTApID4+IDUpOworI2VuZGlmCiAKIAlpZiAo
ZmkgJiBGSV9SVFIpIHsKIAkJaWQgfD0gQ0FOX1JUUl9GTEFHOwogCX0gZWxzZSB7CisJCS8q
IERMQyBmaWVsZCBpcyBzYW1lIGluIFRYQi9SWEIgKGJhc2ljY2FuKSBhbmQgRkkgKHBlbGlj
YW4pIHJlZ2lzdGVycyAqLwogCQljZi0+Y2FuX2RsYyA9IGdldF9jYW5fZGxjKGZpICYgMHgw
Rik7CiAJCWZvciAoaSA9IDA7IGkgPCBjZi0+Y2FuX2RsYzsgaSsrKQorI2lmZGVmIFNKQTEw
MDBfUEVMSUNBTl9NT0RFCiAJCQljZi0+ZGF0YVtpXSA9IHByaXYtPnJlYWRfcmVnKHByaXYs
IGRyZWcrKyk7CisjZWxzZQorCQkJY2YtPmRhdGFbaV0gPSBwcml2LT5yZWFkX3JlZyhwcml2
LCBSRUdfUlhCICsgMiArIGkpOworI2VuZGlmCiAJfQogCiAJY2YtPmNhbl9pZCA9IGlkOwpA
QCAtNDIzLDYgKzUxNCw3IEBACiAJCX0gZWxzZQogCQkJc3RhdGUgPSBDQU5fU1RBVEVfRVJS
T1JfQUNUSVZFOwogCX0KKyNpZmRlZiBTSkExMDAwX1BFTElDQU5fTU9ERSAvKiBCYXNpY0NB
TiBtb2RlIGRvZXNuJ3Qgc3VwcG9ydCBCdXMgRXJyb3IgSW50ZXJydXB0ICovCiAJaWYgKGlz
cmMgJiBJUlFfQkVJKSB7CiAJCS8qIGJ1cyBlcnJvciBpbnRlcnJ1cHQgKi8KIAkJcHJpdi0+
Y2FuLmNhbl9zdGF0cy5idXNfZXJyb3IrKzsKQEAgLTQ1MSw2ICs1NDMsOSBAQAogCQlpZiAo
KGVjYyAmIEVDQ19ESVIpID09IDApCiAJCQljZi0+ZGF0YVsyXSB8PSBDQU5fRVJSX1BST1Rf
VFg7CiAJfQorI2VuZGlmCisKKyNpZmRlZiBTSkExMDAwX1BFTElDQU5fTU9ERSAvKiBCYXNp
Y0NBTiBtb2RlIGRvZXNuJ3Qgc3VwcG9ydCBFcnJvciBQYXNzaXZlIEludGVycnVwdCAqLwog
CWlmIChpc3JjICYgSVJRX0VQSSkgewogCQkvKiBlcnJvciBwYXNzaXZlIGludGVycnVwdCAq
LwogCQlkZXZfZGJnKE5EMkQoZGV2KSwgImVycm9yIHBhc3NpdmUgaW50ZXJydXB0XG4iKTsK
QEAgLTQ1OSw2ICs1NTQsOSBAQAogCQllbHNlCiAJCQlzdGF0ZSA9IENBTl9TVEFURV9FUlJP
Ul9BQ1RJVkU7CiAJfQorI2VuZGlmCisKKyNpZmRlZiBTSkExMDAwX1BFTElDQU5fTU9ERSAv
KiBCYXNpY0NBTiBtb2RlIGRvZXNuJ3Qgc3VwcG9ydCBBcmJpdHJhdGlvbiBMb3N0IEludGVy
cnVwdCAqLwogCWlmIChpc3JjICYgSVJRX0FMSSkgewogCQkvKiBhcmJpdHJhdGlvbiBsb3N0
IGludGVycnVwdCAqLwogCQlkZXZfZGJnKE5EMkQoZGV2KSwgImFyYml0cmF0aW9uIGxvc3Qg
aW50ZXJydXB0XG4iKTsKQEAgLTQ2OCwxMSArNTY2LDE4IEBACiAJCWNmLT5jYW5faWQgfD0g
Q0FOX0VSUl9MT1NUQVJCOwogCQljZi0+ZGF0YVswXSA9IGFsYyAmIDB4MWY7CiAJfQorI2Vu
ZGlmCiAKIAlpZiAoc3RhdGUgIT0gcHJpdi0+Y2FuLnN0YXRlICYmIChzdGF0ZSA9PSBDQU5f
U1RBVEVfRVJST1JfV0FSTklORyB8fAogCQkJCQkgc3RhdGUgPT0gQ0FOX1NUQVRFX0VSUk9S
X1BBU1NJVkUpKSB7CisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01PREUKIAkJdWludDhfdCBy
eGVyciA9IHByaXYtPnJlYWRfcmVnKHByaXYsIFJFR19SWEVSUik7CiAJCXVpbnQ4X3QgdHhl
cnIgPSBwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdfVFhFUlIpOworI2Vsc2UKKwkJdWludDhf
dCByeGVyciA9IDA7CisJCXVpbnQ4X3QgdHhlcnIgPSAwOworI2VuZGlmCisKIAkJY2YtPmNh
bl9pZCB8PSBDQU5fRVJSX0NSVEw7CiAJCWlmIChzdGF0ZSA9PSBDQU5fU1RBVEVfRVJST1Jf
V0FSTklORykgewogCQkJcHJpdi0+Y2FuLmNhbl9zdGF0cy5lcnJvcl93YXJuaW5nKys7CkBA
IC01MTksNyArNjI0LDExIEBACiAJaW50IG4gPSAwOwogCiAJLyogU2hhcmVkIGludGVycnVw
dHMgYW5kIElSUSBvZmY/ICovCisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01PREUKIAlpZiAo
cHJpdi0+cmVhZF9yZWcocHJpdiwgUkVHX0lFUikgPT0gSVJRX09GRikKKyNlbHNlCisJaWYg
KChwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdfQ1IpICYgSVJRX0FMTCkgPT0gMCkKKyNlbmRp
ZgogCQlyZXR1cm4gSVJRX05PTkU7CiAKIAlpZiAocHJpdi0+cHJlX2lycSkKQEAgLTUzNCw3
ICs2NDMsMTEgQEAKIAogCQlpZiAoaXNyYyAmIElSUV9USSkgewogCQkJLyogdHJhbnNtaXNz
aW9uIGNvbXBsZXRlIGludGVycnVwdCAqLwotCQkJc3RhdHMtPnR4X2J5dGVzICs9IHByaXYt
PnJlYWRfcmVnKHByaXYsIFJFR19GSSkgJiAweGY7CisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FO
X01PREUKKwkJCXN0YXRzLT50eF9ieXRlcyArPSBwcml2LT5yZWFkX3JlZyhwcml2LCBSRUdf
RkkpICYgMHhGOworI2Vsc2UKKwkJCXN0YXRzLT50eF9ieXRlcyArPSBwcml2LT5yZWFkX3Jl
Zyhwcml2LCBSRUdfVFhCICsgMSkgJiAweEY7CisjZW5kaWYKIAkJCXN0YXRzLT50eF9wYWNr
ZXRzKys7CiAJCQljYW5fZ2V0X2VjaG9fc2tiKGRldiwgMCk7CiAJCQluZXRpZl93YWtlX3F1
ZXVlKGRldik7CkBAIC01NDYsNyArNjU5LDExIEBACiAJCQkJc3RhdHVzID0gcHJpdi0+cmVh
ZF9yZWcocHJpdiwgUkVHX1NSKTsKIAkJCX0KIAkJfQorI2lmZGVmIFNKQTEwMDBfUEVMSUNB
Tl9NT0RFCiAJCWlmIChpc3JjICYgKElSUV9ET0kgfCBJUlFfRUkgfCBJUlFfQkVJIHwgSVJR
X0VQSSB8IElSUV9BTEkpKSB7CisjZWxzZQorCQlpZiAoaXNyYyAmIChJUlFfRE9JIHwgSVJR
X0VJKSkgeworI2VuZGlmCiAJCQkvKiBlcnJvciBpbnRlcnJ1cHQgKi8KIAkJCWlmIChzamEx
MDAwX2VycihkZXYsIGlzcmMsIHN0YXR1cykpCiAJCQkJYnJlYWs7CmRpZmYgLXJ1IHRydW5r
Lm9yaWcva2VybmVsLzIuNi9kcml2ZXJzL25ldC9jYW4vc2phMTAwMC9zamExMDAwLmggdHJ1
bmsva2VybmVsLzIuNi9kcml2ZXJzL25ldC9jYW4vc2phMTAwMC9zamExMDAwLmgKLS0tIHRy
dW5rLm9yaWcva2VybmVsLzIuNi9kcml2ZXJzL25ldC9jYW4vc2phMTAwMC9zamExMDAwLmgJ
MjAxMS0xMS0xNCAyMDo0OTo0NC41MjY0MDg1NzcgKzA0MDAKKysrIHRydW5rL2tlcm5lbC8y
LjYvZHJpdmVycy9uZXQvY2FuL3NqYTEwMDAvc2phMTAwMC5oCTIwMTEtMTEtMTQgMjA6NTA6
MjAuODEzMzk1MTA1ICswNDAwCkBAIC01MCwxMCArNTAsMTQgQEAKICNpbmNsdWRlIDxzb2Nr
ZXRjYW4vY2FuL2Rldi5oPgogI2luY2x1ZGUgPHNvY2tldGNhbi9jYW4vcGxhdGZvcm0vc2ph
MTAwMC5oPgogCisjZGVmaW5lIFNKQTEwMDBfUEVMSUNBTl9NT0RFIC8qIEJhc2ljQ0FOIGFj
Y2VwdGVkIGlmIG5vdCBkZWZpbmVkICovCisKICNkZWZpbmUgU0pBMTAwMF9FQ0hPX1NLQl9N
QVgJMSAvKiB0aGUgU0pBMTAwMCBoYXMgb25lIFRYIGJ1ZmZlciBvYmplY3QgKi8KIAogI2Rl
ZmluZSBTSkExMDAwX01BWF9JUlEgMjAJLyogbWF4LiBudW1iZXIgb2YgaW50ZXJydXB0cyBo
YW5kbGVkIGluIElTUiAqLwogCisjaWZkZWYgU0pBMTAwMF9QRUxJQ0FOX01PREUKKwogLyog
U0pBMTAwMCByZWdpc3RlcnMgLSBtYW51YWwgc2VjdGlvbiA2LjQgKFBlbGljYW4gTW9kZSkg
Ki8KICNkZWZpbmUgUkVHX01PRAkJMHgwMAogI2RlZmluZSBSRUdfQ01SCQkweDAxCkBAIC03
NiwxOSArODAsMTAgQEAKICNkZWZpbmUgUkVHX1JNQwkJMHgxRAogI2RlZmluZSBSRUdfUkJT
QQkweDFFCiAKLS8qIENvbW1vbiByZWdpc3RlcnMgLSBtYW51YWwgc2VjdGlvbiA2LjUgKi8K
LSNkZWZpbmUgUkVHX0JUUjAJMHgwNgotI2RlZmluZSBSRUdfQlRSMQkweDA3Ci0jZGVmaW5l
IFJFR19PQ1IJCTB4MDgKLSNkZWZpbmUgUkVHX0NEUgkJMHgxRgotCiAjZGVmaW5lIFJFR19G
SQkJMHgxMAogI2RlZmluZSBTRkZfQlVGCQkweDEzCiAjZGVmaW5lIEVGRl9CVUYJCTB4MTUK
IAotI2RlZmluZSBGSV9GRgkJMHg4MAotI2RlZmluZSBGSV9SVFIJCTB4NDAKLQogI2RlZmlu
ZSBSRUdfSUQxCQkweDExCiAjZGVmaW5lIFJFR19JRDIJCTB4MTIKICNkZWZpbmUgUkVHX0lE
MwkJMHgxMwpAQCAtOTYsNiArOTEsMjcgQEAKIAogI2RlZmluZSBDQU5fUkFNCQkweDIwCiAK
KyNlbHNlIC8qIFNKQTEwMDBfUEVMSUNBTl9NT0RFICovCisKKy8qIFNKQTEwMDAgcmVnaXN0
ZXJzIC0gbWFudWFsIHNlY3Rpb24gNi4zIChCYXNpY2NhbiBNb2RlKSAqLworI2RlZmluZSBS
RUdfQ1IJCTB4MDAKKyNkZWZpbmUgUkVHX0NNUgkJMHgwMQorI2RlZmluZSBSRUdfU1IJCTB4
MDIKKyNkZWZpbmUgUkVHX0lSCQkweDAzCisjZGVmaW5lIFJFR19BQwkJMHgwNAorI2RlZmlu
ZSBSRUdfQU0JCTB4MDUKKyNkZWZpbmUgUkVHX1RYQgkJMHgwQQorI2RlZmluZSBSRUdfUlhC
CQkweDE0CisKKyNlbmRpZiAvKiBTSkExMDAwX1BFTElDQU5fTU9ERSAqLworCisvKiBDb21t
b24gcmVnaXN0ZXJzIC0gbWFudWFsIHNlY3Rpb24gNi41ICovCisjZGVmaW5lIFJFR19CVFIw
CTB4MDYKKyNkZWZpbmUgUkVHX0JUUjEJMHgwNworI2RlZmluZSBSRUdfT0NSCQkweDA4Cisj
ZGVmaW5lIFJFR19DRFIJCTB4MUYKKworI2lmZGVmIFNKQTEwMDBfUEVMSUNBTl9NT0RFCiAv
KiBtb2RlIHJlZ2lzdGVyICovCiAjZGVmaW5lIE1PRF9STQkJMHgwMQogI2RlZmluZSBNT0Rf
TE9NCQkweDAyCkBAIC0xMzcsMTEgKzE1Myw1MyBAQAogLyogRUNDIHJlZ2lzdGVyICovCiAj
ZGVmaW5lIEVDQ19TRUcJCTB4MUYKICNkZWZpbmUgRUNDX0RJUgkJMHgyMAotI2RlZmluZSBF
Q0NfRVJSCQk2CisjZGVmaW5lIEVDQ19FUlIJCTB4MDYKICNkZWZpbmUgRUNDX0JJVAkJMHgw
MAogI2RlZmluZSBFQ0NfRk9STQkweDQwCiAjZGVmaW5lIEVDQ19TVFVGRgkweDgwCi0jZGVm
aW5lIEVDQ19NQVNLCTB4YzAKKyNkZWZpbmUgRUNDX01BU0sJMHhDMAorCisjZGVmaW5lIEZJ
X0ZGCQkweDgwCisjZGVmaW5lIEZJX1JUUgkJMHg0MAorCisjZWxzZSAvKiBTSkExMDAwX1BF
TElDQU5fTU9ERSAqLworCisvKiBjb250cm9sIHJlZ2lzdGVyICovCisjZGVmaW5lIENSX1JS
UQkJMHgwMQorI2RlZmluZSBDUl9SSUUJCTB4MDIKKyNkZWZpbmUgQ1JfVElFCQkweDA0Cisj
ZGVmaW5lIENSX0VJRQkJMHgwOAorI2RlZmluZSBDUl9PSUUJCTB4MTAKKyNkZWZpbmUgSVJR
X09GRgkJQ1JfUlJRCisjZGVmaW5lIElSUV9BTEwJCShDUl9SSUUgfCBDUl9USUUgfCBDUl9F
SUUgfCBDUl9PSUUpCisKKy8qIGNvbW1hbmQgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgQ01EX1RS
CQkweDAxCisjZGVmaW5lIENNRF9BVAkJMHgwMgorI2RlZmluZSBDTURfUlJCCQkweDA0Cisj
ZGVmaW5lIENNRF9DRE8JCTB4MDgKKyNkZWZpbmUgQ01EX0dUUwkJMHgxMAorCisvKiBzdGF0
dXMgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgU1JfUkJTCQkweDAxCisjZGVmaW5lIFNSX0RPUwkJ
MHgwMgorI2RlZmluZSBTUl9UQlMJCTB4MDQKKyNkZWZpbmUgU1JfVENTCQkweDA4CisjZGVm
aW5lIFNSX1JTCQkweDEwCisjZGVmaW5lIFNSX1RTCQkweDIwCisjZGVmaW5lIFNSX0VTCQkw
eDQwCisjZGVmaW5lIFNSX0JTCQkweDgwCisKKy8qIGludGVycnVwdCBzb3VyY2VzICovCisj
ZGVmaW5lIElSUV9SSQkJMHgwMQorI2RlZmluZSBJUlFfVEkJCTB4MDIKKyNkZWZpbmUgSVJR
X0VJCQkweDA0CisjZGVmaW5lIElSUV9ET0kJCTB4MDgKKyNkZWZpbmUgSVJRX1dVSQkJMHgx
MAorCisjZGVmaW5lIEZJX1JUUgkJMHgxMAorCisjZW5kaWYgLyogU0pBMTAwMF9QRUxJQ0FO
X01PREUgKi8KIAogLyoKICAqIEZsYWdzIGZvciBzamExMDAwcHJpdi5mbGFncwo=
--------------000302090808080800050503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-users mailing list
Socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-users

--------------000302090808080800050503--
