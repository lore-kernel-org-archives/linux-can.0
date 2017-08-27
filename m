From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Sun, 27 Aug 2017 14:55:25 +0200
Message-ID: <9fb2b77e-7fed-b84c-ea7c-3f1a002749bc@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <150341124698.27819.5656792817823911040@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:56720 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdH0Mz1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2017 08:55:27 -0400
In-Reply-To: <150341124698.27819.5656792817823911040@maxwell>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>

Hello Andri,

Am 22.08.2017 um 16:14 schrieb Andri Yngvason:
> Hello Mark,
> 
> Quoting Jonas Mark (ST-FIR/ENG1) (2017-08-22 13:50:35)
>>>> Which polling interval do you think would be appropriate? It somehow has to be
>>> a reasonable trade-off between latency and CPU usage.
>>> That's a good question. I don't think that there is a really good answer to it.
>>> It would be nice to see intermittent state-transitions happening, so I would say as
>>> fast as possible without affecting CPU usage to a significant degree. The polling
>>> timer should not be a high resolution timer or anything that would preempt an rt
>>> task.
>>>
>>> This value could also depend on the bitrate as that will affect the rate at which the
>>> error-counter can change. E.g. on 125 k rate, you will receive at most one frame
>>> per 1 ms. This means that the error state will change at at least
>>> 64 ms intervals, so we would have to sample at 32 ms intervals to catch all the
>>> transitions. For 1 M this would be around 2 ms.
>>>
>>> Note that this is all somewhat speculative as I do not know exactly how fast the
>>> error counters are incremented/decremented.
>>
>> We agree that there is a sensible lower boundary for the polling interval which depends on the bitrate. And there is a upper boundary which depends on the application.
>>
>> We are currently thinking about whether it would be possible to do the polling only in case the controller is actually experiencing trouble.
>>
>> For the i.MX6 there is an interrupt when the controller changes from Error Active to Error Warning. This shall enable the polling.
>>
>> For the i.MX53 there is no Active -> Warning interrupt. But for all kinds of error events on the bus an Error interrupt will be created. So the polling shall be enabled then. This is a little bit less efficient compared to i.MX6 but the polling will be disabled during the next interrupt if the state is still Error Active (see below).
>>
>> For both, the polling can be disabled when the status is read and it is Error Active. The polling shall be disabled as well when a Bus-Off interrupt occurs.
>>
>> What we still need to resolve is the concurrency between the timer and the interrupt when accessing internal data structures and sending SocketCAN error frames. Once we have that sorted out we will send a patch. None the less, early feedback is welcome.

I do not see a benefit doing polling vs. using bus error interrupts and 
disabling them for a certain amount of time (to avoid flooding). In both 
cases we may not get all state changes at the right moment but somehow 
delayed. The delay period could be configured via module parameter. On 
low end systems it may need to be rather high, on high end systems it 
could even be disabled (delay=0).

> The last time we discussed this issue, I suggested something similar and
> Wolfgang's response was "Puh, that's far too sophisticated."

Well, most users don't use state change monitoring but on the other hand 
it's a mandatory feature. I still prefer a simple solution, no bit-rate 
dependent delay, netlink interface, etc.

> What you suggest does not sound overly complicated, so I would say it's a good
> idea. It seems like it's the best that we can do with what we have.
> 
> Wolfgang, Marc, what do you think?

See above.

Wolfgang.
