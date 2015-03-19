From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 1/2] can: fix multiple delivery of a single CAN frame
 for overlapping CAN filters
Date: Thu, 19 Mar 2015 09:06:45 +0100
Message-ID: <550A8395.4080307@hartkopp.net>
References: <1426659036-4628-1-git-send-email-socketcan@hartkopp.net> <20150318221709.GB2602@Darwish.PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:58861 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbCSIGz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Mar 2015 04:06:55 -0400
In-Reply-To: <20150318221709.GB2602@Darwish.PC>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-can@vger.kernel.org

On 18.03.2015 23:17, Ahmed S. Darwish wrote:

>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 00c13ef..0a6abf1 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -86,6 +86,8 @@ struct raw_sock {
>>   	struct can_filter dfilter; /* default/single filter */
>>   	struct can_filter *filter; /* pointer to filter(s) */
>>   	can_err_mask_t err_mask;
>> +	struct sk_buff *uniq_skb;
>> +	ktime_t uniq_tstamp;
>>   };
>>
>
> My knowledge of the networking internals are really shallow,
> but the `uniq_tstamp' field above feels a little bit redundant?

(..)

> If so, isn't the `uniq_skb' field, on its own, quite sufficient?

AFAIK the skbs are retrieved from a memory pool, so it can be that the skb 
pointer values can be the same by the time.

E.g. if you receive the CAN frames in a timely distance that the skb pointer 
accidentally is the same than the last time, you might unintentionally drop a 
new (changed) content.

With checking the timestamp this possibility of potentially identical skb 
pointers is removed.

Regards,
Oliver

