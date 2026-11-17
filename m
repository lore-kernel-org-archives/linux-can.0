Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888165;
	b=1OQigYCfuzlkuYsPX3jKYatSh9hIIEPSWLj8W3A/05owONFA55byJa4erO1CUOts44nt
	 PuxcsjOV+DdnWlJmg/sAG8jmM88xhKE9sAW2+7x2s+VK3rX6fCFfDfNCn6zHHqrU+7q5O
	 lIOMFVw07Ia/t7+Gx+FAwIQh7u/YB9WsINv8MwknytBajzxJo1rb1uxZgGexf6xMmYyhG
	 oVJVuEz3MV79USWe6JKzX7B5gaPuyG9wpdKnyz4x5PoPP/Oqh6hRRLJeNaaGi/CIQrEAh
	 Sblwej89wEkVl6q7VyANw6JzDW40Bmby9qr5aDm0RXIii3jXZkBtQyrxRVoe47bKwtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888165;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d73AmlHJ6ofaVGoyLKU1xD3Yw5x1I8aGu6DZXY4soDA=;
	b=2RbwICNXMBgBq+whlLP1JZ/A6uJNA/IhMURfSnJjebGX35HANsM3906CvZ8dWKnmg+mu
	 UGO9aQVIMqAiiP4+Y9h8XNL2ztQnWuyLswSaZW8K+urRPloRjv5Kmfmx6H3vNpfBF4xfb
	 fFen9hX2QbCLAvftspBm0NcOvLOM6pbswP24D5cd4k6u9gTrRxh004EbY7nHzplT/WXfu
	 Qt8CzCOtFFOqdSmDGdt+GLuvzZhiGKF5gPAxTDeNIovoNG5p0lVpQv4NwmbkA7Y8BscQG
	 K6Eb4ZMF1yP2qRuD+QBwgnArU7jskBzZf9ld7CdgCRyTf4LcETh75gQIyu+Lv85xtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmcpSYrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36676606A32A
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmcpSYrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB801F000C4;
	Tue, 17 Nov 2026 04:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794888165;
	bh=d73AmlHJ6ofaVGoyLKU1xD3Yw5x1I8aGu6DZXY4soDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HmcpSYrj5qt8f1Tuac9EeQ+JdEod0V7iwk+5y/gA5T6cDrSZ9YlWfS0ciiQn25zVz
	 9UHI8yanHIuJqtdr/AaaeaiTMpwHry/TWKUYIOFinkR+vcoQDmhG6b3W9zTXye2Go5
	 db89LSzoDc0sDmFzfKN03r63NLIS16/rNPlxFBoEd7OVftrtdqy3Y0wQ0f0Jpm4ZIV
	 nCipLav9ex4QI0Jt1sbSdm75wxJcdLBXjtEU9ZaxPNXVZX8vgom4/oNQvLAFmizuFH
	 19MQ/otg0vNHhidKrYnu5Ng41EDfGM6T4wHPo9w/4j8c0ytoC7IXTdqum40S0kogc4
	 H+2V0SzaMoQPw==
Subject: Re: [PATCH v14 5/6] can: j1939: fix "struct j1939_ecu" refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Tue, 17 Nov 2026 04:02:44 +0000
Message-ID: <179488816419.3132.8749873272758008565@kernel.org>
In-Reply-To: <6a627b63-8d8d-4bc9-8533-3f3d8f4a8cc4@I-love.SAKURA.ne.jp>
References: <6a627b63-8d8d-4bc9-8533-3f3d8f4a8cc4@I-love.SAKURA.ne.jp>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "can: j1939: fix \"struct j1939_ecu\"
  refcount leak" describes only the bus.c changes…

Pre-existing issues:
- [High] Pre-existing ABBA deadlock in the ECU address-claim timer path
  that this patch modifies.

--

can: j1939: fix "struct j1939_ecu" refcount leak

This patch adds j1939_ecu_verify_get(). The helper refuses to take an ECU
reference once the netdev is no longer registered or priv->rx_kref has
dropped to zero. It is used in j1939_ecu_timer_start() and
j1939_ecu_map_locked(), so the address-claim timer cannot map an ECU again
after j1939_ecu_unmap_all() has run. The patch also wraps the reg_state
check in j1939_sk_bind() in READ_ONCE() and adds a comment there.

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3924404152a2f..9b40f37546233 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -141,7 +152,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  	/* The corresponding j1939_ecu_put() is in
>  	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
>  	 */
> -	if (!j1939_ecu_get(ecu))
> +	if (!j1939_ecu_verify_get(ecu))
>  		return;
>  
>  	/* Schedule timer in 250 msec to commit address change. */

[Severity: High]
This isn't a bug introduced by this patch, but this fix relies on
j1939_ecu_timer_cancel() as the matching put. Can the cancel path deadlock
against j1939_ecu_timer_handler()?

j1939_ac_process() takes priv->lock and cancels the timer while it still
holds the lock:

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	write_lock_bh(&priv->lock);
    ...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
    ...
}

j1939_ecu_timer_cancel() calls hrtimer_cancel(), which keeps looping as
long as the callback is running. The callback takes the same lock:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
    ...
}

Suppose the soft hrtimer for this ECU expires on CPU B while CPU A is
already inside the write-locked region of j1939_ac_process():

CPU A                                CPU B
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                     __run_hrtimer()
                                       j1939_ecu_timer_handler()
                                         write_lock_bh(&priv->lock)
                                         <spins>
  j1939_ecu_timer_cancel()
    hrtimer_cancel()
      hrtimer_try_to_cancel() == -1
      hrtimer_cancel_wait_running()
      <spins>

On !PREEMPT_RT, hrtimer_cancel_wait_running() is just cpu_relax(). On
PREEMPT_RT it waits on softirq_expiry_lock, which CPU B holds. Can either
CPU make progress here?

This looks reachable from a received address-claim frame. The frame's
NAME has to match an existing ECU while its SA is different or idle, and
it has to arrive about 250 ms after the previous claim armed ac_timer. On
vcan, two local J1939 senders on different CPUs could reach both sides.
The baseline makes the same call inside the locked region, and it dates
back to 9d71dd0c7009.

One option is for j1939_ecu_timer_cancel() to use hrtimer_try_to_cancel()
and drop the reference only when it returns 1. When it returns -1, the
running callback would do the put. Another option is to cancel the timer
before taking priv->lock.

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..6e22ec5e88f5a 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
>  			goto out_release_sock;
>  		}
>  
> -		if (ndev->reg_state != NETREG_REGISTERED) {
> +		/* Do nothing and fail early if netdev is no longer registered.
> +		 * This check is racy but we don't need to recheck after j1939_jsk_add()
> +		 * is called, for either j1939_sk_netdev_event_unregister() from
> +		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
> +		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
> +		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
> +		 * from being called) or j1939_sk_release() will take care of this race.
> +		 */
> +		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {
>  			dev_put(ndev);
>  			ret = -ENODEV;
>  			goto out_release_sock;

[Severity: Low]
This isn't a bug, but the commit message only describes the bus.c
changes:

  Fix this problem by

    (1) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
    (2) making j1939_ecu_map_locked() no-op

The message does not mention this j1939_sk_bind() hunk: the READ_ONCE()
and the comment about why no recheck is needed after j1939_jsk_add().
Could the changelog say why this hunk is part of the fix, so stable
backporters can tell whether they need it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1d96e742-0479-4c36-ad0a-a0aaeda0a4fc%40I-love.SAKURA.ne.jp
