From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 08:05:33 +0200
Message-ID: <4F8670AD.1050104@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F852161.90706@hartkopp.net> <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com> <4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:26021 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab2DLGFa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 02:05:30 -0400
In-Reply-To: <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On 11.04.2012 21:36, Fabio Baltieri wrote:

> On Wed, Apr 11, 2012 at 9:02 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> I should add a check to skip it entirely if led_off_delay == 0 as a
> run-time "optimization" if the feature is not used (triggers does not
> provide a use-counter).


Yes. That's a good idea.

> Do you think it should be disabled by default?


The LED triggers?

Yes. They should be disabled by default.

So far i assume there's a very limited number of hardware having extra LEDs.

> 
>> The second question:
>>
>> Is the LED "blinking" on traffic or is it just "on" for some time when a CAN
>> frame is processed?
> 
> It stays on for some time after each frame. Above a certain
> packet-rate (1/led_off_delay) LED appear to be constantly on. You can
> tell periodic packets from bursts from it but nothing more.


Ok. That's fine.

> Quick not-so-off-topic - I have a small userspace deamon on my router
> which blinks an LED every 100kB of traffic on the WAN interface, which
> is nice because you can almost tell the network load just by looking
> at it! Much more useful than the standard activity LED. (sometimes I
> think I'm taking this too seriously...)


Don't know if traffic counting is a good idea for the first step.

If we all find a really needed use-case we might think about it later.

Regards,
Oliver
