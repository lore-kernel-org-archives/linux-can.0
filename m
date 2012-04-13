From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Fri, 13 Apr 2012 21:00:19 +0200
Message-ID: <4F8877C3.6020702@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com> <5882451.nUC1A4BOX5@ws-stein> <4F86FA24.9000404@hartkopp.net> <CABkP77dTiaziwkYY5bpUZ8PMpj_P7q3zg4Kye4CY=tXV-1OgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:43460 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab2DMTAV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Apr 2012 15:00:21 -0400
In-Reply-To: <CABkP77dTiaziwkYY5bpUZ8PMpj_P7q3zg4Kye4CY=tXV-1OgwQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On 12.04.2012 20:30, Fabio Baltieri wrote:


>> the latter is implemented in my WIFI LED in my notebook:
>>
>> Interface up -> LED is ON
>>
>> Interface traffic -> LED is doing a off-on-sequence which leads to constant
>> blinking when downloading files ...
> 
> I like the idea too.
> 
> So, I'll try to recap the points posted for a v2 o the patch:
> - move the trigger code away from the net layer and put it the drivers
> one for direct use of the drivers, I'll keep it in a separate source
> file with #ifdef to redefine functions as no-op, as it seems to be
> what most other triggers do (and it looks clean to me).


ack.

> - implement functions as led_can_init, led_can_exit, led_can_event
> with an event-id for tx, rx, error, open, stop
> - implement event call from some driver as reference (I can only test
> on vcan, slcan and flexcan, that's probably enough to test it out).


Providing an example for flexcan is IMO the most relevant to demonstrate the
implementation.

> - implement blink function as follows:
>   - for tx/rx trigger, turn full-on on device open, off on device stop
> and one cycle of "blink_delay off - blink_delay on" on event, other
> frames are ignored until the off-on sequence is over.


ack.

>   - for error trigger, just blink on-off on each error event.


?

> - keep delay time as parameter and skip triggers altogether if 0 - or
> - use the activate/deactivate functions of the trigger subsystem to do
> that automatically, that would cost some atomic usage counters.
> - shorten trigger names to 16 characters (32 bytes look i bit big now
> that I think at it).
> 
> Am I missing anything?


Don't know - send a patch 8-)

Tnx,
Oliver
