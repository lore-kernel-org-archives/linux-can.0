Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6B49A3A0
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410917; cv=pass; b=pMwZ9Rs4l1so29YwUhvDf8PgpsYffqyB3FKLcQSsCwKUWuIqNmGx1RmNP1Vrtqnj9KSRhcYd/b/hrGJtQqu3fekAQvzmws+gBVH98gaFMtxr57bsbFkfJ2xPPNf0XZcP1m9QAXvfpQyzZndFwOV20KInB15VSGIwtiS539ZMUyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410917; c=relaxed/simple;
	bh=7xvuc+ov04DTuhqbjWor5DN/ac2cjVuXB1ANjDTVJRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TqZ5RJF6Mt6DylVD4WsOY+oUSubyAeshr8cblTu3MO2LE33ELhaxoblXRz0VyNkNxCaMj000h9XZjm2ClvWZD3gQO88fwqVOV+HFUpNOtfP5Pj03PjNI0tLHD4i2MOxC0HawfGEAwM9b9imQnH14Bn5Yd9bDEclXHHnpTVskrQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MBVxmJdE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jGs/Pa8R; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MBVxmJdE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jGs/Pa8R"
ARC-Seal: i=1; a=rsa-sha256; t=1792410895; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FXmpnBfTwMVPx596a4CbGBQGY9HdjwdFgS8iOecDQ/I5tEppiS8SjadOLg9pS6CQNp
    sN1PPWC8X61BNXObzXPWLjemEIPpR6/rw1ZIiPvY8M40/UzemN+XASFnuTzpMRL0ZqhR
    6EgN7BtWfogCfQogfLe7YwL0tU3ejsBL8rPOZyrT3W196iiJ/+Q9F3BKJ9vMdFILc/2D
    cZqxZ5YdBfMPMuCN55qcgUie8419H9biJOS2VsdgefxsbVen4MeEi52q9H3HkEwkB45U
    pFRh79cS9FrKyUd1vGlccSPLFhZvSpeXFaF+Mp9GU8Z6ukHZqXakNcRJsXSup6jw3cBV
    vSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792410895;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XwCz7qUomq+PXQwbesAgoWsifthNyysfnnSXLubt1sY=;
    b=AfO5OTdMXguhOJBoZWw0jf+6gVrbi9L44NWCtsSZTLtdnMdNd1ciDPruZgz2Ss3O6E
    GgzNCvah7BDj2cOgZMwQBnET0hT4QqPXcVGqo2NCqL03wGNHLH9X7VyfNdj7iBvCQftQ
    beFfey/gV+wDRdjwOQWN+ZISTZAWe4yaR5gsPcEotCk34meaDgkvpc317dAqQgoU+qu8
    CwgK7hXusxr5kKESt4RYUjuKRmdlDFsB3Z/O0lwRrHWet8sF9pElKjcWvzV0we1Kiekv
    12MdJpktt82NTvZ3Puu7TGqK8GGYghTROkSYlT0lI3T7TzzYVBUkrJk1/zCgQwLAX7QP
    thjg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792410895;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XwCz7qUomq+PXQwbesAgoWsifthNyysfnnSXLubt1sY=;
    b=MBVxmJdE5kymFbWzwme+nTNiiIPyoxZAyKiQmeFLX/z4EzFhcdxkKxKn5WuN3v3/mx
    vRio7wE4NPUpA4edA5caTBjyrYBxZwd1YUXBHo4tX1Pai+/vOgNMJOjWMqCRqN1QDbfy
    xQwsRDnXkaQsJMPgU9Gxs3nGk7x7mjbh81/Z33d2HRYrKXYpks4aBRkf4OfAS5zy7701
    wYRPYoD360alZrIDRyDVDXEdAxydHx9p6WJ3XALVgiIK3lrb1bgqfHLLltwNd3mj+h6+
    oS0xNjtlLVLXeuM/L8SJqBZMW91jbSCsu5VI+WSHR8T9keAejYs+z/xrIkOQWO3Xkg3l
    KlHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792410895;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XwCz7qUomq+PXQwbesAgoWsifthNyysfnnSXLubt1sY=;
    b=jGs/Pa8R/YPdMeT9c6cix3supkLCRpXHkk2qOdL123ad9TmWE+4PJ5UNWh7TnByOwF
    dys/9tGkas5hSpBmAWAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JBssWUf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 13:54:54 +0200 (CEST)
Message-ID: <15d97464-0891-4bd1-a431-f5d3bd2803a2@hartkopp.net>
Date: Mon, 19 Oct 2026 13:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v3 1/4] can: proc: reset pkg_stats atomics
 individually
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019074244.50391-2-socketcan@hartkopp.net>
 <sashiko-outbox-176764@kernel.org>
 <83241d6c-ae67-4de9-8582-b958ec836dd1@hartkopp.net>
Content-Language: en-US
In-Reply-To: <83241d6c-ae67-4de9-8582-b958ec836dd1@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I sent a patch that fixes this sashiko-bot review remark:

https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hartkopp.net/

Best regards,
Oliver

pw-bot: cr

On 19.10.26 10:08, Oliver Hartkopp wrote:
> 
> 
> On 19.10.26 09:53, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [Medium] can: proc: stale counter snapshots in can_stat_update() 
>> overwrite reset stats
>> -- 
>>
>> commit 947871fd730bb7740551ee6c8b42c7ac5ed61308
>> Author: Runyu Xiao <runyu.xiao@seu.edu.cn>
>>
>> can: proc: reset pkg_stats atomics individually
>>
>> This patch replaces the whole-struct memset() in can_init_stats() with
>> individual atomic_long_set() and scalar field resets in 
>> can_reset_pkg_stats(),
>> and switches can_stat_update() to use atomic_long_xchg() when reading and
>> clearing the delta counters.
>>
>>> diff --git a/net/can/proc.c b/net/can/proc.c
>>> index de4d05ae34597..70104f13077e0 100644
>>> --- a/net/can/proc.c
>>> +++ b/net/can/proc.c
>>> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
>>>    * af_can statistics stuff
>>>    */
>>> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
>>> +{
>>> +    atomic_long_set(&pkg_stats->rx_frames, 0);
>>> +    atomic_long_set(&pkg_stats->tx_frames, 0);
>>> +    atomic_long_set(&pkg_stats->matches, 0);
>>> +
>>> +    pkg_stats->total_rx_rate = 0;
>>> +    pkg_stats->total_tx_rate = 0;
>>> +    pkg_stats->total_rx_match_ratio = 0;
>>> +
>>> +    pkg_stats->current_rx_rate = 0;
>>> +    pkg_stats->current_tx_rate = 0;
>>> +    pkg_stats->current_rx_match_ratio = 0;
>>> +
>>> +    pkg_stats->max_rx_rate = 0;
>>> +    pkg_stats->max_tx_rate = 0;
>>> +    pkg_stats->max_rx_match_ratio = 0;
>>> +
>>> +    atomic_long_set(&pkg_stats->rx_frames_delta, 0);
>>> +    atomic_long_set(&pkg_stats->tx_frames_delta, 0);
>>> +    atomic_long_set(&pkg_stats->matches_delta, 0);
>>> +}
>>> +
>>>   static void can_init_stats(struct net *net)
>>>   {
>>>       struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
>>>       struct can_rcv_lists_stats *rcv_lists_stats = net- 
>>> >can.rcv_lists_stats;
>>>       /*
>>> -     * This memset function is called from a timer context (when
>>> +     * This stats reset is called from a timer context (when
>>>        * can_stattimer is active which is the default) OR in a process
>>>        * context (reading the proc_fs when can_stattimer is disabled).
>>>        */
>>> -    memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
>>> +    can_reset_pkg_stats(pkg_stats);
>>>       pkg_stats->jiffies_init = jiffies;
>>>       rcv_lists_stats->stats_reset++;
>>> @@ -121,9 +144,10 @@ void can_stat_update(struct timer_list *t)
>>>       long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
>>>       long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
>>>       long matches = atomic_long_read(&pkg_stats->matches);
>>> -    long rx_frames_delta = atomic_long_read(&pkg_stats- 
>>> >rx_frames_delta);
>>> -    long tx_frames_delta = atomic_long_read(&pkg_stats- 
>>> >tx_frames_delta);
>>> -    long matches_delta = atomic_long_read(&pkg_stats->matches_delta);
>>> +    /* fetch and clear values for 'current rate' calculation */
>>> +    long rx_frames_delta = atomic_long_xchg(&pkg_stats- 
>>> >rx_frames_delta, 0);
>>> +    long tx_frames_delta = atomic_long_xchg(&pkg_stats- 
>>> >tx_frames_delta, 0);
>>> +    long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 
>>> 0);
>>>       /* restart counting in timer context on user request */
>>>       if (user_reset)
>>
>> [Severity: Medium]
>> Does can_stat_update() overwrite the freshly reset scalar statistics in
>> pkg_stats with stale pre-reset counter snapshots after calling
>> can_init_stats()?
> 
> Yes, but this is not introduced by this patch. The local snapshots were
> added by 80b5f90158d1 (the commit this patch fixes) and this patch does
> not change the resulting values.
> 
> I would rate this as Low, as the impact is limited to cosmetic procfs
> statistics:
> 
> - total_rx_match_ratio keeps its pre-reset value until new frames are
>    received.
> - current_* and max_* show the last pre-reset interval for one timer
>    period (one second).
> - A jiffies tick between snapshot and reset only increments stats_reset
>    twice; calc_rate() returns 0 in this case, no crash.
> 
> I'll address this in a separate patch with the same Fixes: tag by
> returning early from can_stat_update() after a reset.
> 
> Best regards,
> Oliver
> 
> 
> pw-bot: cr
> 
>>
>> At the beginning of can_stat_update() in net/can/proc.c, the counters are
>> snapshotted into local variables before checking for a reset or overflow:
>>
>>     unsigned long j = jiffies; /* snapshot */
>>
>>     long rx_frames = atomic_long_read(&pkg_stats->rx_frames);
>>     long tx_frames = atomic_long_read(&pkg_stats->tx_frames);
>>     long matches = atomic_long_read(&pkg_stats->matches);
>>     /* fetch and clear values for 'current rate' calculation */
>>     long rx_frames_delta = atomic_long_xchg(&pkg_stats- 
>> >rx_frames_delta, 0);
>>     long tx_frames_delta = atomic_long_xchg(&pkg_stats- 
>> >tx_frames_delta, 0);
>>     long matches_delta = atomic_long_xchg(&pkg_stats->matches_delta, 0);
>>
>>     /* restart counting in timer context on user request */
>>     if (user_reset)
>>         can_init_stats(net);
>>
>>     /* restart counting on jiffies overflow */
>>     if (j < pkg_stats->jiffies_init)
>>         can_init_stats(net);
>>
>>     /* prevent overflow in calc_rate() */
>>     if (rx_frames > (LONG_MAX / HZ))
>>         can_init_stats(net);
>>     ...
>>
>> When user_reset is set (for example, after reading /proc/net/can/ 
>> reset_stats)
>> or when one of the overflow conditions triggers, can_stat_update() calls
>> can_init_stats() -> can_reset_pkg_stats(), which zeroes the atomic 
>> counters
>> and the derived scalar fields (total_*, current_*, max_*).
>>
>> However, the local variables rx_frames, tx_frames, matches, 
>> rx_frames_delta,
>> tx_frames_delta, and matches_delta still hold the pre-reset values when
>> can_stat_update() continues immediately below:
>>
>>     /* calc total values */
>>     if (rx_frames)
>>         pkg_stats->total_rx_match_ratio = (matches * 100) / rx_frames;
>>
>>     pkg_stats->total_tx_rate = calc_rate(pkg_stats->jiffies_init, j,
>>                         tx_frames);
>>     pkg_stats->total_rx_rate = calc_rate(pkg_stats->jiffies_init, j,
>>                         rx_frames);
>>
>>     /* calc current values */
>>     if (rx_frames_delta)
>>         pkg_stats->current_rx_match_ratio =
>>             (matches_delta * 100) /    rx_frames_delta;
>>
>>     pkg_stats->current_tx_rate = calc_rate(0, HZ, tx_frames_delta);
>>     pkg_stats->current_rx_rate = calc_rate(0, HZ, rx_frames_delta);
>>
>>     /* check / update maximum values */
>>     if (pkg_stats->max_tx_rate < pkg_stats->current_tx_rate)
>>         pkg_stats->max_tx_rate = pkg_stats->current_tx_rate;
>>     ...
>>
>> As a result, those pre-reset local variables overwrite 
>> total_rx_match_ratio,
>> current_*, and max_* right after can_reset_pkg_stats() cleared them 
>> (and if
>> the reset was triggered by the rx_frames, tx_frames, or matches overflow
>> checks, the overflowing values are still passed into the ratio and 
>> calc_rate()
>> calculations).
>>
>> Additionally, because can_init_stats() sets pkg_stats->jiffies_init = 
>> jiffies
>> by reading live jiffies rather than using the snapshot j, if jiffies 
>> ticks
>> between the snapshot and can_init_stats(net) during a user_reset, the
>> subsequent check (j < pkg_stats->jiffies_init) will also evaluate to 
>> true,
>> calling can_init_stats(net) a second time and then passing 
>> jiffies_init > j
>> along with the stale non-zero tx_frames and rx_frames into calc_rate().
>>
>> Should can_stat_update() re-arm the timer and return early (or zero 
>> the local
>> snapshot variables) when can_init_stats() is called?
>>
>> [ ... ]
>>
> 

