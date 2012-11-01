From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Thu, 01 Nov 2012 17:08:31 +0100
Message-ID: <50929E7F.1090205@gaisler.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com> <508FFF50.8050900@gaisler.com> <50911EB6.1070105@grandegger.com> <509152D5.2050701@gaisler.com> <50918830.9040601@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:38083 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761933Ab2KAQIl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Nov 2012 12:08:41 -0400
In-Reply-To: <50918830.9040601@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 2012-10-31 21:21, Wolfgang Grandegger wrote:
 >>> Well, sounds like a fatal error. Did you ever saw it? If that happens
 >>> frequently, or even once, the device/system seems not really usable.
 >>
 >> Fatal and yes if this is ever seen something is very bad with the
 >> system. I have never seen it. However the hardware reports if it would
 >> happen, so why not try to take care of it in some manner. If this is
 >> seen the can device is probably useless but it is possible that the rest
 >> of the system might be usable. I don't really know in what circumstances
 >> this would trigger.
 >
 > OK, maybe a more serious message would just be fine.

Yes, I have now made it clearer that this is a very serious error.


>>>>> Furthermore, why is a spin_clock enough here? THe interrupt may run a
>>>>> thread.
>>>>
>>>> It should be enough because the function is only called
>>>> directly from the interrupt handler, right? Or did I miss something?
>>>
>>> The interrupt handler may run as thread, e.g. if the -rt patch has been
>>> applied. Therefore it's safer to use the irqsave/restore variants of the
>>> spin_lock functions. At least that's my understanding. See also
>>> "Documentation/spinlock.txt".
>>
>> I'll look into this. Seems strange if the same cpu can be interrupted in
>> an interrupt handler to run the very same interrupt handler. Sounds like
>> a horrible situation for any driver that does not lock down most of its
>> interrupt handler. Or maybe there is some situation that I don't foresee.
>
> As I said, if you use CONFIG_PREEMPT_RT all interrupt isr will be
> threaded (running by threads).

I have now added it, even though I am still not sure if it is needed. Under 
CONFIG_PREEMPT_RT_FULL a spin_lock_irqsave is just a plain spin_lock anyway 
(plus type checking on the flags argument).


>>> This is most probably an ack slot bus error similar to. You seem not to
>>> handle bus errors and it's not a controller problem as the state did not
>>> change.
>>
>> No, the hardware has no support for can-bus error reporting.
>
> OK, but why is CAN_ERR_CRTL set?

Maybe I am just confused with the terminology. What I mean is that the only 
error reporting that is supported by the hardware (apart from AMBA bus errors, 
but that is unrelated to the discussion) is the error counter related errors.

 From what I can see CAN_ERR_BUSERROR is not reported in the error counter 
related cases by the other drivers I looked in. The grcan hardware does not 
support reporting errors like form and stuff errors and which bits the errors 
occured in and the like.

Have I understood it correctly that reporting about protocol errors like that is 
what it is to support CAN_CTRLMODE_BERR_REPORTING? This seems to be the case but 
the janz-ican3 driver connects CAN_CTRLMODE_BERR_REPORTING to all error frame 
reporting, so I am not entirely sure.


>>> http://lxr.linux.no/#linux+v3.6.4/drivers/net/can/flexcan.c#L353
>>>
>>>>     can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
>>>>           controller-problem{tx-error-passive}
>>>>           error-counter-tx-rx{{136}{0}}
>>>
>>> OK, a state change to error passive. The device seems not to report
>>> changes to error warning.
>>
>> No, there is no interrupts or anything that alert about the error
>> states. That is why I set the sate based on the error counters in the
>> error handler.
>
> Who does trigger the message above?

Sorry for confusing the matter. There is no interrupt for error warning, but 
there are interrupts for increases of the error counters and the other state 
changes. So to be able to report on error warning I check the error counters and 
do it manually.


> Obviously the device restarts automatically after bus-off. Can this be
> switched off. The normal procedure is to call "ip ... type can restart"
> or to set "restart-ms" for automatic restart after the specified delay.

Yes, the hardware becomes error active after having monitored 11 consecutive 
recessive bits on the bus 128 times (as allowed by the 2.0 CAN spec). There is 
no way of turning this off, so to conform to the normal linux procedure of not 
doing this, I shut down the device on bus off interrupt.

In addition I have thrown out the arbitration lost error frame generation as 
arbitration errors can not be singled out. The TXLOSS interrupt might be due to 
arbitration error, but is also triggered in great numbers when there is no one 
else on the can bus or when there is a problem with the hardware interface or 
the bus itself.

This is how things look currently with no one else on the bus:
~ # cansend can0 123#45
   can0  20000004  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
         controller-problem{tx-error-warning}
         error-counter-tx-rx{{96}{0}}
   can0  20000004  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{128}{0}}
~ #

And this is how it looks with a short-circuited bus:
~ # cansend can0 123#45
   can0  20000004  [8] 00 08 00 00 00 00 90 00   ERRORFRAME
         controller-problem{tx-error-warning}
         error-counter-tx-rx{{144}{0}}
   can0  20000004  [8] 00 20 00 00 00 00 98 00   ERRORFRAME
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{152}{0}}
   can0  20000040  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
         bus-off
~ #


Thanks a lot for the input! Much appreciated!

Cheers,
Andreas

