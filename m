From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 20:57:32 +0200
Message-ID: <4F96F79C.5090301@hartkopp.net>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com> <4F964C45.8010804@grandegger.com> <4F96C9C3.1010505@hartkopp.net> <4F96EC1D.5040200@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:41664 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab2DXS5f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 14:57:35 -0400
In-Reply-To: <4F96EC1D.5040200@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

On 24.04.2012 20:08, Wolfgang Grandegger wrote:

> On 04/24/2012 05:41 PM, Oliver Hartkopp wrote:
>> On 24.04.2012 08:46, Wolfgang Grandegger wrote:
>>
>>
>>>> - The blink timer is implemented as:
>>>>   * keep on for delay_time
>>>>   * turn off and retrigger the timer
>>>>   * turn back on after delay
>>>>   so that the hot-path only contains a switch-case, some checks and a mod_timer.
>>>>
>>>> This is tested on an x86 with a custom usb-can interface and on a flexcan-based
>>>> Freescale ARM board. I'll post some patch to implement support in other drivers
>>>> if anyone is interested into testing this one.
>>>>
>>>> Any comments?
>>>
>>> I still think that the blinking support should go to the timer class to
>>> avoid duplicated code. Any good reason against? Apart from that the
>>> patches look good.
>>
>>
>> Hello Wolfgang,
>>
>> what exactly do you mean with "timer class" ??
>>
>> To me the current implementation looks like standard jiffie-based timer usage.
>>
>> IMO hrtimers are not needed here - or what are you thinking of?
> 
> I mean that the code doing that kind of blinking should go to the timer
> class as generic function/feature, which other drivers could then use as
> well, similar to led_trigger_event or led_trigger_blink. Should not be a
> big deal, I think. See also my previous mail:
> 
>   http://marc.info/?l=linux-can&m=133425656510148&w=2
> 


Hm - as i see from the two examples there, the LEDs have a different
behaviour. E.g. on which use-case specific events they blink or set the LEDs
to fixed values.

I can't see any real benefit for these LED users to implement a generic LED
blinking framework. IMO using timers and the led_trigger_event stuff is the
appropriate abstraction level.

If you look into other networking drivers (e.g. the wireless) - they do it
with delayed_work:

http://lxr.linux.no/#linux+v3.3.1/drivers/net/wireless/ath/carl9170/led.c#L105

And everyone defines a specific struct like this one:

http://lxr.linux.no/#linux+v3.3.1/drivers/net/wireless/ath/carl9170/carl9170.h#L205

I think it's an enormous effort to unify all the LED users ...

Regards,
Oliver

