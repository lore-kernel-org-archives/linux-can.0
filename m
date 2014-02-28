From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 13:33:20 +0100
Message-ID: <53108210.6070700@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:50494 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbaB1MdZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 07:33:25 -0500
In-Reply-To: <53108165.5050606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 28.02.2014 13:30, Marc Kleine-Budde wrote:
> On 02/28/2014 01:20 PM, Oliver Hartkopp wrote:
>>
>>
>> On 28.02.2014 11:56, Marc Kleine-Budde wrote:
>>> On 02/27/2014 07:05 PM, Oliver Hartkopp wrote:
>>>> On 27.02.2014 09:43, Marc Kleine-Budde wrote:
>>>>
>>>>>> +		if (priv->do_set_data_bittiming) {
>>
>>
>>>
>>>> The bitrate is always set via do_set[_data]_bittiming() when the interface is
>>>> down - and *not* during the open process.
>>>
>>> No, not _always_. The flexcan and at91 drivers (maybe others, too) write
>>> the values during open().
>>
>> flexcan does not assign priv->do_set_bittiming() and does the bitrate setting
>> at open time.
>>
>> Thats ok too.
>>
>> This is up to the driver, whether do_set[_data]_bittiming() is assigned and
>> when the stuff in the bitrate structures is set into the registers.
>>
>> I don't understand your problem.
> 
> A new do_set_data_bittiming() callback is not needed, as it's better do
> set the data and "normal" bit timing registers during open().

With this argumentation do_set_bittiming() has to be removed too.

Is this your intention?

Regards,
Oliver
