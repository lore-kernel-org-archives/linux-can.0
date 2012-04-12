From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 20:30:18 +0200
Message-ID: <CABkP77dTiaziwkYY5bpUZ8PMpj_P7q3zg4Kye4CY=tXV-1OgwQ@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<4F85D553.2010303@hartkopp.net>
	<CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
	<5882451.nUC1A4BOX5@ws-stein>
	<4F86FA24.9000404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43009 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2DLSaU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 14:30:20 -0400
Received: by wejx9 with SMTP id x9so1439158wej.19
        for <linux-can@vger.kernel.org>; Thu, 12 Apr 2012 11:30:19 -0700 (PDT)
In-Reply-To: <4F86FA24.9000404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

On Thu, Apr 12, 2012 at 5:52 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>> Is the LED "blinking" on traffic or is it just "on" for some time when a
>>>> CAN frame is processed?
>>>
>>> It stays on for some time after each frame. Above a certain
>>> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
>>> tell periodic packets from bursts from it but nothing more.
>>
>> I think a Tx or Rx trigger should just "start" one LED blink, e.g. ON for
>> 100ms and OFF for 100ms no matter if other packets being processed. This way
>> you will constantly see a LED blinking if a specific load is exceeded. If it
>> is at lower rate the LED will blink more rarely.
>> You could even go one step further and activate a LED if the CAN interface is
>> UP and turn it off for some time if there is some traffic. So the LED could
>> inidicate if the interface is being used and/or if there is some traffic.
>
>
> Hi Alexander,
>
> the latter is implemented in my WIFI LED in my notebook:
>
> Interface up -> LED is ON
>
> Interface traffic -> LED is doing a off-on-sequence which leads to constant
> blinking when downloading files ...

I like the idea too.

So, I'll try to recap the points posted for a v2 o the patch:
- move the trigger code away from the net layer and put it the drivers
one for direct use of the drivers, I'll keep it in a separate source
file with #ifdef to redefine functions as no-op, as it seems to be
what most other triggers do (and it looks clean to me).
- implement functions as led_can_init, led_can_exit, led_can_event
with an event-id for tx, rx, error, open, stop
- implement event call from some driver as reference (I can only test
on vcan, slcan and flexcan, that's probably enough to test it out).
- implement blink function as follows:
  - for tx/rx trigger, turn full-on on device open, off on device stop
and one cycle of "blink_delay off - blink_delay on" on event, other
frames are ignored until the off-on sequence is over.
  - for error trigger, just blink on-off on each error event.
- keep delay time as parameter and skip triggers altogether if 0 - or
- use the activate/deactivate functions of the trigger subsystem to do
that automatically, that would cost some atomic usage counters.
- shorten trigger names to 16 characters (32 bytes look i bit big now
that I think at it).

Am I missing anything?

Regards.

-- 
Fabio Baltieri
