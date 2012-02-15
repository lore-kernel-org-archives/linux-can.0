From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Wed, 15 Feb 2012 12:52:38 +0100
Message-ID: <4F3B9C86.8030105@peak-system.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com>
 <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com>
 <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net>
 <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de>
 <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net>
 <4F397145.8040007@grandegger.com> <4F3A307C.1050706@hartkopp.net>
 <4F3A3493.8010900@peak-system.com> <4F3A8ECB.7090803@hartkopp.net>
 <4F3B58D1.1040804@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:47680 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab2BOLws (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 06:52:48 -0500
In-Reply-To: <4F3B58D1.1040804@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 15/02/2012 08:03, Wolfgang Grandegger a =E9crit :
> Hi Oliver,
>
> we start paving common code to partially cure pcmcia related problems=
,
> that's exactly what I do not like.


I think it's much more than a pcmcia related problem: IMHO, I think it'=
s=20
right in some common code to do some 'basic' checks on returned values,=
=20
especially when these are returned from custom callbacks and these=20
values are so critical. For me, it's like one has to check the kmalloc(=
)=20
return value, for example. But I admit this could not be the right(TM)=20
way of doing things in the Kernel.


>> An alternative would be to replace the 'break' statements above with
>>
>> 	return IRQ_NONE;
>>
>> like
>>
>> 		/* check for absent controller due to hw unplug */
>> 		if (status =3D=3D 0xFF&&  !sja1000_probe_chip(dev))
>> 			return IRQ_NONE;
>>
>> Don't know if this is 'good style' - but the while statement allows =
it ;-)
>>
>>> Moreover, regarding to this patch, should the peak_pcmcia custom is=
r always
>>> test for the card presence? I mean, this costs at least 2xtwo iorea=
d8 for each
>>> hw irq!
>>
>> I think the earlier we know the better.


Ok, so I keep testing the presence of the card in the peak_pcmcia drive=
r.

If I may ask something else: didn't find any "linux-pcmcia" mailing lis=
t=20
(or something like that) in vger majordomo lists. Does someone know if=20
there is such a list? By default, which ml should be posted the=20
peak_pcmcia.c too?


>> But indeed both drivers (PEAK/EMS PCMCIA) do no need priv->pre_irq .=
=2E.


Hmmm... I don't know what is the real goal of these pre_irq() and=20
post_iqr() callbacks but I imagine that, for example, the "pre_irq()"=20
could acquire a lock while the post_irq() would release it... So, I=20
would prefer to call the post_irq() anytime (that is, no direct "return=
=20
IRQ_xxx" but a 'break'  or a 'goto'). Does it make sense?


>> So if we add the 'return IRQ_NONE' to the above patch the private ch=
eck for
>> present hardware becomes obsolete as the private ISRs terminate prop=
erly when
>> they get an IRQ_NONE.
>>
>> Right?


I would also have say that before, but I checked that IRQ_NONE may be=20
processed as spurious, so I don't even know, for the moment. LDD3=20
chapter 10 also says:

> Interrupt handlers should return a value indicating whether there was=
=20
> actually an
> interrupt to handle. If the handler found that its device did, indeed=
,=20
> need attention, it
> should return IRQ_HANDLED; otherwise the return value should be IRQ_N=
ONE.

So, what does this "need attention" stands for? Since the device is=20
unplugged, we could say that it didn't need any attention anymore...=20
But, on the other hand, the ems_pcmcia driver does return IRQ_HANDLED=20
when its private check fails to detect the card and it has been=20
approved, so, where is the truth? Near the perfection? ;-)


St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
