From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Fri, 04 May 2012 09:03:19 +0200
Message-ID: <4FA37F37.1000802@hartkopp.net>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com> <4F964C45.8010804@grandegger.com> <20120424190226.GA1589@gmail.com> <4F97A735.5080708@grandegger.com> <4F97AA91.1020007@pengutronix.de> <4F97CC48.5000809@grandegger.com> <20120503214940.GA1826@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:33375 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab2EDHDV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 May 2012 03:03:21 -0400
In-Reply-To: <20120503214940.GA1826@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 03.05.2012 23:49, Fabio Baltieri wrote:

> Hello everyone,
> 
> I'm back on the activity-trigger subject.
> 
> On Wed, Apr 25, 2012 at 12:04:56PM +0200, Wolfgang Grandegger wrote:
>>>>> On Tue, Apr 24, 2012 at 08:46:29AM +0200, Wolfgang Grandegger wrote:
>>>>>> I still think that the blinking support should go to the timer class to
>>>>>> avoid duplicated code. Any good reason against? Apart from that the
>>>>>> patches look good.
>>>>>>
>>>> For me it still does make sense to provide a generic
>>>> led_trigger_blink_once support. But well, go ahead if I'm the only one
>>>> with that opinion.
>>>
>>> +1
>>> At least start a discussion on the LED list (I don't know which list
>>> that is).
>>
>> The MAINAINERS file does not list a mailing list, therefore the LKML
>> should be used, with a CC to Richard Purdie, I think. While checking if
>> LED support is discussed, I found related mails. One shot timer LED
>> support seems to be a frequently discussed issue:
>>
>>   http://marc.info/?t=133489487700001&r=1&w=2
>>   http://marc.info/?l=linux-kernel&m=133331013422467&w=4
>>
>> As usual, it's better to send a patch than to ask a (general) questions.
>> I think we would get rather quick response.
> 
> I spent last couple of days trying to come up with a generic one-shot
> blink patch clean enough to get some chance of integration, but what I
> ended up with was these considerations in favor of framework-specific
> code:
> 
> The only clean way I see to do that is to implement the function as an
> extension of the actual soft-blink code.
> 
> That functions are used as fallback if no hw-blink is available and are
> just blindly toggling values on-off, so they have to be modified quite
> heavily to add necessary state information to support the behaviour of
> the actual code (like when a trigger is added for an already up
> interface) and the feature required by other usage cases (like the
> trigger currently discussed in the list - which is going in the way of a
> trigger-specific implemetation anyway).  This would involve adding flags
> and cases in both trigger and timer code.
> 
> So, I'm taking a break on this and trying to feed this argument: why the
> socketcan code would benefit from a specific implementation rather than
> a generic one?
> 
> Because overall code is *much* more simple and clean!
> 
> - the timer function body is just 12 lines of code, whithout special
>   cases, that's faster to execute and easy to understand (and debug).
> 
> - the event function for TX and RX paths is just some checks and a
>   mod_timer, without list iterations or locking, and as it's going to be
>   called in hard-irq context, I think this is a *strong* plus for the
>   implementation (the most important thing here is to get out of the way
>   as fast as possible, right? A generic implementation would only make
>   latencies worse here).
> 
> So, my point, do you still think that this feature would benefit of a
> generic triggering implementation?
> 
> (of course, I'm posting a v3 with just Oliver's Kconfig notes if you
> agree with my point :-) )
> 


Hi Fabio,

as the former implementation was fine to me there's no need to come up with
additional remarks for me ... btw. i think your implementation is clean,
simple and efficient. Therefore i would vote for it too.

I don't know if we should guide anyone to implement a generic led blinking
framework covering all the (existing) cases in the kernel. Adding your patches
would probably make the creation of such a framework more challenging to a
volunteer in terms of creating a solution which is that simple and efficient.

just my two cents ...

Regards,
Oliver
