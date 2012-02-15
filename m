From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 09:05:41 +0100
Message-ID: <4F3B6755.7080602@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net> <4F3B58D1.1040804@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:25556 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab2BOIFf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 03:05:35 -0500
In-Reply-To: <4F3B58D1.1040804@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 15.02.2012 08:03, Wolfgang Grandegger wrote:

> Hi Oliver,
>=20
> we start paving common code to partially cure pcmcia related problems=
,
> that's exactly what I do not like.


It's PCMCIA and PCIeC and Parallel port, etc. Any pluggable sja1000 har=
dware.

>=20
> On 02/14/2012 05:41 PM, Oliver Hartkopp wrote:
>> On 14.02.2012 11:16, Stephane Grosjean wrote:
>>
>>>
>>> Le 14/02/2012 10:59, Oliver Hartkopp a =E9crit :
>>>
>>>> @@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *d=
ev_id)
>>>>       while ((isrc =3D priv->read_reg(priv, REG_IR))&&  (n<  SJA10=
00_MAX_IRQ)) {
>=20
> In case of unplug, already the above read may return 0xff.


Right. But it does not get a bad effect as we quit from this bad condit=
ion
three lines later. No previously retrieved isrc variable is referenced =
then.
Please re-check the patched sja1000_interrupt() as a whole.

>=20
>>>>           n++;
>>>>           status =3D priv->read_reg(priv, REG_SR);
>>>> +        /* check for absent controller due to hw unplug */
>>>> +        if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>>>> +            break;
>=20
> Once...
>=20
>>>>           if (isrc&  IRQ_WUI)
>>>>               netdev_warn(dev, "wakeup interrupt\n");
>>>> @@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *d=
ev_id)
>>>>               while (status&  SR_RBS) {
>>>>                   sja1000_rx(dev);
>>>>                   status =3D priv->read_reg(priv, REG_SR);
>>>> +                /* check for absent controller */
>>>> +                if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev=
))
>>>> +                    break;
>=20
> ... twice... What about the other accesses?


Which ones do you have in mind?

The really only thing that could happen, that exactly ONE CAN frame can=
 be
damaged on read while accessing the SJA1000 registers. This can not be =
solved
unless you check for sja1000_probe_chip() at the end of reading the fra=
me and
before pushing the skbuff to the rx queue.

But this would add indeed a new ioport access each time we read a CAN f=
rame.

I don't think that we should do this additional effort - even if it's p=
robably
the right(TM) thing to do 8-)

My patch doesn't do any additional ioport accesses in a 'good' conditio=
n.

(..)

>> But indeed both drivers (PEAK/EMS PCMCIA) do no need priv->pre_irq .=
=2E.
>>

>> So if we add the 'return IRQ_NONE' to the above patch the private ch=
eck for
>> present hardware becomes obsolete as the private ISRs terminate prop=
erly when
>> they get an IRQ_NONE.
>>
>> Right?
>=20
> If it's clear that the interrupt came from that device, we should ret=
urn
> IRQ_HANDLED otherwise it's treated as spurious.


Can this usually happen in the case of unplugging devices?

Or we need some kind of wrapper for the sja1000 isr that returns

IRQ_NONE
IRQ_HANDLED
IRQ_PLUGOUT

while HANDLED & PLUGOUT would lead to IRQ_HANDLED on the top level.

> I would accept *one* "if
> (status =3D=3D 0xFF ..." check in a good place.


Sorry but you need an additional check within the while statement.
There are two potential occurrences where we read the status. Why check=
ing
only one time? As i wrote above: Please re-check the entire patched fun=
ction.

Regards,
Oliver
