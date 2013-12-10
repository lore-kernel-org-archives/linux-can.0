From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Tue, 10 Dec 2013 14:47:24 +0100
Message-ID: <52A71B6C.3050600@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:42825 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab3LJNra (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 08:47:30 -0500
In-Reply-To: <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: linux-can@vger.kernel.org

Hey all,

as I have a similar setup here (Core i7, 5x PEAK cPCI = 20 CAN interfaces) I
downloaded the linux-image-3.10-0.bpo.3-rt-686-pae kernel including the
sources from

	http://packages.debian.org/de/wheezy-backports/kernel/

and was able to see Austins problem with the -rt kernel.

My interrupt lines are mostly dedicated to the CAN interfaces, so I was able
to select interrupts (17 & 19) that _only_ deal with sja1000 irq handlers:

 16:          7          7         10          9   IO-APIC-fasteoi   ehci_hcd:usb1, ahci, can4, can5, can6, can7
 17:    6328236    6330659    6328557    6330266   IO-APIC-fasteoi   can8, can10, can9
 18:          0          0          0          0   IO-APIC-fasteoi   can12, can13, can14, can15
 19:    1446093    1443817    1445833    1444230   IO-APIC-fasteoi   can2, can16, can17, can18, can19, can3, can1, can0

can0/can2 are linked together (500 kbit/s)
can1/can3 are linked together (500 kbit/s)
can9 is linked to a 1Mbit/s CAN traffic source

All interfaces get a full bus load from the outside.
Additionally can0 and can1 get a 'cangen -g0 -i <if>' from the local host.

The funny thing was that one time IRQ #19 got disabled twice(?!?) :

Message from syslogd@xxxxx at Dec 10 11:25:37 ...
 kernel:[  967.213174] Disabling IRQ #19

Message from syslogd@xxxxx at Dec 10 12:06:13 ...
 kernel:[ 3401.523019] Disabling IRQ #17

Message from syslogd@xxxxx at Dec 10 12:49:08 ...
 kernel:[ 5975.113373] Disabling IRQ #19

Don't know where the last message could come from as the 8 CAN interfaces at
this interrupt line were already dead for more than a hour.

The disabling of the interrupt seems to be reproducible - as Austin already
mentioned after different times.

My assumption was that we run into a problem with the PITA chip, when
consuming the interface specific interrupt line in peak_pci_post_irq(), see:

static void peak_pci_post_irq(const struct sja1000_priv *priv)
{
        struct peak_pci_chan *chan = priv->priv;
        u16 icr;

        /* Select and clear in PITA stored interrupt */
        icr = readw(chan->cfg_base + PITA_ICR);
        if (icr & chan->icr_mask)
                writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
}

With the writew() only the corresponding SJA1000 line is consumed.

My quick hack was to clear all bits in the PITA each time:

--- peak_pci.c~ 2013-09-08 07:10:14.000000000 +0200
+++ peak_pci.c  2013-12-10 13:26:48.315166478 +0100
@@ -542,9 +542,13 @@
        u16 icr;
 
        /* Select and clear in PITA stored interrupt */
+#if 0
        icr = readw(chan->cfg_base + PITA_ICR);
        if (icr & chan->icr_mask)
                writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
+#else
+       writew(0x00C3, chan->cfg_base + PITA_ICR);
+#endif
 }
 
 static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

The 0x00C3 comes from OR'ing the values from 
static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX]

I'm currently running the setup for more than one hour without any problems.

But I assume that this a really bad hack - and I did not check, if any CAN
frames got lost. Btw. the performance increased from 90% busload to 95%
busload with that patch when creating only local traffic on the host.

Any idea how to proceed?

Regards,
Oliver
