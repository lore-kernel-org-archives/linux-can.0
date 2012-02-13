From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 11:56:34 +0100
Message-ID: <4F38EC62.1050004@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38EA22.2050506@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48576 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2BMK5D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:57:03 -0500
In-Reply-To: <4F38EA22.2050506@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/13/2012 11:46 AM, Stephane Grosjean wrote:
> Le 13/02/2012 11:14, Wolfgang Grandegger a =E9crit :
>>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>>> b/drivers/net/can/sja1000/sja1000.c
>>>> index ebbcfca..f7526a7 100644
>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void
>>>> *dev_id)
>>>>                   n++;
>>>>                   status =3D priv->read_reg(priv, REG_SR);
>>>>
>>>> +               /* check for absent controller due to hw unplug */
>>>> +               if (status =3D=3D 0xFF)
>>>> +                       break;
>>>> +
>>>>                   if (isrc&   IRQ_WUI)
>>>>                           netdev_warn(dev, "wakeup interrupt\n");
>>>>
>>>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void
>>>> *dev_id)
>>>>                           netif_wake_queue(dev);
>>>>                   }
>>>>                   if (isrc&   IRQ_RI) {
>>>> -                       /* receive interrupt */
>>>> -                       while (status&   SR_RBS) {
>>>> +                       /* receive interrupt / check for absent
>>>> controller */
>>>> +                       while (status&   SR_RBS&&   status !=3D 0x=
=46F) {
>>>>                                   sja1000_rx(dev);
>>>>                                   status =3D priv->read_reg(priv,
>>>> REG_SR);
>>>>                           }
>>>>
>>>> @Stephane: Can you check that patch? I'm out of hw right now.
>>> I confirm that this patch works too...
>>> So I think I should be able to post a new version of the peak_pcmci=
a
>>> during that day (the previous should work but some calls to
>>> pcmcia_dev_present() are no more useful...)
>> But that fix should not go to the common interrupt handler, if possi=
ble.
>=20
> I suppose that the reason why you say that is because the 0xff value
> doesn't have got the special meaning of "potential unplug" (is it?), =
so
> I could understand why it's not appropriate to check it, in that comm=
on
> handler (perhaps the returned value is different in some other archs =
too).

That's one reason. The other is that it's related to PCMCIA hotplug. Th=
e
check is not needed for other devices =3D=3D> overhead.

> But I don't agree with that potential infinite loop, testing the SR_R=
BS
> bit.
>=20
> So, since we already are looping until SJA1000_MAX_IRQ, why not chang=
ing
> this:
>=20
>                 if (isrc & IRQ_RI) {
>                        /* receive interrupt */
>                        while (status & SR_RBS) {
>                                 sja1000_rx(dev);
>                                 status =3D priv->read_reg(priv, REG_S=
R);
>                         }

We should add that patch, definetely. And the "check for absent
controller due to hw unplug" should go to the custum isr.

> into something like that:
>=20
>                 if (isrc & IRQ_RI) {
>                        /* receive interrupt */
>                        if (status & SR_RBS)
>                                 sja1000_rx(dev);
>=20
>=20
> In that case, even the 0xff value would not loop infinitely... Testin=
g
> the device presence will be of the driver responsibility and could sp=
eed
> up unplug detection.

But the SJA1000_MAX_IRQ is for another register (not for status). I
think we need two separated loops.

Wolfgang.
