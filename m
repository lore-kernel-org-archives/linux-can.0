Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B951AFFF;
	Fri, 16 Oct 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168121; cv=pass; b=i2UviBDzniTDcHIwVHriyBSWMHgd+bz83i4GUzuAIFkxA0KrLWw+cc2vCXpFYkBgDXjpFW5fiOHDenRlSXu07E6QFTTDaI7Atu5uuw92MW2RpOOWYcRXrUltL9PAsOhGX0ipw5QTO9DbIpUFXWdBX1TgVH+NqS7D3Wi3fYfbdlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168121; c=relaxed/simple;
	bh=q0YN9f/O6gekCA9GBQ/dXTXX74d6AaeW0m3bItIOULM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2akTqM+nQ5CZk1pwhgSm1Mjr3n4Sa0SvLr7ascWPCFXby9L2csvgH1DOdCji22zOjYVbWe9GQlBJw01ojpVd1Z5W33KNYcCdCPZ48lbTkda+aPskEdcxGvu5qSmDqxdeu9HZKEiFk8PbdIN899VKJE9Fx+xbw5CVtbtKA9qOw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VzQn0eJn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uEYyeDGJ; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VzQn0eJn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uEYyeDGJ"
ARC-Seal: i=1; a=rsa-sha256; t=1792167989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JTukwDQeMMKg1Dn/PkLyy3IZftV5iL1NnCJPm7HJPaOCYxg/5bYk3/PdYiPGD9UO6g
    oKUem4gIMQiirhf5Y9nEoVj+oTo4LL+CdMIbQO08XX+IiR39VACFiv8oqvhUFRhuD2gm
    G+Ns2FVoYI3AHN0iYuI0t3Vvbpe00GFWhsA+4eIwJbBVaFbPDm+UwtKvrFI7290374VR
    O509ME3BSxE5jU8YI1Lrswwha5+l92+IXge6fqn20oGtn0mQaOgxXnS2ZCPtleZpdtmq
    TuLBLxSO+/qNP0sKCZLyFJrdlPtYhJ/hvj8krhvTLoV7h4HQTzSq1SvHEAPK4hvQmxEd
    q74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792167989;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JfCm0VuccaxZBDYiP4Hrji1cgGax0G5AJjs9mvMeuXE=;
    b=Pf41fD3TN3IN3tyCzLGHBOFwGYECUYxUblYnklmdQ7QGmNZ5BDtwlyG/L4LoN+xL68
    8/en3ySw2ecwkJMZFIuh5hcz1/eOERSMFgOho983YaRmwwUcOhMbQboTTPuY4az2QXsK
    OhRFpSYFw6iHeqdGA3b82etGczXAWPYGzwcJF9VmVAZaxZv4+FSUx5QJp0eifjpmTJVN
    2mrkUuAAthJupqx3vE3dLKfePz4vSRChGy4HRKNdZJR1ZmQ4xklD5D5Ims8y9XPKAdon
    uiVJmj0QfUgl7zMzNVuFHOGiUgjYuWGsvytgNpaKkXvLoe94lgKpM3S7lQtK/8FIB+n4
    zznA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792167989;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JfCm0VuccaxZBDYiP4Hrji1cgGax0G5AJjs9mvMeuXE=;
    b=VzQn0eJnD52+zA4GE7Ph6GBPBWbOakeakGx+DzSn0GrUqHWU3O60fi33MgOuPPcC1K
    cQM6b2WXGPqeJUO0lVZbY47NLfIT78u1JYYFQYpsbAeiuKT8Q0JDyCsK1OmViTG2CsNh
    UcgsC4xpZrJUWqJi+VZnE+VCDrtWEpxbldL3mg1M7wUWHI08n3rNpPxDxH8TAp5NfMTH
    99Hezt1iP++wREthFubKhXCIeiPY5MzJv2qlwDuDYCw8BApqrDWU4iTZspuemF8mK2X6
    GzOX0Anek5AtEGZ6V66j8mJDhhdJouQtaNUDXAIAC4Oya2QUJVhltR2IPQIZfZhXVjyS
    KeKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792167989;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JfCm0VuccaxZBDYiP4Hrji1cgGax0G5AJjs9mvMeuXE=;
    b=uEYyeDGJrhaFEc3kiCKpHZdNDho/5KOOwGfTNVxbQokeQjKrVhLDJQgKXPyglewUm5
    MDvqOy+8QI+eBmctCgCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GGQSN9w
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 18:26:28 +0200 (CEST)
Message-ID: <99fed91f-dbc5-4029-8a34-7e0113acfe13@hartkopp.net>
Date: Fri, 16 Oct 2026 18:26:21 +0200
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

Fixed in new version.

> - [Medium] bcm_release() now holds the global rtnl_mutex across the whole
>    rx_ops unregistration loop (rtnl_lock() at net/can/bcm.c:1951,…

See below.

> - [Low] Stale comment in bcm_release().

Fixed in new version.

> 
> --


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

Yes. This is a potential misuse scenario, which is far away from common
usage patterns.

In v3 RTNL only covers the removal of the device specific filters. The
'any' CAN device filters live in the socket's namespace and are removed
after rtnl_unlock().

The need for RTNL when removing device specific filters comes from
af_can protecting the per-device receive lists with the per-netns
rcvlists_lock. This is not specific to bcm: raw_release() and
raw_setsockopt(CAN_RAW_FILTER) already hold RTNL across up to 512
filters per call. A per-device lock in struct can_dev_rcv_lists would
remove this dependency for raw, isotp and bcm. This is something for a
separate af_can rework in can-next.

Best regards,
Oliver

pw-bot: cr
