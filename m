Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795370148;
	b=p7rVgWpVROhv1VVCtY6b0BP9UwQn265DFesetCOFG7lBbTVw+s6WuOh/nTVluiX4JOwk
	 cZlMJbekmtAaC/3OTSPDhFX3BfZvZBcPPF7BG0ZDNPFCC1PCah5v1FyDy5IpkbDs+7I3c
	 J7qzoQc3E1Dqg+m8+WWmVHWhboDll14ih2pib/LFt5v/ACW+jVMyIAU4AOFiH8EklItqD
	 frKz+vnIdqkjkksDe8/sZd9YIBIzJvXNros1BF6x9SBqmH9OA9IvEp6alvdhUmpzt/DZ0
	 Y53w1LtVGwpaDacQXtZMZpfXGMS3V7tfX+8sPzwxB+o3uAoRFLUJqq/dWchL9bJEUtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370148;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lq0rquKkiRklAE+L61TYg6uS7ijuVarNH5crdrXRbEU=;
	b=wSKWtXMN7tnCpV57eHgFY19HQ1cDVg9RgfPcvtbva6RS6RnrpJV3YCiiTWeFiYCJV930
	 fGvxGiEUWTi8bTLYNIG7ie29K2SFwx7jysm3lTFA6JbiSfHphuD4dcx4fs8ttD9Y6oCoI
	 dNCf0UonKo/eA/LLysUXfcbHe7LuJSvmdl5nLDdDNl4DI0fUFx8GbGs45utDoVspB8gel
	 by2v0ZbBI/z5Ac4QVpxsKPqhcMgndoqxU0ZRk/FIw+PpLpGH+lpHsJ39XcwAkOCvmM6vo
	 g6AbFmJYMTArxBjXKRFNpvxwCm1Cmfo4tTTQimixgnIwcUJthaC6Q6oUi4L2u4f7jTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LrR9jLF6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=yb6OpCu7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C622606A332
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 17:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C622606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LrR9jLF6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=yb6OpCu7
ARC-Seal: i=1; a=rsa-sha256; t=1795370135; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PuytN4PNR04kbBsj5w5D5a+0AoVKQGttwV+qRlMvwQKIiPpWG8Yfh78urTqvXsK+cK
    iDyGLYnfU9fXbEYjqaia015BN4/465iatyxIX8a7oQPBWwkXy1FOfh4UR1lRE/mRNyX7
    1sPmxJgPvKEi+Wt3z/eB8uQTRspbm1CZHTuG7qomQLEtoHjAdaa59JXUF1Zhq8ss0OBT
    AbkL30GHOudSK9j1AszwEc9IYWrPSXoKU7g0KPgwSNAFIqw71CVmkA8Tw7lhlojrzaGc
    wDv6sew3QZ/FbHrhMh+Kq8DYfsfKRNt+SHsn1i9fqOmPpzdDhQIePdZ/YJZpxS54Zz9n
    KUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795370135;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lq0rquKkiRklAE+L61TYg6uS7ijuVarNH5crdrXRbEU=;
    b=RcRO74wPjS8Dqbm8YZnTe3iZXTLyvHCxYlfFAvXvkdppRRaseE2PvUbWpaTHBU0iSq
    oIVfAfeCrdl7sT6Am8srM1dXw2OuBuR5/4PssJLq3PHg+hHWk5nvkbKfeELALlWq0hQK
    AsaYxc0kXzbXIT+BsQjlnhvmLkZE9KQXYSx3aryi6b8CcC+Qy735NNbhRFBqzFd1RGh4
    2xWVprSJzS4PpnDD+/PtwrkuXg+EPinYlljHLEAa71IzlbiBUemfNtShQnyAUqt59D9r
    oAWo6p1YwcBaXCycFQEO9wVK6hRnpUn8A5KahZzbKtzzEIncPoVxq2zllXQ864ttIi7c
    wJzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795370135;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lq0rquKkiRklAE+L61TYg6uS7ijuVarNH5crdrXRbEU=;
    b=LrR9jLF6nuseHnMkp9t0RGhdmlA6f140/C3WPu992zBJc2EpL5atOvNOQTzn/FuqCt
    fxvGhBiHlyWNF2JqYE7wsitc7NyfJSnM4NtCwj/8SxKEAXHMYrHLX7U/jS5b5HyF9pUT
    hzgLP7ZueDnOzJ3ozeZWOe0Y/6nKLvaspxuOjyMSbbx+miO/c7Ka2FDBzHUqO7wZyic0
    8v+2iHYE6hN+izD7/O9uFfwA9zn6GrqjPF3z6KmCBAktIXmGLpJigp1fq/X735zYYztw
    OfkMJhlmiWuV1s4/cpl973M8725W8yy5kTLSNF6VPbfZECbBTdzfSSC5fUQ3S0B4v6Mw
    35iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795370135;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Lq0rquKkiRklAE+L61TYg6uS7ijuVarNH5crdrXRbEU=;
    b=yb6OpCu7wH6KLWial00BqZpXDJeVVWcKWX1QvmnmCwY172JLeJohAGXBCsjxl+qNsx
    c1yVjmgD0bLbH6yMCJAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AMHtZYdx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 22 Nov 2026 18:55:35 +0100 (CET)
Message-ID: <acaa73da-1884-4898-9296-27a9987fb6d4@hartkopp.net>
Date: Sun, 22 Nov 2026 18:55:35 +0100
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
Subject: Re: [PATCH v7 5/8] can: bcm: use a private mutex instead of
 lock_sock()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
References: <20261120-can-bcmlock-memcg-v7-5-f6b84f5257b1@hartkopp.net>
 <179531304802.3131.12745921065969332467@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179531304802.3131.12745921065969332467@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.11.26 03:04, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The stable dependency note "Cc: stable@vger.kernel.org # depends
>    on \"can: bcm: copy the CAN frames outside of lock_sock()\"" is…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but CAN_J1939 has
>    the same RTNL-stall pattern that this series removes from CAN_RAW,…
> 
> --
> 
> can: bcm: use a private mutex instead of lock_sock()
> 
> This patch replaces lock_sock() in CAN_BCM with a private conf_lock mutex
> in struct bcm_sock. The generic SOL_SOCKET options access user space under
> the socket lock, and with this change they can no longer stall bcm_notify()
> while it holds RTNL. bcm_release() now removes the procfs entry before it
> takes the new mutex.
> 
>> Cc: stable@vger.kernel.org # depends on "can: bcm: copy the CAN frames outside of lock_sock()"
> 
> [Severity: Low]
> Is this dependency note complete? The patch also seems to depend on "can:
> bcm: do not remove the procfs entry in bcm_notify()", which comes earlier
> in the same series.
> 

Yes, this patch depends on both previous CAN_BCM patches of this series.
As both are tagged for stable as well and come first in the series, they
are applied in this order anyway. I will name both prerequisites if
there is a respin.

> That commit turned the plain bo->ifindex = 0 assignments into WRITE_ONCE().
> This patch uses the new lines as context, for example in bcm_release():
> 
> 		WRITE_ONCE(bo->ifindex, 0);
> 	}
> 
> +	mutex_unlock(&bo->conf_lock);
> 
> If only the listed prerequisite is applied, this patch will not apply
> cleanly.
> 
> The dependency is also functional. The commit message says bcm_release()
> removes the procfs entry before taking the mutex. That assumes the entry
> is only ever removed in release.
> 
> Without the prerequisite, bcm_notify() still calls remove_proc_entry()
> inside the NETDEV_UNREGISTER section. With this patch, that call would run
> under conf_lock with RTNL held. If a backport is resolved by hand, the
> RTNL stall would remain through a procfs reader stuck in copy_to_user().
> 
> The prerequisite has its own Cc: stable tag and comes first in the series,
> so applying the series in order works. Could the "# depends on" note list
> it too?
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 1595b7720c981..dc9e2890490ac 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1843,7 +1844,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>>   	switch (msg) {
>>   
>>   	case NETDEV_UNREGISTER:
>> -		lock_sock(sk);
>> +		mutex_lock(&bo->conf_lock);
>>   
>>   		/* rx_ops: remove device specific receive entries */
>>   		list_for_each_entry(op, &bo->rx_ops, list) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but CAN_J1939 seems to have the
> same RTNL stall that this series removes from CAN_RAW, CAN_ISOTP and
> CAN_BCM.
> 

Right. This is a known issue and mentioned in the cover letter. 
CAN_J1939 will be addressed in a separate series.

Best regards,
Oliver

> On NETDEV_UNREGISTER, the j1939 notifier runs with RTNL held and takes the
> socket lock of every bound socket:
> 
> j1939_netdev_notify()
>    j1939_sk_netdev_event_unregister()
> 
> net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
>      ...
> 		lock_sock(sk);
> 		if (jsk->state & J1939_SOCK_BOUND) {
>      ...
> }
> 
> So if a task holds the socket lock of a bound j1939 socket while it
> accesses user memory, it can block RTNL. There appear to be two such
> paths.
> 
> The first is the generic SOL_SOCKET options. For example, SO_ATTACH_FILTER
> in sk_setsockopt() copies the filter from user space under
> sockopt_lock_sock():
> 
> net/core/sock.c:sk_setsockopt() {
>      ...
> 		ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
> 		if (!ret)
> 			ret = sk_attach_filter(&fprog, sk);
>      ...
> }
> 
> The second is j1939_sk_sendmsg(). It holds lock_sock() across
> j1939_sk_send_loop(), which copies the payload from user space:
> 
> net/can/j1939/socket.c:j1939_sk_sendmsg() {
> 	lock_sock(sock->sk);
>      ...
> 	ret = j1939_sk_send_loop(priv, sk, msg, size);
> 
> sendmsg_done:
> 	release_sock(sock->sk);
> }
> 
> If the user buffer is on a FUSE backed mapping, either copy can stall for
> as long as the user wants.
> 
> can_create() has no capability check. A user can create a vcan device in
> their own user and network namespace, bind a j1939 socket to it, stall one
> of these copies, and then delete the vcan device. RTNL would then be held
> until the copy finishes.
> 
> None of the commit messages in the series mention j1939. Should CAN_J1939
> get the same conversion, or should the series say that it is still
> affected?
> 
> [ ... ]
> 

