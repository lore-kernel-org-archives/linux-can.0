From: Felix Seitz <felix.seitz@thm-motorsport.de>
Subject: Re: [PATCH v2] cansniffer: totally untested hack to reduce display
 update by factor of 10
Date: Tue, 24 Jun 2014 20:09:10 +0200
Message-ID: <53A9BEC6.5070907@thm-motorsport.de>
References: <1403627167-28287-1-git-send-email-mkl@pengutronix.de> <53A9A96E.5030407@hartkopp.net> <d65e3040-e640-4c05-baa3-d97ce7a448b6@email.android.com> <53A9BAAE.2000101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52072 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbaFXSJU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 14:09:20 -0400
In-Reply-To: <53A9BAAE.2000101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc and Oliver,

thank you both for your quick help. I will try this out tomorrow.

Regards,
Felix


Am 24.06.2014 19:51, schrieb Oliver Hartkopp:
> Ok, it IS faster (and will therefore help Felix).
>
> But the tiny animation is broken now.
>
> I probably have to rework the animation - will send an updated patch.
>
> Thanks for your support,
> Oliver
>
> On 24.06.2014 18:44, Marc Kleine-Budde wrote:
>>
>> On 24 June 2014 18:38:06 CEST, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>> I'll check it and give a feedback.
>>>
>>> Btw. it needs a v3:
>>>
>>>>   /* time defaults */
>>>>   
>>>> -#define TIMEOUT 50 /* in 100ms */
>>>> -#define HOLD    10 /* in 100ms */
>>>> -#define LOOP     2 /* in 100ms */
>>>> +#define TIMEOUT 500 /* in 10ms */
>>>> +#define HOLD    100 /* in 10ms */
>>>> +#define LOOP      2 /* in 10ms */
>>> LOOP has to be *10 too.
>> Yes, if we want unchanged behaviour, which would be better for mainlining. With my patch the default is now 20ms.
>>
>> Marc
>>

