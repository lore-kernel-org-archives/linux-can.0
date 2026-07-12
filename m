Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104413B4EA5
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887253; cv=pass; b=f4TIwdUXzbtSi+qGMNgG4f/fZyHVD/ymx+4zeQuIV4IwbpZU2bvqEbrV0z9OzqWVabbfuBjsYPEnqgdl1tIjE01qsKMJVE+0kXbMEhFTuFDZuosOZJt8hM/l790AQz+g6+MjwRESALmIb+7sG5axr92K3jqdWsbUx7MnN9nEAok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887253; c=relaxed/simple;
	bh=quJw/9eg3dSPtaNEhNL8+jsHT+YCtIwnC7XYgjpJogE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJwlEMq7kcsAUI8todqm6Sd3uK5qBF03XN0QfgyalkGma9IKmOGj4Y9a2vEVoOIvmetiPWKifnxTBc1vTBUJl0nmEOhFZxScIYPzRdYOfj6ItSSGb8h9PNzUEOZUvQbAV0QDkpcbcRJHDN4CZl8+CXzy1LxC/zla7Z+XRDqgMaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XQirbFND; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KX8lrWj1; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XQirbFND";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KX8lrWj1"
ARC-Seal: i=1; a=rsa-sha256; t=1783887053; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BdJLqHMIYV3kWvd5PAlIONVeCyc7DfxZohtZxVCPhDZG/GsDFYp7a0GGaqYsw7xHHw
    PCULUSsGgTfCU5CS6PYphP/kulU2zd3vYCpDVrTioaNgC/64OtowQpO1aqTGP3XqUK67
    FbbPxQ5dXQs2d/Uj7cpZlW/9iSFQdRyWJpPSgiVcMUknMxgmbKILqqP7dwDnXy6LmXYI
    sot9XvHiFvPNhrUUVza5ltMLgXqiDbNhH5HVr/GHNXwC43VegTV0zoRJ3dCjRv+tzrAA
    D7Db81SToAy/pWLfkgJQZTX8sys28k25gswE1eLZGTUKgh8xP4hJZk2VogxW5J4aN2ds
    c8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783887053;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Hhdw8DhfQ/tHWqsiqMfJOsU/+wVD0OgOULQBXkpjwk8=;
    b=jXE/PT8OOq4hVh/UrTS7GqGkTRtzbfnyvZ4/2VSOowAH1QegJER4+y8a6q5YDHepKC
    aGPYJghBn/PCZHeSHIeK+k06yTilL2iOUychRSzby+TvRbtraF6y+5BwopcsD8LiiQKc
    ZJbNR2RDYT6YJZwkP4ld9xYVTALTR1zKwNPfVFjp9wgvDgRVV0J8udqVKKV8MkOXlKmb
    4As7r19PGrUan2EgCKT4j+yfDB1hlWv8oRxt0vh0dASR0hmjZZvsFWye23iYLx1+8Vt0
    3MOPvpfFUmrTb4CbRJWcII5yAq9Ow2yDniP3tyZAUR3nZN3M/bN6u0zkBbzBoWq8BNBK
    qifA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783887053;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Hhdw8DhfQ/tHWqsiqMfJOsU/+wVD0OgOULQBXkpjwk8=;
    b=XQirbFNDOKXkbTdRCcASUyBuJkX0yizMgngiQgmX83kxrI4uOQT45r9XQsL+fXdQvF
    lffRxIQdghfbHOkhQwvdFeHWyj4Weg2D0KEau+vOzkqKrn+iA8WQ8WfRU5tQQc7OUvS5
    wvKduO0OE811/kI6cRnkjNLKnU8ECpLMz+g9Fx9m1lDiCo1xCgv5GawidbjCl0e5L5G+
    WwxH3u1UYwb52pctfvyLEK4t/9eprhRJFE/RgqUixKt8pqmDzJeJQ6TgsZxmVKqJqqCh
    4zMH8OBW63aP8AKwViysU2YViQLbFtvFMbcoCYTUljIvwa0tQkhJ3//1ZOVsWT13YvgY
    PCKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783887053;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Hhdw8DhfQ/tHWqsiqMfJOsU/+wVD0OgOULQBXkpjwk8=;
    b=KX8lrWj1cyeSZfj8etmCcGU/gplyt0KI9QxUuU7toen3XKtvYCfGCGF6+QPhFDK6wh
    ZRLxBthgj6ATEWQHMbDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.178]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26CKAqWNy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 12 Jul 2026 22:10:52 +0200 (CEST)
Message-ID: <92a2b9a2-6f09-4fd9-bf83-eb6cbe217e49@hartkopp.net>
Date: Sun, 12 Jul 2026 22:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] can: isotp: serialize TX state transitions under
 so->rx_lock
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
 <20260712-isotp-fixes-v10-3-793a1b1ce17f@hartkopp.net>
 <20260712181155.B42EA1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260712181155.B42EA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12.07.26 20:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Lockless state transition in the timeout handler creates a race condition that causes timeout errors to be silently dropped or misattributed, leading sendmsg() to erroneously return success for timed-out transfers.

The patch set fixes potential UAF and stalls.

The error return codes especially for (uncommon) multi-threaded users 
have been there for years and might be fixed in later patches.

So no reason to delay this patch set.

Best regards,
Oliver

> --
> 
> --- Patch [3]: [PATCH v10 3/3] can: isotp: serialize TX state transitions under so->rx_lock ---
> commit e21ce85bab56b1b57ffd11ce2b23b760bfb72c21
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: isotp: serialize TX state transitions under so->rx_lock
> 
> This commit serializes CAN ISOTP TX state transitions and timer cancellations
> under so->rx_lock to prevent concurrent modifications. It also changes the
> timeout handlers to locklessly cancel transfers by checking and updating
> so->tx_gen and so->tx.state.
> 
> Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 44c044eb83e12..54becaf6898f1 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> [ ... ]
>> @@ -893,53 +927,83 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
> [ ... ]
>> +static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
>>   {
>> -	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
>> -					     txtimer);
>>   	struct sock *sk = &so->sk;
>> +	u32 gen = READ_ONCE(so->tx_gen);
>> +	u32 old_state = READ_ONCE(so->tx.state);
>>   
>>   	/* don't handle timeouts in IDLE or SHUTDOWN state */
>> -	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
>> +	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
>> +		return HRTIMER_NORESTART;
>> +
>> +	/* only claim the timeout if the state is still unchanged */
>> +	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
>>   		return HRTIMER_NORESTART;
>>   
>>   	/* we did not get any flow control or echo frame in time */
>>   
>> -	/* report 'communication error on send' */
>> -	sk->sk_err = ECOMM;
>> -	if (!sock_flag(sk, SOCK_DEAD))
>> -		sk_error_report(sk);
>> +	if (READ_ONCE(so->tx_gen) == gen) {
>> +		/* report 'communication error on send' */
>> +		sk->sk_err = ECOMM;
>> +		if (!sock_flag(sk, SOCK_DEAD))
>> +			sk_error_report(sk);
>> +	}
> 
> [Severity: High]
> Does this lockless state transition create a race window where timeout
> errors are lost?
> 
> By setting so->tx.state to ISOTP_IDLE before setting sk->sk_err = ECOMM,
> a thread waiting in isotp_sendmsg() for wait_tx_done might wake up, observe
> ISOTP_IDLE, and read sock_error() before the error is set, falsely returning
> success.
> 
> Additionally, could another concurrent sendmsg() see the IDLE state,
> claim the socket, and increment tx_gen before the error is set?
> 
> If this happens, the check if (READ_ONCE(so->tx_gen) == gen) will fail,
> and the error will never be reported to the original waiting thread.
> 
> [ ... ]
>> @@ -960,13 +1024,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> [ ... ]
>> +	/* new transfer: bump so->tx_gen and drain the old one's timers,
>> +	 * still under the so->rx_lock we just claimed the socket with
>> +	 */
>> +	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
>> +	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
>> +	hrtimer_cancel(&so->txtimer);
>> +	hrtimer_cancel(&so->echotimer);
> 
> [Severity: High]
> When this tx_gen increment occurs concurrently with isotp_tx_timeout()
> after the timeout has already transitioned the state to ISOTP_IDLE, doesn't it
> cause the timeout handler to suppress the error for the previous transfer?
> 
> [ ... ]
> 

