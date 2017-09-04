From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/6] can: flexcan: fix state transition regression
Date: Mon, 4 Sep 2017 13:09:37 +0200
Message-ID: <f95ded2c-5ac6-9da7-c521-3cbe8edf94ed@grandegger.com>
References: <1f925f5e8c9747cf92351ce2bc471bff@SGPMBX1017.APAC.bosch.com>
 <ea64fc2b-e94d-3fc0-35ad-3a70d94800e6@grandegger.com>
 <1943d84bc81b47368ce9b312f2d6ab11@SGPMBX1017.APAC.bosch.com>
 <1eed176d-c141-03aa-188a-83853aa9cc8a@grandegger.com>
 <792529725893484b9254b6eed7b08d2e@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:53126 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdIDLJk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Sep 2017 07:09:40 -0400
In-Reply-To: <792529725893484b9254b6eed7b08d2e@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 04.09.2017 um 12:01 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Friday, September 01, 2017 11:15 PM
>>
>> [...]
>>>> usually a [PATCH 0/x] is coming first telling what the series does. We
>>>> use "git format-patch --cover-letter ..." for that purpose.
>>> OK. Thanks for your hint!
>>> I'll prepare the updated patch series with cover letter later.
>>
>> You patches are also white-space mangled.
> Perhaps because of the outlook. Although I've tested send to myself and
> copy the text then use "git am" to apply, it works in my local, but
> seems can not work when it send out. :(
> 
> Can we send the updated patches in separate e-mails, with attachments
> instead of inline text? Because we cannot easily switch to other
> mail client...
> 
> Or, do you have other proposal?
> 
>>
>> [...]
>>> I'm not sure that I understood your proposal correctly, the guess is
>>> the second "reg_esr & FLEXCAN_ESR_ERR_STATE" is a typo, do you mean
>>> "reg_esr & FLEXCAN_ESR_BUS_ERR"
>>
>> Typo, sorry, I mean "(reg_esr & FLEXCAN_ESR_ERR_BUS)".
> Sorry I made another typo too. :)
> 
>>
>>> If we only call flexcan_irq_state() upon state + error interrupt, then:
>>> (new core: with    [TR]WRN_INT, e.g., i.MX6,
>>>    old core: without [TR]WRN_INT, e.g., i.MX53)
>>
>> The "FLEXCAN_QUIRK_BROKEN_PERR_STATE" is for the i.MX6. Only thinking
>> about the core here.
>>
>>> 1. error state increases, enough for both new and old cores.
>>>       active ---> warning ---> passive ---> bus off
>>>                      ^            ^            ^
>>>                   WRN_INT/     ERR_INT      BOFF_INT
>>> 	        ERR_INT(old core)
>>>
>>> 2. error state decreases, not enough for both new and old cores.
>>>       active <--- warning <--- passive
>>>          ^           ^
>>>       [TR]X       WRN_INT/
>>> 	        [TR]X(old core)
>>
>> I was oping that the error warning interrupt occurs when the error
>> counter falls again below error passive. Then we could enable the error
>> interrupt on "active -> waning" and disable it on "passive -> warning"
>> state changes. If that does work, than we can disable the error
>> interrupt not before the "warning -> active" change.
> Disable error interrupt on "passive -> warning" cannot handle the case:
> 1. Disconnect the cable, until error passive reported
> 2. Connect the cable, and wait error warning reported
> 3. Disconnect the cable while it is still error warning
> Due to the error interrupt is disabled, so it cannot report error
> passive again.
> 
>>
>>> The [TR]X interrupt is required for the state decreases, and the
>>> overhead of them IMHO is not overkill:
>>> 1. If flexcan_irq_state() is called when the state is not change,
>>>      then, the overhead is read FLT_CONF and/or read error counter,
>>>      do O(1) calculation and compare the state, then quit.
>>
>> Yes, there is just a little overhead.
>>
>>> 2. If flexcan_irq_state() is called when the state is changed,
>>>      then, that's what help us to report correct state transitions.
>>
>> The only difference between "new core" and "old core":
>>
>> new core: error interrupt enabled between error warning and passive.
>> old core: error interrupt enabled between error active and passive.
>>
>> Not sure it it's worth the extra code.
> Yes, it is worth. :) Please see the test result in
> https://marc.info/?l=linux-can&m=150424626206586&w=2, where we can
> optimize for the new core further.

I have already prepared the following answer:

"I think we should throttle the interrupt rate as much as possible. 
Therefore I would go for the special treatment of old and new cores."

Will have  a closer look to your new approach when I'm back in the office.

Wolfgang.
