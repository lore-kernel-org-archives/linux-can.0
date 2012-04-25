From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Wed, 25 Apr 2012 09:26:45 +0200
Message-ID: <4F97A735.5080708@grandegger.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com> <4F964C45.8010804@grandegger.com> <20120424190226.GA1589@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59450 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab2DYH0s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Apr 2012 03:26:48 -0400
In-Reply-To: <20120424190226.GA1589@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Fabio,

On 04/24/2012 09:02 PM, Fabio Baltieri wrote:
> Hi Wolfgang,
> 
> On Tue, Apr 24, 2012 at 08:46:29AM +0200, Wolfgang Grandegger wrote:
>> I still think that the blinking support should go to the timer class to
>> avoid duplicated code. Any good reason against? Apart from that the
>> patches look good.
>>
>> Wolfgang.
> 
> I can see you point and I considered your note about adding the
> one-shot-blink function to the led-class framework (sorry for not
> mentioning it in my first post).  Still, I ended up with this code for
> a couple of reasons:
> 
> - I think that the led_blink_set function is primarily used to configure
>   leds with hardware blinking (like i2c led drivers).  While it would be
>   possible to extend the function to get one-shot behavior and always
>   fallback on software blink, I think that that's out of the purpose of
>   the led-class, which should just translate on-off requests to
>   underlaying hardware.

Why, there is already led_tigger_event() and led_trigger_blink(). Why
should led_trigger_blink_once() then do not make sense?

> - I think that different drivers may want to obtain different on-off
>   behavior depending on the application.  For example in the ide-disk
>   case the user expects to see a steady-on LED on constant activity,
>   and that's how it's implemented, while in this case the on-if-up
>   keep-blinking-on-activity off-if-down makes much more sense. So I think
>   that even if a generic blink function were available, people would
>   still be using custom functions because they want to fine tune the
>   behavior for the application.  Also, maybe a function too generic may
>   impact on performance in critical paths.

The blinking could be specified with led_trigger_blink_once().

> - in this case, it looks to me like the implementation is as optimized
>   as it can be, in the sense that the hot-path does really only some
>   essential check and engage the timer and the timer function itself is
>   really short.  Also the final blinking effect is nice IMO :-)

For me it still does make sense to provide a generic
led_trigger_blink_once support. But well, go ahead if I'm the only one
with that opinion.

Wolfgang.
