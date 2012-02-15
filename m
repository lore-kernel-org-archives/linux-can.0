From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 16:06:03 +0100
Message-ID: <4F3BC9DB.6040604@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net> <4F3B58D1.1040804@grandegger.com> <4F3B9C86.8030105@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33079 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2BOPGP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 10:06:15 -0500
In-Reply-To: <4F3B9C86.8030105@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/15/2012 12:52 PM, Stephane Grosjean wrote:
> Le 15/02/2012 08:03, Wolfgang Grandegger a =E9crit :
>> Hi Oliver,
>>
>> we start paving common code to partially cure pcmcia related problem=
s,
>> that's exactly what I do not like.
>=20
>=20
> I think it's much more than a pcmcia related problem: IMHO, I think i=
t's
> right in some common code to do some 'basic' checks on returned value=
s,
> especially when these are returned from custom callbacks and these
> values are so critical. For me, it's like one has to check the kmallo=
c()
> return value, for example. But I admit this could not be the right(TM=
)
> way of doing things in the Kernel.

Well, but it's unusual (and slow) to check any hardware access.

>>> An alternative would be to replace the 'break' statements above wit=
h
>>>
>>>     return IRQ_NONE;
>>>
>>> like
>>>
>>>         /* check for absent controller due to hw unplug */
>>>         if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>>>             return IRQ_NONE;
>>>
>>> Don't know if this is 'good style' - but the while statement allows
>>> it ;-)
>>>
>>>> Moreover, regarding to this patch, should the peak_pcmcia custom i=
sr
>>>> always
>>>> test for the card presence? I mean, this costs at least 2xtwo
>>>> ioread8 for each
>>>> hw irq!
>>>
>>> I think the earlier we know the better.
>=20
>=20
> Ok, so I keep testing the presence of the card in the peak_pcmcia dri=
ver.
>=20
> If I may ask something else: didn't find any "linux-pcmcia" mailing l=
ist
> (or something like that) in vger majordomo lists. Does someone know i=
f
> there is such a list? By default, which ml should be posted the
> peak_pcmcia.c too?

Here is the entry from the kernel's MAINTAINER file with the relevant
mailing list address:

PCMCIA SUBSYSTEM
P:      Linux PCMCIA Team
L:      linux-pcmcia@lists.infradead.org
W:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
S:      Maintained
=46:      Documentation/pcmcia/
=46:      drivers/pcmcia/
=46:      include/pcmcia/


>>> But indeed both drivers (PEAK/EMS PCMCIA) do no need priv->pre_irq =
=2E..
>=20
>=20
> Hmmm... I don't know what is the real goal of these pre_irq() and
> post_iqr() callbacks but I imagine that, for example, the "pre_irq()"
> could acquire a lock while the post_irq() would release it... So, I
> would prefer to call the post_irq() anytime (that is, no direct "retu=
rn
> IRQ_xxx" but a 'break'  or a 'goto'). Does it make sense?

The pre_irq and post_irq callbacks have been introduced to allow device
specific interrupt handling/acknowledgement before and after the common
handler. Have a look to the peak_pci driver to understand what I mean.

>=20
>=20
>>> So if we add the 'return IRQ_NONE' to the above patch the private
>>> check for
>>> present hardware becomes obsolete as the private ISRs terminate
>>> properly when
>>> they get an IRQ_NONE.
>>>
>>> Right?
>=20
>=20
> I would also have say that before, but I checked that IRQ_NONE may be
> processed as spurious, so I don't even know, for the moment. LDD3
> chapter 10 also says:
>=20
>> Interrupt handlers should return a value indicating whether there wa=
s
>> actually an
>> interrupt to handle. If the handler found that its device did, indee=
d,
>> need attention, it
>> should return IRQ_HANDLED; otherwise the return value should be IRQ_=
NONE.
>=20
> So, what does this "need attention" stands for? Since the device is
> unplugged, we could say that it didn't need any attention anymore...
> But, on the other hand, the ems_pcmcia driver does return IRQ_HANDLED
> when its private check fails to detect the card and it has been
> approved, so, where is the truth? Near the perfection? ;-)

=46rom http://lxr.linux.no/#linux+v3.2.6/include/linux/irqreturn.h:

  IRQ_NONE            interrupt was not from this device

Wolfgang.

