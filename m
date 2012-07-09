From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/4] can: Properly fill the netlink header when responding
 to RTM_GETROUTE
Date: Mon, 09 Jul 2012 18:28:27 +0200
Message-ID: <4FFB06AB.4060409@hartkopp.net>
References: <cover.1341489914.git.tgraf@suug.ch> <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch> <4FF74CE9.7000604@hartkopp.net> <20120709094342.GF32535@canuck.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:65504 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab2GIQ2V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 12:28:21 -0400
In-Reply-To: <20120709094342.GF32535@canuck.infradead.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-can@vger.kernel.org

On 09.07.2012 11:43, Thomas Graf wrote:

> On Fri, Jul 06, 2012 at 10:39:05PM +0200, Oliver Hartkopp wrote:
>> what about this approach which reduces the number of parameters and stack
>> space when calling cgw_put_job() ??
>>
>>
>> diff --git a/net/can/gw.c b/net/can/gw.c
>> index b41acf2..b6b9e0a 100644
>> --- a/net/can/gw.c
>> +++ b/net/can/gw.c
>> @@ -444,11 +444,15 @@ static int cgw_notifier(struct notifier_block *nb,
>>  	return NOTIFY_DONE;
>>  }
>>  
>> -static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
>> +static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj,
>> +		       struct netlink_callback *cb)
>>  {
>>  	struct cgw_frame_mod mb;
>>  	struct rtcanmsg *rtcan;
>> -	struct nlmsghdr *nlh = nlmsg_put(skb, 0, 0, 0, sizeof(*rtcan), 0);
>> +	struct nlmsghdr *nlh;
>> +
>> +	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).pid, cb->nlh->nlmsg_seq,
>> +			RTM_NEWROUTE, sizeof(*rtcan), NLM_F_MULTI);
>>  	if (!nlh)
>>  		return -EMSGSIZE;
>>  
>> @@ -571,7 +575,7 @@ static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
>>  		if (idx < s_idx)
>>  			goto cont;
>>  
>> -		if (cgw_put_job(skb, gwj) < 0)
>> +		if (cgw_put_job(skb, gwj, cb) < 0)
>>  			break;
>>  cont:
>>  		idx++;
> 
> The format I've chosen allows to implement a non-dump RTM_GETROUTE using
> cgw_put_job() if needed and is in line with how such filling functions
> are typically prototyped in other netlink protocol implementations.
> 


Yes, i also checked that the format was commonly used, but i did not find any
use-case for cgw_put_job() besides the full dump ...

Btw. both approaches are fine to me then.

Many thanks,
Oliver

