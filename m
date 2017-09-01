From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/6] can: flexcan: fix state transition regression
Date: Fri, 1 Sep 2017 17:14:47 +0200
Message-ID: <1eed176d-c141-03aa-188a-83853aa9cc8a@grandegger.com>
References: <1f925f5e8c9747cf92351ce2bc471bff@SGPMBX1017.APAC.bosch.com>
 <ea64fc2b-e94d-3fc0-35ad-3a70d94800e6@grandegger.com>
 <1943d84bc81b47368ce9b312f2d6ab11@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:54928 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdIAPOu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 11:14:50 -0400
In-Reply-To: <1943d84bc81b47368ce9b312f2d6ab11@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 01.09.2017 um 04:48 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Thursday, August 31, 2017 7:37 PM
>>
>> Hello ZHU Yi,
>>
>> usually a [PATCH 0/x] is coming first telling what the series does. We
>> use "git format-patch --cover-letter ..." for that purpose.
> OK. Thanks for your hint!
> I'll prepare the updated patch series with cover letter later.

You patches are also white-space mangled.

>>
>> Am 31.08.2017 um 10:24 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>> [...]
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 13f0f21..df4bfb8 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -765,8 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>    		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>>>    	}
>>>
>>> -	/* state change interrupt */
>>> -	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
>>> +	/* state change interrupt or broken error state quirk fix is enabled */
>>> +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>> +	    (priv->devtype_data->quirks &
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE))
>>>    		flexcan_irq_state(dev, reg_esr);
>>
>> This means that flexcan_irq_state() is called for any interrupt source.
>> That's what we had in the pre rx-offload version. Thinking about it:
>> do we need that (overhead for RX and TX)? Maybe the following works already:
>>
>>   +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>   +	    ((priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_ERR_STATE) &&
>>   +		(reg_esr & FLEXCAN_ESR_ERR_STATE)))
> I'm not sure that I understood your proposal correctly, the guess is
> the second "reg_esr & FLEXCAN_ESR_ERR_STATE" is a typo, do you mean
> "reg_esr & FLEXCAN_ESR_BUS_ERR"

Typo, sorry, I mean "(reg_esr & FLEXCAN_ESR_ERR_BUS)".


> If we only call flexcan_irq_state() upon state + error interrupt, then:
> (new core: with    [TR]WRN_INT, e.g., i.MX6,
>   old core: without [TR]WRN_INT, e.g., i.MX53)

The "FLEXCAN_QUIRK_BROKEN_PERR_STATE" is for the i.MX6. Only thinking 
about the core here.

> 1. error state increases, enough for both new and old cores.
>      active ---> warning ---> passive ---> bus off
>                     ^            ^            ^
>                  WRN_INT/     ERR_INT      BOFF_INT
> 	        ERR_INT(old core)
> 
> 2. error state decreases, not enough for both new and old cores.
>      active <--- warning <--- passive
>         ^           ^
>      [TR]X       WRN_INT/
> 	        [TR]X(old core)

I was oping that the error warning interrupt occurs when the error 
counter falls again below error passive. Then we could enable the error 
interrupt on "active -> waning" and disable it on "passive -> warning" 
state changes. If that does work, than we can disable the error 
interrupt not before the "warning -> active" change.

> The [TR]X interrupt is required for the state decreases, and the
> overhead of them IMHO is not overkill:
> 1. If flexcan_irq_state() is called when the state is not change,
>     then, the overhead is read FLT_CONF and/or read error counter,
>     do O(1) calculation and compare the state, then quit.

Yes, there is just a little overhead.

> 2. If flexcan_irq_state() is called when the state is changed,
>     then, that's what help us to report correct state transitions.

The only difference between "new core" and "old core":

new core: error interrupt enabled between error warning and passive.
old core: error interrupt enabled between error active and passive.

Not sure it it's worth the extra code.

> Of course, if flexcan core can generate appropriate state interrupts
> in its next version (FlexCAN4?), then we don't need such overhead
> at all, but when will this wish come true? :)

Not on the i.MX6q, for sure ;).

Wolfgang.
