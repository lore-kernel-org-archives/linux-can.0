From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 20:47:40 +0200
Message-ID: <4F87234C.2040707@grandegger.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>	<4F852161.90706@hartkopp.net>	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>	<4F85D553.2010303@hartkopp.net>	<CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>	<4F86862C.5020007@grandegger.com>	<4F86B75C.2040006@gmail.com>	<4F86FC7E.5030709@hartkopp.net>	<4F86FF20.60207@grandegger.com> <CABkP77dzvdTFFTxUwAAPtTHFt2SzOGWRxet=bhX+c4LKpS20Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59794 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829Ab2DLSro (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 14:47:44 -0400
In-Reply-To: <CABkP77dzvdTFFTxUwAAPtTHFt2SzOGWRxet=bhX+c4LKpS20Gw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Martin Gysel <m.gysel@gmail.com>, linux-can@vger.kernel.org

On 04/12/2012 07:28 PM, Fabio Baltieri wrote:
> On Thu, Apr 12, 2012 at 6:13 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> I think the original approach from Fabio was to follow the LED implementation
>>> from mac80211:
>>>
>>> "The implementation is similar to the MAC80211_LEDS one, and takes quite a lot
>>> of inspiration and some code from it."
>>>
>>> And IMHO we should follow this implementation as it is proved to be used in
>>> high traffic netdev environments. I wonder if some 'generic gpio LED'
>>> implementation will perform sufficiently.
>>
>> Yes, I agree. But that implementation does not use timers but toggles
>> the LED on/off for each new packet.
>>
>> http://lxr.linux.no/#linux+v3.3.1/net/mac80211/led.c#L15
> 
> That's correct, but I think it works for 80211 because there you
> always have some traffic. In the canbus case if implemented as
> "toggle" you'll end up with a led full-on when removing the cable with
> 50% probability - which I think is quite misleading.

Well, yes, I see that problem as well.

>> I would vote for that solution as well (because it's very lite and we
>> already have counters for rx and tx packets).
> 
> There are other implementation (which I took as example) in critical
> paths which blink leds on one-time events with timers:
> 
> ledtrig-ide-disk (with fixed 10ms timeout):
> http://lxr.linux.no/#linux+v3.3.1/drivers/leds/ledtrig-ide-disk.c#L28
> 
> netfilter's xt_LED trigger:
> http://lxr.linux.no/#linux+v3.3.1/net/netfilter/xt_LED.c#L69

So we will duplicate again almost the same code for CAN? No, please
don't...

> I think that with the timer called with a reasonably high delay
> (20-30ms) it should be quite lightweight. After all, most of the times
> embedded system's leds are gpio-mapped and will be handled by a bunch
> of function call and single memory write...

... but provide a patch for the LED class first implementing that
functionality, maybe even with a configurable delay. Note that there is
already a led_tigger_blink().

Wolfgang.
