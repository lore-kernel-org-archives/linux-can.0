From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 31 Oct 2012 21:21:04 +0100
Message-ID: <50918830.9040601@grandegger.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com> <508FFF50.8050900@gaisler.com> <50911EB6.1070105@grandegger.com> <509152D5.2050701@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44616 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760682Ab2JaUVU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 31 Oct 2012 16:21:20 -0400
In-Reply-To: <509152D5.2050701@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 10/31/2012 05:33 PM, Andreas Larsson wrote:
> On 2012-10-31 13:51, Wolfgang Grandegger wrote:
>> On 10/30/2012 05:24 PM, Andreas Larsson wrote:
>>> On 10/30/2012 11:07 AM, Wolfgang Grandegger wrote:
>>>>> +    /* AHB bus error interrupts (not CAN bus errors) - shut down the
>>>>> +     * device.
>>>>> +     */
>>>>> +    if (sources & (GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR)) {
>>>>> +        if (sources & GRCAN_IRQ_TXAHBERR) {
>>>>> +            netdev_err(dev, "got AHB bus error on tx\n");
>>>>> +            stats->tx_errors++;
>>>>> +        } else {
>>>>> +            netdev_err(dev, "got AHB bus error on rx\n");
>>>>> +            stats->rx_errors++;
>>>>> +        }
>>>>> +        netdev_err(dev, "halting device\n");
>>>>> +
>>>>> +        /* Prevent anything to be enabled again and halt device */
>>>>> +        SPIN_LOCK(&priv->lock);
>>>>> +        priv->closing = true;
>>>>> +        netif_stop_queue(dev);
>>>>> +        grcan_stop(dev);
>>>>> +        SPIN_UNLOCK(&priv->lock);
>>>>
>>>> Hm, does that really happen? How can the user/app realized the problem
>>>> and recover?
>>>
>>> My understanding of it is that if you get amba bus errors something is
>>> seriously wrong and nothing can be done at driver level to recover.
>>> Shutting down the device is to prevent the driver from spamming console
>>> messages. I used to have a sysfs indication of such errors. Now dmesg is
>>> the way to find out about the problem. The user can always bring the
>>> interface down and up again and try again after such an error.
>>
>> Well, sounds like a fatal error. Did you ever saw it? If that happens
>> frequently, or even once, the device/system seems not really usable.
> 
> Fatal and yes if this is ever seen something is very bad with the
> system. I have never seen it. However the hardware reports if it would
> happen, so why not try to take care of it in some manner. If this is
> seen the can device is probably useless but it is possible that the rest
> of the system might be usable. I don't really know in what circumstances
> this would trigger.

OK, maybe a more serious message would just be fine.

>>>> Furthermore, why is a spin_clock enough here? THe interrupt may run a
>>>> thread.
>>>
>>> It should be enough because the function is only called
>>> directly from the interrupt handler, right? Or did I miss something?
>>
>> The interrupt handler may run as thread, e.g. if the -rt patch has been
>> applied. Therefore it's safer to use the irqsave/restore variants of the
>> spin_lock functions. At least that's my understanding. See also
>> "Documentation/spinlock.txt".
> 
> I'll look into this. Seems strange if the same cpu can be interrupted in
> an interrupt handler to run the very same interrupt handler. Sounds like
> a horrible situation for any driver that does not lock down most of its
> interrupt handler. Or maybe there is some situation that I don't foresee.

As I said, if you use CONFIG_PREEMPT_RT all interrupt isr will be
threaded (running by threads).

>>>>> +    priv->can.ctrlmode_supported  =
>>>>> +        CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
>>>>
>>>> What about triple-sampling?
>>>
>>> That is not supported by the hardware.
> 
> Well, now it will be in future versions of the controller, so support is
> added to the driver.
> 
> 
>>>> I curious how the device behaves on bus errors and state changes. Could
>>>> you please show the output of "candump -e any,0:0,#FFFFFFFF" while
>>>> sending a CAN message with no other node on the bus (not connected) and
>>>> with going bus off (by short-circuiting CAN high and low).
>>>
>>>
>>> Here is the output (with long sequences of similar error frames
>>> where only one counter is increasing cut out) from the the upcoming v4.
>>> let me know if you see any problems with this.
>>
>> How did your trigger that sequence? Short-circuit or not cable
>> connected? The latter, I assume, as bus-off is not reached.
> 
> Triggered by short-circuiting, just as asked.

I ask for both tests but I missed the bus-off forther down.

>>>
>>>    can0  20000006  [8] 00 00 00 00 00 00 10 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          controller-problem{}
>>>          error-counter-tx-rx{{16}{0}}
>>
>> This is most probably an ack slot bus error similar to. You seem not to
>> handle bus errors and it's not a controller problem as the state did not
>> change.
> 
> No, the hardware has no support for can-bus error reporting.

OK, but why is CAN_ERR_CRTL set?

>> http://lxr.linux.no/#linux+v3.6.4/drivers/net/can/flexcan.c#L353
>>
>>>    can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
>>>          controller-problem{tx-error-passive}
>>>          error-counter-tx-rx{{136}{0}}
>>
>> OK, a state change to error passive. The device seems not to report
>> changes to error warning.
> 
> No, there is no interrupts or anything that alert about the error
> states. That is why I set the sate based on the error counters in the
> error handler.

Who does trigger the message above?

>>>    can0  20000006  [8] 00 20 00 00 00 00 90 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          controller-problem{tx-error-passive}
>>>          error-counter-tx-rx{{144}{0}}
>>
>> State changes should be reported only once.
> 
> Do you mean that an error message should only be sent on state change?

Yes. On state change or another error, e.g. the lost-arbitration above.

>> But it did not change. This
>> is then a bus error (CAN_ERR_PROT | CAN_ERR_BUSERROR). See also above.
>>
>>>    [...]
>>>    can0  20000006  [8] 00 20 00 00 00 00 F0 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          controller-problem{tx-error-passive}
>>>          error-counter-tx-rx{{240}{0}}
>>>    can0  20000006  [8] 00 20 00 00 00 00 F8 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          controller-problem{tx-error-passive}
>>>          error-counter-tx-rx{{248}{0}}
>>>    can0  20000042  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          bus-off
>>>          error-counter-tx-rx{{128}{0}}
>>>    can0  20000006  [8] 00 00 00 00 00 00 18 00   ERRORFRAME
>>>          lost-arbitration{at bit 0}
>>>          controller-problem{}

Obviously the device restarts automatically after bus-off. Can this be
switched off. The normal procedure is to call "ip ... type can restart"
or to set "restart-ms" for automatic restart after the specified delay.

>> Also a sequence to bus-off including the recovery would be nice.

The sequence with no cable connected would be nice as well.

...

> Thanks for the input! I'll send in v4 so you can see what the code that
> generated the above.

Please fix the error handling first.

Thanks,

Wolfgang.

