From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Mon, 13 Feb 2012 11:46:58 +0100
Message-ID: <4F38EA22.2050506@peak-system.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com>
 <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com>
 <4F38E274.4050304@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:34049 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2BMKrE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:47:04 -0500
In-Reply-To: <4F38E274.4050304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 13/02/2012 11:14, Wolfgang Grandegger a =E9crit :
>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>> b/drivers/net/can/sja1000/sja1000.c
>>> index ebbcfca..f7526a7 100644
>>> --- a/drivers/net/can/sja1000/sja1000.c
>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>> @@ -493,6 +493,10 @@ irqreturn_t sja1000_interrupt(int irq, void *d=
ev_id)
>>>                   n++;
>>>                   status =3D priv->read_reg(priv, REG_SR);
>>>
>>> +               /* check for absent controller due to hw unplug */
>>> +               if (status =3D=3D 0xFF)
>>> +                       break;
>>> +
>>>                   if (isrc&   IRQ_WUI)
>>>                           netdev_warn(dev, "wakeup interrupt\n");
>>>
>>> @@ -504,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, void *de=
v_id)
>>>                           netif_wake_queue(dev);
>>>                   }
>>>                   if (isrc&   IRQ_RI) {
>>> -                       /* receive interrupt */
>>> -                       while (status&   SR_RBS) {
>>> +                       /* receive interrupt / check for absent
>>> controller */
>>> +                       while (status&   SR_RBS&&   status !=3D 0xF=
=46) {
>>>                                   sja1000_rx(dev);
>>>                                   status =3D priv->read_reg(priv, R=
EG_SR);
>>>                           }
>>>
>>> @Stephane: Can you check that patch? I'm out of hw right now.
>> I confirm that this patch works too...
>> So I think I should be able to post a new version of the peak_pcmcia
>> during that day (the previous should work but some calls to
>> pcmcia_dev_present() are no more useful...)
> But that fix should not go to the common interrupt handler, if possib=
le.

I suppose that the reason why you say that is because the 0xff value=20
doesn't have got the special meaning of "potential unplug" (is it?), so=
=20
I could understand why it's not appropriate to check it, in that common=
=20
handler (perhaps the returned value is different in some other archs to=
o).

But I don't agree with that potential infinite loop, testing the SR_RBS=
=20
bit.

So, since we already are looping until SJA1000_MAX_IRQ, why not changin=
g=20
this:

                 if (isrc & IRQ_RI) {
                        /* receive interrupt */
                        while (status & SR_RBS) {
                                 sja1000_rx(dev);
                                 status =3D priv->read_reg(priv, REG_SR=
);
                         }

into something like that:

                 if (isrc & IRQ_RI) {
                        /* receive interrupt */
                        if (status & SR_RBS)
                                 sja1000_rx(dev);


In that case, even the 0xff value would not loop infinitely... Testing=20
the device presence will be of the driver responsibility and could spee=
d=20
up unplug detection.

St=E9phane


--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
