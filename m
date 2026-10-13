Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8851DB0F
	for <linux-can@vger.kernel.org>; Tue, 13 Oct 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909939; cv=pass; b=ua2vnSpCQHfao5OVqV2kHH5PRf+YieDDKfMj+zMIso8sN7argCWCHY34dHzK0N9Prl84ykm2f9a8PYTOGP8fBnu81/FzBHXAdkc35wOQCqfW9D1IZPGBmCS8cBYe2TUg0W79VaoWwDePHq2xyIbkruYOY6CSXjXbhSOckxcy1yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909939; c=relaxed/simple;
	bh=j6/yuhJa6Ua5Ie/co/12F1hnnIL9c2sL1P/uLW9tfKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UoTD1kuwUYrO+WwLVf1njV+gYIlaGOJK0LcqVjxnljgJ6wOA71QwPCdTGxwu0WVAPoBZiYPgLUQvpTdaV+4Nb491YND9r21+culJtJyQfUbgWGwBcNeW0Ryd+UGk6szuu4DROEPBxA4S/SeBPLxH7xXOzFi2EPef83FJCxrMfhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Egvx3FMs; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PAmRr6Tw; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Egvx3FMs";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PAmRr6Tw"
ARC-Seal: i=1; a=rsa-sha256; t=1791909749; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NDdth13OOlO5x3Hx9u046ZmjgLg1lb5X4tu38ouG3CVJgTOAiAH7CJtNdYiwaSi1iR
    +4w65kfCaGiT9L4+8T7zH0ORRus4qvgh5/x8/v8hEgbou/MPNgnPSuQJwdpE1/i3ZZ3R
    GCy5mF7RgiqZ+mdWEtKYByUKegzq6A8AlYK4z+mcSS+A+jHBbcD/2fuCjcA6au7D3+9/
    E8uw9WfXshy1wGGyS3wn7lpxzUmeGSYKFk7Ma4O/gd7Ol65mdbwJwTBG6gCjLIf69Bi0
    MG6VbMqE5Ksfx8YGJBnWJrkqTpC6u+G/b1hafRVAvUr33pOR3j3GgS7lLI6tuty4PYVh
    XMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791909749;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3/G8x4Xh0VDHTTNuEgcAWC/QuB2ntUvlWphhBzevN04=;
    b=pTGDwc3XUIppWsTYafF5AJFlOVapyx+qzwggTGHtD63OWEK3DcQpkIQknakKLXrvB5
    YAtSyO/klMPpjAVJppnYFFgn9Qo5msxPzXLpm3D+8TPfjuxpIz1bFTHDBhqkRgLR38lw
    ImI3PvPImzCYFUUzoOXZEdoDoMEI934pfmrEy0vEO06MPtsrjJpceaj2NwXIAxLBsRiZ
    MnJxLGhPMLtExux+HjqKM5YYIlKrwk7NHav9zBTgeae3EJeNMyHpg4qXwLmZrg2eEqR2
    iEvGz8dEcGOf79L1QdFyVNOKpi+hVK6bmFvWG4kQIBvv+pIqDqJAZ6pDBUewX0/+IKmD
    0bDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791909749;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3/G8x4Xh0VDHTTNuEgcAWC/QuB2ntUvlWphhBzevN04=;
    b=Egvx3FMsK83hP2fUdHmBkVnLt+BD0LKYK1dNOYMpa74oMWVyk9bVrTeGQWRMfeaWHC
    KaFtdelowyXLwRrSMdkp7dYphEDj8SifpW/AWaUq4kZ7Uo0wJDY6+nyR77uIirl5eJdW
    r6LUVBRDmKRYezDbMRub33pvzTdsOTX2bM8y9c+eY6QQsraxcEB8RrdUF5qQesT6wb9f
    ULt81oWPTwDZ3T14g5Ko3spEabS+y3kqXxQpgpTzLTtMlqgF86qzZNOlxXfcGQ9O8VIk
    XiD45iOYy2JeGXMCbCbfam6WHI2bRVeFxeczwlAshccv8oTRPzxGN3PxEMv6GIZy2mu5
    dc6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791909749;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3/G8x4Xh0VDHTTNuEgcAWC/QuB2ntUvlWphhBzevN04=;
    b=PAmRr6Two6MlfGk6CGq3JxItnyvop3m0Uf70BUpCdBFk+uKWV+flsdooOtuxAc8Nty
    t4uDiq5UihrNv85aW9CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DGgT7aV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 18:42:29 +0200 (CEST)
Message-ID: <e194ae0f-7e11-4959-8f35-4f69c648fd19@hartkopp.net>
Date: Tue, 13 Oct 2026 18:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] can: remove CAN filters independent from namespace
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260929163424.16382-2-socketcan@hartkopp.net>
 <179100651478.1406898.6853696436813565877@kernel.org>
 <99878bd4-a4f4-470e-a6df-373c30a48668@hartkopp.net>
Content-Language: en-US
In-Reply-To: <99878bd4-a4f4-470e-a6df-373c30a48668@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

the namespace movement at release time problem also applies to bcm.c and 
raw.c (less critical). Therefore I sent three patches after all.

I think they won't make it into 7.3 in this cycle - but maybe you can 
consider them for your can-next PR.

At least they are all checked by Claude Opus-5 so I don't expect any 
harsh feedback from sashiko-bot :-D

Best regards,
Oliver

On 13.10.26 13:08, Oliver Hartkopp wrote:
> I reworked and stripped this patch to only address the race which can 
> indeed be fixed by moving rtnl_lock() as originally suggested by Norbert 
> and Opus-5 ;-)
> 
> The new patch is reduced for stable here:
> 
> https://lore.kernel.org/linux-can/20261013105909.91715-1- 
> socketcan@hartkopp.net/
> 
> Thanks Norbert and thanks for the review!
> 
> Best regards,
> Oliver
> 
> On 03.10.26 07:48, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 2 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply
>> (one such reply per series is enough).
>>
>> - [High] bcm_release() (net/can/bcm.c) unregisters device-bound receive
>>    filters without holding RTNL, so a concurrent namespace move can 
>> still…
>> - [Medium] The commit message describes a failure that does not occur in
>>    the notifier code.
>> - [Medium] The patch removes the early net_eq() return in bcm_notify()
>>    and moves lock_sock(sk) above the switch (net/can/bcm.c:1838).
>>
>> -- 
>>
>> can: remove CAN filters independent from namespace
>>
>> This commit removes the net_eq() namespace check from the BCM, ISOTP and
>> RAW netdev notifiers, so CAN filters are removed on NETDEV_UNREGISTER
>> even when the device namespace differs from the socket namespace. In
>> bcm.c it adds tracked net_device pointers (bo->dev, op->tx_dev) for
>> device comparisons, and bcm_notify() now takes lock_sock() for every
>> event. In isotp_release() the can_rx_unregister() calls now use
>> dev_net(so->dev).
>>
>> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4- 
>> CBAE2F301A8E@doyensec.com/
>>
>>> When the devices namespace is changed the socket namespace and the 
>>> device
>>> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
>>> the CAN protocols netdev notifiers therefore led to skipping the 
>>> required
>>> removal of the CAN filters from the (namespace changed) CAN devices.
>>
>> [Severity: Medium]
>>
>> Is this root cause accurate? In __dev_change_net_namespace(), the
>> UNREGISTER notifiers run while dev_net(dev) still points to the old
>> namespace:
>>
>> net/core/dev.c:__dev_change_net_namespace() {
>>      ...
>>     unlist_netdevice(dev);
>>      ...
>>     call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
>>      ...
>>     netdev_lock(dev);
>>     dev_net_set(dev, net);
>>     netdev_unlock(dev);
>>     dev->ifindex = new_ifindex;
>>      ...
>> }
>>
>> The bind and registration paths are raw_bind(), isotp_bind(),
>> bcm_connect(), bcm_rx_setup() and bcm_sendmsg(). All of them look up
>> the device with dev_get_by_index(sock_net(sk), ...). can_rx_register()
>> also refuses a device from another namespace:
>>
>>     if (dev && !net_eq(net, dev_net(dev)))
>>         return -ENODEV;
>>
>> For a socket with filters on the moved device, wouldn't the removed
>> net_eq() check in raw_notify(), isotp_notify() and bcm_notify() have
>> passed during the move?
>>
>> No registration seems able to get in between either:
>>
>> - raw and isotp register under rtnl.
>> - bcm_rx_setup() runs under lock_sock(), which bcm_notify() also takes
>>    for UNREGISTER.
>> - Lookups fail after unlist_netdevice().
>>
>> I couldn't find a path where the notifier sees a bound device in a
>> foreign namespace.
>>
>> The real bug this patch fixes looks like it is in isotp_release():
>>
>> 1. The socket is unlinked from the notifier list.
>> 2. A namespace move completes.
>> 3. can_rx_unregister(sock_net(sk), so->dev, ...) returns early on its
>>     own net_eq() check.
>>
>> That is a race between release and the move, not the notifier check.
>>
>> Could the commit message describe the path that was actually hit, or
>> the reproducer from the report? The BCM rework, which is tagged for
>> stable, is justified by this description.
>>
>>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>>> index 3d637a1e0ac1a..cd3522ec32c0a 100644
>>> --- a/net/can/bcm.c
>>> +++ b/net/can/bcm.c
>>
>> [ ... ]
>>
>>> @@ -1792,15 +1833,13 @@ static void bcm_notify(struct bcm_sock *bo, 
>>> unsigned long msg,
>>>   {
>>>       struct sock *sk = &bo->sk;
>>>       struct bcm_op *op;
>>> -    int notify_enodev = 0;
>>> +    int sk_err = 0;
>>> -    if (!net_eq(dev_net(dev), sock_net(sk)))
>>> -        return;
>>> +    lock_sock(sk);
>>
>> [Severity: Medium]
>>
>> With the early return gone and lock_sock() moved above the switch,
>> bcm_notifier() now takes the lock of every BCM socket in every
>> namespace. It does this for every NETDEV_DOWN and NETDEV_UNREGISTER of
>> any CAN device, while holding RTNL:
>>
>> net/can/bcm.c:bcm_notifier() {
>>      ...
>>     list_for_each_entry(bcm_busy_notifier, &bcm_notifier_list, 
>> notifier) {
>>         spin_unlock(&bcm_notifier_lock);
>>         bcm_notify(bcm_busy_notifier, msg, dev);
>>         spin_lock(&bcm_notifier_lock);
>>     }
>>      ...
>> }
>>
>> Before this change, sockets in other namespaces returned immediately,
>> and NETDEV_DOWN never took lock_sock().
>>
>> bcm_sendmsg() holds lock_sock() across bcm_tx_setup(), bcm_rx_setup()
>> and bcm_tx_send(), and these call memcpy_from_msg() on the user buffer.
>> Suppose that buffer is on a FUSE-backed mmap that never answers the
>> read. An unprivileged user in a user namespace can set this up. The
>> copy then blocks with the socket lock held.
>>
>> Can a CAN device event in an unrelated namespace then block in
>> lock_sock() inside bcm_notify() with RTNL held? An example is "ip link
>> set can0 down" in init_net. That would stall network configuration
>> system-wide.
>>
>> A similar stall was already possible for same-namespace UNREGISTER
>> events. This change extends it to cross-namespace events and to
>> NETDEV_DOWN. Later patches in this series don't appear to change this.
>>
>> NETDEV_DOWN only needs the bo->dev == dev comparison, which
>> raw_notify() and isotp_notify() already do without the socket lock.
>> Would a lockless check, before lock_sock(), of whether this socket
>> references dev at all avoid this?
>>
>>>       switch (msg) {
>>
>> [ ... ]
>>
>>> @@ -1984,6 +2025,10 @@ static int bcm_release(struct socket *sock)
>>>       if (bo->bound) {
>>>           WRITE_ONCE(bo->bound, 0);
>>>           bo->ifindex = 0;
>>> +        if (bo->dev) {
>>> +            netdev_put(bo->dev, &bo->dev_tracker);
>>> +            bo->dev = NULL;
>>> +        }
>>>       }
>>>       sock_orphan(sk);
>>
>> [Severity: High]
>>
>> Does bcm_release() still have the same window between release and a
>> namespace move that this patch closes for isotp?
>>
>> bcm_release() removes the socket from bcm_notifier_list and then takes
>> only lock_sock(). Unlike raw_release() and isotp_release(), it does not
>> take rtnl_lock():
>>
>> net/can/bcm.c:bcm_release() {
>>      ...
>>     list_del(&bo->notifier);
>>     spin_unlock(&bcm_notifier_lock);
>>
>>     lock_sock(sk);
>>      ...
>>             if (op->rx_reg_dev)
>>                 bcm_rx_unreg(op->rx_reg_dev, op);
>>      ...
>> }
>>
>> The list_del() can happen before a concurrent move's UNREGISTER walk
>> reaches this socket. In that case bcm_notify() never runs for it, and
>> op->rx_reg_dev stays set.
>>
>> bcm_rx_unreg() then reads dev_net(dev) without RTNL, and
>> can_rx_unregister() reads it a second time:
>>
>> net/can/bcm.c:bcm_rx_unreg() {
>>     if (op->rx_reg_dev == dev) {
>>         can_rx_unregister(dev_net(dev), dev, op->can_id,
>>                   REGMASK(op->can_id), bcm_rx_handler, op);
>>
>>         /* mark as removed subscription */
>>         op->rx_reg_dev = NULL;
>>         netdev_put(dev, &op->rx_reg_dev_tracker);
>>      ...
>> }
>>
>> net/can/af_can.c:can_rx_unregister() {
>>      ...
>>     if (dev && !net_eq(net, dev_net(dev)))
>>         return;
>>      ...
>> }
>>
>> The concurrent writer is dev_net_set() in __dev_change_net_namespace(),
>> which runs under RTNL and netdev_lock().
>>
>> Say the argument is sampled as the old namespace and dev_net_set() runs
>> before the net_eq() check. can_rx_unregister() then returns without
>> unlinking anything. bcm_rx_unreg() still clears op->rx_reg_dev, and
>> bcm_remove_op() later frees op.
>>
>> Can the next frame received on the device in the new namespace then
>> call bcm_rx_handler() with the freed op?
>>
>> Now say the check passes instead. hlist_del_rcu() runs under the old
>> namespace's rcvlists_lock, while code in the new namespace may modify
>> the same per-device list under its own lock.
>>
>> Could this corrupt the receive list?
>>
>> The isotp_release() change to dev_net(so->dev) in this patch relies on
>> rtnl_lock() being held there. This window existed before this patch,
>> and later patches in this series don't appear to change bcm_release().
>>
>> For the BCM part of this fix to be complete, does bcm_release() need
>> rtnl_lock() around the unregister step, as raw_release() and
>> isotp_release() take?
>>
> 
> 

