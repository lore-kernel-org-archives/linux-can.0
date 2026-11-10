Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794298821;
	b=eRR8vsZZw9ODZcOMoUC67fRq32x4c23qPXxWfAYkFJfOMs4sCcNROAtDZ85895/epGdq
	 2eZ7DuxjLrEcmpEgWH/KMp2YXZjzG9kZ5ZGeUecO0dl/PjDsJ4tiEgBGl6l1Pvj8AqqB4
	 4yAKHt0NoHfPYmU5JKwUvOZInbfovOIJmWHV+GTY+wOwFoTTWI45tMcZ3T+Mpkl/U/FYU
	 iWgLlb09u2A0s/3RAC8/77uwn363CrNAdSLFvDO5w1RWR4sxSTXHJt4udpsfGgk5Kn4ys
	 OtIPPSwFo3E3e/hKe49woeBCL66fVlNsROqTx/Rl7Jf7SSZ9MKAXCjw/5WqEw/kTRdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298821;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bDQzzHO9VqFtCAL00LSoPOvY9cYkmE0SfpK298qffE4=;
	b=Uz+aVnJZLRHqcfdevrnNOxnZ5Kd605iSEYNTRbajrgrfkK6KB0he9I6vfXr/5kf3VrH1
	 oy1rH/KdSJ8sjptwo9de0fqng5SUYu0K1uY5PUY+HwGy8OIHXQ5Yze1qljd7ZxuU3CDS0
	 JAlAb0M2HcHlIziN50ErddjtDGCDclhs5LjX8GNzQXtYoAuL1f2QqaWHi3nVXk1ZADVwJ
	 +ghJvt4T4EoEzTDpVBf5EYpPnAV3afeePhmlVitReWaRb+DyX0iNotoA44S+M65+GOjZG
	 TUIyBNzPOf6dCpWUbgNAQPoXttYHn7GDg/rwFqBtdRdMdNsJp5QDvO+KBVzVrcaQGwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h+ylEJaq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dU3CcJ4f;
	arc=fail smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCB606A33F
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 08:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ACCB606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h+ylEJaq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dU3CcJ4f
ARC-Seal: i=1; a=rsa-sha256; t=1794298814; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HI6mwod5QcDFl28CflM44zvBXMP6KpiETp1BQx0u1z1YaFqMbt9Ovi6T8qWEuYokxc
    U8V8DXf8ICPdT3giV6aK3HfjAu8H8XRX4iYi55wkWGYBf7PJ3NhYskJuUYKvIyLAEQsK
    e7r809AoP0qPtWEvJ3gGQ2tp/LmGdfF+PavRRgBmBWbTahik5EKMY7t1l+LbcJJ5q0NM
    4vyoP1njtW0VGFC48D1fMN8HVoRXQIb6Ef2IlwwIrRn2NsJRfugPELfFD4OokphIIEIF
    qLQOfgbPdRthrT92olU0neTVl55NVe8uGA/Ds1Uf/gJzrfIk81Ob7q2NBRy0f/W3eHbr
    1a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794298814;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bDQzzHO9VqFtCAL00LSoPOvY9cYkmE0SfpK298qffE4=;
    b=XTSXVWy0LlOMiN4Vcplv7P+yLy3YSuXYAtq3NPYf+rndQWPJFUOirza5J+LX0RJOgu
    6BMLgic3xRDhqvtbuje4V83xvPGF6hw2FWZ5YV5sEeOReUzRHEimvgQLPYrdGpYggSGP
    mVX3PNstmYlvqyrDR1FrmzGwZsQYMRnwJCOJUd9tkXQvK9Gr8BzJFo/JTKlV/CZZU/t5
    yz/xJvPgBPSapXecs6ZWHiVym+To6tIapJXJNC74Ns+VuZQe+JKklM8tLx+NTkhiR9n7
    hVupJNwj8zYw6BlWJiGH2+QmMW2+Gxf6wRtrTni4yUtFwOFF01o75asoXaUA7uguNJDV
    oTiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794298814;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bDQzzHO9VqFtCAL00LSoPOvY9cYkmE0SfpK298qffE4=;
    b=h+ylEJaqQdHasNOejxUEmHPX2jkzwU1P7tRrsyR6ticqydDsfi+sHsH7TUaC9wZ5uY
    WAK85QIeXeL5r/CdgMi8Ez5xKG2k3xnn2mrgGju138zDEA7WfJfKkFXbx5b1ZoajJEaD
    AcVCuIXFtGuvzA3BeSPzkj0D4t0wt/08Yv+x7zfhpMIbqtiyTLvVV6F8jNOSAxsF8v2m
    QLlAMcGJlkoInQsAjB/2f5q/P9PcWVTAWGuvmyFdLfS+t4qAOvlWYVpVVgAKqVcEDP7u
    vihuMsX4t7Fx5HxYZXGW9o6sbWtoF4sWG/aLsWVbtY0ekNJQSJ7MZHokDQ3lkc6R4e7F
    agTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794298814;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bDQzzHO9VqFtCAL00LSoPOvY9cYkmE0SfpK298qffE4=;
    b=dU3CcJ4fQiAko7Jfs7Dvp2qX6bQaE1B30mWJ0j4Lf5uP1pd5tmkiIZo2+4yzYAzCsI
    T+WANc3HqEcrJJ12EBAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AA8KExzG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 09:20:14 +0100 (CET)
Message-ID: <86c39dea-fb15-4228-8e8d-3ae47f8dcad5@hartkopp.net>
Date: Tue, 10 Nov 2026 09:20:06 +0100
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
Subject: Re: [PATCH v2 1/3] can: bcm: copy the CAN frames outside of
 lock_sock()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261108-can-bcmlock-memcg-v2-1-19fafdfc9d12@hartkopp.net>
 <179428891717.488853.3748927072022061221@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179428891717.488853.3748927072022061221@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.11.26 06:35, netdev-bot+sashiko@kernel.org wrote:
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
> - [High] The patch is an incomplete fix: an unprivileged user can still
>    block RTNL through a stalled user-space copy made while a CAN_BCM…
> 
> --
> 
> can: bcm: copy the CAN frames outside of lock_sock()
> 
> This patch moves the user space copy of the CAN frames for TX_SETUP,
> RX_SETUP and TX_SEND in bcm_sendmsg() so it happens before lock_sock().
> The frames go into a stack or kvmalloc() buffer and are passed to the
> opcode handlers through a kvec based msghdr. The aim is that a stalled
> copy can no longer block bcm_notify(), which waits for lock_sock() while
> holding RTNL.
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
> 
> Does this fully close the RTNL stall the commit message describes for
> CAN_BCM sockets?
> 
> bcm_notify() still takes lock_sock() under RTNL for every CAN_BCM socket
> in the netns, bound or not:
> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }
> 
> CAN_BCM does not set SOCK_CUSTOM_SOCKOPT. So the generic SOL_SOCKET
> paths still read and write user memory on a CAN_BCM socket while holding
> that same lock:
> 
> setsockopt(SOL_SOCKET, SO_ATTACH_FILTER)
>    sk_setsockopt()
>      sockopt_lock_sock(sk)
>      copy_bpf_fprog_from_user()
>      sk_attach_filter()
>        __get_filter()
>          copy_from_user(prog->insns, fprog->filter, fsize)
> 
> getsockopt(SOL_SOCKET, SO_GET_FILTER)
>    sk_get_filter()
>      sockopt_lock_sock(sk)
>      copy_to_sockptr(optval, fprog->filter, ...)
> 
> Suppose fprog.filter points into a FUSE backed mapping whose daemon never
> answers. The copy_from_user() then sleeps with sk_lock owned. If a vcan
> device in the same unprivileged user and net namespace is removed at the
> same time:
> 
> rtnl_lock()
> unregister_netdevice()
>    bcm_notifier()
>      bcm_notify()
>        lock_sock(sk)    <- waits for the stalled setsockopt()
> 
> RTNL then stays held for as long as the FUSE daemon chooses.
> 
> The commit message acknowledges this:
> 
>    "The generic SOL_SOCKET options in sk_setsockopt() and sk_getsockopt(),
>    e.g. SO_ATTACH_FILTER, still access user space under the socket lock.
>    This is not specific to CAN_BCM and not addressed by this patch."
> 
> raw_notify() and isotp_notify() also take lock_sock() under RTNL. They do
> so only for sockets bound to the device that is going away. bcm_notify()
> does it for every CAN_BCM socket in the netns. So the same unprivileged
> RTNL stall still seems reachable on CAN_BCM sockets after this patch,
> which is marked for stable.
> 
> Would it be better to stop bcm_notify(), and possibly the other CAN
> notifiers, from sleeping on lock_sock() under RTNL? Another option is to
> do the user copies in the core SOL_SOCKET filter paths before the socket
> lock is taken.
> 

Yes, that is the right direction. The generic SOL_SOCKET options copy
user data under sockopt_lock_sock(), not only for SO_ATTACH_FILTER but
e.g. also for SO_LINGER or SO_TXTIME. In the unprivileged scenario the
namespace only contains the attacker's sockets, so restricting
bcm_notify() to related sockets would not help either. Other protocols
like PPPoE (pppoe_flush_dev()) have the same pattern.

The CAN protocols only use lock_sock() to serialize their own state and
do not use the socket backlog. With the recent fixes the CAN specific
user space copies are done outside of the lock. So a socket specific
mutex that replaces lock_sock() could decouple the CAN notifiers from
the generic socket lock. I will look into this for can-next.

This patch removes the CAN_BCM specific copies under lock_sock() and
stays a fix on its own.

>> +	switch (msg_head.opcode) {
>> +	case TX_SETUP:
>> +		if (msg_head.nframes >= 1 && msg_head.nframes <= MAX_NFRAMES)
>> +			flen = msg_head.nframes * cfsiz;
>> +		break;
> 
> [ ... ]
> 

