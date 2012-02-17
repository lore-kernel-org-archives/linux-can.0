From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4.1] can/sja1000: add support for PEAK-System PCMCIA card
Date: Fri, 17 Feb 2012 15:47:49 +0100
Message-ID: <4F3E6895.9050304@peak-system.com>
References: <1329387042-4021-1-git-send-email-s.grosjean@peak-system.com>
 <20120217082455.GA5648@comet.dominikbrodowski.net>
 <4F3E1C10.8070207@peak-system.com> <4F3E1F83.8020708@pengutronix.de>
 <4F3E58E4.3030407@volkswagen.de> <4F3E61D7.1040208@peak-system.com>
 <4F3E66E5.8070201@volkswagen.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:52486 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab2BQOsD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2012 09:48:03 -0500
In-Reply-To: <4F3E66E5.8070201@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 17/02/2012 15:40, Oliver Hartkopp a =E9crit :
> On 17.02.2012 15:19, Stephane Grosjean wrote:
>> Le 17/02/2012 14:40, Oliver Hartkopp a =E9crit :
>>>
>>> The only remaining issue with PEAK PCIeC is the locking warning=20
>>> about the
>>> PCIeC LED timer lock (&card->led_timer) when i enable and start the=
=20
>>> interface
>>> under CAN load. I do have a peak_pci v5 driver here - but in v6 onl=
y=20
>>> changed
>>> the device_id table right?
>>
>> Yes, mainly.
>>>
>>> To get this problem you need to connect the PCIeC to a CAN bus whic=
h is
>>> already having CAN traffic between at least two functional nodes.
>>>
>>
>> Does this issue always occurs, each time you configure the interface=
?..
>
> No. It's exactly the first time i configure the interface from a xter=
m=20
> in gnome (after making me su to do so). But only under load.
>
> > Especially with the "new" sja1000.ko?
>
> That's no difference.
>
> I assume there's some LED locking race at startup (e.g. try to blink=20
> fast after detecting the traffic).
>


Well, quite annoying: I'm not able to reproduce the issue at all, with=20
my own testbed...
I'll give you feedback asap...

Thanks Oliver,
Regards

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
