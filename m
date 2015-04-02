From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Flexcan (was: Re: Fwd: Querying current tx_queue usage of a SocketCAN
 interface)
Date: Thu, 02 Apr 2015 22:35:41 +1100
Message-ID: <551D298D.7040809@optusnet.com.au>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au> <loom.20150402T022922-646@post.gmane.org> <551CA777.8070208@optusnet.com.au> <551CE174.2030303@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080009080709090405080405"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:58266 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbbDBLft (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Apr 2015 07:35:49 -0400
In-Reply-To: <551CE174.2030303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, dan.egnor@gmail.com, linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------080009080709090405080405
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/04/2015 5:28 PM, Marc Kleine-Budde wrote:
> On 04/02/2015 04:20 AM, Tom Evans wrote:
>> I had to seriously rewrite the FlexCAN drivers for our i.MX53 because the
>> Ethernet driver blocked the CAN driver for so long the CAN hardware receive
>> FIFO overflowed. Linux doesn't even support setting different interrupt
>> priorities on ARM (but my problem was with NAPI).
>
> Can you share your changes? I'll have some days to hack on a better
> generic RX-FIFO implementation for the at91 and flexcan.

Sure. "git diff -p" based of the 3.4 kernel sources.

Working from home over Easter using git under cygwin under Windows via 
Thunderbird, so the CRLFs and line breaks could be messed up, sorry. 
Patches inline and attached. If this lot is useless, tell me what to 
type to do it properly and I'll resend on Tuesday.

flexcan.c.patch.buffer

The problem with the FlexCan driver is that it takes the interrupt, then 
throws to NAPI to actually read the hardware buffers. How messed up is 
that? It isn't as if reading 16 bytes or so is going to take THAT long, 
and as there's only six message buffers it overflows in 600us at 1MHz. 
In the same kernel, the Ethernet driver DOESN'T throw to NAPI but 
handles as many 1500-byte Ethernet frames as there are coming in in the 
one ISR. Other things can delay NAPI as well. So I fixed it with a 
sledgehammer. It reads the messages during the ISR to an internal ring 
buffer (sized to 100, later to 128)

flexcan.c.patch.flood

A disconnected CAN bus generate an interrupt storm. This patch fixes it 
the same way it is apparently done in some 3.18 drivers. This may 
already be in there.

flexcan.c.patch.buffer

---------------------------------------------------

diff --git a/arm-linux/drivers/net/can/flexcan.c 
b/arm-linux/drivers/net/can/flexcan.c
old mode 100644
new mode 100755
index 14c8a86..96e0b55
--- a/arm-linux/drivers/net/can/flexcan.c
+++ b/arm-linux/drivers/net/can/flexcan.c
@@ -43,6 +43,9 @@
  /* 8 for RX fifo and 2 error handling */
  #define FLEXCAN_NAPI_WEIGHT		(8 + 2)

+/* Buffers in the interrupt-read ring, 10ms@100us per. */
+#define FLEXCAN_READ_RING_SIZE		(100)
+
  /* FLEXCAN module configuration register (CANMCR) bits */
  #define FLEXCAN_MCR_MDIS		BIT(31)
  #define FLEXCAN_MCR_FRZ			BIT(30)
@@ -170,6 +173,14 @@ struct flexcan_regs {
  	struct flexcan_mb cantxfg[64];
  };

+struct flexcan_ring {
+	u32 input;		/* Ring input index */
+	u32 output;		/* Ring output index */
+	u32 full;		/* ring full/wrapped flag */
+	spinlock_t ring_lock;
+	struct can_frame frames[FLEXCAN_READ_RING_SIZE];
+};
+
  struct flexcan_priv {
  	struct can_priv can;
  	struct net_device *dev;
@@ -182,6 +193,7 @@ struct flexcan_priv {
  	struct clk *clk;
  	struct flexcan_platform_data *pdata;
  	struct gpio_sw *xcvr_switch;
+	struct flexcan_ring read_ring;
  };

  static struct can_bittiming_const flexcan_bittiming_const = {
@@ -532,12 +544,70 @@ static int flexcan_read_frame(struct net_device *dev)
  	return 1;
  }

+static int flexcan_read_frame_to_ring(struct net_device *dev)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
+
+	cf = &priv->read_ring.frames[priv->read_ring.input];
+
+	/* Read even if ring full to clear the interrupt request */
+	flexcan_read_fifo(dev, cf);
+
+	if (priv->read_ring.full) {
+		stats->rx_dropped++;
+		return 0;
+	}
+	priv->read_ring.input += 1;
+	if (priv->read_ring.input >= FLEXCAN_READ_RING_SIZE) {
+		priv->read_ring.input  = 0;
+	}
+	if (priv->read_ring.input == priv->read_ring.output) {
+		priv->read_ring.full = 1;
+	}
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	return 1;
+}
+
+static int flexcan_read_frame_from_ring(struct net_device *dev)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	skb = alloc_can_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 1;	/* was 0, but that's an infinite loop bug */
+	}
+	/* Assumes that the ring-empty test already done */
+	memcpy(cf, &priv->read_ring.frames[priv->read_ring.output], sizeof(*cf));
+
+	spin_lock_irqsave(&priv->read_ring.ring_lock, flags);
+	priv->read_ring.full = 0;
+	priv->read_ring.output += 1;
+	if (priv->read_ring.output >= FLEXCAN_READ_RING_SIZE) {
+		priv->read_ring.output = 0;
+	}
+	spin_unlock_irqrestore(&priv->read_ring.ring_lock, flags);
+
+	netif_receive_skb(skb);
+
+	return 1;
+}
+
  static int flexcan_poll(struct napi_struct *napi, int quota)
  {
  	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = netdev_priv(dev);
  	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_esr;
  	int work_done = 0;

  	/*
@@ -545,16 +615,16 @@ static int flexcan_poll(struct napi_struct *napi, 
int quota)
  	 * use saved value from irq handler.
  	 */
  	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
+	priv->reg_esr = 0;

  	/* handle state changes */
  	work_done += flexcan_poll_state(dev, reg_esr);

-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
+	/* handle RX-RING */
+	while (((priv->read_ring.full) ||
+		(priv->read_ring.input != priv->read_ring.output)) &&
  	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+		work_done += flexcan_read_frame_from_ring(dev);
  	}

  	/* report bus errors */
@@ -563,9 +633,6 @@ static int flexcan_poll(struct napi_struct *napi, 
int quota)

  	if (work_done < quota) {
  		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
  	}

  	return work_done;
@@ -598,11 +665,14 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
  		 * The error bits are cleared on read,
  		 * save them for later use.
  		 */
-		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
+		priv->reg_esr |= reg_esr & FLEXCAN_ESR_ERR_BUS;
+		/*
+		 * Read the FIFO into the rings.
+		 */
+		while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
+			flexcan_read_frame_to_ring(dev);
+			reg_iflag1 = flexcan_read(&regs->iflag1);
+		}
  		napi_schedule(&priv->napi);
  	}

@@ -1012,6 +1082,7 @@ static int __devinit flexcan_probe(struct 
platform_device *pdev)
  	priv->dev = dev;
  	priv->clk = clk;
  	priv->pdata = pdev->dev.platform_data;
+	spin_lock_init(&priv->read_ring.ring_lock);

  	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);

---------------------------------------------------

flexcan.c.patch.flood

---------------------------------------------------

diff --git a/arm-linux/drivers/net/can/flexcan.c 
b/arm-linux/drivers/net/can/flexcan.c
index 2b25548..f773cb6 100644
--- a/arm-linux/drivers/net/can/flexcan.c
+++ b/arm-linux/drivers/net/can/flexcan.c
@@ -857,11 +857,26 @@ static int flexcan_chip_start(struct net_device *dev)
  	 * _note_: we enable the "error interrupt"
  	 * (FLEXCAN_CTRL_ERR_MSK), too. Otherwise we don't get any
  	 * warning or bus passive interrupts.
+	 *
+	 * __note__: The above is rubbish and causes interrupt
+	 * flooding. Change it to the 3.18 way without of obeying
+	 * CAN_CTRL_MODE_BERR_REPORTING and without enabling the
+	 * Error interrupts.
  	 */
  	reg_ctrl = flexcan_read(&regs->ctrl);
  	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
  	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
-		FLEXCAN_CTRL_ERR_STATE | FLEXCAN_CTRL_ERR_MSK;
+		FLEXCAN_CTRL_ERR_STATE /* | FLEXCAN_CTRL_ERR_MSK */;
+
+	/*
+	* enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
+	* on most Flexcan cores, too. Otherwise we don't get
+	* any error warning or passive interrupts.
+	*/
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
+	else
+		reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;

  	/* save for later use */
  	priv->reg_ctrl_default = reg_ctrl;

---------------------------------------------------

Tom


--------------080009080709090405080405
Content-Type: text/plain; charset=windows-1252;
 name="flexcan.c.patch.buffer"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="flexcan.c.patch.buffer"

ZGlmZiAtLWdpdCBhL2FybS1saW51eC9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvYXJt
LWxpbnV4L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMKb2xkIG1vZGUgMTAwNjQ0Cm5ldyBt
b2RlIDEwMDc1NQppbmRleCAxNGM4YTg2Li45NmUwYjU1Ci0tLSBhL2FybS1saW51eC9kcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jCisrKyBiL2FybS1saW51eC9kcml2ZXJzL25ldC9jYW4v
ZmxleGNhbi5jCkBAIC00Myw2ICs0Myw5IEBACiAvKiA4IGZvciBSWCBmaWZvIGFuZCAyIGVy
cm9yIGhhbmRsaW5nICovCiAjZGVmaW5lIEZMRVhDQU5fTkFQSV9XRUlHSFQJCSg4ICsgMikK
IAorLyogQnVmZmVycyBpbiB0aGUgaW50ZXJydXB0LXJlYWQgcmluZywgMTBtc0AxMDB1cyBw
ZXIuICovCisjZGVmaW5lIEZMRVhDQU5fUkVBRF9SSU5HX1NJWkUJCSgxMDApCisKIC8qIEZM
RVhDQU4gbW9kdWxlIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgKENBTk1DUikgYml0cyAqLwog
I2RlZmluZSBGTEVYQ0FOX01DUl9NRElTCQlCSVQoMzEpCiAjZGVmaW5lIEZMRVhDQU5fTUNS
X0ZSWgkJCUJJVCgzMCkKQEAgLTE3MCw2ICsxNzMsMTQgQEAgc3RydWN0IGZsZXhjYW5fcmVn
cyB7CiAJc3RydWN0IGZsZXhjYW5fbWIgY2FudHhmZ1s2NF07CiB9OwogCitzdHJ1Y3QgZmxl
eGNhbl9yaW5nIHsKKwl1MzIgaW5wdXQ7CQkvKiBSaW5nIGlucHV0IGluZGV4ICovCisJdTMy
IG91dHB1dDsJCS8qIFJpbmcgb3V0cHV0IGluZGV4ICovCisJdTMyIGZ1bGw7CQkvKiByaW5n
IGZ1bGwvd3JhcHBlZCBmbGFnICovCisJc3BpbmxvY2tfdCByaW5nX2xvY2s7CisJc3RydWN0
IGNhbl9mcmFtZSBmcmFtZXNbRkxFWENBTl9SRUFEX1JJTkdfU0laRV07Cit9OworCiBzdHJ1
Y3QgZmxleGNhbl9wcml2IHsKIAlzdHJ1Y3QgY2FuX3ByaXYgY2FuOwogCXN0cnVjdCBuZXRf
ZGV2aWNlICpkZXY7CkBAIC0xODIsNiArMTkzLDcgQEAgc3RydWN0IGZsZXhjYW5fcHJpdiB7
CiAJc3RydWN0IGNsayAqY2xrOwogCXN0cnVjdCBmbGV4Y2FuX3BsYXRmb3JtX2RhdGEgKnBk
YXRhOwogCXN0cnVjdCBncGlvX3N3ICp4Y3ZyX3N3aXRjaDsKKwlzdHJ1Y3QgZmxleGNhbl9y
aW5nIHJlYWRfcmluZzsKIH07CiAKIHN0YXRpYyBzdHJ1Y3QgY2FuX2JpdHRpbWluZ19jb25z
dCBmbGV4Y2FuX2JpdHRpbWluZ19jb25zdCA9IHsKQEAgLTUzMiwxMiArNTQ0LDcwIEBAIHN0
YXRpYyBpbnQgZmxleGNhbl9yZWFkX2ZyYW1lKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJ
cmV0dXJuIDE7CiB9CiAKK3N0YXRpYyBpbnQgZmxleGNhbl9yZWFkX2ZyYW1lX3RvX3Jpbmco
c3RydWN0IG5ldF9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgbmV0X2RldmljZV9zdGF0cyAq
c3RhdHMgPSAmZGV2LT5zdGF0czsKKwlzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2ID0gbmV0
ZGV2X3ByaXYoZGV2KTsKKwlzdHJ1Y3QgY2FuX2ZyYW1lICpjZjsKKworCWNmID0gJnByaXYt
PnJlYWRfcmluZy5mcmFtZXNbcHJpdi0+cmVhZF9yaW5nLmlucHV0XTsKKworCS8qIFJlYWQg
ZXZlbiBpZiByaW5nIGZ1bGwgdG8gY2xlYXIgdGhlIGludGVycnVwdCByZXF1ZXN0ICovCisJ
ZmxleGNhbl9yZWFkX2ZpZm8oZGV2LCBjZik7CisKKwlpZiAocHJpdi0+cmVhZF9yaW5nLmZ1
bGwpIHsKKwkJc3RhdHMtPnJ4X2Ryb3BwZWQrKzsKKwkJcmV0dXJuIDA7CisJfQorCXByaXYt
PnJlYWRfcmluZy5pbnB1dCArPSAxOworCWlmIChwcml2LT5yZWFkX3JpbmcuaW5wdXQgPj0g
RkxFWENBTl9SRUFEX1JJTkdfU0laRSkgeworCQlwcml2LT5yZWFkX3JpbmcuaW5wdXQgID0g
MDsKKwl9CisJaWYgKHByaXYtPnJlYWRfcmluZy5pbnB1dCA9PSBwcml2LT5yZWFkX3Jpbmcu
b3V0cHV0KSB7CisJCXByaXYtPnJlYWRfcmluZy5mdWxsID0gMTsKKwl9CisKKwlzdGF0cy0+
cnhfcGFja2V0cysrOworCXN0YXRzLT5yeF9ieXRlcyArPSBjZi0+Y2FuX2RsYzsKKworCXJl
dHVybiAxOworfQorCitzdGF0aWMgaW50IGZsZXhjYW5fcmVhZF9mcmFtZV9mcm9tX3Jpbmco
c3RydWN0IG5ldF9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgbmV0X2RldmljZV9zdGF0cyAq
c3RhdHMgPSAmZGV2LT5zdGF0czsKKwlzdHJ1Y3QgZmxleGNhbl9wcml2ICpwcml2ID0gbmV0
ZGV2X3ByaXYoZGV2KTsKKwlzdHJ1Y3QgY2FuX2ZyYW1lICpjZjsKKwlzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlza2IgPSBhbGxvY19jYW5fc2ti
KGRldiwgJmNmKTsKKwlpZiAodW5saWtlbHkoIXNrYikpIHsKKwkJc3RhdHMtPnJ4X2Ryb3Bw
ZWQrKzsKKwkJcmV0dXJuIDE7CS8qIHdhcyAwLCBidXQgdGhhdCdzIGFuIGluZmluaXRlIGxv
b3AgYnVnICovCisJfQorCS8qIEFzc3VtZXMgdGhhdCB0aGUgcmluZy1lbXB0eSB0ZXN0IGFs
cmVhZHkgZG9uZSAqLworCW1lbWNweShjZiwgJnByaXYtPnJlYWRfcmluZy5mcmFtZXNbcHJp
di0+cmVhZF9yaW5nLm91dHB1dF0sIHNpemVvZigqY2YpKTsKKworCXNwaW5fbG9ja19pcnFz
YXZlKCZwcml2LT5yZWFkX3JpbmcucmluZ19sb2NrLCBmbGFncyk7CisJcHJpdi0+cmVhZF9y
aW5nLmZ1bGwgPSAwOworCXByaXYtPnJlYWRfcmluZy5vdXRwdXQgKz0gMTsKKwlpZiAocHJp
di0+cmVhZF9yaW5nLm91dHB1dCA+PSBGTEVYQ0FOX1JFQURfUklOR19TSVpFKSB7CisJCXBy
aXYtPnJlYWRfcmluZy5vdXRwdXQgPSAwOworCX0KKwlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZwcml2LT5yZWFkX3JpbmcucmluZ19sb2NrLCBmbGFncyk7CisKKwluZXRpZl9yZWNlaXZl
X3NrYihza2IpOworCisJcmV0dXJuIDE7Cit9CisKIHN0YXRpYyBpbnQgZmxleGNhbl9wb2xs
KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IHF1b3RhKQogewogCXN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYgPSBuYXBpLT5kZXY7Ci0JY29uc3Qgc3RydWN0IGZsZXhjYW5fcHJpdiAq
cHJpdiA9IG5ldGRldl9wcml2KGRldik7CisJc3RydWN0IGZsZXhjYW5fcHJpdiAqcHJpdiA9
IG5ldGRldl9wcml2KGRldik7CiAJc3RydWN0IGZsZXhjYW5fcmVncyBfX2lvbWVtICpyZWdz
ID0gcHJpdi0+YmFzZTsKLQl1MzIgcmVnX2lmbGFnMSwgcmVnX2VzcjsKKwl1MzIgcmVnX2Vz
cjsKIAlpbnQgd29ya19kb25lID0gMDsKIAogCS8qCkBAIC01NDUsMTYgKzYxNSwxNiBAQCBz
dGF0aWMgaW50IGZsZXhjYW5fcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBx
dW90YSkKIAkgKiB1c2Ugc2F2ZWQgdmFsdWUgZnJvbSBpcnEgaGFuZGxlci4KIAkgKi8KIAly
ZWdfZXNyID0gZmxleGNhbl9yZWFkKCZyZWdzLT5lc3IpIHwgcHJpdi0+cmVnX2VzcjsKKwlw
cml2LT5yZWdfZXNyID0gMDsKIAogCS8qIGhhbmRsZSBzdGF0ZSBjaGFuZ2VzICovCiAJd29y
a19kb25lICs9IGZsZXhjYW5fcG9sbF9zdGF0ZShkZXYsIHJlZ19lc3IpOwogCi0JLyogaGFu
ZGxlIFJYLUZJRk8gKi8KLQlyZWdfaWZsYWcxID0gZmxleGNhbl9yZWFkKCZyZWdzLT5pZmxh
ZzEpOwotCXdoaWxlIChyZWdfaWZsYWcxICYgRkxFWENBTl9JRkxBR19SWF9GSUZPX0FWQUlM
QUJMRSAmJgorCS8qIGhhbmRsZSBSWC1SSU5HICovCisJd2hpbGUgKCgocHJpdi0+cmVhZF9y
aW5nLmZ1bGwpIHx8CisJCShwcml2LT5yZWFkX3JpbmcuaW5wdXQgIT0gcHJpdi0+cmVhZF9y
aW5nLm91dHB1dCkpICYmCiAJICAgICAgIHdvcmtfZG9uZSA8IHF1b3RhKSB7Ci0JCXdvcmtf
ZG9uZSArPSBmbGV4Y2FuX3JlYWRfZnJhbWUoZGV2KTsKLQkJcmVnX2lmbGFnMSA9IGZsZXhj
YW5fcmVhZCgmcmVncy0+aWZsYWcxKTsKKwkJd29ya19kb25lICs9IGZsZXhjYW5fcmVhZF9m
cmFtZV9mcm9tX3JpbmcoZGV2KTsKIAl9CiAKIAkvKiByZXBvcnQgYnVzIGVycm9ycyAqLwpA
QCAtNTYzLDkgKzYzMyw2IEBAIHN0YXRpYyBpbnQgZmxleGNhbl9wb2xsKHN0cnVjdCBuYXBp
X3N0cnVjdCAqbmFwaSwgaW50IHF1b3RhKQogCiAJaWYgKHdvcmtfZG9uZSA8IHF1b3RhKSB7
CiAJCW5hcGlfY29tcGxldGUobmFwaSk7Ci0JCS8qIGVuYWJsZSBJUlFzICovCi0JCWZsZXhj
YW5fd3JpdGUoRkxFWENBTl9JRkxBR19ERUZBVUxULCAmcmVncy0+aW1hc2sxKTsKLQkJZmxl
eGNhbl93cml0ZShwcml2LT5yZWdfY3RybF9kZWZhdWx0LCAmcmVncy0+Y3RybCk7CiAJfQog
CiAJcmV0dXJuIHdvcmtfZG9uZTsKQEAgLTU5OCwxMSArNjY1LDE0IEBAIHN0YXRpYyBpcnFy
ZXR1cm5fdCBmbGV4Y2FuX2lycShpbnQgaXJxLCB2b2lkICpkZXZfaWQpCiAJCSAqIFRoZSBl
cnJvciBiaXRzIGFyZSBjbGVhcmVkIG9uIHJlYWQsCiAJCSAqIHNhdmUgdGhlbSBmb3IgbGF0
ZXIgdXNlLgogCQkgKi8KLQkJcHJpdi0+cmVnX2VzciA9IHJlZ19lc3IgJiBGTEVYQ0FOX0VT
Ul9FUlJfQlVTOwotCQlmbGV4Y2FuX3dyaXRlKEZMRVhDQU5fSUZMQUdfREVGQVVMVCAmCi0J
CQl+RkxFWENBTl9JRkxBR19SWF9GSUZPX0FWQUlMQUJMRSwgJnJlZ3MtPmltYXNrMSk7Ci0J
CWZsZXhjYW5fd3JpdGUocHJpdi0+cmVnX2N0cmxfZGVmYXVsdCAmIH5GTEVYQ0FOX0NUUkxf
RVJSX0FMTCwKLQkJICAgICAgICZyZWdzLT5jdHJsKTsKKwkJcHJpdi0+cmVnX2VzciB8PSBy
ZWdfZXNyICYgRkxFWENBTl9FU1JfRVJSX0JVUzsKKwkJLyoKKwkJICogUmVhZCB0aGUgRklG
TyBpbnRvIHRoZSByaW5ncy4KKwkJICovCisJCXdoaWxlIChyZWdfaWZsYWcxICYgRkxFWENB
Tl9JRkxBR19SWF9GSUZPX0FWQUlMQUJMRSkgeworCQkJZmxleGNhbl9yZWFkX2ZyYW1lX3Rv
X3JpbmcoZGV2KTsKKwkJCXJlZ19pZmxhZzEgPSBmbGV4Y2FuX3JlYWQoJnJlZ3MtPmlmbGFn
MSk7CisJCX0KIAkJbmFwaV9zY2hlZHVsZSgmcHJpdi0+bmFwaSk7CiAJfQogCkBAIC0xMDEy
LDYgKzEwODIsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBmbGV4Y2FuX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJcHJpdi0+ZGV2ID0gZGV2OwogCXByaXYtPmNs
ayA9IGNsazsKIAlwcml2LT5wZGF0YSA9IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOworCXNw
aW5fbG9ja19pbml0KCZwcml2LT5yZWFkX3JpbmcucmluZ19sb2NrKTsKIAogCW5ldGlmX25h
cGlfYWRkKGRldiwgJnByaXYtPm5hcGksIGZsZXhjYW5fcG9sbCwgRkxFWENBTl9OQVBJX1dF
SUdIVCk7CiAK
--------------080009080709090405080405
Content-Type: text/plain; charset=windows-1252;
 name="flexcan.c.patch.flood"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="flexcan.c.patch.flood"

ZGlmZiAtLWdpdCBhL2FybS1saW51eC9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvYXJt
LWxpbnV4L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMKaW5kZXggMmIyNTU0OC4uZjc3M2Ni
NiAxMDA2NDQKLS0tIGEvYXJtLWxpbnV4L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMKKysr
IGIvYXJtLWxpbnV4L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMKQEAgLTg1NywxMSArODU3
LDI2IEBAIHN0YXRpYyBpbnQgZmxleGNhbl9jaGlwX3N0YXJ0KHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCiAJICogX25vdGVfOiB3ZSBlbmFibGUgdGhlICJlcnJvciBpbnRlcnJ1cHQiCiAJ
ICogKEZMRVhDQU5fQ1RSTF9FUlJfTVNLKSwgdG9vLiBPdGhlcndpc2Ugd2UgZG9uJ3QgZ2V0
IGFueQogCSAqIHdhcm5pbmcgb3IgYnVzIHBhc3NpdmUgaW50ZXJydXB0cy4KKwkgKgorCSAq
IF9fbm90ZV9fOiBUaGUgYWJvdmUgaXMgcnViYmlzaCBhbmQgY2F1c2VzIGludGVycnVwdAor
CSAqIGZsb29kaW5nLiBDaGFuZ2UgaXQgdG8gdGhlIDMuMTggd2F5IHdpdGhvdXQgb2Ygb2Jl
eWluZworCSAqIENBTl9DVFJMX01PREVfQkVSUl9SRVBPUlRJTkcgYW5kIHdpdGhvdXQgZW5h
YmxpbmcgdGhlCisJICogRXJyb3IgaW50ZXJydXB0cy4KIAkgKi8KIAlyZWdfY3RybCA9IGZs
ZXhjYW5fcmVhZCgmcmVncy0+Y3RybCk7CiAJcmVnX2N0cmwgJj0gfkZMRVhDQU5fQ1RSTF9U
U1lOOwogCXJlZ19jdHJsIHw9IEZMRVhDQU5fQ1RSTF9CT0ZGX1JFQyB8IEZMRVhDQU5fQ1RS
TF9MQlVGIHwKLQkJRkxFWENBTl9DVFJMX0VSUl9TVEFURSB8IEZMRVhDQU5fQ1RSTF9FUlJf
TVNLOworCQlGTEVYQ0FOX0NUUkxfRVJSX1NUQVRFIC8qIHwgRkxFWENBTl9DVFJMX0VSUl9N
U0sgKi87CisKKwkvKgorCSogZW5hYmxlIHRoZSAiZXJyb3IgaW50ZXJydXB0IiAoRkxFWENB
Tl9DVFJMX0VSUl9NU0spLAorCSogb24gbW9zdCBGbGV4Y2FuIGNvcmVzLCB0b28uIE90aGVy
d2lzZSB3ZSBkb24ndCBnZXQKKwkqIGFueSBlcnJvciB3YXJuaW5nIG9yIHBhc3NpdmUgaW50
ZXJydXB0cy4KKwkqLworCWlmIChwcml2LT5jYW4uY3RybG1vZGUgJiBDQU5fQ1RSTE1PREVf
QkVSUl9SRVBPUlRJTkcpCisJCXJlZ19jdHJsIHw9IEZMRVhDQU5fQ1RSTF9FUlJfTVNLOwor
CWVsc2UKKwkJcmVnX2N0cmwgJj0gfkZMRVhDQU5fQ1RSTF9FUlJfTVNLOwogCiAJLyogc2F2
ZSBmb3IgbGF0ZXIgdXNlICovCiAJcHJpdi0+cmVnX2N0cmxfZGVmYXVsdCA9IHJlZ19jdHJs
Owo=
--------------080009080709090405080405--
