Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411076;
	b=0yDfwQpe3L3Aq5yE6Uk1QadRBFvqOoo71xzYJMdmCnn8x31mIhqR4W2dnt9qQR2OF9U8
	 YlKKr/Qt0HqGCyPNz7vUn+PLHcXr6fBuRGsh95zycMvV8fQu9U9LjNxPJ/qD9CzOXrMkP
	 K1EztL3nS8mAEgMhV2wN49nJGz3IFE5Jv3Z2HcKktzMiHZTnIgFTgUICuuZHkhYGUz1ht
	 Wo7XBRY8Tz7RSsQEqnsNsNtr0Euf3jkW9B6LhtFo/USMUD6bJHJj1UOogyvprOlZOVnWb
	 fLD8Fk0+e0cQem0uglpkzuLiG8krQyS5gAb/ILnD4fsRuktYlk1fBsPMrNEPrKDs6sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411076;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UyItIewXOMGi6q7Fe8FTZzaKeTy/zKjm9dGyJ2Fa4Po=;
	b=MdXNJWemSUFcBIaLi6KjD4QFQ05zZfWptLO19FMwTLgjvi2DfLf7LL8DviWiBEhkkvja
	 +VhW2o0d8xrwpkErmJWIrDU04pz3f+9BD7iZ3AzFTs/YsmjJPCWNFmkYocjaVTjKd8UNA
	 e2xxu5F4x2N1MNYmIRPvs3Ph9E8z/D9whw9P9fLLsXcjmZ0XyP6WOxPienglmB59WrToV
	 YEgHwC3D1+8yc4w5rR34RWEIyLyeK4pjJRdaSm/7GxPON3pj0Uv5HEV7P2XCbTTenG6UU
	 qxL6xyYUPL77Wx62CHbq27wPd5la+2KlmoN7PXfxam8gU38kl6KUzbI/orTOJHTh3lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BKFBffut;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XGwaO5KO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DC606A330
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44DC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BKFBffut;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XGwaO5KO
ARC-Seal: i=1; a=rsa-sha256; t=1794411067; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cuF9Ug0qLWULC+1THl5+Jbf+bHgcffptH8pCtY2tWarvSd5aH+WGKxA4zxxaFCDfhL
    nfFknXOsOYp+3HQ1ibK6MA4qaHDXs7DO9YqN8zYmLALYJTT8uav9WiXflqWO7Wf+N85h
    KZ5W9spUz/RtMIQGXN/os3G3x1Fq0I6/mV0d5P8jYdaEhvrNKlQT7zY+gFectGcIpVj2
    f7bz4bx3mv0aeU1Wjegxc5ilN/TPOwiDgM3eMPCyusGXtBf/z7PgsTCAH8ixTqG9psfn
    M8EbxSUHd85z2DQIlbdIUlAFG3Rbgk8E97bK9JmCK68f/ESbMScYPR9I1AFO5ZwA7HxO
    laXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794411067;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UyItIewXOMGi6q7Fe8FTZzaKeTy/zKjm9dGyJ2Fa4Po=;
    b=THMABRna1geU0l2Hgrvj0WpGRevhgieZO7ezXSnQOTACg8wh4eSOwUDJOnFlDQBZuK
    faWmxaEpHCjL9lEhx90NiJ9aitiEYvzkmYKej6mk5fBdA26jaqmSVrR/ncV5qncPwfa9
    7GdIAUkRYjeyGrmsQltinXtJtzN2N/NfRouYUd/TilnR1j/25it+faRwQvI+2zm3uXJA
    DELtw7ukiP9vdK4M96OVH7s/qCP4jtGPZNnP9d53EqRtCVF3QLiWp75edsFt6Hvx/ItS
    fVJyZzTZA3Cs38UAHCBHOu+Q38SZP1BMsQmREu5XcPGWawfBufHna8kNePtLzQHHCsII
    8o1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794411067;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UyItIewXOMGi6q7Fe8FTZzaKeTy/zKjm9dGyJ2Fa4Po=;
    b=BKFBffutnQL3OkiuKhWvCqqjzPNG2aOk3pMd4djm79v7HSmQVzYetBtibLdAv/yIHJ
    QfBUpHn8lGkMUCYnqAbHvrlqEQOat5KhtB7GdnHyM6zZH4W12x+Idv6E5ZFSwN+4U3b5
    izMuNM92MPf6iwADovVRTE7j1nokt84wEdyLkIrsWjWXvSajpn5JvYmSYlyTOrS0Q7l1
    ySCH91D4yeJhC42YgAS6phgFKFtS5o0FSXnMC2INjXjl/uQo4AORQJ0f6wLDV/YtqMgt
    tQi/xf2XgXWkNIcKzhIJFLApejkxfTikOD2ZtOLwHbKf0FpDTXZtwYmqxDmtUGQxp+BQ
    Dqpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794411067;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UyItIewXOMGi6q7Fe8FTZzaKeTy/zKjm9dGyJ2Fa4Po=;
    b=XGwaO5KOakURkgQbYN6ZAH4EIP7PYWsd0DbBWgh2Hd4yV9v7aXcpLv02Hv108U0pAD
    jBy7uhFrZ5yieWfZQkCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFV79ON
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:31:07 +0100 (CET)
Message-ID: <205dc367-04b9-474f-8dec-59070ce48aec@hartkopp.net>
Date: Wed, 11 Nov 2026 16:31:07 +0100
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
Subject: Re: [PATCH v3 3/3] can: enable memcg accounting for user triggered
 allocations
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261109-can-bcmlock-memcg-v3-3-2d798ca30578@hartkopp.net>
 <179440251065.488853.2772127877752272552@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179440251065.488853.2772127877752272552@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.26 14:08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit is meant to stop unprivileged users from getting
>    around their memory cgroup limit with long-lived CAN allocations, but…
> 
> --
> 
> can: enable memcg accounting for user triggered allocations
> 
> This commit charges CAN allocations triggered by unprivileged users to
> the memory cgroup of the allocating process. It covers the CAN socket
> structures, the receivers, the per-netns lists, the BCM ops and their
> frame arrays, the raw and j1939 filters, j1939_priv and the isotp TX
> buffer.
> 
> Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 7a90ba3f1cf1c..34cccb4801415 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1184,7 +1184,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   
>>   	/* PDU size > default => try max_pdu_size */
>>   	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
>> -		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
>> +		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL_ACCOUNT);
>>   
>>   		if (newbuf) {
>>   			so->tx.buf = newbuf;
> 
> [Severity: Medium]
> The TX buffer is charged here. Is the matching RX buffer in
> isotp_rcv_ff() meant to stay uncharged?
> 
> net/can/isotp.c:isotp_rcv_ff() {
>      ...
> 	/* PDU size > default => try max_pdu_size */
> 	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
> 		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
>      ...
> }


Good catch!
Added charging of the buffer to the memcg of the socket owner:

diff --git a/net/can/isotp.c b/net/can/isotp.c
@@ -611,7 +612,13 @@ static int isotp_rcv_ff(struct sock *sk, struct 
canfd_frame *cf, int ae)

  	/* PDU size > default => try max_pdu_size */
  	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
-		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
+		struct mem_cgroup *old_memcg;
+		u8 *newbuf;
+
+		/* charge the buffer to the memcg of the socket owner */
+		old_memcg = set_active_memcg(mem_cgroup_from_sk(sk));
+		newbuf = kmalloc(max_pdu_size, GFP_ATOMIC | __GFP_ACCOUNT);
+		set_active_memcg(old_memcg);

  		if (newbuf) {
  			so->rx.buf = newbuf;

See v4 patch:
https://lore.kernel.org/linux-can/20261111-can-bcmlock-memcg-v4-6-5428607a608f@hartkopp.net/

pw-bot: cr

> 
> This buffer can be as large as MAX_PDU_SIZE (1025 KiB) per socket. It is
> only freed in isotp_sock_destruct(), so it lives as long as the socket.
> 
> Both buffers are only reallocated when can-isotp is loaded with a
> max_pdu_size larger than DEFAULT_MAX_PDU_SIZE. That is the only
> configuration where the TX change has any effect, and in it the RX
> buffer, which is just as large, is still not charged.
> 
> Suppose a user opens many isotp sockets (using fork(), the same argument
> the commit message makes for BCM) and gets a First Frame with
> FF_DL > 8300 delivered to each one, e.g. through a vcan device in a user
> and net namespace. That user could pin about 1 MiB of uncharged memory
> per socket.
> 
> The commit message gives this reason for leaving it out:
> 
>      The isotp RX buffer and the j1939 RX sessions are allocated in softirq
>      context and can not be attributed to a process.
> 
> Is that accurate for the isotp RX buffer? sk_alloc() calls
> mem_cgroup_sk_alloc(). On cgroup v2, that stores the creating task's
> memcg in sk->sk_memcg and takes a css reference:
> 
> mm/memcontrol.c:mem_cgroup_sk_alloc() {
>      ...
> 	memcg = mem_cgroup_from_task(current);
> 	if (mem_cgroup_is_root(memcg))
> 		goto out;
>      ...
> 	if (css_tryget(&memcg->css))
> 		sk->sk_memcg = memcg;
>      ...
> }
> 
> Could the RX allocation be charged to the socket owner with
> set_active_memcg(sk->sk_memcg) and GFP_ATOMIC | __GFP_ACCOUNT? Another
> option would be to allocate the larger RX buffer in process context,
> e.g. at bind() or setsockopt() time.
> 

