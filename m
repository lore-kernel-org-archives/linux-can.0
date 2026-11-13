Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544267;
	b=mO90Cr33lNGRERlHrstowd8thCKJ7wusi/YO9iRQ7f2cFH9IP4lYmPDewfAysgtubCmg
	 GVjcla6gAg+V+RBZ4YO0uh7hBEFnBhklh3GkA4gsGqt75s+fxdYtD9ZFWu1k45cp91FTQ
	 EVs3ILZFw8E6fPu9gXNIUldhY4t28r9Dtdw9VZC0FHswo9bxQavmoMyGhKWoA2dIjP+0B
	 U/Ezsaw7m0I2CrzBULrndg2WW+oDskKvrDZ9gns92KjFquIYdHROgVIwl0zeZShiZ1eKy
	 5vf8T25KppOrY+msni5VCI53Ml7MzuUFcdn/Jk0QSytV5F9u7NcOm7tscv1lP4Xb0pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544267;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bUbMQkAVXe5iVFnc8xD8AtI5M7lmYV44x7jN8yV+osw=;
	b=EdqLsWbAjqIN4edZeg3uvm13ZfQUjqXLsP0EuPYpMhtsNi1pqFloEtL9/LHp2w+xGuZN
	 R2+uGMxsOgseW1TE12S8Dt5/pVok27WGY4Q5+/5xxQ/GOBGcWCYKOjKYnb3nxd6IgIpz4
	 CiK+JZrfTC9D+h0lDqJpAVtpM68Mzgmkuzd+l66A3XVlDHho3rHF/hXhH/m6HqTth4mvS
	 ziCAsV/+ycG34T/91Iz3n8IFN+m31DAGIJl12YNPbSi4X1Naq5WE8LlppLNJZiA2rGqRp
	 iQw7uwA2XheDEO97XYaaWcf1ZeW/HT92lj6sBXq66XUyEISafvar8A/jm6r+r5h5QvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhcEMRSr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A1606A336
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhcEMRSr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85EC1F000C6;
	Fri, 13 Nov 2026 04:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794544267;
	bh=bUbMQkAVXe5iVFnc8xD8AtI5M7lmYV44x7jN8yV+osw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhcEMRSrAZ4jJ1WfcTKnS8CqBmGu24IsosKlE19jg6py5Bnym9Pyh9vqlb1L6Q34m
	 GX+Nld/z3TvMw4vu+EoLWnByceGtUoydm9QP3Vo9Sd0+KprsHsQHFC1Sno4PVbanks
	 RtKjPyzIlG7ElJxf8l2p0HMlBCoyueQWl6B9qskm/E2pAlEKSJfhEvEX6049AXxFJ9
	 7FWmOMdMnxVRMyNfFV855PYoh8PaRrSc+JvUTg4OMAv4AoNrCsf/f6mjFM5xPNC6Lc
	 wKkdVk24YylkNB9Jo3r2VOF18KIknEXfjH53xj//MWutCcVTnMdCAsaHfer4p2OQOf
	 29IJokowkW2OA==
Subject: Re: [PATCH v4 6/6] can: enable memcg accounting for user triggered
 allocations
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Fri, 13 Nov 2026 04:31:06 +0000
Message-ID: <179454426640.488853.6734133900556874595@kernel.org>
In-Reply-To: <20261111-can-bcmlock-memcg-v4-6-5428607a608f@hartkopp.net>
References: <20261111-can-bcmlock-memcg-v4-6-5428607a608f@hartkopp.net>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/can/isotp.c:isotp_rcv_ff(), the large RX buffer is
  charged to whatever memcg mem_cgroup_from_sk(sk) returns.
- [Medium] isotp_rcv_ff() (net/can/isotp.c:620) charges the softirq RX
  buffer with GFP_ATOMIC | __GFP_ACCOUNT.

--

can: enable memcg accounting for user triggered allocations

This patch charges CAN allocations that unprivileged users can trigger to
the memory cgroup of the allocating process. That covers sockets,
receivers, bcm ops and frames, raw/j1939 filters, isotp TX/RX buffers and
j1939_priv. The isotp RX buffer is allocated in softirq context and is
charged to the memcg of the socket via set_active_memcg().

Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 50a3f4cd2b316..5e6940aea5ed3 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -611,7 +612,13 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>  
>  	/* PDU size > default => try max_pdu_size */
>  	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
> -		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
> +		struct mem_cgroup *old_memcg;
> +		u8 *newbuf;
> +
> +		/* charge the buffer to the memcg of the socket owner */
> +		old_memcg = set_active_memcg(mem_cgroup_from_sk(sk));

[Severity: Medium]
Does mem_cgroup_from_sk(sk) return the socket owner's memcg in every
configuration where kmem accounting is active?

mem_cgroup_from_sk() returns sk->sk_memcg. The only code that sets it is
mem_cgroup_sk_alloc(), and that is gated on socket memory accounting, not
on kmem accounting:

mm/memcontrol.c:mem_cgroup_sk_alloc() {
	if (!mem_cgroup_sockets_enabled)
		return;
    ...
	if (mem_cgroup_is_root(memcg))
		goto out;
	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
		goto out;
	if (css_tryget(&memcg->css))
		sk->sk_memcg = memcg;
    ...
}

Two configurations leave sk_memcg NULL:

- cgroup v1 where memory.kmem.tcp.limit_in_bytes was never written
- cgroup v2 booted with cgroup.memory=nosocket

In both, the other allocations in this patch are still charged to the
caller's cgroup: sk_alloc(GFP_KERNEL_ACCOUNT) in can_create(), the isotp
TX buffer, the filters and the bcm ops.

Here, though, the call becomes set_active_memcg(NULL) in softirq, and
current_obj_cgroup() falls back to the root objcg:

mm/memcontrol.c:current_obj_cgroup() {
    ...
	memcg = this_cpu_read(int_active_memcg);
	if (unlikely(memcg))
		goto from_memcg;

	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
    ...
}

Wouldn't the kmalloc(max_pdu_size, ...) below then be charged to root
instead of the socket owner's limited cgroup?

This branch only runs when the max_pdu_size module parameter is raised
above DEFAULT_MAX_PDU_SIZE (8300), because rx.buflen starts at
ARRAY_SIZE(rx.sbuf). Once it is raised, each isotp socket can hold an RX
buffer of up to MAX_PDU_SIZE (1025 KiB) that its cgroup is never charged
for.

The isotp_sock itself is charged to current's objcg in can_create(). Its
RX buffer instead depends on socket memory accounting. Is that mismatch
intended?

In these configurations, the new comment and this part of the commit
message don't seem to hold:

    The isotp RX buffer for PDUs > DEFAULT_MAX_PDU_SIZE is allocated in
    softirq context and is charged to the memory cgroup of the socket with
    set_active_memcg().

> +		newbuf = kmalloc(max_pdu_size, GFP_ATOMIC | __GFP_ACCOUNT);

[Severity: Medium]
GFP_ATOMIC contains __GFP_HIGH, so try_charge_memcg() never fails this
charge at the limit. It takes the force path instead:

mm/memcontrol.c:try_charge_memcg() {
    ...
nomem:
	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH))) {
		ret = -ENOMEM;
		goto out;
	}
force:
	...
	page_counter_charge(&memcg->memory, nr_pages);
    ...
}

When max_pdu_size is raised, can an unprivileged process use this to push
its cgroup far past memory.max?

For example, a process still under its limit opens N isotp sockets and
binds them all to the same rx_id. It then sends one First Frame with
FF_DL > 8300, e.g. from a CAN_RAW socket with local loopback.

Every socket then reaches this kmalloc(max_pdu_size, GFP_ATOMIC |
__GFP_ACCOUNT), which can be up to 1025 KiB (an order-9 allocation) per
socket, and each charge is forced past the limit.

At creation each socket was only charged for the isotp_sock with its two
8300 byte sbufs, about 32 KiB as a kmalloc-large allocation. This memory
is unreclaimable kernel memory, and a forced charge doesn't trigger a
memcg OOM, so the overshoot can persist while the tasks sleep.

The commit message says the charge is forced. It doesn't mention that
forcing lets the per socket footprint grow far beyond what was charged
when the sockets were created.

isotp_rcv_ff() already handles a failed allocation by replying with an
overflow flow control frame:

	if (so->rx.len > so->rx.buflen) {
		/* send FC frame with overflow status */
		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
		return 1;
	}

Given that, would a GFP combination that can fail at the limit keep the
limit enforced here, such as GFP_NOWAIT | __GFP_ACCOUNT or
(GFP_ATOMIC & ~__GFP_HIGH) | __GFP_ACCOUNT?

> +		set_active_memcg(old_memcg);
>  
>  		if (newbuf) {
>  			so->rx.buf = newbuf;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-can-bcmlock-memcg-v4-0-5428607a608f%40hartkopp.net
