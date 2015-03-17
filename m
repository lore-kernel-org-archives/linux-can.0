From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE to eliminate
 duplicate matches
Date: Tue, 17 Mar 2015 16:49:51 +0100
Message-ID: <55084D1F.3080001@hartkopp.net>
References: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net> <550849E6.7040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:57931 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486AbbCQPtz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 11:49:55 -0400
In-Reply-To: <550849E6.7040104@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org

On 17.03.2015 16:36, Andre Naujoks wrote:
> On 17.03.2015 13:58, Oliver Hartkopp wrote:
>> The CAN_RAW socket can set multiple CAN identifier specific filters that lead
>> to multiple filters in the af_can.c filter processing. These filters are
>> indenpendent from each other which leads to logical OR'ed filters when applied.
>>
>> Especially when the filter is intended to notch single CAN IDs or CAN ID ranges
>> a problem emerges when using more than just one filter: The notched CAN IDs
>> will be delivered once while the other CAN IDs will be delivered twice.
>>
>> This patch implements a new option to make sure that every CAN frame which is
>> filtered for a specific socket is only delivered once to the user space.
>> This is independent from the number of matching CAN filters of this socket.
>
> Hi Oliver.
>
> I don't think this should be an option. A CAN-frame should never be
> delivered more than once even if multiple filters match.
>
> In my eyes this is a long standing bug ;-), which would get an
> off-switch this way.

https://www.youtube.com/watch?v=4JgxDxwf7RU

:-))

So you think the 'unifying option' should be enabled by default!?!
Would you assume this to break any user space apps?

Btw. what's your opinion about

http://marc.info/?l=linux-can&m=142660595731528&w=2

??

Regards,
Oliver
