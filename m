From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH v4.1] can/sja1000: add support for PEAK-System PCMCIA
 card
Date: Fri, 17 Feb 2012 15:40:37 +0100
Message-ID: <4F3E66E5.8070201@volkswagen.de>
References: <1329387042-4021-1-git-send-email-s.grosjean@peak-system.com> <20120217082455.GA5648@comet.dominikbrodowski.net> <4F3E1C10.8070207@peak-system.com> <4F3E1F83.8020708@pengutronix.de> <4F3E58E4.3030407@volkswagen.de> <4F3E61D7.1040208@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:49232 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2BQOko (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2012 09:40:44 -0500
In-Reply-To: <4F3E61D7.1040208@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 17.02.2012 15:19, Stephane Grosjean wrote:
> Le 17/02/2012 14:40, Oliver Hartkopp a =E9crit :
>>
>> The only remaining issue with PEAK PCIeC is the locking warning abou=
t the
>> PCIeC LED timer lock (&card->led_timer) when i enable and start the =
interface
>> under CAN load. I do have a peak_pci v5 driver here - but in v6 only=
 changed
>> the device_id table right?
>
> Yes, mainly.
>>
>> To get this problem you need to connect the PCIeC to a CAN bus which=
 is
>> already having CAN traffic between at least two functional nodes.
>>
>
> Does this issue always occurs, each time you configure the interface?=
=2E.

No. It's exactly the first time i configure the interface from a xterm =
in=20
gnome (after making me su to do so). But only under load.

 > Especially with the "new" sja1000.ko?

That's no difference.

I assume there's some LED locking race at startup (e.g. try to blink fa=
st=20
after detecting the traffic).

Regards,
Oliver
