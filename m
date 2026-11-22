Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795372008;
	b=OqXMuz6UJwnDDhygKaC9jaEkJtqtOpbLfno41stLQ1cOpJceB57MdPbr5j1z8FMJT89a
	 HVEYNtLMG17IVK5QtLUrEvucRQIVMPg5fHd1RC8D4CFKc9+awNSuK4jYq0RaAH0fkVSgq
	 1pJzke5Hc8lWTtOv4xpfhDxfI7BK7UZR5YZYfP8CONRHtriMB51tif2siAekczLxDrDUH
	 i1AVnzmm3LLph56soTKxu5n7QMU+wSvokh9D665AzKaGsW1MG+eT6PSEi6oDiSFV5Q+Qf
	 /q7H7lkwsgJNqhTZPt9FHt4J4eMKaiQ1yDZLNzl7/DDxes86LiDJvfWjb34TOXbJ5Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372008;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5wYEEKBskF9QUuL0d8Xestyql9JX9byiIZR6RG/bGjE=;
	b=yohjmdsG6vfMgrkzzrmGJWt4bc01+9F4Jj10fswJ+Uxsd+6PfCw1eOB5OihkNby2Dum+
	 dUx3zDRO7uWvvbPE9LZjYvFqJDK/KV86p8lJMA7F5hKwMKwy44RUJqZqMt77rrxf2jGde
	 ga/y2RHxR5NTeQuJZA3eFb502mzaWgaglbfQuUc0x3ZcGcG3nVnD4mTRUAVTt+5T/esNY
	 p2P8nltUO1TkaD6ANYQdyBx8jeKxeXCt3rgc5xlyfVQqfW8rOtt90PFtnFOjZguRt32SW
	 zcSc7we+qI6Gr0Boj6nHeX3diDzfWLu2YuOZIoD4MAjuhJJb/KlUIYmD5OwtGU66t4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f3qCL75J;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Fs6kJ/tO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC26606A334
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC26606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f3qCL75J;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Fs6kJ/tO
ARC-Seal: i=1; a=rsa-sha256; t=1795371995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lbVTmEZEaiGkTxLBU9OAchJrxhjV5zsueNNITdDwy2sWa/Ph+qsYHgQtbz3gBPuaw3
    IbVodHouqCCac1elh3QvlCsjwCZ+Er/A6lHBGUumMvrWXLcljNUehqCnBoIWdEDYLDBx
    xcLnCP7wLLNE/o7R9VnbjrmmXK7pL+wQjeOYm8yfTHZ2z8YOElgFPstfTeh3pA7DOGO/
    56+gdkLyLF+0waCrSV598At0AaWfac8ipYIhJfthItWeX+vRacBy4KLXnjSeOQ9+pTlU
    hP7FdgP2Tug7/+cAKbKMis9yQWfKMoG11DPQ1rkSujkCRjl9yLVbUqpOTFTB5ttKnkxM
    pvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795371995;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5wYEEKBskF9QUuL0d8Xestyql9JX9byiIZR6RG/bGjE=;
    b=MPi6W/geM4KT3bIIlsBBuTSid0bakdJbZR2iV+RXrrS+XpdQ/BAJ8pjvLj/huE4dma
    0escdgKPv/Js3drmLK6v2oWEDem9ZAXF4KK/H/g+l2s4hdYEqrCbpRje8McAsesPZtMQ
    IN++/c7eJwD43e86E5xSXXNKEiYiZnGjFM2zIm5nJoZcVA6uAKi0qhWLdVX4fhumW1L0
    i0RJY8gb8KqMkBmn4G4hQN2KlzrwI4lFrlkvZZaBEng+DRLltI/KOQx+mIT0/VSwl13T
    8lre74K+bgyK/isYzamH6FjP2jy4PTeiYO0raHP3s1o/PbkrXiU8yRwcEPyNnCfoSFUr
    wdTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795371995;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5wYEEKBskF9QUuL0d8Xestyql9JX9byiIZR6RG/bGjE=;
    b=f3qCL75JdyPc/ENV3IeFwItT43Rh7MSyFeuYgS+D1bqKs2/U5HqtxWJBe8Eb9RLHXe
    7PHZRIjp9K71KzcLoP7fKNliLFpiHfb2jY0868K4JVuMHRm1fiO5HWHoHsI3fn0miJT2
    9nS7yscBCzB924LG87ROqe0srOhBqVL0QZziW//OJwFxDFcPpJyT9IYUhnEIGRbcyu2R
    YsPAmjsslldh66vQBfqJ33oVfWp9pMokfOIwL6cTd8bhfbruTGRDFCYggCcFQLDCP/sn
    cr76BnGKEALIpbGwObRU3rY+TIz5UiibfR5UVvquKD19oFnCraEYWRGhvuuy8joIeBEq
    lk/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795371995;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5wYEEKBskF9QUuL0d8Xestyql9JX9byiIZR6RG/bGjE=;
    b=Fs6kJ/tOylmgzyeRw1VCVSZ2ghl4CoEYtutDlV9sULgEs/xbUaGwl+Z9zFwJXCXGcK
    byluZS5tc2Fkx0MA0FBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AMIQYYi7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 22 Nov 2026 19:26:34 +0100 (CET)
Message-ID: <663b215f-5746-4473-976b-48a72e519f9f@hartkopp.net>
Date: Sun, 22 Nov 2026 19:26:34 +0100
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
Subject: Re: [PATCH v7 7/8] can: isotp: reject socket options while a transfer
 is active
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
References: <20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net>
 <179531305000.3131.3851387722489339935@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179531305000.3131.3851387722489339935@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Both findings belong to the scenario that has already been discussed
for v6 of this patch:

https://lore.kernel.org/linux-can/8cf5687f-4dd4-42f9-b459-5e192b2bcdd5@hartkopp.net/

They require a concurrent setsockopt() or bind() on a socket whose bound
CAN device vanished, while a sendmsg() on the same socket is still in
progress. A regular application gets ENODEV and closes the socket in
this case. Such a scenario can only be created on purpose, does not lead
to memory corruption and affects only the socket of the caller.

On 22.11.26 03:04, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch gates isotp_setsockopt_locked() (net/can/isotp.c, lines
>    1733-1739) on tx.state/rx.state == ISOTP_IDLE.
> - [Low] The commit message says that reading
>    CAN_ISOTP_EXTEND_ADDR/CAN_ISOTP_WAIT_TX_DONE after the claim means…
> 
> --
> 
> can: isotp: reject socket options while a transfer is active
> 
> This patch makes isotp_setsockopt_locked() return -EAGAIN while
> so->tx.state or so->rx.state is not ISOTP_IDLE, the same way
> isotp_bind() already does. It also moves the reads of the
> CAN_ISOTP_EXTEND_ADDR and CAN_ISOTP_WAIT_TX_DONE flags in
> isotp_sendmsg() to after the transfer claim and the so->bound recheck.
> 
> Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 0b7db1ead7a90..642fec500af9d 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1188,6 +1188,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   		goto err_out_drop;
>>   	}
>>   
>> +	/* read the options after the claim of the transfer */
>> +	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
>> +	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
>> +
> 
> [Severity: Low]
> The commit message says that reading these flags after the claim means
> "all socket options used by isotp_sendmsg() are covered by this check".
> Does that also hold for so->ll.tx_flags?
> 
> Later in isotp_sendmsg(), so->ll.tx_flags is read only after the state
> has been published, the timer armed and rx_lock dropped:
> 
> 	WRITE_ONCE(so->tx.state, new_state);
> 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
> 		      HRTIMER_MODE_REL_SOFT);
> 	spin_unlock_bh(&so->rx_lock);
> 
> 	/* send the first or only CAN frame */
> 	cf->flags = so->ll.tx_flags;
> 
> isotp_tx_timeout() takes no lock and can cmpxchg() tx.state back to
> ISOTP_IDLE. That happens if the sending task is delayed past the 1s/2s
> timeout after spin_unlock_bh(), for example by CFS bandwidth
> throttling, RT starvation or a vCPU stall. A malformed or OVFLW FC
> handled in isotp_rcv_fc() can reset the state in the same way.
> 
> Suppose the bound device is also unregistered in that window, so
> isotp_notify() clears so->bound. isotp_setsockopt_locked() then passes
> both the -EISCONN check and the new IDLE check. Its CAN_ISOTP_LL_OPTS
> case does memcpy(&so->ll, ll, sizeof(*ll)) at the same time as the
> plain read of so->ll.tx_flags above.
> 
> The impact looks limited to a data race on a single u8 that KCSAN can
> flag. The device is already down by then, so can_send() rejects the
> skb with -ENETDOWN.
> 
> Could cf->flags = so->ll.tx_flags be moved before the final
> spin_lock_bh()/hrtimer_start() block, so that the commit message claim
> holds?

The CAN device is already gone in this case and can_send() rejects the
frame, so no frame with partly updated options is sent at all.

> 
> [ ... ]
> 
>> @@ -1726,6 +1730,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>>   	if (so->bound)
>>   		return -EISCONN;
>>   
>> +	/* A transmission or reception that outlived a previous binding
>> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
>> +	 * socket options, see isotp_bind().
>> +	 */
>> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
>> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
>> +		return -EAGAIN;
>> +
> 
> [Severity: Low]
> This comment points to isotp_bind(), which says "the FC/echo and RX
> watchdog timers bound how long this takes". The commit message makes
> the same point:
> 
>    As the transmission and the reception always end by their timeouts at
>    the latest, this state is only temporary.
> 
> Is that accurate for the window in isotp_sendmsg() between the claim
> and the final hrtimer_start()? Under rx_lock, isotp_sendmsg() cancels
> all three TX timers and moves tx.state out of IDLE:
> 
> 	hrtimer_cancel(&so->txfrtimer);
> 	hrtimer_cancel(&so->txtimer);
> 	hrtimer_cancel(&so->echotimer);
> 	...
> 	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
> 
> It then calls memcpy_from_msg(), dev_get_by_index() and
> sock_alloc_send_skb(). No timer is armed until
> hrtimer_start(tx_hrt, ...) near the end of the function.
> 
> memcpy_from_msg() can block on a user page fault, for example with
> userfaultfd or a FUSE-backed mapping. A blocking sock_alloc_send_skb()
> can wait up to sk_sndtimeo, which defaults to MAX_SCHEDULE_TIMEOUT.
> 
> If NETDEV_UNREGISTER clears so->bound during that window, setsockopt()
> and bind() would keep returning -EAGAIN until sendmsg() makes progress,
> not just for a period bounded by a timer.
> 

This only blocks the caller's own socket until its own sendmsg()
returns.

The caller only harms itself: the frame is not sent and its own socket
returns -EAGAIN until its own sendmsg() returns. Other sockets and other
users are not affected. At most, the receive path can still send a
single, possibly inconsistent, flow control frame on the caller's own
target CAN device, as described in the referenced mail.

The regular sequence for a CAN_ISOTP socket is setsockopt() -> bind() ->
sendmsg()/recvmsg() -> close(). When the bound CAN device vanishes, the
application gets an ENODEV error and either closes the socket or binds
it again, optionally after setting new socket options. While a transfer
is still pending, this returns -EAGAIN until the transfer has ended. To
reach the described windows, the caller has to move or remove the CAN
device itself and fire setsockopt() and bind() at its own socket without
waiting for this error, while its own sendmsg() is still in progress.
This is a pointless misuse of the socket API without any gain for the
caller.

Covering these windows would need additional and possibly complex
locking between isotp_sendmsg(), isotp_notify() and setsockopt()/bind(),
which adds complexity to the transmission path for every regular user
without any benefit. Therefore the code is not changed for these
scenarios.

Best regards,
Oliver

> There is no memory-safety issue here. Could the comment and commit
> message be updated to describe this case?
> 
> [ ... ]
> 

