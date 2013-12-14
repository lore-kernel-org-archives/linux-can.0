From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Sat, 14 Dec 2013 10:51:06 +0100
Message-ID: <52AC2A0A.1040201@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com> <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net> <52AA3F16.3070309@grandegger.com> <52A
 AD5A9.5030607@hartkopp.net> <52AADC61.6010807@pengutronix.de> <52AB345A.6020203@hartkopp.net> <52AB407B.4040700@hartkopp.net> <52AB78BE.6010905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:64159 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3LNJvJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Dec 2013 04:51:09 -0500
In-Reply-To: <52AB78BE.6010905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org

Ok. I think I got it now:

As long as the PCAN PCI adapter had only 2 channels PEAK obviously used the
PSB4600 PITA v1.2 (1-pita_12p.pdf) where there are two interrupt lines INT0
and INT1 accessible by bit 0 and bit 1 in the ICR register (see page 191).

Due to the discontinuation of the PSB4600 in newer designs there's a Lattice
4256V CPLD, see detail photo at

	http://gridconnect.com/pcan/can-adapters/can-mini-pci.html

The CPLD now obviously uses the formerly reserved bits 6+7 for the channels
3+4 in a backward compatible manner. So everything with peak_pci_icr_masks[]
is fine but it's no real PITA anymore :-)

Sorry for the confusion.

Looks like there's some more investigation of the -rt irq threads to do :-(

Regards,
Oliver


On 13.12.2013 22:14, Oliver Hartkopp wrote:
> Hi all,
> 
> after some more investigation of the two PITA specifications
> 
> https://www.google.de/#q=PCI+Interface+for+Telephony+infineon
> 
> http://pdf.datasheetcatalog.com/datasheet/infineon/1-pita_22p.pdf
> 
> and
> 
> http://pdf.datasheetcatalog.com/datasheet/infineon/1-pita_12p.pdf
> 
> I'm not sure *why* the driver works at all.
> 
> It's the mix between byte and word accesses and especially the per-device
> interrupt bits in the PITA_ICR (Interrupt Control Register).
> 
> The interrupt bits in this register GP[0123]_INT are located in the bits
> 2,3,4,5 in the ICR (1-pita_12p.pdf, p. 191 / 1-pita_22p.pdf p.202)
> 
> If my interpretation is correct the
> 
> 	static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] = {
>         	0x02, 0x01, 0x40, 0x80
> 	};
> 
> would be completely bogus and would not hit the right bit in
> 
> static void peak_pci_post_irq(const struct sja1000_priv *priv)
> {
>         struct peak_pci_chan *chan = priv->priv;
>         u16 icr;
> 
>         /* Select and clear in PITA stored interrupt */
>         icr = readw(chan->cfg_base + PITA_ICR);
>         if (icr & chan->icr_mask)
>                 writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
> }
> 
> at all.
> 
> Am I wrong? Or is this the wrong specification?
> The code in ems_pci.c seems to fit to this PITA spec ...
> 
> Regards,
> Oliver
> 
> 
> On 13.12.2013 18:14, Oliver Hartkopp wrote:
>> Answering myself ...
>>
>>>
>>> Maybe it's time to look into other implementations than PEAK/mainline ...
>>>
>>
>> E.g. a EMS_PCI adapter has a PITA-2 too (depending on it's HW revicsion).
>> There's a EMS PCI driver in mainline and (at least) can4linux.
>>
>> Both access the registers with 32 bit read/write functions but the peak_pci
>> only writes 16 bit values?!?
>>
>> Checking
>>
>> 	http://pdf.datasheetcatalog.com/datasheet/infineon/1-pita_22p.pdf
>>
>> 32 bit should be the right way to do it.
>>
>> Regards,
>> Oliver
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
