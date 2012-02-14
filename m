From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Tue, 14 Feb 2012 10:14:57 +0100
Message-ID: <4F3A2611.90703@peak-system.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com>
 <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com>
 <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net>
 <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de>
 <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net>
 <4F397145.8040007@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41972 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759569Ab2BNJPG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 04:15:06 -0500
In-Reply-To: <4F397145.8040007@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>


Le 13/02/2012 21:23, Wolfgang Grandegger a =E9crit :
> On 02/13/2012 08:55 PM, Oliver Hartkopp wrote:
>> What happens, if inside this inner while() statement the unplug happ=
ens?
>>
>> Do we get two correct CAN frames and then we get eight CAN frames li=
ke this:
>>
>> 12345677 4 AA BB CC DD
>> 12345678 6 AA BB CC DD EE FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>
>> ???
> Do you have seen such traces with the "device present" check in the
> custom handler? I doubt.

Well if I may interfere: since the driver "remove()" entry point is=20
called and the netdev interface is destroyed next, nobody can truly say=
s=20
if these frames have time to be processed until the client application.=
=20
The problem is not here.

> First it is unlikely, that the unplug will happen when data from the
> device gets processed. And if, the check in the while loop will not
> change a lot, in contrast to the check in the custom handler. If it
> happens while processing the data, we will get grap... but well...
>
>> Sending nothing is preferred to sending wrong data :-)
> You cannot avoid sending crap under any circumstances. Also be aware
> that the while loop will normally process just *one* message, and rar=
ely
> more.

cannot say that, this is arch dependent.

>>> Of course, the loop should be limited in sja1000_interrupt anyway.
>>
>> IMO checking for absent hardware in the custom isr is fine and shoul=
d fix most
>> of the problems (as we can already see in the ems_pcmcia driver).

cannot say that: all the tests I made @1xMbps bitrate show that the=20
issue at least occurs 3/4 of time in the sja1000_interrupt, not in the=20
custom isr. This also is obviously arch dependent.

>> But adding the patch which is checking two times for status !=3D 0xF=
=46 reduces
>> the race conditions to almost zero. Having a while() statement that
>> potentially produces wrong data doesn't heal the problem IMO.
> I disagree. It will not change a lot. Measurements may proof that I'm
> wrong, though.

What about the fix Oliver talked about in one his first e-mail:

> The used status register has a bit for bus-off which is "1" in the bu=
s-off
> case. Assuming RX interrupts can only occur in a 'bus-on' state, this=
 bit can
> be assumed to be '0'.

IMHO, this is the best proposal: while the sja1000_interrupt() requests=
=20
for the SR, it seems normal that it does some semantic checks about wha=
t=20
it got.

So the fix could be something like this instead:

         while ((isrc =3D priv->read_reg(priv, REG_IR)) && (n <=20
SJA1000_MAX_IRQ)) {
                 n++;
                 status =3D priv->read_reg(priv, REG_SR);

+               if (status & (SR_RBS|SR_BS) =3D=3D (SR_RBS|SR_BS)) {
+                       /* what? something is rotten in my kingdom... *=
/
+                       n =3D 0;
+                       break; /* or goto post_irq; as you want... */
+               }

                 if (isrc & IRQ_RI) {
                         /* receive interrupt */
                         while (status & SR_RBS) {
                                 sja1000_rx(dev);
                                 status =3D priv->read_reg(priv, REG_SR=
);
+                               if (status & (SR_RBS|SR_BS) =3D=3D=20
(SR_RBS|SR_BS)) {
+                                       /* what? something is rotten in=
=20
my kingdom, here also... */
+                                       n =3D 0;
+                                       goto post_irq;
                                 }
                         }
                 }
         }

+post_irq:
         if (priv->post_irq)
                 priv->post_irq(priv);


Of course, in order to definitely say asta lavista to the potential=20
infinite loop, we can use a for(;;) loop instead of the while()...

What are your opinion?

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
