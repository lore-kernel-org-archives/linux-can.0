From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE
 to eliminate duplicate matches
Date: Tue, 17 Mar 2015 16:58:42 +0100
Message-ID: <55084F32.50500@gmail.com>
References: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net> <550849E6.7040104@gmail.com> <55084D1F.3080001@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33318 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbCQP6p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 11:58:45 -0400
Received: by wgbcc7 with SMTP id cc7so12235688wgb.0
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 08:58:44 -0700 (PDT)
In-Reply-To: <55084D1F.3080001@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 17.03.2015 16:49, Oliver Hartkopp wrote:
> On 17.03.2015 16:36, Andre Naujoks wrote:
>> On 17.03.2015 13:58, Oliver Hartkopp wrote:
>>> The CAN_RAW socket can set multiple CAN identifier specific filters
>>> that lead
>>> to multiple filters in the af_can.c filter processing. These filters are
>>> indenpendent from each other which leads to logical OR'ed filters
>>> when applied.
>>>
>>> Especially when the filter is intended to notch single CAN IDs or CAN
>>> ID ranges
>>> a problem emerges when using more than just one filter: The notched
>>> CAN IDs
>>> will be delivered once while the other CAN IDs will be delivered twice.
>>>
>>> This patch implements a new option to make sure that every CAN frame
>>> which is
>>> filtered for a specific socket is only delivered once to the user space.
>>> This is independent from the number of matching CAN filters of this
>>> socket.
>>
>> Hi Oliver.
>>
>> I don't think this should be an option. A CAN-frame should never be
>> delivered more than once even if multiple filters match.
>>
>> In my eyes this is a long standing bug ;-), which would get an
>> off-switch this way.
> 
> https://www.youtube.com/watch?v=4JgxDxwf7RU
> 
> :-))
> 
> So you think the 'unifying option' should be enabled by default!?!

Yes!

> Would you assume this to break any user space apps?

I don't see how. In fact I had to work around the "duplpicate frame
issue" on occasion. If nobody sees a reason against this, I am strongly
in favour of making this the default behaviour.

> 
> Btw. what's your opinion about
> 
> http://marc.info/?l=linux-can&m=142660595731528&w=2

http://marc.info/?l=linux-can&m=142660682531909&w=2 ;-)

I'd like that as a socket option. Effectively choosing if the set
filters should be OR'd or AND'd.

Regards
  Andre

> 
> ??
> 
> Regards,
> Oliver

