From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: raw: raw_setsockopt: limit number of can_filter that
 can be set
Date: Tue, 6 Dec 2016 22:47:39 +0100
Message-ID: <87fed5e3-2ffd-0ca9-30ca-4b6144121443@hartkopp.net>
References: <20161205105536.23668-1-mkl@pengutronix.de>
 <d807d5f3-632f-e5c1-dc71-7acb75717af0@hartkopp.net>
 <ef096557-7bbc-296a-8418-30dbede85065@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:23555 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbcLFVrq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2016 16:47:46 -0500
In-Reply-To: <ef096557-7bbc-296a-8418-30dbede85065@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@google.com>

On 12/06/2016 12:19 PM, Marc Kleine-Budde wrote:
> On 12/05/2016 09:44 PM, Oliver Hartkopp wrote:

>>> --- a/net/can/raw.c
>>> +++ b/net/can/raw.c
>>> @@ -499,6 +499,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>>  		if (optlen % sizeof(struct can_filter) != 0)
>>>  			return -EINVAL;
>>>
>>> +		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
>>> +			return -EINVAL;
>>
>> What about -E2BIG instead of -EINVAL here?
> 
> I copied the concept from the readv/writev implementation:
> 
> http://lxr.free-electrons.com/source/fs/read_write.c#L756

Is good to me either.

Regards,
Oliver


