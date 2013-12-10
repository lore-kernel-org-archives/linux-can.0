From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Tue, 10 Dec 2013 17:05:05 +0100
Message-ID: <52A73BB1.7070701@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30034 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3LJQFQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 11:05:16 -0500
In-Reply-To: <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On 10.12.2013 15:41, Wolfgang Grandegger wrote:
> On Tue, 10 Dec 2013 14:47:24 +0100, Oliver Hartkopp

>> +       writew(0x00C3, chan->cfg_base + PITA_ICR);
> 
> This may kill unhandled (shared) IRQs. You can do that only if all
> handlers have been called in advance (with a global ISR).
> 

So here's my patch for PITA access protection in peak_pci_post_irq().

Note that we need a single lock for all (e.g. 4) channels of the PITA.
So my idea was to create the lock in the per-channel structure of the first
channel and then let the channels 1,2,3 refer to this lock.

Maybe there's a better solution for that. E.g. the driver cleanup at removal
time may get into problems with this approach?!?

So far the system is running. I'll take a look tomorrow morning if its still
alive :-) Maybe Austin can do some tests with this patch too.

Regards,
Oliver

--- linux-source-3.10/drivers/net/can/sja1000/peak_pci.c	2013-09-08 07:10:14.000000000 +0200
+++ linux-source-3.10-rt/drivers/net/can/sja1000/peak_pci.c	2013-12-10 16:58:16.381938240 +0100
@@ -41,6 +41,8 @@
 struct peak_pciec_card;
 struct peak_pci_chan {
 	void __iomem *cfg_base;		/* Common for all channels */
+	spinlock_t pita_lock;
+	spinlock_t *pita_lock_ptr;
 	struct net_device *prev_dev;	/* Chain of network devices */
 	u16 icr_mask;			/* Interrupt mask for fast ack */
 	struct peak_pciec_card *pciec_card;	/* only for PCIeC LEDs */
@@ -539,12 +541,17 @@
 static void peak_pci_post_irq(const struct sja1000_priv *priv)
 {
 	struct peak_pci_chan *chan = priv->priv;
+	unsigned long flags;
 	u16 icr;
 
 	/* Select and clear in PITA stored interrupt */
+	spin_lock_irqsave(chan->pita_lock_ptr, flags);
+
 	icr = readw(chan->cfg_base + PITA_ICR);
 	if (icr & chan->icr_mask)
 		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
+
+	spin_unlock_irqrestore(chan->pita_lock_ptr, flags);
 }
 
 static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -553,6 +560,7 @@
 	struct peak_pci_chan *chan;
 	struct net_device *dev;
 	void __iomem *cfg_base, *reg_base;
+	spinlock_t *pita_lock_ptr0;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
 
@@ -611,6 +619,7 @@
 	icr = readw(cfg_base + PITA_ICR + 2);
 
 	for (i = 0; i < channels; i++) {
+
 		dev = alloc_sja1000dev(sizeof(struct peak_pci_chan));
 		if (!dev) {
 			err = -ENOMEM;
@@ -623,6 +632,13 @@
 		chan->cfg_base = cfg_base;
 		priv->reg_base = reg_base + i * PEAK_PCI_CHAN_SIZE;
 
+		if (i == 0) {
+			spin_lock_init(&chan->pita_lock);
+			pita_lock_ptr0 = &chan->pita_lock;
+		}
+
+		chan->pita_lock_ptr = pita_lock_ptr0;
+
 		priv->read_reg = peak_pci_read_reg;
 		priv->write_reg = peak_pci_write_reg;
 		priv->post_irq = peak_pci_post_irq;


