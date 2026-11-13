Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566476;
	b=4L7PekM8ls54DLzYOPbP1nhRFisLiG3B4NbN3XhGUoeN7/1jex1oWwJj4bHgVhiMg61l
	 QWBagJ4EbMs3BmZLbvWwNgy2u0TStM50HhE/ZiwGT04rbatQQEEmCCaMGTvzGfMRoQwZA
	 +p8pv8COHYySe1BzMW0hToUpRgxp8ImBb3YUl/VwGiPs11sTaimyPuls35HsVQa6i+KB5
	 MiQhFKxt9qW/uKDxtux8OYEqTgq0boxwh4bdOOjlrq4UI/sKdI6yFkik0q6wF0bWixHlD
	 dTwZ6V8ngsqSSPPo82DOkglPR2O0q1ryxcb/Y4FqK2186X2ItqjtoL8ho3pQ8MLhfvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566476;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oOy67A1xRcvCQioF03+Bqad4fpK4xQJwPvaJ1zrudlo=;
	b=z97rUAVxX0RGq8u1nJUX3igxz+rvZQbE7F44t104ghhk1AbHpnApQHw5ACdShjGx97ya
	 Jl7IwFWiyU1ghT5dcBXNFagH29KyTrQg6mkhuW7si/XfA39FT9WQFnoKsUDl1zuWWv06u
	 7b330faaRkw4h7yfCsXgwjO/61iA57rhvvkgpUgMpPVegzqeag49jpVfSbzli7NB7MrDn
	 53unXjxuFw9zfgxL0uiRru5BWiZlxgs0NQMPwykLVCAjEVw8oWv7ZSIUGjRezObsmgNau
	 pB62MLE2KduSp72j71PyTGoa/Bb25rJKYNuzEjzxoDJ2Ym7xqhHwhF4KznbkMiayngQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=O59GtUb8;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0d1bWC4m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4120606A321
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4120606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=O59GtUb8;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0d1bWC4m
ARC-Seal: i=1; a=rsa-sha256; t=1794566465; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=anVzhqYqRvSnh4SQAdqF1JjT6f2irQcSgsqDjglXo9M00LFo8RB3bpf4MXddLVz7Lp
    A6y94e1Q6+LNni7hbb9F0o9150qDzhTFshzELiYP6OtUxG9vuAF+wNUN+bMCOHlDRcbk
    doSc5+mBTdciBRbvkU7BlDoJsB78dvoOiU6AtyEt/fAddPZ2KCSjWoJREpug6F0PVNaa
    SI/wBEgAxcLRj7Ck58qMk9x4yFRKqjlP1yLKUJ4+2f3PN1FPWrW8kGU08JSXg0FtxHhE
    shYNzE35yNvVy3Iyg8QTBzikF9rIqZvmk8ByoL+QAhm0ij5sLhPZIe/lvkic/o5e424n
    bxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794566465;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oOy67A1xRcvCQioF03+Bqad4fpK4xQJwPvaJ1zrudlo=;
    b=FvBC27/xJo4ytuyKy/VTyZdjYVqFQzvIak1n210a6MSPOsqZ2TE7vxC17niWizFNhX
    4HPuLGnhI0TwGC8a2z0MH3+OXbBVKkbmrauXeJUym8r3lXwOrQJ37366nQOOnucMsTPp
    PIDqPkdHdNVN5iUfSEMdQzazIt5Ze++iGqeaUjlAAR3wXxTHAkcFs+mBQqBYrKoVlVRa
    B+SSTT1pstn7bYkL+WUuzbU2yj5hRaMhjbH2OXFJBomWqTuVg7DvYuX7odleLyRMkVos
    DDTm86p3f4y3umBCJpxiEhFfDcPTLRGY2Q9zQLVqlXpH4V6S/n9JGf54ZdL6OMnsJ4/A
    M9kA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794566465;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oOy67A1xRcvCQioF03+Bqad4fpK4xQJwPvaJ1zrudlo=;
    b=O59GtUb8gtdRAV4EdPDhVIcSK0G5DzuVK5t+y1pevEE4garPSMdbAdS1rQAnFe/yY9
    WP6dtzNszVVDB22ZIrYFP7iW3bhjhTChAHN8FSAxSSaMPrQBGTsWdwX2Nnk0WBfTHsJ7
    6lBt3T5VK5XwTL31jr8kbrLGqwb67r9Ck+M2ZA12DQvrtUSlg0Fmo7iiUS/2kLTt/5Bp
    LmTyTuakmIUWG1nMGDIYohpXWj/C9F89dD0AeD/unuy+/5CsKpfYqTSBAXxPGPvZOvlz
    +zJDEukPXcgl+RGY4hz0FCJzdbSTmQ1CA3pAERIByIgWOOl4+iHQRHQpQFEWR2qitOBS
    3KOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794566465;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=oOy67A1xRcvCQioF03+Bqad4fpK4xQJwPvaJ1zrudlo=;
    b=0d1bWC4mG4ZEAg/oiWdPpa7XZXROsGFpKBFYkXBTu0EKa437Qon9ElWLiJtaxzaJwl
    PcqYd2wSEE536R4Q7eDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAf5IuM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:41:05 +0100 (CET)
Message-ID: <315a49cb-f8f4-4201-913f-e6faca5e0751@hartkopp.net>
Date: Fri, 13 Nov 2026 11:41:00 +0100
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
Subject: Re: [PATCH v4 6/6] can: enable memcg accounting for user triggered
 allocations
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261111-can-bcmlock-memcg-v4-6-5428607a608f@hartkopp.net>
 <179454426640.488853.6734133900556874595@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179454426640.488853.6734133900556874595@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.11.26 05:31, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In net/can/isotp.c:isotp_rcv_ff(), the large RX buffer is
>    charged to whatever memcg mem_cgroup_from_sk(sk) returns.
> - [Medium] isotp_rcv_ff() (net/can/isotp.c:620) charges the softirq RX
>    buffer with GFP_ATOMIC | __GFP_ACCOUNT.
> 

Both issues are addressed by reverting the changes from v4 back to v3.

We do not account the extension of the rx-buffer to 
mem_cgroup_from_sk(sk) anymore and stay on the root fallback in softirq 
context.

Btw. this patch is removed from the v5 patch set and will be prepared 
for can-next to have this patch set to clearly address "can: avoid RTNL 
stalls in CAN_RAW, CAN_ISOTP and CAN_BCM" for stable.

Best regards,
Oliver

> --
> 
> can: enable memcg accounting for user triggered allocations
> 
> This patch charges CAN allocations that unprivileged users can trigger to
> the memory cgroup of the allocating process. That covers sockets,
> receivers, bcm ops and frames, raw/j1939 filters, isotp TX/RX buffers and
> j1939_priv. The isotp RX buffer is allocated in softirq context and is
> charged to the memcg of the socket via set_active_memcg().
> 
> Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 50a3f4cd2b316..5e6940aea5ed3 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -611,7 +612,13 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>>   
>>   	/* PDU size > default => try max_pdu_size */
>>   	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
>> -		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
>> +		struct mem_cgroup *old_memcg;
>> +		u8 *newbuf;
>> +
>> +		/* charge the buffer to the memcg of the socket owner */
>> +		old_memcg = set_active_memcg(mem_cgroup_from_sk(sk));
> 
> [Severity: Medium]
> Does mem_cgroup_from_sk(sk) return the socket owner's memcg in every
> configuration where kmem accounting is active?
> 
> mem_cgroup_from_sk() returns sk->sk_memcg. The only code that sets it is
> mem_cgroup_sk_alloc(), and that is gated on socket memory accounting, not
> on kmem accounting:
> 
> mm/memcontrol.c:mem_cgroup_sk_alloc() {
> 	if (!mem_cgroup_sockets_enabled)
> 		return;
>      ...
> 	if (mem_cgroup_is_root(memcg))
> 		goto out;
> 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
> 		goto out;
> 	if (css_tryget(&memcg->css))
> 		sk->sk_memcg = memcg;
>      ...
> }
> 
> Two configurations leave sk_memcg NULL:
> 
> - cgroup v1 where memory.kmem.tcp.limit_in_bytes was never written
> - cgroup v2 booted with cgroup.memory=nosocket
> 
> In both, the other allocations in this patch are still charged to the
> caller's cgroup: sk_alloc(GFP_KERNEL_ACCOUNT) in can_create(), the isotp
> TX buffer, the filters and the bcm ops.
> 
> Here, though, the call becomes set_active_memcg(NULL) in softirq, and
> current_obj_cgroup() falls back to the root objcg:
> 
> mm/memcontrol.c:current_obj_cgroup() {
>      ...
> 	memcg = this_cpu_read(int_active_memcg);
> 	if (unlikely(memcg))
> 		goto from_memcg;
> 
> 	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
>      ...
> }
> 
> Wouldn't the kmalloc(max_pdu_size, ...) below then be charged to root
> instead of the socket owner's limited cgroup?
> 
> This branch only runs when the max_pdu_size module parameter is raised
> above DEFAULT_MAX_PDU_SIZE (8300), because rx.buflen starts at
> ARRAY_SIZE(rx.sbuf). Once it is raised, each isotp socket can hold an RX
> buffer of up to MAX_PDU_SIZE (1025 KiB) that its cgroup is never charged
> for.
> 
> The isotp_sock itself is charged to current's objcg in can_create(). Its
> RX buffer instead depends on socket memory accounting. Is that mismatch
> intended?
> 
> In these configurations, the new comment and this part of the commit
> message don't seem to hold:
> 
>      The isotp RX buffer for PDUs > DEFAULT_MAX_PDU_SIZE is allocated in
>      softirq context and is charged to the memory cgroup of the socket with
>      set_active_memcg().
> 
>> +		newbuf = kmalloc(max_pdu_size, GFP_ATOMIC | __GFP_ACCOUNT);
> 
> [Severity: Medium]
> GFP_ATOMIC contains __GFP_HIGH, so try_charge_memcg() never fails this
> charge at the limit. It takes the force path instead:
> 
> mm/memcontrol.c:try_charge_memcg() {
>      ...
> nomem:
> 	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH))) {
> 		ret = -ENOMEM;
> 		goto out;
> 	}
> force:
> 	...
> 	page_counter_charge(&memcg->memory, nr_pages);
>      ...
> }
> 
> When max_pdu_size is raised, can an unprivileged process use this to push
> its cgroup far past memory.max?
> 
> For example, a process still under its limit opens N isotp sockets and
> binds them all to the same rx_id. It then sends one First Frame with
> FF_DL > 8300, e.g. from a CAN_RAW socket with local loopback.
> 
> Every socket then reaches this kmalloc(max_pdu_size, GFP_ATOMIC |
> __GFP_ACCOUNT), which can be up to 1025 KiB (an order-9 allocation) per
> socket, and each charge is forced past the limit.
> 
> At creation each socket was only charged for the isotp_sock with its two
> 8300 byte sbufs, about 32 KiB as a kmalloc-large allocation. This memory
> is unreclaimable kernel memory, and a forced charge doesn't trigger a
> memcg OOM, so the overshoot can persist while the tasks sleep.
> 
> The commit message says the charge is forced. It doesn't mention that
> forcing lets the per socket footprint grow far beyond what was charged
> when the sockets were created.
> 
> isotp_rcv_ff() already handles a failed allocation by replying with an
> overflow flow control frame:
> 
> 	if (so->rx.len > so->rx.buflen) {
> 		/* send FC frame with overflow status */
> 		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
> 		return 1;
> 	}
> 
> Given that, would a GFP combination that can fail at the limit keep the
> limit enforced here, such as GFP_NOWAIT | __GFP_ACCOUNT or
> (GFP_ATOMIC & ~__GFP_HIGH) | __GFP_ACCOUNT?
> 
>> +		set_active_memcg(old_memcg);
>>   
>>   		if (newbuf) {
>>   			so->rx.buf = newbuf;
> 
> [ ... ]
> 

