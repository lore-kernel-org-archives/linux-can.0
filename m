From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 09:37:16 +0200
Message-ID: <4F86862C.5020007@grandegger.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>	<4F852161.90706@hartkopp.net>	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>	<4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37283 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2DLHhU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 03:37:20 -0400
In-Reply-To: <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 04/11/2012 09:36 PM, Fabio Baltieri wrote:
> On Wed, Apr 11, 2012 at 9:02 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>> And we should probably add a new CAN netlink command here
>>>>
>>>>        http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/dev.c#L577
>>>>
>>>> to configure the LED timer per interface: 0 -> LEDs off (==default)
>>>
>>> Nice... I'm taking notes here. :-)
>>
>>
>> Hm - probably this is a bit heavy weighted suggestion from me.
>>
>> Do you really think the timer value needs to be configurable or is a simple
>> on/off switch ok too?
> 
> I think that if the bus only has a light traffic a longer time would
> be more helpful, otherwise any fixed time of some tenths of
> milliseconds should just do the job (that's how ledtrig-ide-disk
> works). A single module parameter looked like a decent compromise to
> me.
> 
> I should add a check to skip it entirely if led_off_delay == 0 as a
> run-time "optimization" if the feature is not used (triggers does not
> provide a use-counter). Do you think it should be disabled by default?
> 
>> The second question:
>>
>> Is the LED "blinking" on traffic or is it just "on" for some time when a CAN
>> frame is processed?
> 
> It stays on for some time after each frame. Above a certain
> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
> tell periodic packets from bursts from it but nothing more.

Concerning the LED control (on. off, blinking), could that not be
done/configured in the generic LED interface (via sysfs files)? That
seems the right place for me. Then the CAN LED software just needs to
send the trigger which would significantly simplify the code (without
timer).

Furthermore, if I understand your patch correctly, the LEDs with the
names "canX-rx" and "canX-tx" are directly assigned (hardwired). A more
flexible method would be appreciated, if it could be realized with just
a little more code.

Wolfgang.


