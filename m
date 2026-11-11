Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410827;
	b=iWwKK4QGm54/tJInChRcff2t6Tna8ecavRAWXCdodHqG/EYSREXJTadTm441ty8881dp
	 lO19j0wLqG/zHtFqHqrK0z/YiGOxfrZX5qxNG9gGWutRxvgDCvPC5xMo+rtqJMl95q2pO
	 34aune1FQIIjGuHK3sVKidY0TKa4wYdMIIjIiUiXGXZZzx2tCaivBXdZrqh/unu8JpnaC
	 jy5SYOkxGYT4MKBn5M7U2LuJScEbxB7E9uqYPq+Umn66KjV0KiZqKBzsZuOckPF5EHMXy
	 Q3KqdrTknWTOKhCdxe7Ma9jf8u3PfFtGNnhvruRknuPeCxkhdbeB3sWEP7J5nJzrmoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410827;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3rEBDPxreqIhYe9UIZWQTsA9mfsasMlpsXL3qkZvYnE=;
	b=XrSIvmHB595aQJxATEZB5cN6QDsOpmrjt2eTCjfwzcK7OSuAkmGDYdtr+Yrk6zMdLwHs
	 HnRy0xK/6NvLxRMb5RfoxBcdaPTe5gPMLqDXYVJziG4wLo5pTp6qTHWiG4DT5QZev5kih
	 kF+U6RbxGHWcTOKnLk29EeXBrhfouysUhkXNEMqeShH4YgrIrb6rEuo8e2NU2KnjojlSg
	 bVSq+2ZYinxu4GHWyybUoSjWglHY/L0JazhFYpxWYmYLEKq3vd4MfbwEZ+vsbfQXOmEor
	 mXqmFGhAS/KDOS5CCctaBeu4Z/PHQ92k12FDXsm+ATDJ6yKomgC7KmaXOTxee+bd7Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="l/VROfi6";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uNMfQJ0q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AA606A334
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390AA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=l/VROfi6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uNMfQJ0q
ARC-Seal: i=1; a=rsa-sha256; t=1794410818; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iHWTGSBPCRwovmH80zBOy8TuM3fNs0F/hacm3oh6iWqpaabobwTXfACW4rPzhRiQkm
    jjBvMfZBpNJOPveHh55U3AgYK0c4DN2JyLf3UoYM3u+LcVDQSAZlPD3KT4vdIKusd0rO
    rwKCY+elJZ0/Jhww/BII1U4oMw8ny+0GlPjAI6tQfoTuM53h4tcSQC0eNu9ksp5O+6i0
    wDb+fUjXpy17i6LGquCApQ2xoKmiplMfD6XZuNB90aim3ok4PP5PcasQOst9zhBnfuTs
    35EMb7W9Oqg5fqiogq09jOJ8NLopnCPrDu1CklGV20BzD5j/oNk2n/MzmDUqDB4WcQJB
    iKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410818;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3rEBDPxreqIhYe9UIZWQTsA9mfsasMlpsXL3qkZvYnE=;
    b=pDPxjhyzYwF3Ra8iYCL9OPQ/zutc1HMwECaM1cT7JcufhW9eZ74Adkk9HD7WdPnD5L
    fJEl50BEilq7sTTRw3QMcZH1EPCYHyqvEfmyL77TFINAFV2Fxp9yOfoBFOhxXzUuCkte
    dQ+dOHpBQosbcJ4HQ7VJvMKebCTwAj43ooQLvsHgYyzr3MdpPGm7w9cUl7j2lUS9mBp3
    GotFBdAVTWboAwLwuYB5qnnnaMQOYMMSZy5OoPEcD9tBk97wmKiCVnBDrGMnYj7nan8w
    /oDWK+kH19LQ38IT5yroFaHgJ6CJYxCfLvONTLP4nWLYKqb8LQIGAVnW1rXid3HmkU01
    Q+Yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410818;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3rEBDPxreqIhYe9UIZWQTsA9mfsasMlpsXL3qkZvYnE=;
    b=l/VROfi6voZPeXJ+kjIVrkD5Gnj+hU9U/HcHuhi9lK+0hLnUhYFVteebqJuknZZb/g
    jeacc2k9tfD5F2RMpZ6fkZDu6QoHIHJsN0BOyXNgYos7SBKNJ6I+vvC5wXwWTvc+cFwN
    g/7o6e6qe6DKN/N47mtomQP/X1CrhE8vG2eVDrzyWlR8hzcR05YXSEx7e92atzH9GAt0
    FTihK3Vrc50xdkxOWRL1z+/kkjuW2BCKJpbREgfixty0U1a1QKjER0ITf2HOFwAlrEhp
    CtjAfZHssSeGphof6E/FbPeU3mqk5M18aGCOPikeH0GBMqD4x4MFk3zzulWNDQcQRQNI
    75Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410818;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3rEBDPxreqIhYe9UIZWQTsA9mfsasMlpsXL3qkZvYnE=;
    b=uNMfQJ0qlPvPkVevIA1H7djjUnAsJ8VsZ0W6yYHsVyXk2Eq/QaagudeJgOmv1CiW53
    Rj693uqnukbEphTayRBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFQw9N9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:26:58 +0100 (CET)
Message-ID: <b5e5018f-c985-4dc9-8d5a-1f9e14adfcd6@hartkopp.net>
Date: Wed, 11 Nov 2026 16:26:52 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] can: bcm: copy the CAN frames outside of
 lock_sock()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261109-can-bcmlock-memcg-v3-1-2d798ca30578@hartkopp.net>
 <179440250969.488853.8384338061112608293@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179440250969.488853.8384338061112608293@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.26 14:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch does not fully fix the problem its commit message
>    describes.
> 
> --
> 
> can: bcm: copy the CAN frames outside of lock_sock()
> 
> This patch moves the user space copies of the CAN frames for TX_SETUP,
> RX_SETUP and TX_SEND in bcm_sendmsg() so they happen before lock_sock().
> The frames are then handed to the opcode handlers through a kvec based
> msghdr. The goal is that a stalled copy can no longer hold the socket lock
> while bcm_notify() waits for it under RTNL.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 7bd2aa39777af..3f4c8d8283376 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	if ((size - MHSIZ) % cfsiz)
>>   		return -EINVAL;
>>   
>> +	/* Copy the CAN frames from user space before lock_sock(), so a
>> +	 * stalled copy can not block bcm_notify() waiting for lock_sock()
>> +	 * under RTNL. Only the frames the opcode handler reads are copied.
>> +	 * The handlers keep their checks and read the frames from fmsg.
>> +	 */
> 
> [Severity: High]
> Does this fully close the RTNL stall described in the commit message?
> 
> bcm_notify() still sleeps on the socket lock of every CAN_BCM socket in
> the netns while it holds RTNL:

Yes. This is changed by introducing a per-socket mutex in v4 which 
removes the rtnl dependency:

https://lore.kernel.org/linux-can/20261111-can-bcmlock-memcg-v4-5-5428607a608f@hartkopp.net/

> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }

pw-bot: cr

> 
> A CAN_BCM socket also goes through the generic SOL_SOCKET handling. Some
> of those options access user memory while holding the same lock:
> 
> sk_setsockopt()
>    sockopt_lock_sock(sk)    /* lock_sock() outside BPF context */
>    case SO_ATTACH_FILTER:
>      copy_bpf_fprog_from_user()
>      sk_attach_filter()
>        __get_filter()
>          copy_from_user(prog->insns, fprog->filter, fsize)
> 
> SO_ATTACH_REUSEPORT_CBPF and SO_ATTACH_BPF also copy from user memory
> under this lock. getsockopt(SO_GET_FILTER) reaches sk_get_filter(), which
> calls copy_to_sockptr() into user memory under sockopt_lock_sock(sk).
> 
> So an unprivileged user could open a CAN_BCM socket and call
> setsockopt(SO_ATTACH_FILTER) with fprog.filter pointing at a FUSE backed
> mapping whose read never completes. If a vcan device in that user and
> network namespace is then deleted, the RTNL holder blocks in
> bcm_notifier()->bcm_notify()->lock_sock() for as long as the copy stalls.
> The commit message uses this same scenario as its motivation.
> 
> The commit message says the SOL_SOCKET paths are not addressed. The new
> comment here, though, says a stalled copy can not block bcm_notify(). That
> is only true for the copies in bcm_sendmsg().
> 
> Would it be more robust to change bcm_notify() itself rather than each
> copy path? For example, it could avoid sleeping on lock_sock() under RTNL
> by deferring the per-socket teardown to a work item. Another option is to
> protect bo->bound, bo->ifindex and the op lists with a BCM private lock
> that is never held across user access.
> 
> The later patches in this series ("can: bcm: do not remove the procfs
> entry in bcm_notify()" and "can: enable memcg accounting for user
> triggered allocations") do not seem to change this. At the end of the
> series, bcm_notify() still calls lock_sock(sk) under RTNL.
> 
>> +	switch (msg_head.opcode) {
>> +	case TX_SETUP:
> 
> [ ... ]
> 

