From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Tue, 14 Feb 2012 17:41:47 +0100
Message-ID: <4F3A8ECB.7090803@hartkopp.net>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net> <4F3A3493.8010900@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:23173 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885Ab2BNQls (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 11:41:48 -0500
In-Reply-To: <4F3A3493.8010900@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 14.02.2012 11:16, Stephane Grosjean wrote:

>=20
> Le 14/02/2012 10:59, Oliver Hartkopp a =C3=A9crit :
>=20
>> @@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev=
_id)
>>       while ((isrc =3D priv->read_reg(priv, REG_IR))&&  (n<  SJA1000=
_MAX_IRQ)) {
>>           n++;
>>           status =3D priv->read_reg(priv, REG_SR);
>> +        /* check for absent controller due to hw unplug */
>> +        if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>> +            break;
>>
>>           if (isrc&  IRQ_WUI)
>>               netdev_warn(dev, "wakeup interrupt\n");
>> @@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev=
_id)
>>               while (status&  SR_RBS) {
>>                   sja1000_rx(dev);
>>                   status =3D priv->read_reg(priv, REG_SR);
>> +                /* check for absent controller */
>> +                if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>> +                    break;
>>               }
>>           }
>>           if (isrc&  (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI=
)) {
>>
>> The big advantage is, that we do not need another expensive register=
 read nor
>> another loop counter variable in the case everything is working fine=
=2E
>>
>> Only when the _already_ read status variable becomes 0xFF we check i=
n the
>> mode register if the device is still present.
>>
>> And finally there's a very little chance left to create rubbish data=
=2E
>=20
>=20
> Quite perfect, except that we will push a "rubbish" error frame befor=
e
> exiting, and we will return IRQ_HANDLED while I would prefer IRQ_NONE=
=2E..
> But does it matter?


An alternative would be to replace the 'break' statements above with

	return IRQ_NONE;

like

		/* check for absent controller due to hw unplug */
		if (status =3D=3D 0xFF && !sja1000_probe_chip(dev))
			return IRQ_NONE;

Don't know if this is 'good style' - but the while statement allows it =
;-)

>=20
> Moreover, regarding to this patch, should the peak_pcmcia custom isr =
always
> test for the card presence? I mean, this costs at least 2xtwo ioread8=
 for each
> hw irq!


I think the earlier we know the better.

But indeed both drivers (PEAK/EMS PCMCIA) do no need priv->pre_irq ...

So if we add the 'return IRQ_NONE' to the above patch the private check=
 for
present hardware becomes obsolete as the private ISRs terminate properl=
y when
they get an IRQ_NONE.

Right?

Regards,
Oliver
