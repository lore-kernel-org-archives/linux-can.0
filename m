From: Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: Re: [PATCH] net: add comment for sock_efree() usage
Date: Tue, 10 Mar 2015 10:50:52 -0700
Message-ID: <54FF2EFC.8070102@redhat.com>
References: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net> <54FF29F6.6080403@redhat.com> <54FF2C40.8070904@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbbCJRu7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Mar 2015 13:50:59 -0400
In-Reply-To: <54FF2C40.8070904@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: eric.dumazet@gmail.com


On 03/10/2015 10:39 AM, Oliver Hartkopp wrote:
> On 03/10/2015 06:29 PM, Alexander Duyck wrote:
>> On 03/10/2015 10:19 AM, Oliver Hartkopp wrote:
>>> In opposite to sock_rfree() and sock_wfree() the function sock_efree() does
>>> not need to change the sk_[rw]_mem_alloc length. Add the comment to point out
>>> the idea for using sock_efree() in the _e_rror handler or e.g. timestamp path.
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>    net/core/sock.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 93c8b20..7a1eac8 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -1655,6 +1655,10 @@ void sock_rfree(struct sk_buff *skb)
>>>    }
>>>    EXPORT_SYMBOL(sock_rfree);
>>>    +/*
>>> + * Buffer destructor for skbs that don't have sk_[rw]_mem_alloc accounting.
>>> + * E.g. error handler / timestamp path. Automatically called from kfree_skb.
>>> + */
>>>    void sock_efree(struct sk_buff *skb)
>>>    {
>>>        sock_put(skb->sk);
>> This should probably be pushed out to the netdev list since this effects all
>> sockets.
> Yes. That was my default. Will put netdev in --to next time.
>
>> Technically speaking there is a 1 byte sk_wmem_alloc that this is accounting
>> for to keep the socket from being closed.  It is shared between all instances
>> that are using sock_efree as their destructor, and will drop that 1 byte when
>> sk_refcnt has reached 0.
> Ok. What would be your suggestion then?
>
> 'destructor that doesn't fiddle with sk_[rw]_mem_alloc length' ??? :-)))
>
> Best regards,
> Oliver

I'd suggest keeping it simple.  You are trying to define it as something 
it isn't.  It still does accounting, your description makes it sound 
like it doesn't.

For example sock_rfree doesn't tell you where it is supposed to be used 
and what it is accounting for.  It just is described as a read buffer 
descructor called from kfree_skb.  I'd suggest something similar, maybe 
just describe it as a desctructor used to free buffers that are not used 
directly in read or write.

- Alex
