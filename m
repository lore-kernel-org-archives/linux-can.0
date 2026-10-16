Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299F448BAF;
	Fri, 16 Oct 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140836; cv=pass; b=OA9MAy7hYxMucS48JtPy7leHiXD5kXZsPm8Vpt3X1CGaaR6Uf+ILyu7iT+tEHeZhQPg+1mzWGd058kBzfRRaikWydeuVzd4Yl90qBc8KyzUptejvPy+Kb/x3Miw/e4mOERPRiKKYydHw6JIo2eLLf62A4J5OmfBTBMx9wMZVoSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140836; c=relaxed/simple;
	bh=3wPWHY63AvjS3DrC6i3SxSQskAQTqPqClCMRUm5t4V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4rCXJyPyikvPuJCtXJR2RSMID/7mISrm4mzxT+gTXSu/7/AlbTSIj09D6OG4oTlkxCf8N3A3tRLZLbiQs3d5ih6VV+PxhrOWWDSxA/DCZRp0SlofOYAZ58rsYkcQvw8XCdVjn/UklwPvUjcM2laIzjXKc1GKW2lJUdbJGXs5cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sOsRagb4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nFQ9euoW; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sOsRagb4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nFQ9euoW"
ARC-Seal: i=1; a=rsa-sha256; t=1792140695; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mwFg9U/0DIMcZRWh0Vap25tzaq5cSeVd8Dxw5jl3AfOpqDRflxq1gpNwPor0T8b0BT
    6JlKFcovB+7TzNiZsqnVN6M033VEyR0gfCvJ31yrQgxkS42IOejICFhdJZlp22oHn8wl
    lgTnwui5+Cny58HkEdCgfCQAWJCpRTPbe4wIEPLP0CDJR+V9m9x2o5KjVAGBjoCPYR1E
    S4LzP8hfa13F4mcZ8BdiBB/5sg9xXj8ASdD029QOliDo3fFtgEeGV15SodgjzDp5TFRf
    bIaWbMo61POk/WJYRriR1mtM/bQDZAkdLAwyikdaWZ12aiLNr3w9pHKba/AOkjxBwzeM
    e/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792140695;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vfi/EkoIJB8r9e+tAVZTNlXvcWxdjGlCci5n1/TcCjg=;
    b=m22Ax0Ug1rwRzpd8q8VAKgR5aPQxoKjvhc8EjfnUOjucLF43QdXbCYzN7XnSh2yi4a
    c674VsGmuH4T9KtTZ/5N9tjik8onaBeEzJNdkx+bFDQl70APWkVAK5obQU+AcT7WP15b
    05wYdV41v17yvPp6yPCieu1JbVHthl39luNQAmjsiOIQKO/VgKJUPq+uhzPQkiJRDvzb
    xx7Z2y47/uS4I95JZxwHsIOi2ejBDKeYjfc6P/rU5modHx1jJjGvjGUAuSLjPOtizfOi
    aFiTIa6zyptFOGLzNUaG+BedcKlyEwJ+wFn5v6sytaUJAfllQNcPembeOLbul36CdCQ5
    bHTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792140695;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vfi/EkoIJB8r9e+tAVZTNlXvcWxdjGlCci5n1/TcCjg=;
    b=sOsRagb4wuDZ0s1EGs4St7BLSOwkx4rLD11UL89zy/4jDTF1RnMlZQAHXvDw4hoX0c
    FF1ZkjXeMUj9YKlGSuPVACcZAeJLNN+UeIHpUy7zlZzpaGLKI9GJP9UnAjwdY0+jSXQv
    ThIR6ldMPJUSbywbVSa/qWY92rGNQC4Pp8l/w3v0iGToxXUibpT8Y1mzdYeIr1yNekS5
    j0XPw14LYUUgAkKNiLWoP/CrqVZ4USzEgMHUSQSd+9OM6Nzc2bl5rYLM6nRzp0b1Dm/p
    YCoVMTc/smwhO6oaIC9XRQrSJvlHGvrl9QqThhLqjO361BqQlbtSFkBG3SGoXY2chYBu
    kUlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792140695;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vfi/EkoIJB8r9e+tAVZTNlXvcWxdjGlCci5n1/TcCjg=;
    b=nFQ9euoWfSEvxU4qbhObChD4+Vohm+YXNhkQdNNS3rzAR/OSZgjJF4V8xgq7EaZZDm
    iAmEI7gaS0ioCg+xriCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29G8pYLCk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 10:51:34 +0200 (CEST)
Message-ID: <797e174d-cb77-47f8-b56e-c1cfcb1784e4@hartkopp.net>
Date: Fri, 16 Oct 2026 10:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/37] can: bcm: fix filter removal race between
 release and netns change
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be
References: <20261015015336.816543-9-mkl@pengutronix.de>
 <179211822523.434549.241636889494644724@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179211822523.434549.241636889494644724@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'm working on an update on this.

On 16.10.26 04:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit moves remove_proc_entry() ahead of rtnl_lock() so
>    that procfs readers cannot stall RTNL from close().
> - [Medium] bcm_release() now holds the global rtnl_mutex across the whole
>    rx_ops unregistration loop (rtnl_lock() at net/can/bcm.c:1951,…
> - [Low] Stale comment in bcm_release().
> 
> --
> 
> can: bcm: fix filter removal race between release and netns change
> 
> bcm_release() now takes rtnl_lock() before it removes the socket from
> bcm_notifier_list. It holds RTNL across the rx_ops unregistration, so
> bcm_release() and bcm_notify() can no longer both skip filter removal
> while the bound device moves to another netns. The bcm_busy_notifier
> busy-wait becomes a WARN_ON_ONCE(), and the procfs entry and tx_ops are
> now removed before RTNL is taken.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Link: https://patch.msgid.link/20261014142114.280279-3-socketcan@hartkopp.net
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 6759662e024c..301920011a30 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1926,21 +1926,19 @@ static int bcm_release(struct socket *sock)
>>   
>>   	/* remove bcm_ops, timer, rx_unregister(), etc. */
>>   
>> -	spin_lock(&bcm_notifier_lock);
>> -	while (bcm_busy_notifier == bo) {
>> -		spin_unlock(&bcm_notifier_lock);
>> -		schedule_timeout_uninterruptible(1);
>> -		spin_lock(&bcm_notifier_lock);
>> -	}
>> -	list_del(&bo->notifier);
>> -	spin_unlock(&bcm_notifier_lock);
>> -
>> +	/* Remove the procfs entry and the tx_ops before taking RTNL:
>> +	 * remove_proc_entry() waits for concurrent readers of the entry and
>> +	 * must not hold up RTNL for them. Clear bo->bcm_proc_read so that
>> +	 * bcm_notify() does not remove the entry a second time.
>> +	 */
>>   	lock_sock(sk);
>>   
>>   #if IS_ENABLED(CONFIG_PROC_FS)
>>   	/* remove procfs entry */
>> -	if (net->can.bcmproc_dir && bo->bcm_proc_read)
>> +	if (net->can.bcmproc_dir && bo->bcm_proc_read) {
>>   		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
>> +		bo->bcm_proc_read = NULL;
>> +	}
>>   #endif /* CONFIG_PROC_FS */
> 
> [Severity: Medium]
> list_del(&bo->notifier) now runs after rtnl_lock(). That means this
> first lock_sock() section runs while the socket is still on
> bcm_notifier_list. Can a procfs reader still stall RTNL here, just
> indirectly through the socket lock?
> 
> Consider this interleaving:
> 
> CPU1 (close)
> bcm_release()
>    lock_sock(sk)
>    remove_proc_entry()
>      proc_entry_rundown()
>        wait_for_completion()      <- waits for the reader on CPU2
> 
> CPU2 (reader of /proc/net/can-bcm/<ino>)
> proc_reg_read()
>    use_pde()
>    pde_read()                     <- copy to a FUSE or userfaultfd
>                                      backed buffer blocks
> 
> CPU3 (NETDEV_UNREGISTER, RTNL held)
> bcm_notifier()
>    bcm_notify(bo, NETDEV_UNREGISTER, dev)
>      lock_sock(sk)                <- blocks behind CPU1
> 
> bcm_notify() takes lock_sock(sk) before it checks whether any op or the
> binding uses dev. So deleting or moving any CAN device in the socket's
> netns would be enough.
> 
> Before this patch, the socket was unlinked first and the busy-wait made
> sure bcm_notify() was not running for it, so this interleaving was not
> possible.
> 
> The procfs entry is mode 0644 and is created on any connect(), including
> can_ifindex = 0. With unprivileged user namespaces, a vcan device in a
> user-owned netns can trigger the notifier, and RTNL is global.
> 
> Does this mean the commit message goal ("which could otherwise stall
> RTNL from a plain close()") is only partly met?
> 
> There are similar RTNL stall paths already. bcm_sendmsg() holds
> lock_sock() across memcpy_from_msg() in bcm_tx_setup() and
> bcm_rx_setup(), and bcm_notify() itself calls remove_proc_entry() under
> RTNL. This particular ordering is new with this patch, though.
> 
> [ ... ]
> 
>> @@ -1948,6 +1946,21 @@ static int bcm_release(struct socket *sock)
>>   		bcm_remove_op(op);
>>   	}
>>   
>> +	release_sock(sk);
>> +
>> +	rtnl_lock();
>> +
>> +	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
>> +	 * be walking bcm_notifier_list and point to this socket. The spinlock
>> +	 * is still needed as bcm_init() adds sockets without holding RTNL.
>> +	 */
>> +	spin_lock(&bcm_notifier_lock);
>> +	WARN_ON_ONCE(bcm_busy_notifier == bo);
>> +	list_del(&bo->notifier);
>> +	spin_unlock(&bcm_notifier_lock);
>> +
>> +	lock_sock(sk);
>> +
>>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>>   		/*
>>   		 * Don't care if we're bound or not (due to netdev problems)
> 
> [Severity: Low]
> This isn't a functional problem, but the comment a bit further down in
> this rx_ops loop in bcm_release() still describes a concurrent
> unregister:
> 
> 			 * op->rx_reg_dev is a tracked reference taken
> 			 * when the subscription was registered, so it
> 			 * stays valid here even if a concurrent
> 			 * NETDEV_UNREGISTER already unlisted the device.
> 
> This loop now runs between rtnl_lock() and rtnl_unlock(), and the socket
> stays on bcm_notifier_list until RTNL is taken. A NETDEV_UNREGISTER has
> either already finished, in which case bcm_notify()->bcm_rx_unreg()
> cleared op->rx_reg_dev, or it runs after this loop, when the socket is
> no longer on the list.
> 
> Can a concurrent NETDEV_UNREGISTER still happen at this point? The old
> comment seems to contradict the new comment added above it.
> 
> The same comment in bcm_delete_rx_op() is still accurate, because that
> path does not hold RTNL. Should the copy in bcm_release() be updated?
> 
>> @@ -1973,6 +1986,8 @@ static int bcm_release(struct socket *sock)
>>   
>>   	}
>>   
>> +	rtnl_unlock();
>> +
>>   	synchronize_rcu();
> 
> [Severity: Medium]
> The global rtnl_mutex is now held across the whole rx_ops
> unregistration loop, and userspace decides how long that loop is. Is
> that intended?
> 
> bcm_rx_setup() allocates one op per distinct (can_id, ifindex) with
> kzalloc(OPSIZ, GFP_KERNEL). That allocation is not memcg accounted, and
> there is no per-socket limit. bcm_connect() accepts can_ifindex == 0
> without any device, and ANYDEV ops register on the all-devices list
> through:
> 
> 	err = can_rx_register(sock_net(sk), NULL, op->can_id,
> 
> So an unprivileged user with no CAN hardware can create a very large
> number of ops.
> 
> On close(), each op calls can_rx_unregister(). That takes
> spin_lock_bh(&net->can.rcvlists_lock) and walks the receiver hlist
> linearly until it finds the match.
> 
> A second socket can put M newer entries in front of the victim's
> entries in the same bucket. It can do this with EFF ids that fold to
> the same bucket in effhash(), or with the same SFF id. RTNL would then
> be held for roughly K * M list steps.
> 
> Before this patch, the same loop ran only under lock_sock(sk), so only
> the closing task paid for it. Now it would block netlink and netdev
> configuration in every network namespace.
> 
> The loop without cond_resched() already existed, and the attacker needs
> a lot of kernel memory. What is new is that RTNL covers the whole loop.
> 

