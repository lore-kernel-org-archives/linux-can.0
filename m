Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEE455629
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397338; cv=pass; b=D/GuPlpQofSe4SG3OFC7a2yjJyLr7Z1UOt6RjzFJz5dNnI9QcOPZdVhbDNYwoNBSJM/NxXRWBdKyfsWJ72eQ66IhuZMy+dBLVr3a4BEjcfk5UX3GkGo+83baKnIcBkvPmUuZKstCr80dybW61JaHk56MGpSri9XRbI0IMPy/Mho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397338; c=relaxed/simple;
	bh=reBd+OcjXMbahZaREWZkjeEzFNdSWPfYbBOa+mNDlA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A26eEawbZZFOWgeBeZCT6zcu+EM+oTNmb3j7fJ7QoB4nYckmF/VBnSnVRyTkhgKFPOsTKRxqE03mx/eNHG/3NUg4cqlwRKbnmG3ZvFowGQxXw1NqAtS/SkROO/VsqaXt5WryyE3hErSg4BLnVlg02tLYSmtFhGPte30xKItYywY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eLlCoEnf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5r64w6kW; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eLlCoEnf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5r64w6kW"
ARC-Seal: i=1; a=rsa-sha256; t=1792397321; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KwwuxW2j2qmKXXKQu1N+GEq3u3mE4QBp2GqEFY15Tow6QN36EB4nRBXdBH9kGDo0ex
    WMAt0WLL2cmb9lgkcfNcufu+ibHH90sfxsuywaHVmpxF1cVQuNQfuZPh7UoVAiHNjzkm
    aIjBvT4tbvzIXMdLqDgsIzhzQYq64mVm5nH0f6BlvxDzBa4326SEi3lMsb3SiVvy7Nwu
    Z//W/VRfj7/f/zkMSZmFxikUvcwe8scUf2f/Esz1tFPm9MUL3Kw19lShxWqKhLOoKwSA
    j4CaM/E9g8/1bN1LcbqGFZW4mad4VTrxZnUWrWQftXr3itQe4HY85iv+A69y+7HoaiN9
    b7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792397321;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ax4WbjHhcP3QE1+obLX5BAjM2aDflIruHdjY/HnwNlA=;
    b=jj+PoXlIC66j7DE36Mi/rv8xiDk4TdB0m2SNv91Vf97U4iSsLZxcQ3x5Wmnm/cMw7y
    srSxG6HfytueiB3wC3xc49Adebk66vRL7Mjj+ls3aWbHWxZPBjg0PaGtwA3+H8SOmebj
    FNBokoEAGR3pdh61DdbGPZtfZbwNIelfZcQ9SLvBFDBWbGmznrR+ZL22NXsicpBEpIAB
    zxyLNRkdCZ9oDUHHfq8gOi0TibKmo9ihJjY/ViH/KDzBaS4ncga+zWWi13i/xSSgth+E
    866f0ts1lLZjxm2ALlO/sHr2K7EQSy7/CFB2Q5hoZape3MU3RW6jP0LFjdyX/4vQO+ur
    dCQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792397321;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ax4WbjHhcP3QE1+obLX5BAjM2aDflIruHdjY/HnwNlA=;
    b=eLlCoEnf1j294qyi+YC9Ob+FEggyEwwWU3N/nt1FRvMEI9PeOLC+Vkm6Ml+EeLR0vE
    rkO8KXTxDtzh1jNIPdDUGkIQoh2w4jwtbWLFZQyGZsPpUu+N8+vJ0OuBU675RZ1Hwvq+
    ft7PCmJndAMFZ4gGUlpSse5h/0wIAyUTlVDOcU4ZgL/QESl7jeYJyXki5Z9ZmAbAyFj3
    jXKRYwCCsPeiMj3B4vAwRZhbL8AxsywnPhitxNnmq9Swu3Wz/V+EUa3Su2If3tEbgAlp
    dW8CFmbWdG4CVLcJI84ffyVAWaIsRZiu2ZDPoEI1GyY1VdTC/PjYnfv/hKRWOLBTPsEB
    AnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792397321;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ax4WbjHhcP3QE1+obLX5BAjM2aDflIruHdjY/HnwNlA=;
    b=5r64w6kW4WMowTY8q2PA8C+VinTtW0qU8zk8WIHJ8Qppq5HwH32o1VGYANmDK2NPcl
    L2lzDBXhjVy9rN0XfsBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29J88fV3m
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 10:08:41 +0200 (CEST)
Message-ID: <83241d6c-ae67-4de9-8582-b958ec836dd1@hartkopp.net>
Date: Mon, 19 Oct 2026 10:08:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v3 1/4] can: proc: reset pkg_stats atomics
 individually
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019074244.50391-2-socketcan@hartkopp.net>
 <sashiko-outbox-176764@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-176764@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.10.26 09:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] can: proc: stale counter snapshots in can_stat_update() overwrite reset stats
> --
> 
> commit 947871fd730bb7740551ee6c8b42c7ac5ed61308
> Author: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> can: proc: reset pkg_stats atomics individually
> 
> This patch replaces the whole-struct memset() in can_init_stats() with
> individual atomic_long_set() and scalar field resets in can_reset_pkg_stats(),
> and switches can_stat_update() to use atomic_long_xchg() when reading and
> clearing the delta counters.
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
> Does can_stat_update() overwrite the freshly reset scalar statistics in
> pkg_stats with stale pre-reset counter snapshots after calling
> can_init_stats()?

Yes, but this is not introduced by this patch. The local snapshots were
added by 80b5f90158d1 (the commit this patch fixes) and this patch does
not change the resulting values.

I would rate this as Low, as the impact is limited to cosmetic procfs
statistics:

- total_rx_match_ratio keeps its pre-reset value until new frames are
   received.
- current_* and max_* show the last pre-reset interval for one timer
   period (one second).
- A jiffies tick between snapshot and reset only increments stats_reset
   twice; calc_rate() returns 0 in this case, no crash.

I'll address this in a separate patch with the same Fixes: tag by
returning early from can_stat_update() after a reset.

Best regards,
Oliver


pw-bot: cr

> 
> At the beginning of can_stat_update() in net/can/proc.c, the counters are
> snapshotted into local variables before checking for a reset or overflow:
> 
> 	unsigned long j = jiffies; /* snapshot */
> 
> 	long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
> 	long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
> 	long matches = atomic_long_read(&pkg_stats->matches);
> 	/* fetch and clear values for 'current rate' calculation */
> 	long rx_frames_delta = atomic_long_xchg(&pkg_stats->rx_frames_delta, 0);
> 	long tx_frames_delta = atomic_long_xchg(&pkg_stats->tx_frames_delta, 0);
> 	long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
> 
> 	/* restart counting in timer context on user request */
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
> When user_reset is set (for example, after reading /proc/net/can/reset_stats)
> or when one of the overflow conditions triggers, can_stat_update() calls
> can_init_stats() -> can_reset_pkg_stats(), which zeroes the atomic counters
> and the derived scalar fields (total_*, current_*, max_*).
> 
> However, the local variables rx_frames, tx_frames, matches, rx_frames_delta,
> tx_frames_delta, and matches_delta still hold the pre-reset values when
> can_stat_update() continues immediately below:
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
> As a result, those pre-reset local variables overwrite total_rx_match_ratio,
> current_*, and max_* right after can_reset_pkg_stats() cleared them (and if
> the reset was triggered by the rx_frames, tx_frames, or matches overflow
> checks, the overflowing values are still passed into the ratio and calc_rate()
> calculations).
> 
> Additionally, because can_init_stats() sets pkg_stats->jiffies_init = jiffies
> by reading live jiffies rather than using the snapshot j, if jiffies ticks
> between the snapshot and can_init_stats(net) during a user_reset, the
> subsequent check (j < pkg_stats->jiffies_init) will also evaluate to true,
> calling can_init_stats(net) a second time and then passing jiffies_init > j
> along with the stale non-zero tx_frames and rx_frames into calc_rate().
> 
> Should can_stat_update() re-arm the timer and return early (or zero the local
> snapshot variables) when can_init_stats() is called?
> 
> [ ... ]
> 

