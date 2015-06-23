From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix loss of frames due to wrong assumption in raw_rcv
Date: Tue, 23 Jun 2015 10:01:39 +0200
Message-ID: <55891263.3050704@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:43276 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbbFWIBz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2015 04:01:55 -0400
In-Reply-To: <5588E6FB.5040903@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Tom,

On 23.06.2015 06:56, Tom Evans wrote:
> On 22/06/15 20:24, Oliver Hartkopp wrote:
>> But the point becomes an issue when there's no userspace application that
>> requires timestamps.
>>
>> I did my testing wile having at least one "candump" instances running, which
>> enables timestamping. So when there's no one requesting timestamps the check
>> in can_rcv does not perform properly.
>>
>> Therefor my patch grabs your idea to set the timestamps for CAN skbs
>> unconditionally. But there were some more places in the code where we need to
>> take care about that.
>
> The original patch contains:
>
> +    /* eliminate multiple filter matches for the same skb */
> +    if (this_cpu_ptr(ro->uniq)->skb == oskb &&
> +        ktime_equal(this_cpu_ptr(ro->uniq)->tstamp, oskb->tstamp)) {
> +        return;
> +    } else {
> +        this_cpu_ptr(ro->uniq)->skb = oskb;
> +        this_cpu_ptr(ro->uniq)->tstamp = oskb->tstamp;
> +    }
> +
>
> Mightn't it be more robust if the above check didn't filter out a packet if
> either of the timestamps weren't set (were zero)? Assuming the structures are
> zeroed before this gets set.

Yes. But the source just moved on with the introduction of joined filters.
And when you don't have a unique skb detection the joint filter mechanic fails 
totally.

An alternative to force the timestamp to be set would be to add another 
'counter' to struct can_skb_priv which is just increased by the driver with 
every received CAN frame.

But I wonder if its worth the effort in opposite to just enable timestamping 
in every skb. What do you think?

Regards,
Oliver
