From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Mon, 28 Aug 2017 10:33:41 +0200
Message-ID: <23b53bdc-b7d4-f6de-b192-629ffe9795b0@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
 <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:44690 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754250AbdH1Idn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 04:33:43 -0400
In-Reply-To: <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 28.08.2017 um 06:21 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hi Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Sunday, August 27, 2017 6:57 PM
>>
>> Am 22.08.2017 um 16:06 schrieb Marc Kleine-Budde:
>>> On 08/22/2017 03:50 PM, Jonas Mark (ST-FIR/ENG1) wrote:
>>>> Hello Andri,
>>>>
>>>>>> Which polling interval do you think would be appropriate? It
>>>>>> somehow has to be
>>>>> a reasonable trade-off between latency and CPU usage. That's a good
>>>>> question. I don't think that there is a really good answer to it.
>>>>> It would be nice to see intermittent state-transitions happening,
>>>>> so I would say as fast as possible without affecting CPU usage to a
>>>>> significant degree. The polling timer should not be a high
>>>>> resolution timer or anything that would preempt an rt task.
>>>>>
>>>>> This value could also depend on the bitrate as that will affect the
>>>>> rate at which the error-counter can change. E.g. on 125 k rate, you
>>>>> will receive at most one frame per 1 ms. This means that the error
>>>>> state will change at at least 64 ms intervals, so we would have to
>>>>> sample at 32 ms intervals to catch all the transitions. For 1 M
>>>>> this would be around 2 ms.
>>>>>
>>>>> Note that this is all somewhat speculative as I do not know exactly
>>>>> how fast the error counters are incremented/decremented.
>>>>
>>>> We agree that there is a sensible lower boundary for the polling
>>>> interval which depends on the bitrate. And there is a upper boundary
>>>> which depends on the application.
>>>>
>>>> We are currently thinking about whether it would be possible to do
>>>> the polling only in case the controller is actually experiencing
>>>> trouble.
>>>
>>> Why not enable bus errors on broken controllers. Disable once a bus
>>
>> Yes, that's what we have done in the past for Flexcan controller cores
>> that do not have dedicated interrupt lines for state changes. We have
>> introduced FLEXCAN_QUIRK_BROKEN_ERR_STATE for that purpose. It should
>> work already with the current driver. Yi ZHU, have you tried that?
> Yes, I've tried that. After add FLEXCAN_QUIRK_BROKEN_ERR_STATE to i.MX6,
> the state transitions still not correct. The reason is flexcan_irq_state() will only
> be called upon state interrupt, but the flexcan core will not generate interrupts for
> all state transitions.
> (http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/flexcan.c#L769)

I see! That's a *bug*, which should be fixed first! The bus error 
interrupt reports bus errors, no state changes. It's triggered when the 
bus error counter changes, Therefore it should be possible to derive 
proper state changes from it. FLEXCAN_QUIRK_BROKEN_ERR_STATE relys on that.

> After enable bus error interrupt and change to call flexcan_irq_state() upon _any_
> interrupt, then we can get correct state transitions as expected. Of course, interrupt
> flooding also came as expected.

OK.

>>> error hits and re-enable them after a configurable timeout with a proper
>>> default. I have a patch somewhere, although it applies only against the
>>> pre rx-offload version of the driver.
>>
>> And that would help to avoid the interrupt flooding problem.
> Yes, that would help. But I think if we change to above approach, then we do not
> need to rely on a configurable timeout to avoid interrupt flooding. We can disable/
> enable error interrupt depends on the state transitions:
> 1. disable error interrupt when state change to error passive
> Why error passive not bus off?

That's defined somewhere in the standard, but I couldn't find a good 
ref/link quickly. When the node is bus-off, it can not receive messages 
any longer.

> First, flexcan is able to interrupt when bus off, and the node will not generate any
> interrupt in this state. Second, interrupt flooding happens when node is doing
> auto-retransmission until bus off, and in case of only singled out node on the bus,
> then this node cannot become bus off, hence, the flooding won't stop.

When no cable is connected, the node will never go to bus-off. Yes, 
that's normal behaviour.

> However at most 16 times consecutive bus error interrupts will change state to error
> passive, so after the node in this state, we can safely disable the bus error interrupt.

This depends on the bus off recovery method defined by "restart-ms". If 
it's "0", the controller should not be restarted automatically, 
otherwise after the specified time. But bus-off hanling is a different 
toppic.

> 2. enable error interrupt when state change to error warning

Guessing what's the idea behind! If the error warning interrupt works, 
there is no need to deal with bus error interrupts till the error 
warning state is reached. But to realize the error passive interrupt, we 
may need the bus errors.

> Why error warning not error active?

How the error counter decrease is described, e.g., in [1] and [2].

> Minimal 32 times consecutive Tx/Rx interrupts will change state from error passive to
> error active. So if the error condition occur again while the state is not recovered to
> error active (e.g., at error warning), then until the error condition is removed, the state
> will stay in error warning.
> 
> Hence, re-enable the error interrupt upon error warning transition allow us to report
> error passive again. And if the error condition occur again while the state is still
> error passive, we do not need to touch the bus error interrupt.
> 
> I've tested this, the state transitions works fine, and the flood of interrupts are limited
> to the number of required frame transfer according to the rule of error counting and
> state transitions defined in specification.
> 
> What do you think? If you agree with this, I can prepare a patch for review.
>

Bus error interrupts will only be enabled if the error-counters are 
between 96 and 127 to realize the state change to error passive. State 
changes to error warning and bus-off are reported via dedicated 
interrupt lines. Well, that may work even if it's tricky. But you need 
to take care of all other quirks and bus-error reporting as well. This 
may result is a rather complex patch.

[1] https://www.kvaser.com/about-can/the-can-protocol/can-error-handling/
[2] http://www.port.de/cgi-bin/CAN/CanFaqErrors

Wolfgang.
