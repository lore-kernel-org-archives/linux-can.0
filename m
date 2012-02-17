From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH v4.1] can/sja1000: add support for PEAK-System PCMCIA
 card
Date: Fri, 17 Feb 2012 14:40:52 +0100
Message-ID: <4F3E58E4.3030407@volkswagen.de>
References: <1329387042-4021-1-git-send-email-s.grosjean@peak-system.com> <20120217082455.GA5648@comet.dominikbrodowski.net> <4F3E1C10.8070207@peak-system.com> <4F3E1F83.8020708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:52371 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2BQNlo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2012 08:41:44 -0500
In-Reply-To: <4F3E1F83.8020708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 17.02.2012 10:36, Marc Kleine-Budde wrote:
> On 02/17/2012 10:21 AM, Stephane Grosjean wrote:
>> Hi Oliver,
>>
>> I've got one (newbie) question: what is the next step? I mean, should I
>> post the same patch again but with this "Acked-by"? Or what? Should I
>> wait for any linux-can Acked-by ?
>
> No need to repost so soon. A Tested-by from Oliver under heavy load
> detaching together with the Fix unplug Patch would be fine.
>

I can confirm that with together with this patch
"[PATCH v2] can: sja1000 fix isr hang when hw is unplugged under load"

http://marc.info/?l=linux-can&m=132932474901518&w=2

there is no freeze on my Dell830 when unplugging the PEAK PCMCIA Card.

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Indeed i got some 'last famous CAN frames' on plug out like this:

can0  10 [8] 37 00 FF FF FF FF FF FF

while it should have been

can0  10 [8] 37 00 00 00 00 00 00 00

So the last message can contain rubbish but it doesn't freeze the machine
anymore. The behavior is now just like we discussed it :-)

I also did not get any freezes with the PEAK PCIeC anymore.

The only remaining issue with PEAK PCIeC is the locking warning about the
PCIeC LED timer lock (&card->led_timer) when i enable and start the interface
under CAN load. I do have a peak_pci v5 driver here - but in v6 only changed
the device_id table right?

To get this problem you need to connect the PCIeC to a CAN bus which is 
already having CAN traffic between at least two functional nodes.

Regards,
Oliver

