Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624940D579
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077602; cv=pass; b=c2Tv/hj6Ya5wNTk2bOMsNYFNh7hscCIm/1j8dcxXf5EQeOnbhv6Gfsw4oTGkTKcK1ifDaV1hIcFNp6ByLOdwJGFC2r0tpdPr6rydvge7VD1qgLRWuCAVm+aBhBVJpC05XfXjcsthl9oLvl3LbtUK934ct9XPM4RurdLFjXlWEz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077602; c=relaxed/simple;
	bh=o7FURnSktLhHtEfqsY9K1anzDJIfOBZs8bi+OH29um4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVFWwYFb1KlhIudpZCbj/v431LhVydkRKYtl+zdq06aoGOzU3y7xK9fj5zrQM8DBksDkvCeKEd/p6cAwzROuuV6NfiYeXsx0nLi4CpUgH0mPqtdBFxvf63Po8CrPaBd3h4Fubssw/mf48PYU7EilBFEbHelt7/zpv5aHi/m6IGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pVKY3l0f; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6BP2pCkQ; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pVKY3l0f";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6BP2pCkQ"
ARC-Seal: i=1; a=rsa-sha256; t=1781076872; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ma5YKUeH+73cPEw7wyxIeRVxhUnvdi75E9oCQR92wLahdQpNjU2eorGXKtYTOmVGx3
    OUAZkuqI9vrZ18x13Ko6s+Trq8JDVJJN/cjsIISHQ1A/WO4S2Ns863H8WkpcyCm9e5Ll
    9jsqzDUzQgBNMJSb5JxZICUO4bpmQaUFmMCgAh8QvZR1snlk5BA9PqxsTD6xgjK6qQgI
    0zBjRXB1uNrMpXu6/X0C+0LEJoTHnum1EOLmvRl9ZJ0k4mECZaMNAYvB0X+i1eNFs4R1
    3usDysnfY4B7BESG3WGIe5ay07bYFlFVLJ3RLNFAV6idg8zPbmJ8s+K6ZSRspcJzAEDc
    I06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076872;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FbmbWX4P52oBfXTOG1yQekYMpshcDC+1bZt9a+Lkt84=;
    b=d3kS63bdCkkQzeSaOvtS+MzrhDOJ8WoAi8p4BirpOsWTZKVRjaxBPwhNCRFuU8J6u9
    fjBt1h8iyQ3LOknp9VZwTTyYbPl1TpOFFsFa+C3Jkw5NbwjuQLaNJ8+rzZVV7lt2ljvp
    7sFWuufSwK8oAaKCa1hTXYPocheq/ltIjjVJxUneLZfXOIN9KdsJdhJXNbyXz/MdkQ7T
    +C9fYYiIUM9Nqc+F6B8jZavXQ5b8mbuDcqKZCz09emTK9YhtEAfNZ/Ng9EBXMcDc206V
    +A0KeSXuGzljrBACJOqb8EX5E0JWO7P32rfN5DbEHzCtooUBvMc7wFiuQPNS0xn+HFu8
    pKKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076872;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FbmbWX4P52oBfXTOG1yQekYMpshcDC+1bZt9a+Lkt84=;
    b=pVKY3l0fPE/c8Z0FmCQC1KZXW9+n1BW3vjorvClfMu3rLOSwJQbV1mUPhwSVaO8/bE
    iKvQ7rHYcIvm44qax/x1tggf0ceQWP3gMOQlpipqaRQRMrradvo/ZmsvUk0eX/Q9pnU1
    /o53NyHsuWdYagtwQaIF0Ik584wPkVh2ZlqzGKK9r5jVeB7ZRTNcyM8ULCciP/T9tGt7
    UhCnZ2Fe3tRHMrGN0wJ22SBGd073pQIkEgjyUNNzo6LYHPYgnOnUPwbRVHOiSQrG8lo7
    tj70/8MVsgckNCrnrXTFm0lakLJZHhFLq+XPMr1I4AXQw9d/HaeZApztgnh2qjsFCljn
    kPxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781076872;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FbmbWX4P52oBfXTOG1yQekYMpshcDC+1bZt9a+Lkt84=;
    b=6BP2pCkQV0ro4AeP89oJoz4aNKvqAPgZYD4ss/M8GKZqDIDep8jFVniJa5N7uCf3Wn
    rNtgm4TXJ+4OQxw9UUBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25A7YWhJr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 09:34:32 +0200 (CEST)
Message-ID: <4345af11-bf74-4e19-9ded-174a7fa8be02@hartkopp.net>
Date: Wed, 10 Jun 2026 09:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next] can: bcm: mark intentional lockless read of
 bo->bound for KCSAN
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <20260601181915.71862-1-socketcan@hartkopp.net>
 <20260609185138.E76CE1F00893@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260609185138.E76CE1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.06.26 20:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless TOCTOU race in bcm_sendmsg() leads to unintended Global CAN Filter Leak.
> --
> 
> commit 7f7ce41fd35425d40c8342127156c8195ff2363e
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: mark intentional lockless read of bo->bound for KCSAN
> 
> The commit marks the lockless read of bo->bound in bcm_sendmsg() and the
> corresponding write in bcm_notify() with READ_ONCE() and WRITE_ONCE() to
> resolve KCSAN warnings. It asserts this lockless read is functionally safe
> and will safely drop downstream operations.
> 
> Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
> 
>> Once the lock is acquired, any subsequent attempts to configure BCM
>> jobs (like RX_SETUP) will safely fail because bcm_notify() has
>> already cleared bo->ifindex to 0. While a user-defined ifindex of 0
>> is normally a valid feature to listen on "all" CAN interfaces,
>> bcm_notify() only triggers for specific real CAN devices. In this
>> unregister context, the combination of bound=0 and ifindex=0 effectively
>> invalidates the socket binding. This prevents the registration of
>> stale CAN filters and drops downstream operations safely without any
>> memory corruption or stale state exploitation.
> 
> [Severity: High]
> Is this description accurate regarding safely failing and preventing the
> registration of stale CAN filters?
> 
> This is a pre-existing issue, but if bcm_notify() unregisters the device
> concurrently, couldn't a race occur where bcm_sendmsg() caches ifindex == 0
> while still observing bo->bound == 1?

No. bcm_notify() can only be invoked for real interfaces which have an 
ifindex > 0

> 
> Since bo->ifindex is a plain read at the top of bcm_sendmsg(), the compiler
> can defer it until after the volatile read of bo->bound and the potentially
> sleeping memcpy_from_msg().
> 
> If this happens, bcm_sendmsg() could observe bo->bound == 1, but cache
> bo->ifindex == 0.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index fd9fa072881e2..6c93c57212b49 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1379,7 +1379,8 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	int cfsiz;
>>   	int ret; /* read bytes or error codes as return value */
>>   
>> -	if (!bo->bound)
>> +	/* Lockless fast-path check for bound socket */
>> +	if (!READ_ONCE(bo->bound))
>>   		return -ENOTCONN;
>>   
>>   	/* check for valid message length from userspace */
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't bcm_sendmsg() then
> pass the cached ifindex == 0 to bcm_rx_setup() under the socket lock?
> 
> net/can/bcm.c:bcm_sendmsg() {
>      ...
>      lock_sock(sk);
> 
>      switch (msg_head.opcode) {
>      ...
>      case RX_SETUP:
>          ret = bcm_rx_setup(&msg_head, msg, ifindex, sk);
>          break;
>      ...
> }
> 
> Does bcm_rx_setup() ever re-validate bo->bound while holding the lock?
> 
> If it doesn't, wouldn't bcm_rx_setup() interpret ifindex == 0 as an explicit
> request to listen on all CAN interfaces?
> 
> net/can/bcm.c:bcm_rx_setup() {
>      ...
>      } else
>          err = can_rx_register(sock_net(sk), NULL, op->can_id,
>                                REGMASK(op->can_id),
>                                bcm_rx_handler, op, "bcm", sk);
>      ...
> }
> 
> Could this actively register a global filter on an unbound socket, leaking
> traffic from all CAN buses into a process that was only authorized to
> monitor a specific, now-deleted interface?
> 

