From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: RxFilter issues vcan
Date: Thu, 30 May 2013 10:49:28 +0200
Message-ID: <51A71298.1070202@volkswagen.de>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:59799 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967252Ab3E3Iyv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 May 2013 04:54:51 -0400
In-Reply-To: <51A70F0E.1010902@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Am 30.05.2013 10:34, schrieb Sebastian Haas:
> Hi,
>
> Am 30.05.2013 06:58, schrieb Oliver Hartkopp:
>> On 29.05.2013 22:55, Sebastian Haas wrote:
>>> Hello everybody,
>>>
>>> I played a bit with the RxFilters and noticed that they are behaving somewhat
>>> strange.
>>>
>>> If I start candump this way:
>>> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>>>   I want to receive any messages except 100h and 101h.
>>>
>>> When I send a message which matches the filter, it is received twice:
>>> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>>>    vcan0  1FF   [1]  22
>>>    vcan0  1FF   [1]  22
>>>
>>> When I send a message which should not received at all, it is received:
>>> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>>>    vcan0  100   [1]  22
>>>
>>> Did I misunderstood the filter here?
>>
>> The filters are independent and therefore "logical OR".
> Ok. That explain why received 100h even though I tried to filter it out. But
> why receive a message twice while it was only sent once?

You have defined two(!) filters that let pass the CAN-ID 0x1FF.

So what else would you expect?

:-)

>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
