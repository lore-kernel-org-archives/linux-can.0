Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888164;
	b=ZXNQCjOt2s/iZz+rD8pMuDKcI5fm1wjZFy1+34QvRNKWX1ptqeyI0+PfYrRu4hC1ask1
	 VNzywo/T2O7/2GPvTPh4+jQ5W1LBYdD7AvHncZUgeJNghrl6gzeE7DITfW7ca+DofStOa
	 9QtoUzbrvHmkTvE/Itvbwd7F8T6A+I41VpephGpoTT67NF+4WSuyRQGBQCM/Ap2+fhJiu
	 UZ6r5yBT2wbhtm6HEaI6asxJ9qVLVw336InswS9kH46y10PRAPnrWcXyTXy+R1fN+M6RG
	 /OU68JOKu3Z/zVSwdeIfxkRdWUPbyWCxkjQH/Pz80WEHnsU89qVQpq4miuyWbz4sXyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888164;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sgw0WdWS8qwVgLSHwhQrIVRjmrocH9bUNS+/+dcLaGc=;
	b=IOJlz3T9r77X/NBdO6BzwdjNkSKV/upHYrbjusvJ87RaxGALQE55Yjsu2tYLHK6I9663
	 gXJw3NBaItojxBWUG0+iWsuTJnQHGGBZJrDGOOEE4Z7/YqmtFDZY71+Q2nFwREsBDHdfT
	 TU8rfyaoCS6sPh8fQ9TCkNBC5QN9HYwAzImWSzXekNkq2dxVKnaj4/4+iTUWTErv+Qlkx
	 0iZrEqLN5SQWFRvdvG8uE6Mw2uuarh05l17EI4I2QXNyNDqDHRo2LdGdbnHoBHo6MdrhW
	 cI5Ubkzf01UFfEzBaQ53NrOgfDMQRFO3TpWgvA2xxDc+wdvEtjAIhGY1KecTCF317PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBMg1Gy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB1606A32A
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBMg1Gy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B5B1F000C4;
	Tue, 17 Nov 2026 04:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794888164;
	bh=sgw0WdWS8qwVgLSHwhQrIVRjmrocH9bUNS+/+dcLaGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YBMg1Gy5+aComMHx5Z5JuoKTQbIqsWvHwVsVYk+jBiiIYqqbQbC8DGcaFOzy1YWQv
	 zKqlsygO0hhXVqrAHYdP0cL31pcGsespnNiVbVxLIfPTu6LwGvM3Hxfj8d+0m4y/bO
	 Y6lN9Qw/pY2aLgtrYGNAevMK64f4cQb2uaEEvUvByTOmVvnL0cRlt8C8k5GTS520fY
	 g+QMDv/2vYUYyxKimCbhBeHQSJhCZCR8vSs91rBvLurJKw4TAPzXOW9f68/XPrIICR
	 hfve7WXEnxTMlZG+0h3gMcyQ5bqMa1Mb84ncoubImMQrl9ClnpOB1LKY8P9fpKzEz3
	 Oo67E5tFkeigw==
Subject: Re: [PATCH v14 3/6] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Tue, 17 Nov 2026 04:02:43 +0000
Message-ID: <179488816314.3132.13214176750033848739@kernel.org>
In-Reply-To: <c7618d34-4419-404e-9289-a8c32b065d2d@I-love.SAKURA.ne.jp>
References: <c7618d34-4419-404e-9289-a8c32b065d2d@I-love.SAKURA.ne.jp>
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

- [Low] The rationale comment in __j1939_priv_release_work()
  (net/can/j1939/main.c, lines ~167-186) is stale after this patch.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but it is a
  remote-triggerable deadlock.

--

can: j1939: fix possibility of list corruption in __j1939_ecu_release()

This patch moves the release of struct j1939_ecu to the j1939_wq
workqueue. The release work can then always hold priv->lock for write
while it calls list_del(). ECUs whose kref has reached zero can now
still be on priv->ecus, so j1939_ecu_get() switches to
kref_get_unless_zero() and lookups skip ECUs that have started release.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0aeeee1491e4f 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -14,25 +14,47 @@
>  
>  #include "j1939-priv.h"
>  
> -static void __j1939_ecu_release(struct kref *kref)
> +static void __j1939_ecu_release_work(struct work_struct *work)
>  {
> -	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +	struct j1939_ecu *ecu = container_of(work, struct j1939_ecu, release_work);
>  	struct j1939_priv *priv = ecu->priv;
>  
> +	write_lock_bh(&priv->lock);
>  	list_del(&ecu->list);
> +	write_unlock_bh(&priv->lock);
>  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);
>  }
>  
> +static void __j1939_ecu_release(struct kref *kref)
> +{
> +	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +
> +	/* Since not all callers are calling j1939_ecu_put() with priv->lock
> +	 * held for write, defer actual release to WQ context. By deferring to
> +	 * WQ context, readers might find ECUs with ecu->kref == 0. Therefore,
> +	 * readers must validate with j1939_ecu_valid() or j1939_ecu_get().
> +	 */
> +	INIT_WORK(&ecu->release_work, __j1939_ecu_release_work);
> +	queue_work(j1939_wq, &ecu->release_work);
> +}

[Severity: Low]

j1939_priv_put() is now called from __j1939_ecu_release_work(), after
write_unlock_bh(&priv->lock). Is the comment in
__j1939_priv_release_work() in net/can/j1939/main.c still accurate?

net/can/j1939/main.c:__j1939_priv_release_work() {
	...
	 *   (3) A user who unexpectedly became the last user of "struct j1939_priv"
	 *       indirectly calls j1939_priv_put() via e.g. j1939_ecu_put(ecu).
	...
}

With this patch, j1939_ecu_put()->kref_put()->__j1939_ecu_release()
only calls INIT_WORK() and queue_work(). Callers that hold priv->lock,
such as j1939_ac_process() at out_ecu_put or j1939_ecu_timer_handler(),
can no longer reach j1939_priv_put() synchronously through this path.

None of the other j1939_priv_put() callers seem to call it with
priv->lock held either.

Should the example in that comment be updated? It is still unchanged
at the end of the series.

[ ... ]

> @@ -122,6 +147,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
>  	if (hrtimer_cancel(&ecu->ac_timer))
> +		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
>  }

[Severity: Critical]

This is a pre-existing issue that this patch did not introduce. Can
j1939_ecu_timer_cancel() deadlock when j1939_ac_process() calls it?

j1939_ac_process() takes priv->lock for write and still holds it when
it cancels the timer:

net/can/j1939/address-claim.c:j1939_ac_process() {
	write_lock_bh(&priv->lock);
	...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
	...
}

hrtimer_cancel() waits for a callback that is already running. The
ac_timer callback takes the same lock:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
	...
	write_lock_bh(&priv->lock);
	...
}

Here is a possible sequence for the same ECU:

CPU A (NET_RX softirq)              CPU B (HRTIMER softirq)
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                    j1939_ecu_timer_handler()
                                      write_lock_bh(&priv->lock)
                                        <- spins on CPU A
  j1939_ecu_timer_cancel()
    hrtimer_cancel()
      <- callback running, loops waiting for CPU B

On !PREEMPT_RT, hrtimer_cancel_wait_running() is only cpu_relax(). On
PREEMPT_RT it blocks on softirq_expiry_lock, and the stuck expiry
context holds that lock. Either way, both CPUs spin with BH disabled.

Any node on the CAN bus can trigger this once a local j1939 socket has
registered the RX handler. It sends an Address Claimed frame for NAME N
at SA X, which arms the 250 ms ac_timer through
j1939_ecu_timer_start(). About 250 ms later it sends a second Address
Claimed frame for NAME N with a different SA, while the callback is
running. The sender can keep retrying until the timing matches. Normal
address claim contention could also hit this window.

This ordering is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1d96e742-0479-4c36-ad0a-a0aaeda0a4fc%40I-love.SAKURA.ne.jp
