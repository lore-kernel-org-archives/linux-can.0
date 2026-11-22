Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795363082;
	b=Ls0I1M7KxZ4KbKAIYtq1/nW63b0Za/eKrAZHCFjXZ6zZbHjmRoOGtXLriZvknm4XpRm/
	 kUK9jJmfpOqFT7VmuXeCes5QC9fe0Yn07UfjA2ziMYozIS1twUxJQt3k/DdbgJ4c5n8rz
	 1cFfE2Uc+mVX0NuvzqpH7XgOYrAH3qHugKr3OQ38l7IpR7POuDt0ILV3ey6oYaKy9BVfC
	 a9Pj2UWjXKBTL2dXWkOZ5+qKh53h3XuUzXGDBMPrAiZttJ2l7H/8ihFdKE/sSwaqdQs3I
	 xnc8zfYY5MaowWfySJ4LMJC+DYK87wjx5mH2IK34HL9yP8DilvJg53CTPU+cYD4srvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363082;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+wmVmi3iBpaBiezjxFHHG2qC79tQSzWe6ZblYWHggJo=;
	b=T10Em7Rti3Inzpg8B0FyOU+TQAIZ522HM/tCqI+5NS3vEn/n60TOiPDjCGliHJmO7vur
	 vzb4NchUVWao2ph81N0jUUy0DwLbIamVapkKW82faJTBLcTgFwuB4fEX4pU4rwXSOuzDH
	 BN65fx49x70ISzqVx+uNNizzP7EZZtjtavYykIwq9TWNosZs+95sdxB+L87m7FTtIuIsi
	 igrJ/xiP5CpwXSnitfcqns6qRFBHCGONhGOag0hRMGnQXYbfcrnNeBcrkLFlng+OB1Yek
	 ToaaKdyZww0EHFqlw/EcTYHH2pvTq5Kk+Y+GtrkRq1grIPKWG3EWULRJ+MlftJ0K0BQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PuTnlujY;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pYjqM+Gy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95A606A320
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 15:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E95A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=PuTnlujY;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pYjqM+Gy
ARC-Seal: i=1; a=rsa-sha256; t=1795363068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B8SxibQtxKhIWxKQcPFksQycPs++6q528NLgNjsfE7ryRXZTlzl2fayXogHRvdx6cw
    axN8bUzmGSauaJvcjTk4Nk1EvkSy1woxB5oMkUTCv2Hrga8gHT7pPAvu3JOSlFdL52ZG
    0N7O6BC59KzCQfa4UNQT5RoIvuvBMYR5hqGrzEQ/MmKKQLEjm2nWTunYr+SKZf0y/T4J
    x2tihodQKs2ySJ+Eu4C0im9FXR7iGGkf5hEdZV+nB7DdwMjUvva7kj3hjtceSpLR4yVp
    EiB/QhQZw5NgTjKQyAbJ0PVEB7UzhPMXc1B/ylqD1/vueC1B40BivSrUgrFpqrh/9x9W
    8rig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795363068;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+wmVmi3iBpaBiezjxFHHG2qC79tQSzWe6ZblYWHggJo=;
    b=lv32F06ZfrsAHkRWpmR17+pWUGKioO3/78+4A/6UeszseelNUnXS5cACloMe7Dt23x
    n17AdFhB/PYBYfnUSHSVLbt32hiBNK1e5giwTuBa69qlux4l6+5W9JmMIBp6pCbaER89
    y4S+D3fsQ8vupfC3iPIEHIrdulSMQsT8fVpgJDJeyANbHi0zYWt8/xaVeoJspSBll5B+
    yufv963fbPEz/c5gsZT+d7k4kiQVIuBty44Fo/KpRzcJfVOmvRofYcYNzIqBamyuOg6C
    80pONqMiip1hRPFUwMoGFYBvZwYBUxAFmNZkhmHtzaVrmVBEVppPp4hdTTbY3tFS7Bj/
    tLbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795363068;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+wmVmi3iBpaBiezjxFHHG2qC79tQSzWe6ZblYWHggJo=;
    b=PuTnlujYEmEfTn3w4h5nXfu07vyyx0I72gF9BRdzIxHyTmeXCQQBM+szwLsnhuJmOY
    Pu/oLvb9va1bsOAukVJXOtoIi5Ux1UfDqAWYkcmznE6Rrr+S5Gq38eixioxMOLcT2FJj
    11xkkvuaEN9Gh8pNOtz3PRfeeSibNiMMtvg4NR+xd7Esb9nn6XbuS8duTqI8NgC8sxzW
    rD3bjMizb7dWWysT4NhXCSovdw8krDBYG1iSUTvry7zTmJeO1PUArEcrw9bujKvXttTy
    KdEfhf+76Lh+rSjW2oV16JGcOsuMWyrYcIApr3WF3g/hPa/FmVU8EoUnLc6z5Z0ubPAT
    xS4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795363068;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+wmVmi3iBpaBiezjxFHHG2qC79tQSzWe6ZblYWHggJo=;
    b=pYjqM+Gy9Xf90y08UWVGdpuvu9Sefp2FV/2cjR3BL+pQOpNFN+Qa23TiVoYMzr87CM
    2BWFi6ZBa3Bw/SpabMBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AMFvmYI9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 22 Nov 2026 16:57:48 +0100 (CET)
Message-ID: <06097b4b-fec4-4423-a18b-dba817faf608@hartkopp.net>
Date: Sun, 22 Nov 2026 16:57:43 +0100
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
Subject: Re: [PATCH v7 6/8] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
References: <20261120-can-bcmlock-memcg-v7-6-f6b84f5257b1@hartkopp.net>
 <179531304900.3131.6873205153419606406@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179531304900.3131.6873205153419606406@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.11.26 03:04, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] In net/can/isotp.c, isotp_rcv_ff() now arms so->rxtimer for
>    ISOTP_FC_TIMEOUT (1 s) as soon as a First Frame is received, and it…
> 
> --
> 
> can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
> 
> This patch starts the rx timeout in isotp_rcv_ff() and isotp_rcv_cf()
> whenever reception continues in ISOTP_WAIT_DATA, so the socket no longer
> stays in that state indefinitely when no flow control frame is sent. It
> also moves the consecutive frame length checks ahead of hrtimer_cancel(),
> so an invalid CF is dropped without stopping the rx timeout.
> 
> Closes: https://lore.kernel.org/linux-can/179504035916.3136.12986898667697830880@kernel.org/
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 8229b6a69ecd0..0b7db1ead7a90 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -634,6 +634,10 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>>   	so->rx.sn = 1;
>>   	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
>>   
>> +	/* start rx timeout, isotp_send_fc() restarts it */
>> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
>> +		      HRTIMER_MODE_REL_SOFT);
>> +
>>   	/* no creation of flow control frames */
>>   	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
>>   		return 0;
> 
> [Severity: Medium]
> Could this abort valid transfers on a CAN_ISOTP_LISTEN_MODE socket?

A listen mode socket does not take part in the ISO-TP protocol. It only
tries to reassemble the data PDUs from the observed CAN frames on a
best effort basis. Its rx timeout ensures that a reception does not
remain in ISOTP_WAIT_DATA forever when a PDU is not completed.

Listen mode already uses the 1 second rx timeout after every consecutive
frame. This patch applies the same timeout after the first frame, which
was the only case without a running timeout.

The timeout is needed in listen mode as well: without it the rx state
can get stuck after the CAN device has been removed, and an incomplete
PDU is reported with ETIMEDOUT like before.

Best regards,
Oliver

> 
> In listen mode isotp_send_fc() is never called, so nothing restarts this
> timer before the first CF. That means the listener's window for the
> first CF is 1 s counted from the FF, not from the real receiver's FC.
> 
> The listener also never sees the real receiver's FC frames. isotp_bind()
> sends only rx_id to isotp_rcv(). tx_id goes to isotp_rcv_echo(), which
> drops anything that is not its own echo:
> 
> net/can/isotp.c:isotp_rcv_echo() {
>      ...
> 	/* only handle my own local echo CF/SF skb's (no FF!) */
> 	if (skb->sk != sk)
> 		return;
>      ...
> }
> 
> The real peers can legitimately use a longer FF to first CF gap. The
> Linux sender re-arms its timer for each FC.WT:
> 
> net/can/isotp.c:isotp_rcv_fc() {
>      ...
> 	case ISOTP_FC_WT:
> 		/* start timer to wait for next FC frame */
> 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> 			      HRTIMER_MODE_REL_SOFT);
>      ...
> }
> 
> The receiver's N_Cr window also starts when it sends its FC, not when
> the FF arrived. So a transfer with one or more FC.WT frames, or with a
> slow FC followed by a slow first CF, can have a gap of more than 1 s
> and still be compliant.
> 
> In that case the sequence would be:
> 
> isotp_rcv_ff()
>      WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
>      hrtimer_start(&so->rxtimer, 1 s)
>      return 0 (listen mode, no FC)
> 
>    real receiver sends FC.WT (not visible to the listener)
> 
> isotp_rx_timer_handler()
>      sk->sk_err = ETIMEDOUT;
>      WRITE_ONCE(so->rx.state, ISOTP_IDLE);
> 
> isotp_rcv_cf()
>      if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
>          return 0;
> 
> Each CF of that PDU is then dropped, so the listener reports ETIMEDOUT
> and loses a PDU that both real peers completed. Before this patch, the
> listen-mode socket stayed in WAIT_DATA without a timer between the FF
> and the first CF, so such a PDU was still reassembled.
> 
> The commit message says:
> 
>    In listen mode a first frame that is not followed by consecutive
>    frames now leads to ETIMEDOUT, like a missing consecutive frame inside
>    a block already does.
> 
> A gap inside a block does not include the FC round trip, but the FF to
> first CF gap always does. The message does not mention that slow but
> compliant transfers are now aborted for listen-mode users, and the
> patch is tagged for stable.
> 
> Would it make sense to use a longer timeout for the listen-mode FF case,
> or at least to describe this trade-off in the commit message? The later
> patch in the series ("can: isotp: reject socket options while a transfer
> is active") does not change this behaviour.
> 
> [ ... ]
> 

