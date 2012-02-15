From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 08:03:45 +0100
Message-ID: <4F3B58D1.1040804@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48586 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab2BOHD4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 02:03:56 -0500
In-Reply-To: <4F3A8ECB.7090803@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Oliver,

we start paving common code to partially cure pcmcia related problems,
that's exactly what I do not like.

On 02/14/2012 05:41 PM, Oliver Hartkopp wrote:
> On 14.02.2012 11:16, Stephane Grosjean wrote:
>=20
>>
>> Le 14/02/2012 10:59, Oliver Hartkopp a =E9crit :
>>
>>> @@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *de=
v_id)
>>>       while ((isrc =3D priv->read_reg(priv, REG_IR))&&  (n<  SJA100=
0_MAX_IRQ)) {

In case of unplug, already the above read may return 0xff.

>>>           n++;
>>>           status =3D priv->read_reg(priv, REG_SR);
>>> +        /* check for absent controller due to hw unplug */
>>> +        if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>>> +            break;

Once...

>>>           if (isrc&  IRQ_WUI)
>>>               netdev_warn(dev, "wakeup interrupt\n");
>>> @@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *de=
v_id)
>>>               while (status&  SR_RBS) {
>>>                   sja1000_rx(dev);
>>>                   status =3D priv->read_reg(priv, REG_SR);
>>> +                /* check for absent controller */
>>> +                if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev)=
)
>>> +                    break;

=2E.. twice... What about the other accesses?

>>>               }
>>>           }
>>>           if (isrc&  (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_AL=
I)) {
>>>
>>> The big advantage is, that we do not need another expensive registe=
r read nor
>>> another loop counter variable in the case everything is working fin=
e.
>>>
>>> Only when the _already_ read status variable becomes 0xFF we check =
in the
>>> mode register if the device is still present.
>>>
>>> And finally there's a very little chance left to create rubbish dat=
a.
>>
>>
>> Quite perfect, except that we will push a "rubbish" error frame befo=
re
>> exiting, and we will return IRQ_HANDLED while I would prefer IRQ_NON=
E...
>> But does it matter?

Well, it's far away from being perfect?

>=20
> An alternative would be to replace the 'break' statements above with
>=20
> 	return IRQ_NONE;
>=20
> like
>=20
> 		/* check for absent controller due to hw unplug */
> 		if (status =3D=3D 0xFF && !sja1000_probe_chip(dev))
> 			return IRQ_NONE;
>=20
> Don't know if this is 'good style' - but the while statement allows i=
t ;-)
>=20
>>
>> Moreover, regarding to this patch, should the peak_pcmcia custom isr=
 always
>> test for the card presence? I mean, this costs at least 2xtwo ioread=
8 for each
>> hw irq!
>=20
>=20
> I think the earlier we know the better.
>=20
> But indeed both drivers (PEAK/EMS PCMCIA) do no need priv->pre_irq ..=
=2E
>=20
> So if we add the 'return IRQ_NONE' to the above patch the private che=
ck for
> present hardware becomes obsolete as the private ISRs terminate prope=
rly when
> they get an IRQ_NONE.
>=20
> Right?

If it's clear that the interrupt came from that device, we should retur=
n
IRQ_HANDLED otherwise it's treated as spurious. I would accept *one* "i=
f
(status =3D=3D 0xFF ..." check in a good place.

Wolfgang.
