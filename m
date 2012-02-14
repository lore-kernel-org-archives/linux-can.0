From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can/sja1000: add support for PEAK-System PCMCIA card
Date: Tue, 14 Feb 2012 10:30:05 +0100
Message-ID: <4F3A299D.2000406@grandegger.com>
References: <1328543779-9209-1-git-send-email-s.grosjean@peak-system.com> <4F38D46D.5010406@pengutronix.de> <4F38DF75.3040000@peak-system.com> <4F38E274.4050304@grandegger.com> <4F38E8DA.9060000@hartkopp.net> <4F38EDB1.7080209@grandegger.com> <4F38EEAD.3060607@pengutronix.de> <4F38EF3A.7040907@grandegger.com> <4F396AC9.8090308@hartkopp.net> <4F397145.8040007@grandegger.com> <4F3A2611.90703@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50052 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2BNJaR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 04:30:17 -0500
In-Reply-To: <4F3A2611.90703@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 02/14/2012 10:14 AM, Stephane Grosjean wrote:
>=20
> Le 13/02/2012 21:23, Wolfgang Grandegger a =E9crit :
>> On 02/13/2012 08:55 PM, Oliver Hartkopp wrote:
>>> What happens, if inside this inner while() statement the unplug hap=
pens?
>>>
>>> Do we get two correct CAN frames and then we get eight CAN frames
>>> like this:
>>>
>>> 12345677 4 AA BB CC DD
>>> 12345678 6 AA BB CC DD EE FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>> 1FFFFFFF 8 FF FF FF FF FF FF FF FF
>>>
>>> ???
>> Do you have seen such traces with the "device present" check in the
>> custom handler? I doubt.
>=20
> Well if I may interfere: since the driver "remove()" entry point is
> called and the netdev interface is destroyed next, nobody can truly s=
ays
> if these frames have time to be processed until the client applicatio=
n.
> The problem is not here.
>=20
>> First it is unlikely, that the unplug will happen when data from the
>> device gets processed. And if, the check in the while loop will not
>> change a lot, in contrast to the check in the custom handler. If it
>> happens while processing the data, we will get grap... but well...
>>
>>> Sending nothing is preferred to sending wrong data :-)
>> You cannot avoid sending crap under any circumstances. Also be aware
>> that the while loop will normally process just *one* message, and ra=
rely
>> more.
>=20
> cannot say that, this is arch dependent.
>=20
>>>> Of course, the loop should be limited in sja1000_interrupt anyway.
>>>
>>> IMO checking for absent hardware in the custom isr is fine and shou=
ld
>>> fix most
>>> of the problems (as we can already see in the ems_pcmcia driver).
>=20
> cannot say that: all the tests I made @1xMbps bitrate show that the
> issue at least occurs 3/4 of time in the sja1000_interrupt, not in th=
e
> custom isr. This also is obviously arch dependent.

What check did you use in the custom isr? A dummy register read !=3D 0x=
ff?
If that is really the case, I would prefer Oliver's simple fix in
sja1000_interrupt().

Wolfgang.
