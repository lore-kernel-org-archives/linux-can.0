Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2D3BADB4;
	Fri, 16 Oct 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150708; cv=pass; b=UZDEXskBTxy4ZAtu4CIqDEN6sl7RN2YGriKqXgnQDlkmtSDCDTpFC7ZFIN7+xyzuEis3INIvTZA7xFm6mxB2K+YC8FeB6lmLgLWCxfDNV/eNJIEw5XKpcmGx9Y+q59NkGC7DNaxkyxpLD5flaUQjWhhbrIeenVAKSH/EvaPNgng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150708; c=relaxed/simple;
	bh=eeI69TK68moHHSb/ujmgxwEyuII6Lq2vwhbJFdSLVns=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bfDUD/OFtX/H2Yb0rygosW5UhzEMP3tTx6xBaJYKBu6NOhBZoXq9CvxZTJ2WJnxLEdNwPR+KgjX+NZixvhTUonnopzs/XSPUoWTTGaXSQO2g/ee8jq3pdl7EhKfzSEO1SUS+U13GN5yOIC40akNdDHrlw57hKvYSwU5I9WOsX6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=V1hx30b0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sYrGLFVV; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="V1hx30b0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sYrGLFVV"
ARC-Seal: i=1; a=rsa-sha256; t=1792150576; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FUp9YzmBcjZnoVQ8Y7tuFeB60q7OGGz5DUV3ycMgSW0TKgy3tWDXpHnNxlpGj/GPwM
    GgSU9szR1UrYbIoexcVBfrUaYyMn6MooaVtJD/+lH9mwJ/frT3AdSlDn7RSbbckQIFph
    09iM27wv8YMtfIBB94TeUuYuCf2HFMv6wUp5yi+EffNz3qWU5xrftOvjrkd2eoZ1wMsd
    Fv1Dn01AUB/1VMU9vyYsLvqvD7lKtHg+qXaHhP6MauivReQr2vtfYOtR0Tz4KU86jZg1
    kYPbNqYz9exsbLEy+7BYmppbpJ3LPytWHo6pehH5k8qB1QZiv5KxZT5J4dp0/AAIEeBU
    9rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792150576;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZzIx2Bsg372R91Y7FEetD/Sbu2zfo1xtev2+Jyl8M5c=;
    b=GbaC2fx2Aj7lC2dr7M+FztFbC7hhdBHxT/hM5DFaTiovvRMKxiCs+buwz2VANJxW4a
    WWgKipHnaH/ObtFhcsUQeMJSPrldOC9ifEO1QOsNg2CBSynOYGJe1rmPoYfBxCrp4thF
    h3rvbwlvy6NOqeFFt87W+JWb1b1DxZ1jnTQoiW71flioF7qWzAhNdkz0z+LE5LP69u49
    F8zgO+xMdsW8pAN9hruvY2USFvMAKgTbJGL5EVKmDGFhIfh0M65BqZ6E2hlYWzs/2gu+
    an7NLnktoYRQjmKGuaOEgT9Dx5Ei2VvdQ2z4OIAXN+/XEHHisZgyBb387+yhJHdRHcTR
    2Sbw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792150576;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZzIx2Bsg372R91Y7FEetD/Sbu2zfo1xtev2+Jyl8M5c=;
    b=V1hx30b0NgASeB1Y04DpydHlAo0JnEnLUWhbDwmL2HrPMylAhEHO5gXadx5+TPMfad
    Z59qLJfanXjbt8dMcZnKvuvYeZUzWRx/8FQEnv/Thfs4LbT1LiDqVah8DRMfecWBOINM
    GaFxQSBkJn2+ZO16lwN45zSmMw6S9l0jOXE3S6NwWpfiz2kFBZ1kHV+/+f6zmVwDt5Sd
    qER4G0l1fPlXVytLrbBvK0P+K17nfXSYUlmRSF9Cy049tkQ2XbOy2yKx/KJVL2gnwJTk
    9U3HFllEuBt9hEIMYPXP5WFlbsay28JuQqbn65SBhkyeg8M1/I5yXSi9XdvUD8LOmacq
    dv8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792150576;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZzIx2Bsg372R91Y7FEetD/Sbu2zfo1xtev2+Jyl8M5c=;
    b=sYrGLFVV6FoMz7t/b3JdPCOWXpZvJS0esPYQUdw+Ps6t7hOC3j47dhsjHXFgdFwfNx
    0p9IT1BlvlxBv5BH1PBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GBaGM4O
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 13:36:16 +0200 (CEST)
Message-ID: <31fa7f9f-7bd5-40e4-9e94-c685b6b4f498@hartkopp.net>
Date: Fri, 16 Oct 2026 13:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/37] can: bcm: fix filter removal race between
 release and netns change
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be
References: <20261015015336.816543-9-mkl@pengutronix.de>
 <179211822523.434549.241636889494644724@kernel.org>
 <797e174d-cb77-47f8-b56e-c1cfcb1784e4@hartkopp.net>
Content-Language: en-US
In-Reply-To: <797e174d-cb77-47f8-b56e-c1cfcb1784e4@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've sent a new series fixing the valid sashiko-bot remarks:

[PATCH can-next v3 0/3] can: take rtnl_lock() before leaving the 
notifier list

https://lore.kernel.org/linux-can/20261016091128.325332-1-socketcan@hartkopp.net/

where only the bcm patch (and the cover letter) were changed.

[PATCH can-next v3 2/3] can: bcm: fix filter removal race between 
release and netns change

https://lore.kernel.org/linux-can/20261016091128.325332-3-socketcan@hartkopp.net/

Best regards,
Oliver

On 16.10.26 10:51, Oliver Hartkopp wrote:
> I'm working on an update on this.
> 
> On 16.10.26 04:37, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 2 · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply
>> (one such reply per series is enough).
>>
>> - [Medium] The commit moves remove_proc_entry() ahead of rtnl_lock() so
>>    that procfs readers cannot stall RTNL from close().
>> - [Medium] bcm_release() now holds the global rtnl_mutex across the whole
>>    rx_ops unregistration loop (rtnl_lock() at net/can/bcm.c:1951,…
>> - [Low] Stale comment in bcm_release().
>>
>> -- 
>>
>> can: bcm: fix filter removal race between release and netns change
>>
>> bcm_release() now takes rtnl_lock() before it removes the socket from
>> bcm_notifier_list. It holds RTNL across the rx_ops unregistration, so
>> bcm_release() and bcm_notify() can no longer both skip filter removal
>> while the bound device moves to another netns. The bcm_busy_notifier
>> busy-wait becomes a WARN_ON_ONCE(), and the procfs entry and tx_ops are
>> now removed before RTNL is taken.
>>
>> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4- 
>> CBAE2F301A8E@doyensec.com/
>> Link: https://patch.msgid.link/20261014142114.280279-3- 
>> socketcan@hartkopp.net
>>
>>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>>> index 6759662e024c..301920011a30 100644
>>> --- a/net/can/bcm.c
>>> +++ b/net/can/bcm.c
>>> @@ -1926,21 +1926,19 @@ static int bcm_release(struct socket *sock)
>>>       /* remove bcm_ops, timer, rx_unregister(), etc. */
>>> -    spin_lock(&bcm_notifier_lock);
>>> -    while (bcm_busy_notifier == bo) {
>>> -        spin_unlock(&bcm_notifier_lock);
>>> -        schedule_timeout_uninterruptible(1);
>>> -        spin_lock(&bcm_notifier_lock);
>>> -    }
>>> -    list_del(&bo->notifier);
>>> -    spin_unlock(&bcm_notifier_lock);
>>> -
>>> +    /* Remove the procfs entry and the tx_ops before taking RTNL:
>>> +     * remove_proc_entry() waits for concurrent readers of the entry 
>>> and
>>> +     * must not hold up RTNL for them. Clear bo->bcm_proc_read so that
>>> +     * bcm_notify() does not remove the entry a second time.
>>> +     */
>>>       lock_sock(sk);
>>>   #if IS_ENABLED(CONFIG_PROC_FS)
>>>       /* remove procfs entry */
>>> -    if (net->can.bcmproc_dir && bo->bcm_proc_read)
>>> +    if (net->can.bcmproc_dir && bo->bcm_proc_read) {
>>>           remove_proc_entry(bo->procname, net->can.bcmproc_dir);
>>> +        bo->bcm_proc_read = NULL;
>>> +    }
>>>   #endif /* CONFIG_PROC_FS */
>>
>> [Severity: Medium]
>> list_del(&bo->notifier) now runs after rtnl_lock(). That means this
>> first lock_sock() section runs while the socket is still on
>> bcm_notifier_list. Can a procfs reader still stall RTNL here, just
>> indirectly through the socket lock?
>>
>> Consider this interleaving:
>>
>> CPU1 (close)
>> bcm_release()
>>    lock_sock(sk)
>>    remove_proc_entry()
>>      proc_entry_rundown()
>>        wait_for_completion()      <- waits for the reader on CPU2
>>
>> CPU2 (reader of /proc/net/can-bcm/<ino>)
>> proc_reg_read()
>>    use_pde()
>>    pde_read()                     <- copy to a FUSE or userfaultfd
>>                                      backed buffer blocks
>>
>> CPU3 (NETDEV_UNREGISTER, RTNL held)
>> bcm_notifier()
>>    bcm_notify(bo, NETDEV_UNREGISTER, dev)
>>      lock_sock(sk)                <- blocks behind CPU1
>>
>> bcm_notify() takes lock_sock(sk) before it checks whether any op or the
>> binding uses dev. So deleting or moving any CAN device in the socket's
>> netns would be enough.
>>
>> Before this patch, the socket was unlinked first and the busy-wait made
>> sure bcm_notify() was not running for it, so this interleaving was not
>> possible.
>>
>> The procfs entry is mode 0644 and is created on any connect(), including
>> can_ifindex = 0. With unprivileged user namespaces, a vcan device in a
>> user-owned netns can trigger the notifier, and RTNL is global.
>>
>> Does this mean the commit message goal ("which could otherwise stall
>> RTNL from a plain close()") is only partly met?
>>
>> There are similar RTNL stall paths already. bcm_sendmsg() holds
>> lock_sock() across memcpy_from_msg() in bcm_tx_setup() and
>> bcm_rx_setup(), and bcm_notify() itself calls remove_proc_entry() under
>> RTNL. This particular ordering is new with this patch, though.
>>
>> [ ... ]
>>
>>> @@ -1948,6 +1946,21 @@ static int bcm_release(struct socket *sock)
>>>           bcm_remove_op(op);
>>>       }
>>> +    release_sock(sk);
>>> +
>>> +    rtnl_lock();
>>> +
>>> +    /* The netdev notifier chain runs under RTNL, so bcm_notifier() 
>>> can't
>>> +     * be walking bcm_notifier_list and point to this socket. The 
>>> spinlock
>>> +     * is still needed as bcm_init() adds sockets without holding RTNL.
>>> +     */
>>> +    spin_lock(&bcm_notifier_lock);
>>> +    WARN_ON_ONCE(bcm_busy_notifier == bo);
>>> +    list_del(&bo->notifier);
>>> +    spin_unlock(&bcm_notifier_lock);
>>> +
>>> +    lock_sock(sk);
>>> +
>>>       list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>>>           /*
>>>            * Don't care if we're bound or not (due to netdev problems)
>>
>> [Severity: Low]
>> This isn't a functional problem, but the comment a bit further down in
>> this rx_ops loop in bcm_release() still describes a concurrent
>> unregister:
>>
>>              * op->rx_reg_dev is a tracked reference taken
>>              * when the subscription was registered, so it
>>              * stays valid here even if a concurrent
>>              * NETDEV_UNREGISTER already unlisted the device.
>>
>> This loop now runs between rtnl_lock() and rtnl_unlock(), and the socket
>> stays on bcm_notifier_list until RTNL is taken. A NETDEV_UNREGISTER has
>> either already finished, in which case bcm_notify()->bcm_rx_unreg()
>> cleared op->rx_reg_dev, or it runs after this loop, when the socket is
>> no longer on the list.
>>
>> Can a concurrent NETDEV_UNREGISTER still happen at this point? The old
>> comment seems to contradict the new comment added above it.
>>
>> The same comment in bcm_delete_rx_op() is still accurate, because that
>> path does not hold RTNL. Should the copy in bcm_release() be updated?
>>
>>> @@ -1973,6 +1986,8 @@ static int bcm_release(struct socket *sock)
>>>       }
>>> +    rtnl_unlock();
>>> +
>>>       synchronize_rcu();
>>
>> [Severity: Medium]
>> The global rtnl_mutex is now held across the whole rx_ops
>> unregistration loop, and userspace decides how long that loop is. Is
>> that intended?
>>
>> bcm_rx_setup() allocates one op per distinct (can_id, ifindex) with
>> kzalloc(OPSIZ, GFP_KERNEL). That allocation is not memcg accounted, and
>> there is no per-socket limit. bcm_connect() accepts can_ifindex == 0
>> without any device, and ANYDEV ops register on the all-devices list
>> through:
>>
>>     err = can_rx_register(sock_net(sk), NULL, op->can_id,
>>
>> So an unprivileged user with no CAN hardware can create a very large
>> number of ops.
>>
>> On close(), each op calls can_rx_unregister(). That takes
>> spin_lock_bh(&net->can.rcvlists_lock) and walks the receiver hlist
>> linearly until it finds the match.
>>
>> A second socket can put M newer entries in front of the victim's
>> entries in the same bucket. It can do this with EFF ids that fold to
>> the same bucket in effhash(), or with the same SFF id. RTNL would then
>> be held for roughly K * M list steps.
>>
>> Before this patch, the same loop ran only under lock_sock(sk), so only
>> the closing task paid for it. Now it would block netlink and netdev
>> configuration in every network namespace.
>>
>> The loop without cond_resched() already existed, and the attacker needs
>> a lot of kernel memory. What is new is that RTNL covers the whole loop.
>>
> 
> 

