From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 16:32:28 +0100
Message-ID: <4F35388C.5040803@sebastianhaas.info>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F34F8BC.3030903@peak-system.com> <4F34FC8F.4000104@pengutronix.de> <4F350326.30006@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:43292 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab2BJPc1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 10:32:27 -0500
In-Reply-To: <4F350326.30006@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Am 10.02.2012 12:44, schrieb Wolfgang Grandegger:
> On 02/10/2012 12:16 PM, Marc Kleine-Budde wrote:
>> On 02/10/2012 12:00 PM, Stephane Grosjean wrote:
>>> Hi all,
>>>
>>> While always fighting against pcmcia Oliver (very hot) unplug issue=
, I
>>> decided to have a look to the sja1000 lib, since the pcmcia driver =
ISR
>>> does call "sja1000_interrupt()",
>>>
>>> Unfortunately, I found that:
>>>
>>>                  if (isrc&  IRQ_RI) {
>>>                          /* receive interrupt */
>>>                          while (status&  SR_RBS) {
>>>                                  sja1000_rx(dev);
>>>                                  status =3D priv->read_reg(priv, RE=
G_SR);
>>>                          }
>>>                  }
>>>
>>> My problem is, once the card is unplugged, every ioread in its
>>> corresponding io space does return 0xff...
>>> I just change this potential infinite while() into a corresponding
>>> for(;;) loop to test, like this:
>>>
>>> -                        while (status&  SR_RBS) {
>>> +                        int i;
>>> +                        for (i =3D 0; (status&  SR_RBS)&&  (i<  10=
); i++) {
>>>
>>> And no more PC hang!
>>>
>>> Can you confirm this, please?
>>>
>>> @Oliver: IMHO, the 0xff (invalid) value is also the reason of the
>>> "wakeup interrupt" message you got when unplugging the cards from t=
heir
>>> slots...
>>
>> Is 0xff a valid value for REG_SR in the first place? If not we can f=
or
>> example exit the interrupt handler.
>
> Is the access to the address space of an unplugged card defined at al=
l?
> Or may it even hang the system?
AFAIK PCMCIA is based on ISA and therefor it is absolutely valid to rea=
d=20
and even write into this address space. It is up to user to check if th=
e=20
device is still there and accessiable.

=46or that ems_pcmcia does something like this:
static irqreturn_t ems_pcmcia_interrupt(int irq, void *dev_id)
{
=2E..
   /* Card not present */
   if (readw(card->base_addr) !=3D 0xAA55)
     return IRQ_HANDLED;

   Call sja1000_interrupt() ...
=2E..
}

Stephan=E9 can you do something like this as well?

Cheers,
  Sebastian
