Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E847AF5C;
	Tue,  1 Sep 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258585; cv=pass; b=LY6ZIkTxQXuMNWGUUrn3JUdcMJ9DKRwgbn8u23257G3ktuaZ56edcdOqCpp2lMvs4XuQCN3CW8cx4rdwj84vqJC7ngoKYHzvC3USqYULQ2Dl9J+G41n8WAr/Qqwf17spC+2hicUfMaF5qwcHCJh76E5Pa3fs6MgLtzUS+zZ+Xs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258585; c=relaxed/simple;
	bh=Evt/D5s0slnahZeaTZVG44InUSJyclin4Mk/o7Qgf+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUG4l2mQMVcI90oqYf0NslG05v6LzRZnXDpvfhqchOiBduAdRssbtnJKLAfNO8H1KNsEkSUkurd5g4lqGXA2Q4YDtbN6aBn93JvsxYKwytHrGedsI1FSvLt7Uip/v0hpditIWBfUzjwM0UMKTJQeOLTs5O3ZB8HpwV2SxSikBf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XcPdEoXV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=D+TX0qGt; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XcPdEoXV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="D+TX0qGt"
ARC-Seal: i=1; a=rsa-sha256; t=1788258356; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FelNbVRcmqGy/6hzfEMv72bwXBKXb8dwTNUlBpaPmV1+rnw+XHvZyv75UplqB4a5C5
    pTBh+o3KX+yvACR5K4gu/XGDD4igz7Yz4GDX+czybFijFycXJtMuh6L2R/OreHSu28u4
    tXrqjiyhn2Uf0HkFbVzvqxEyLGZTKg2ShA/ZxiAM3g0uab39ihRLSWWiVq/+d4I+IkVR
    8F+GtfS36iW2BfJ2v+1GNAKJFSkHu91V743Hw2rtp5rF3ZwEBDqj09KKnZcQanp7R7Ih
    +uHscx4Ib0HlxDrY0g3iznALz8dg9k9pBNZOBhf4eKy4Ba5ZQvM1son86IAIxd0YeWNR
    tQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788258356;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dCZLhSfUEhaAwMruir2LhZBbM+2WIp8P80xffuqNLsI=;
    b=i8IRpH5r5JVCFWgBoxB/BqsGB+GEDsXJXiLfYtjqNtn7cbnPTdaS9nd9A8+UfJpueR
    mg6be8gmdBr+AYZ+FgFJjx3FNraaxDUV1RuBr6w4WRBHlEP+ciFf5a1dcoRp1tgSH1gy
    Ck1IxZtPJQD9wBn+fYGNJaukmMNNgg6rSxTAQ0WqT2ICUXNOmf5R3+M/q4ERB6zkV8p6
    05BdP6WpXlYw7wU25EBRxQ1/G4R9aiZAP8rwRyyQpmh4ZtT+PQF18f4qD/3LFfAS+JIQ
    rB85yyFCP3TkG3zL5rIWtYYZlPcLni787nt5SW/vj3Z/wqDh4fhtYjJt79pWrNfEVYJs
    rjhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788258355;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dCZLhSfUEhaAwMruir2LhZBbM+2WIp8P80xffuqNLsI=;
    b=XcPdEoXVB1LKR3SalFayjD+Gah+ede6tPZsXc8WO7B74Djj1Ls5B6jZUZEiBJlfCkP
    Z1MH3Qx6hvMchisgtwApgsiBfK9LHvFUicDgDxnqEg7dhME3FSM2gsfGqn07YbircmPt
    YO7gWOvKZDdGqaUKYtman5qwIsLXtUituIZT4XODoTO/FK0jmgPklQSqFqpWO4rEdMH8
    wVvtg10Ckh78JSKdNQotIauNREaUxOOSE86c0P/rjmuO+eavAJzu9j1IvVZV5exvAjYP
    RRGuGLqaZ1N2pXG99r//1ZyMF+14XBt65zKyg3pqUvUTjyKnFpge2Qdebuw8oZhKOXxq
    2qxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788258353;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dCZLhSfUEhaAwMruir2LhZBbM+2WIp8P80xffuqNLsI=;
    b=D+TX0qGtGojyAKhqY1CsoQQsPtZHJ6UuGsujqgvXqPJgAnyMaPGx9f5ixhEqVwrkf0
    rUDja61g89CE92fttCDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b7281APmQQi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Sep 2026 12:25:48 +0200 (CEST)
Message-ID: <31977601-8ded-4c73-9460-e4140933ff85@hartkopp.net>
Date: Tue, 1 Sep 2026 12:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: isotp: take rtnl_lock() before leaving the
 notifier list
To: Norbert Szetei <norbert@doyensec.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-kernel@vger.kernel.org
References: <CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com>
 <2c5851d3-cd83-4a16-91ed-b7323cabe7c0@hartkopp.net>
 <E1633997-A167-405C-9B1D-4FFED8E4A595@doyensec.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <E1633997-A167-405C-9B1D-4FFED8E4A595@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Norbert!

On 01.09.26 09:01, Norbert Szetei wrote:
> Hey Oliver,
> 
>> On Aug 31, 2026, at 15:08, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hello Norbert,
>>
>> many thanks for your patch and the analysis of the unremoved filter lists in the case of moving a CAN device to another namespace.
>>
>> But I don't think that moving rtnl_lock() up so that it covers a busy loop including a schedule_timeout_uninterruptible(1) wait is not a nice move for other rtnl_lock() users.
>>
>> Focussing on the removal of the correct filter lists when the namespace is changed away from the socket's namespace I would propose this small change:
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 155530aedce2..0835a4758a72 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
>>         /* remove current filters & unregister
>>          * tracked reference so->dev is taken at bind() time with rtnl_lock
>>          */
>>         if (so->bound && so->dev) {
>>                 if (isotp_register_rxid(so))
>> -                       can_rx_unregister(net, so->dev, so->rxid,
>> +                       can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
>>                                           SINGLE_MASK(so->rxid),
>>                                           isotp_rcv, sk);
>>
>> -               can_rx_unregister(net, so->dev, so->txid,
>> +               can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
>>                                   SINGLE_MASK(so->txid),
>>                                   isotp_rcv_echo, sk);
>>                 netdev_put(so->dev, &so->dev_tracker);
>>         }
>>
>> @@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>> static void isotp_notify(struct isotp_sock *so, unsigned long msg,
>>                          struct net_device *dev)
>> {
>>         struct sock *sk = &so->sk;
>>
>> -       if (!net_eq(dev_net(dev), sock_net(sk)))
>> -               return;
>> -
>>         if (so->dev != dev)
>>                 return;
>>
>>         switch (msg) {
>>         case NETDEV_UNREGISTER:
>>
>>
>> Can you give it a try with your KASAN setup and maybe also ask opus about my idea?
> 
> I just tested your version and I was no longer able to reproduce
> the bug. Initially, I considered it too, but moving rtnl_lock()
> sounded simpler and I had not thought about the busy-wait sitting
> there. Thanks for pointing this out and submitting the patch.

Thanks for testing!

Btw. sashiko bot pointed out some inconvenience with the removed 
net_eq() check, as I'm checking for ifindex equality in bcm.c at some 
places - and the ifindex values are not unique over all namespaces like 
the struct netdev *dev pointer.

https://lore.kernel.org/linux-can/20260831212432.6C2B51F000E9@smtp.kernel.org/

So I need to extend bcm.c in a way that it is checking the dev pointers 
instead of dev->ifindex in those places. There will be a v2 soon.

Btw. many thanks for testing that the original root cause was fixed with 
this approach.

Best regards,
Oliver


> 
> Regards,
> Norbert
> 
>> Many thanks,
>> Oliver
>>
>> On 31.08.26 10:30, Norbert Szetei wrote:
>>> isotp_release() removes the socket from isotp_notifier_list before it
>>> takes rtnl_lock(). The netdev notifier chain runs under RTNL, so a
>>> socket that leaves the list in that window is skipped by isotp_notify()
>>> and has to unregister its own CAN filters.
>>> It cannot always do that. isotp_release() passes sock_net(sk) to
>>> can_rx_unregister(), which returns early when that netns no longer
>>> matches dev_net(dev), before the receiver list is searched and before
>>> the "receive list entry not found" warning. Once the bound device has
>>> been moved to another netns the filters are removed zero times, and
>>> can_rx_register() stores rcv->sk without taking a reference, so the
>>> receivers left in the device's dev_rcv_lists point at the freed socket
>>> and travel with the device into the new netns.
>>>    BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
>>>    Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
>>>     can_rcv_filter+0x4af/0x8c0
>>>     can_receive+0x28d/0x3c0
>>>     can_rcv+0x2a9/0x310
>>>     __netif_receive_skb_one_core+0x21a/0x260
>>>     process_backlog+0x210/0x760
>>> Take rtnl_lock() before removing the socket from the notifier list, so
>>> that isotp_release() and isotp_notify() cannot both skip the removal.
>>> Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: Claude:claude-opus-5
>>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>>> ---
>>> Reproducer available on request.
>>>   net/can/isotp.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>>> index 155530aedce2..8ca75d30360c 100644
>>> --- a/net/can/isotp.c
>>> +++ b/net/can/isotp.c
>>> @@ -1475,6 +1475,8 @@ static int isotp_release(struct socket *sock)
>>>    /* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
>>>    wake_up_interruptible(&so->wait);
>>>   + rtnl_lock();
>>> +
>>>    spin_lock(&isotp_notifier_lock);
>>>    while (isotp_busy_notifier == so) {
>>>    spin_unlock(&isotp_notifier_lock);
>>> @@ -1484,7 +1486,6 @@ static int isotp_release(struct socket *sock)
>>>    list_del(&so->notifier);
>>>    spin_unlock(&isotp_notifier_lock);
>>>   - rtnl_lock();
>>>    lock_sock(sk);
>>>      /* remove current filters & unregister
>>
> 

