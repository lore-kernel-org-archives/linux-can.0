Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794210981;
	b=gyaINtbP8MWQnjNupTEI0UsFLNc7fWXzOv7oUR5zSjYi3rYJEpwFeu+Ic8oiMyGtHIHl
	 0npY1rQAbdBx0tP7VdVJAe5dY6fQQ1rBu461aYkULRV6pTRgAYzJfvzb8A7vM9AdV6x17
	 JOrHsuLiIumtEdRYwK/CYL4WlZAiXsJjGmbFVnKeHYXoKzBDDYNMm3jxSi9zvjTXjLk1a
	 RtSlMA/UAlFWIuQtasRTxq9oxPPRiWeerZ1Z2v8KicFItTXYdI/fQeH7eNueMrVdIifan
	 iswffvBgOGNSqI5xa1K1sgANu2XLZ0VMC1a5akVm4ET0GbtmO5DWF9SuRABP9elLJfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210981;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w5XC+GU+MInRvjHBNPzUG7GXXBDsBrKQuzUAQ/UXrx0=;
	b=FnvjgM+UIyOzG64ytqarFOgpeuyAYCGWe6hC4cPoP1nD+t4jSSMmgEVmqtcaOSzsOI2X
	 DPMvErcct1+B5vQYBIHHDNuizAGu9Ne7rIiKot0fwJMe1hMN2XoQi+InzskjSXdKbtLgJ
	 OTAYXblPkcNuEldAdSMPOdxn3CD8M++qELC0LhEslbk5DTdCqRxmGsCVW9oPemWgRjkRk
	 9PfiVxJotxq3B4ZldgDj63PMQwNKtb4WOMAwTd+qfoEkPlwIA+1HAXA32PnXtImQSEu9l
	 7X3CZmRBSLj76Q2PG1Qz5XeukAuvqxQLDwjZLIuidtIis9uCMGhMhWyk4Xy9AAKGuUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mU7wgen4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9IUSAZUk;
	arc=fail smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916D606A337
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A916D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mU7wgen4;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9IUSAZUk
ARC-Seal: i=1; a=rsa-sha256; t=1794210970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O0Lps8ECZKqgIr1u9fAbHw6QrK4vhgxbEJQyfyE2uXCfRSibQCLuMswPaXyTz2dX1R
    Ubg6T33IqadP8YEST9BAaMzXnvU5SliR++ZoKDKzPdbA9PpztizrvSXN8eArzDTKC9DJ
    El14FQJypUI8uloZQNQBNlv4Hr3Sv0gAwBna29bDEDvw5Q3bXdMu2ZqLdyRnJboXFMmH
    9cvACnKi8cBTKtS89SDxmIRqy9qkTJnRw0sAouks3gsxpq7CaesJfn+3AqPF/oYH59hg
    0Cnmb0ZmDLQOxuwrnVsnSdnfhY8fY1dIAIVPfmS5SWtdMhflGpSHaD4xQ7XWXApg5tGu
    97zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794210970;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w5XC+GU+MInRvjHBNPzUG7GXXBDsBrKQuzUAQ/UXrx0=;
    b=h9fNcG9an0Ari/yQNqED8ceF/9l1nue/LE6Q4NxcFb9PjqAKvKIByq/7fOfKBeR9dx
    Mpw0pBu9DqRsWJiNSHWcS5O4tFoEIyyXJ+5NuI/KwprIjF32BB9+PYkx7ya62h+VgQX1
    H5pSj76PJKcWxBnfCMyKkOhCrLhnfa6egwB3mKDfuq17GWKFQn5D27sCQ5HzCcBYM5G3
    Kr3AdsQOFATy+gzMCJuzONAHQEowbD2Z8mEaSK8bEq45ma0tyHM0B165I6U+qUxIF0YQ
    zZFUpzDWwvxfgzTDQYSEU8Le6pFERpbt0fpnLZ6Yan2cQ6Sh8kAUxx0n4O9IcZ/8b/Rv
    /eCw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794210970;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w5XC+GU+MInRvjHBNPzUG7GXXBDsBrKQuzUAQ/UXrx0=;
    b=mU7wgen4RbxpisaEKpiBaFT91SnmKgzinnAiB2RPOi8G92uMcPwvtwXcGefPGUBeI3
    i9lpU68w+gMdrUn4+hBTybzwJuZrFkt72pZFaRJbQgDyCX01xKTzRKKVtQGPAoRQ09HF
    91Va9P8kdCO57ZY7bV7xPc1yxxxFPzOs9RRGc40jAOGo6qNFabcupo7r11ILVU2zarD+
    uTRHjPXiqYepyKaY+W4w67XVAw/b4m3/diJaZXRyGmQH1BB75/tVisxiwqQ+QEnG0q3t
    gx4ztYNIoAyQZGDUyBZtr1GyN6rFIiBJTkfpucLkSJtPFq50e79iSWvOTm7aN2dgrnZC
    RweA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794210970;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w5XC+GU+MInRvjHBNPzUG7GXXBDsBrKQuzUAQ/UXrx0=;
    b=9IUSAZUkTuaNPUMOJs9UeYN5QVUgSCGfUEcEIh5oLeHPxSRXNH6PRRXfZPJlPfSVuG
    EtOmwlVA6S+X8N/+MsBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A97u9qjb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 08:56:09 +0100 (CET)
Message-ID: <1c69ebd8-aade-49cb-8b9e-e665c055566c@hartkopp.net>
Date: Mon, 9 Nov 2026 08:56:04 +0100
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
Subject: Re: [PATCH 1/3] can: bcm: copy the CAN frames outside of lock_sock()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
 <179419070782.488853.4274206106803700746@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179419070782.488853.4274206106803700746@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.11.26 03:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch does not close the RTNL-blocking vector that its
>    commit message describes.
> - [Low] The new comment on the stack buffer in bcm_sendmsg() (`struct
>    canfd_frame sframe; /* buffer for a single CAN CC / FD frame */`) and…
> 
> --
> 
> can: bcm: copy the CAN frames outside of lock_sock()
> 
> This patch moves the user space copy of the CAN frames for TX_SETUP,
> RX_SETUP and TX_SEND in bcm_sendmsg() to before lock_sock(). The frames
> go to a stack buffer or a kvmalloc() buffer and are handed to the opcode
> handlers through a kvec based msghdr. The goal is that a stalled copy
> can no longer hold lock_sock() while bcm_notify() waits for it under
> RTNL.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 7bd2aa39777af..9c39f7363ca59 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1643,6 +1643,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	struct bcm_sock *bo = bcm_sk(sk);
>>   	int ifindex;
>>   	struct bcm_msg_head msg_head;
>> +	struct msghdr fmsg = {};	/* CAN frames copied to kernel memory */
>> +	struct kvec kv;
>> +	struct canfd_frame sframe;	/* buffer for a single CAN CC / FD frame */
> 
> [Severity: Low]
> This isn't a bug, but this comment and the commit message don't match
> what the code does. The commit message says:
> 
>      A single CAN frame is copied to a buffer on the stack, multiple
>      frames to a kvmalloc() buffer
> 
> The code picks the buffer by byte size, not by frame count:
> 
>      if (flen > sizeof(sframe)) {
>          frames = kvmalloc(flen, GFP_KERNEL);
> 
> sizeof(struct canfd_frame) is 72 (CANFD_MTU). For TX_SETUP or RX_SETUP
> without CAN_FD_FRAME, cfsiz is CAN_MTU (16). So 2 to 4 classic CAN
> frames (flen of 32, 48 or 64) land in sframe, and kvmalloc() only starts
> at the fifth frame.
> 
> Could the comment and the commit message say the stack buffer holds up
> to sizeof(struct canfd_frame) bytes? A later change that trusts the
> "single frame" wording, for example shrinking sframe to struct
> can_frame for the CC case, would let the byte-size check overflow the
> stack object.

Correct. Reworded the commit message in v2:

Up to
sizeof(struct canfd_frame) bytes, i.e. a single CAN FD frame or up to
four CAN CC frames, are copied to a buffer on the stack, more frames to
a kvmalloc() buffer of up to MAX_NFRAMES + 1 CAN FD frames.

https://lore.kernel.org/linux-can/20261108-can-bcmlock-memcg-v2-1-19fafdfc9d12@hartkopp.net/

pw-bot: cr

> 
>> +	void *frames = &sframe;
>> +	size_t flen = 0;
>>   	int cfsiz;
>>   	int ret; /* read bytes or error codes as return value */
>>   
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
> [ ... ]
> 
>> +	kv.iov_base = frames;
>> +	kv.iov_len = flen;
>> +	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
>> +
>>   	lock_sock(sk);
> 
> [Severity: High]
> Can RTNL still be blocked the same way through other paths on a CAN_BCM
> socket?
> 
> The commit message names the root cause as bcm_notify() taking
> lock_sock() of every CAN_BCM socket in the netns while RTNL is held:
> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }
> 
> That part is unchanged. bcm_ops has no .setsockopt or .getsockopt, so
> SOL_SOCKET options go to the generic sk_setsockopt(), which copies user
> memory while holding the socket lock:
> 

Right, but not focus of this patch. Added this to v2 commit message:

The generic SOL_SOCKET options in sk_setsockopt() and sk_getsockopt(),
e.g. SO_ATTACH_FILTER, still access user space under the socket lock.
This is not specific to CAN_BCM and not addressed by this patch.

In fact this is not CAN specific and sk_attach_filter() is not used 
together with CAN as we have our specific filtering infrastructure.

> net/core/sock.c:sk_setsockopt() {
>      ...
> 	sockopt_lock_sock(sk);
> 
> 	switch (optname) {
>      ...
> 		ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
> 		if (!ret)
> 			ret = sk_attach_filter(&fprog, sk);
>      ...
> }
> 
> sk_attach_filter()->__get_filter() then does:
> 
> 	if (copy_from_user(prog->insns, fprog->filter, fsize)) {
> 
> fprog->filter is a pointer chosen by the user, and outside of TCP no
> capability is needed. SO_ATTACH_REUSEPORT_CBPF follows the same path.
> SO_GET_FILTER->sk_get_filter() also writes to user memory with
> copy_to_sockptr() while sockopt_lock_sock() is held.
> 
> So an unprivileged user in a user and net namespace could do:
> 
>      open CAN_BCM socket
>      setsockopt(SOL_SOCKET, SO_ATTACH_FILTER) with fprog.filter on a
>        FUSE backed mapping that never completes the fault
>        -> __get_filter() stalls with the socket lock held
>      delete the vcan device (or tear down the netns)
>        -> bcm_notifier()->bcm_notify()->lock_sock() sleeps under RTNL
> 
> Isn't that the same scenario the commit message describes as fixed? The
> statement "The generic SOL_SOCKET options in sk_setsockopt() are not
> affected by this patch" doesn't say that this path can still block
> RTNL, and it doesn't mention the getsockopt path.
> 
> bcm_notify() still takes lock_sock(sk) under NETDEV_UNREGISTER after the
> later patches in this series ("can: bcm: do not remove the procfs entry
> in bcm_notify()" and "can: enable memcg accounting for user triggered
> allocations").
> 
> Would it be better to change bcm_notify() so it doesn't sleep on
> lock_sock() of unrelated sockets under RTNL, or to defer the per-socket
> cleanup out of the RTNL section? Either of those would replace moving
> individual copies in bcm_sendmsg() out of the lock.
> 
>>   
>>   	/* Re-validate under the socket lock: a concurrent bcm_notify()
> 
> [ ... ]
> 

