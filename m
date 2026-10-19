Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792428910;
	b=ggBrgXv86QOO1/w0tjNvfCSlKj/sDTkRHNPdvMS/B6ExOXRk2YEIdhDhISDuGBrmEK+D
	 o+AxZjvm6fXR3sn9nrqXSJh8SDc6EI0JWxomEFy259PJAabHof+9RiahucrJ7ipeirkJ5
	 kmiWdsaEnnNvnZtcqleXB7qyRYqHLJJhbu5vELxlcSn1uEbEb2nnZndyBKKDcfPgdrZ9Y
	 Q5M94Oveq6a36W0xaeLlT7vqOjcvCoZojKQLfQjdD9B7/tsWWNxxLNfya2HxUmd6wrCk3
	 nZrs6Q+fhtDh07s+RT4zdc0YYxUzHVVlXyGOpCgfk3Dzj6r4JreT0c+jH8V7bTFS/OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428910;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=25ht40xsUnjoF6cIeZGXfaQqy73ylTv6+L7Vod7bljA=;
	b=hR//aG68q1InZddPrQwT0vvn9Qr3ohF2WsQBEcw7nQSgola7g7k7knZwMqV2drSR0oC5
	 deH96WSc5AGfqLx8W570iprkmDPRwNU87mG4y7L3fRfN3iSyXJIoLjcfSu6svCLR/r5LW
	 fVOtuf5ruvJ1F6NAtMZhbWrhdgrDQPdDUG2Ngp67VkaCcXnnWXJuFlgE6SJuMahYNbL45
	 vZGm7DYnZeYiOTZ413qrtIkTAmygDaGcPivuE1i2CGIMEzlye+E1CULcZYDAqCXa4quvJ
	 nqa+IIugFBy4ywgZXDDpZ0lLtkW/AJxgC3gBRvCvzEQgqPUB58u5/ZfMPN7bw/HSQUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XhPdhAng;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="m/EsOQ+J";
	arc=fail smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356B606A31F
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4356B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XhPdhAng;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=m/EsOQ+J
ARC-Seal: i=1; a=rsa-sha256; t=1792428897; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o0WO8vRykPaIFXi/3seSGn9IxS81IItctZsuyDYWB6/FPykukJMjDn6ATBSXnhAxOs
    QmLyUEMa/jOUI0l6V5FZSlOKk+6w9TLSiXLCwDin4HPGS8eJOtjfIljUiG4B6pL44+Os
    armSBfdIgWqPq4K6vtYdTB3cs3BzmXOOTHTBcZ8O80C2PWorWEC418Cc7guySrhJbcyC
    xHl6jFtof3baVAFPlhI7ocFZS9xMeQCiNrq5QUf8QMY+ggFutWdTbUL/NTOiJiO9jVg6
    9k0OdtasyeUhFZ7lDBwDyOgxNFLQiHLSzT/JRrex4B9ns8Zhe8ltIlQJjetEE65oXgFH
    1HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792428897;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=25ht40xsUnjoF6cIeZGXfaQqy73ylTv6+L7Vod7bljA=;
    b=mpz/pJSxefiQr2Sd8s8UmRg5rVGq/S4ZaMcxxXcCXs0AIHkRux2/DlwKKFPn6i4Ysm
    /lBXfzJkgRRT5GzJp6DNBJ1rb/SnQEhCkJi3YRqGK6v9CagF7wiDHRwgzkIwNVlQLHht
    tfwBwZcAVHb3D/NANVCH+1K30qw4gEjmnj5k4Y30v1eW8gUBAPTjlg1c/aZ/xEX+7q/V
    gJKt8BBGogOFe6k5WTRJjxKPAAlxfJ/dWIISGYYncNlYY2+0tL788tl3n5LS4Q+It2Tw
    DmgYlFKQoPvWLhvXKgjuQb5H+tTMK0RyMwfhfwUy4S5bWvQhez/yTZJov9ouu+Zf6uqj
    qnmQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792428897;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=25ht40xsUnjoF6cIeZGXfaQqy73ylTv6+L7Vod7bljA=;
    b=XhPdhAngUHSqXjpueM7upWFWDf5qCsPGi928mLn9fT73IlPtEOcVBxDSnp1oEku5Lg
    rvlf9/0QHS0Cb6HHlgIgNfPdWeTaVNXsm+Nn11/9F1mZRO4ub7HCXNAW34loMgWwxlh1
    KL31II+K40mq+2tbgpfcjUmWFgtOPD6qMQGNvumbhy094pOzmJvqDKOuE3zm+aQJb0iu
    HDtTVS29BzYeYL6Huj5W2nlb5XsVrbGmrl1+9Txbl+fZ7lh0HBtwT9yiEbvJP4RvErRv
    0S9tZYF2gfFuKgl/pyrsLovb5voYZjkNNw3mFubEPMzH3mn+e17iulh4n439e+yF116U
    NbIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792428897;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=25ht40xsUnjoF6cIeZGXfaQqy73ylTv6+L7Vod7bljA=;
    b=m/EsOQ+J/2obgt75IArx2sC+7onUDLncE623sd6XSZdhh7ZvL/T8w4t/S7ywazwq2c
    LaqL8vW8TK0wCpD3W7BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JGsvXn3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 18:54:57 +0200 (CEST)
Message-ID: <f3059d51-ec05-4ff9-8d24-159eeb0b1281@hartkopp.net>
Date: Mon, 19 Oct 2026 18:54:51 +0200
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
Subject: Re: [PATCH net-next 05/12] can: proc: reset pkg_stats atomics
 individually
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-6-mkl@pengutronix.de>
 <sashiko-outbox-177945@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-177945@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.10.26 18:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] can: proc: pre-reset local snapshots overwrite zeroed stats in can_stat_update()
> --
> 
> commit 569f80e5a195e52b5ac88d8f5cdb36714d69c5db
> Author: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> can: proc: reset pkg_stats atomics individually
> 
> This patch replaces the whole-struct memset() in can_init_stats() with
> can_reset_pkg_stats() to reset atomic_long_t counters via atomic_long_set()
> and scalar fields individually. It also uses atomic_long_xchg() in
> can_stat_update() to fetch and clear the *_delta counters atomically.
> 
> Link: https://patch.msgid.link/20261016110905.422684-1-socketcan@hartkopp.net
> 
>> diff --git a/net/can/proc.c b/net/can/proc.c
>> index de4d05ae34597..70104f13077e0 100644
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
>>    * af_can statistics stuff
>>    */
>>   
>> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
>> +{
>> +	atomic_long_set(&pkg_stats->rx_frames, 0);
>> +	atomic_long_set(&pkg_stats->tx_frames, 0);
>> +	atomic_long_set(&pkg_stats->matches, 0);
>> +
>> +	pkg_stats->total_rx_rate = 0;
>> +	pkg_stats->total_tx_rate = 0;
>> +	pkg_stats->total_rx_match_ratio = 0;
>> +
>> +	pkg_stats->current_rx_rate = 0;
>> +	pkg_stats->current_tx_rate = 0;
>> +	pkg_stats->current_rx_match_ratio = 0;
>> +
>> +	pkg_stats->max_rx_rate = 0;
>> +	pkg_stats->max_tx_rate = 0;
>> +	pkg_stats->max_rx_match_ratio = 0;
>> +
>> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
>> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
>> +	atomic_long_set(&pkg_stats->matches_delta, 0);
>> +}
>> +
>>   static void can_init_stats(struct net *net)
>>   {
>>   	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
>>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>>   	/*
>> -	 * This memset function is called from a timer context (when
>> +	 * This stats reset is called from a timer context (when
>>   	 * can_stattimer is active which is the default) OR in a process
>>   	 * context (reading the proc_fs when can_stattimer is disabled).
>>   	 */
>> -	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
>> +	can_reset_pkg_stats(pkg_stats);
>>   	pkg_stats->jiffies_init = jiffies;
>>   
>>   	rcv_lists_stats->stats_reset++;
>> @@ -121,9 +144,10 @@ void can_stat_update(struct timer_list *t)
>>   	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
>>   	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
>>   	long matches = atomic_long_read(&pkg_stats->matches);
>> -	long rx_frames_delta = atomic_long_read(&pkg_stats->rx_frames_delta);
>> -	long tx_frames_delta = atomic_long_read(&pkg_stats->tx_frames_delta);
>> -	long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
>> +	/* fetch and clear values for 'current rate' calculation */
>> +	long rx_frames_delta = atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
>> +	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
>> +	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
>>   
>>   	/* restart counting in timer context on user request */
>>   	if (user_reset)
> 
> [Severity: Medium]
> In net/can/proc.c:can_stat_update(), the counters and deltas are read into
> local variables before the reset checks:
> 
> 	if (user_reset)
> 		can_init_stats(net);
> 
> 	/* restart counting on jiffies overflow */
> 	if (j < pkg_stats->jiffies_init)
> 		can_init_stats(net);
> 
> 	/* prevent overflow in calc_rate() */
> 	if (rx_frames > (LONG_MAX / HZ))
> 		can_init_stats(net);
> 	...
> 
> When a user reads /proc/net/can/reset_stats (setting user_reset = 1) or an
> overflow condition triggers, can_init_stats(net) -> can_reset_pkg_stats()
> zeroes all the counters and scalar fields in pkg_stats, and updates
> pkg_stats->jiffies_init = jiffies.
> 
> However, because can_stat_update() does not return early or clear those
> local snapshot variables after calling can_init_stats(net), it proceeds to
> recompute the statistics using the stale pre-reset values:
> 
> 	/* calc total values */
> 	if (rx_frames)
> 		pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
> 
> 	pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
> 					    tx_frames);
> 	pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
> 					    rx_frames);
> 
> 	/* calc current values */
> 	if (rx_frames_delta)
> 		pkg_stats->current_rx_match_ratio =
> 			(matches_delta * 100) /	rx_frames_delta;
> 
> 	pkg_stats->current_tx_rate = calc_rate(0, HZ, tx_frames_delta);
> 	pkg_stats->current_rx_rate = calc_rate(0, HZ, rx_frames_delta);
> 
> 	/* check / update maximum values */
> 	if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
> 		pkg_stats->max_tx_rate = pkg_stats->current_tx_rate;
> 	...
> 
> Doesn't this immediately overwrite pkg_stats->total_rx_match_ratio,
> current_rx_match_ratio, current_tx_rate, current_rx_rate, max_tx_rate,
> max_rx_rate, and max_rx_match_ratio with pre-reset values right after
> can_reset_pkg_stats() cleared them (with max_* and match ratios persisting
> across subsequent timer ticks)?
> 
> Additionally, if jiffies advances between the initial snapshot of j at the
> start of can_stat_update() and pkg_stats->jiffies_init = jiffies in
> can_init_stats(), the subsequent check (j < pkg_stats->jiffies_init) will
> evaluate to true, calling can_init_stats(net) a second time and passing
> oldjif > newjif into calc_rate(). And if an overflow check on rx_frames,
> tx_frames, or matches triggered the reset, the rate and ratio calculations
> still run with the overflowing local values.
> 
> Should can_stat_update() re-arm the timer and return early when a reset
> occurs, or perform the reset checks before snapshotting the counters?
> 
> [ ... ]
> 
>>

Is fixed in a follow-up patch:

https://lore.kernel.org/linux-can/20261019152741.54854-3-socketcan@hartkopp.net/


pw-bot: cr

> 

