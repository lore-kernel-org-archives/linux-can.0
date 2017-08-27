From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Sun, 27 Aug 2017 12:57:17 +0200
Message-ID: <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:36742 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdH0LDr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2017 07:03:47 -0400
In-Reply-To: <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>

Am 22.08.2017 um 16:06 schrieb Marc Kleine-Budde:
> On 08/22/2017 03:50 PM, Jonas Mark (ST-FIR/ENG1) wrote:
>> Hello Andri,
>>
>>>> Which polling interval do you think would be appropriate? It
>>>> somehow has to be
>>> a reasonable trade-off between latency and CPU usage. That's a good
>>> question. I don't think that there is a really good answer to it.
>>> It would be nice to see intermittent state-transitions happening,
>>> so I would say as fast as possible without affecting CPU usage to a
>>> significant degree. The polling timer should not be a high
>>> resolution timer or anything that would preempt an rt task.
>>>
>>> This value could also depend on the bitrate as that will affect the
>>> rate at which the error-counter can change. E.g. on 125 k rate, you
>>> will receive at most one frame per 1 ms. This means that the error
>>> state will change at at least 64 ms intervals, so we would have to
>>> sample at 32 ms intervals to catch all the transitions. For 1 M
>>> this would be around 2 ms.
>>>
>>> Note that this is all somewhat speculative as I do not know exactly
>>> how fast the error counters are incremented/decremented.
>>
>> We agree that there is a sensible lower boundary for the polling
>> interval which depends on the bitrate. And there is a upper boundary
>> which depends on the application.
>>
>> We are currently thinking about whether it would be possible to do
>> the polling only in case the controller is actually experiencing
>> trouble.
> 
> Why not enable bus errors on broken controllers. Disable once a bus

Yes, that's what we have done in the past for Flexcan controller cores 
that do not have dedicated interrupt lines for state changes. We have 
introduced FLEXCAN_QUIRK_BROKEN_ERR_STATE for that purpose. It should 
work already with the current driver. Yi ZHU, have you tried that?

> error hits and re-enable them after a configurable timeout with a proper
> default. I have a patch somewhere, although it applies only against the
> pre rx-offload version of the driver.

And that would help to avoid the interrupt flooding problem.

Wolfgang.
