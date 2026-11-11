Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402511;
	b=w4cB6SiH7PZSg611niY0wMUolgkqqsfgrS4CqPOWvVLzFJemo7rlfbFquXGSeoz3qnOl
	 hj/u+VTxgImvREKaYyRoF6YqZ8OJ+A04XpUY3Jj5FR97xVZGHpWNXxB3iO510CQCcl0LW
	 Onu4zjZDpX2JFX2sit17gs3fMPSWL2dpeKieevWwflAu7VZnqAyl+qzJJPZwMt7TVvXX0
	 ujKP4mSIGwQQ5kHT32oX+wyfaWhkOly8WLi0UffyPN5DD/0dgJfGi4DfKC0UtyQ3p+9Mn
	 9d+JNytQRDYzcGMoHP+1jzDnCZPm7H6OGKUUG05+7B2V0RvPDoh8qRF/VvXFwsjGwqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402511;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KDhI7iGOXDo97JxcAzpqJgf/y/+DXBtJ7B9FeMYy3Fw=;
	b=OcT3ajvaULmcQFtZ77fia8y79hB8GyBl+DwTr5l252dBuaP7XXdgi05hQio0xGYCDamO
	 MKrVrPvN8pxXHNxBzlHHf6d4lqB4Pfua6F1r7l6Z0HsFV3cMIpdLGLoaw1Zuksz2Su+/8
	 DtXMDmA/T0nflNi/ZTQTwSk438pizypaotlge5bboU3FR8m86Vg3bxqwB+kw0jzz8jndG
	 7HoTKL/mxaEQtGu1h6MmTnag7MNktUzH1yJz0kWYLdByUBD3Hia4U+8QYbQB0ph0o99ug
	 Nu17YhzpNBu9qwgyKt240h/ExDUXGfYFIshP7yCAQQrVbsNGANfgSxAaSRfkhpTSL+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkXxwXbb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0682606A321
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkXxwXbb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1141F00A05;
	Wed, 11 Nov 2026 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402511;
	bh=KDhI7iGOXDo97JxcAzpqJgf/y/+DXBtJ7B9FeMYy3Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IkXxwXbbPRVg5Jai1omDngv0aiqRFlesTBYckrqIXF+9OrYsX+k2aAb1xvSLWyoNT
	 XW2h5wjkYZwJN6szijT3m3QbV3ybhjstupdiIbQ4SP9/SPr3L0a30ov+7MqI35awRG
	 UOutFUFU9n2IWHQzztwmKVXA1YpuCSB6XscInekwOXdLlJ2KQInDpkAsSWaQo7jfvL
	 4NDeDGeAEN8kZ7bMlcYszse1zI8p25aaH0DNBy0wM6UopVeOe7ZPROFFUX/3pDRn+U
	 BrSf/D8wfgQtggD0aFPRjHfo0+2i/mDAjSo7kfa/1zoK9RGWWx/fdICwqfAviLNJ3x
	 6/BFonq1GHSqA==
Subject: Re: [PATCH v3 3/3] can: enable memcg accounting for user triggered
 allocations
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Wed, 11 Nov 2026 13:08:30 +0000
Message-ID: <179440251065.488853.2772127877752272552@kernel.org>
In-Reply-To: <20261109-can-bcmlock-memcg-v3-3-2d798ca30578@hartkopp.net>
References: <20261109-can-bcmlock-memcg-v3-3-2d798ca30578@hartkopp.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit is meant to stop unprivileged users from getting
  around their memory cgroup limit with long-lived CAN allocations, but…

--

can: enable memcg accounting for user triggered allocations

This commit charges CAN allocations triggered by unprivileged users to
the memory cgroup of the allocating process. It covers the CAN socket
structures, the receivers, the per-netns lists, the BCM ops and their
frame arrays, the raw and j1939 filters, j1939_priv and the isotp TX
buffer.

Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 7a90ba3f1cf1c..34cccb4801415 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1184,7 +1184,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  
>  	/* PDU size > default => try max_pdu_size */
>  	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
> -		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
> +		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL_ACCOUNT);
>  
>  		if (newbuf) {
>  			so->tx.buf = newbuf;

[Severity: Medium]
The TX buffer is charged here. Is the matching RX buffer in
isotp_rcv_ff() meant to stay uncharged?

net/can/isotp.c:isotp_rcv_ff() {
    ...
	/* PDU size > default => try max_pdu_size */
	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
    ...
}

This buffer can be as large as MAX_PDU_SIZE (1025 KiB) per socket. It is
only freed in isotp_sock_destruct(), so it lives as long as the socket.

Both buffers are only reallocated when can-isotp is loaded with a
max_pdu_size larger than DEFAULT_MAX_PDU_SIZE. That is the only
configuration where the TX change has any effect, and in it the RX
buffer, which is just as large, is still not charged.

Suppose a user opens many isotp sockets (using fork(), the same argument
the commit message makes for BCM) and gets a First Frame with
FF_DL > 8300 delivered to each one, e.g. through a vcan device in a user
and net namespace. That user could pin about 1 MiB of uncharged memory
per socket.

The commit message gives this reason for leaving it out:

    The isotp RX buffer and the j1939 RX sessions are allocated in softirq
    context and can not be attributed to a process.

Is that accurate for the isotp RX buffer? sk_alloc() calls
mem_cgroup_sk_alloc(). On cgroup v2, that stores the creating task's
memcg in sk->sk_memcg and takes a css reference:

mm/memcontrol.c:mem_cgroup_sk_alloc() {
    ...
	memcg = mem_cgroup_from_task(current);
	if (mem_cgroup_is_root(memcg))
		goto out;
    ...
	if (css_tryget(&memcg->css))
		sk->sk_memcg = memcg;
    ...
}

Could the RX allocation be charged to the socket owner with
set_active_memcg(sk->sk_memcg) and GFP_ATOMIC | __GFP_ACCOUNT? Another
option would be to allocate the larger RX buffer in process context,
e.g. at bind() or setsockopt() time.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-can-bcmlock-memcg-v3-0-2d798ca30578%40hartkopp.net
