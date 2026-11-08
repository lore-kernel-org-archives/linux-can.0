Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794126325;
	b=dyDNGDjI5ocC3ufFgA3swwoB5gjmlQOIc5yc32iKfCdU0iNYcsyidThXemSnBzs+kgBs
	 BwCowbWoKqJBRDy7Dr67HKW4pN6B7Hgu8QZ+tUzXEOVOUgbuXRv2rQh6jFBbdDUUpfrQX
	 aYWzIDvrSoru2yUVs11Yx0Uv5bklWBHZ7MTVihvvumc/bzfmiFLTtLwpchlbBJcj8AIJO
	 b5Y/1pXL2+52z+GOlz0/P9XOlYkQzwkC1Q1TsTocqeN5HQ5x5OZT13HHKz3uYAUzTp+0C
	 F8r//e01SsgOv2VA2WUFubEhndMiTdac9cQa1f6Cx94ORAzjf9PE9hbjZNIy19DMhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126325;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ea1iQ2Tern8QXMIfb0uDmLtJsoXUTk4MBjkBRAlvGMo=;
	b=23mIHYLiqwsgiRs9CYD9aSHCimy8wnilyGcDNIGh2i1SVtHx0ZEq7wPcfSMDA19TmOG9
	 nyrge24g65QLvoh9UTr2LlTSjXvuHxwZP1k56ugNUoItPGhhcQUjaES4tTMjsF8pQq2qZ
	 phrApJ4wwC4J6kZ057IRX9nUjhcZx1yhSRRDMms7C0d86NkHSxva+/nvqK1H39RkekHhk
	 i3ak/wE5fo408zQ01LdaNxrB9nu6t2OO7zCGiWcD8wyxaR1QlFpCxN659WuMOyv/399iB
	 czz3IAJHPq9wGCTeAaVRAs3sxsKEzH5qEEMvSPxjnqnffDjnZWO9t1O8C+uw1Om+YFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No324tbF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C67606A31C
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No324tbF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78481F008A2;
	Sun,  8 Nov 2026 08:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126324;
	bh=ea1iQ2Tern8QXMIfb0uDmLtJsoXUTk4MBjkBRAlvGMo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=No324tbFWRJI31YG52TSREmjv2w4GRTb9eBOhTEeDfU9g+gqav9I4ThO7i8/klyCf
	 V+5kYdOtLwhL8kVsC+TTkyXBy5vX8zaK0Tr4go6rDSJO86GxWPO/ZjM+xFohmXc+dW
	 U06wkIRUmKmh1DxdGoQx64yEmvCsmGxltbhNEbUXEhO8gFIcg0EcXHvzIRdR3QGlrh
	 aRkBDJVKoNknqn8ixdqvmHBRDssTxwRUgdlG4AAMT9c48+QJj+ZRERbJqTLteObxHs
	 7UyyErf2a1QcQyhzLbLC6tjHeaQV0ZQUE7B2KlAVHuEMqkMDAiPoS4jefnCmbUnJ3m
	 jEFfr5BRqbxMA==
Subject: Re: [PATCH v9 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 08:25:23 +0000
Message-ID: <179412632338.488853.1595860027578010747@kernel.org>
In-Reply-To: <489aa8c0-c9c8-4aeb-9479-f7cb4c6a03df@I-love.SAKURA.ne.jp>
References: <489aa8c0-c9c8-4aeb-9479-f7cb4c6a03df@I-love.SAKURA.ne.jp>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] can: j1939: race between j1939_local_ecu_get() and
  j1939_jsk_add() on unbind
- [Low] Undeclared stable dependency.
- [Low] The new '!kref_read(&priv->rx_kref)' condition in
  j1939_local_ecu_get() (bus.c:366-367) can never be true.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  a FIXME that describes it wrongly.

--

can: j1939: fix "struct j1939_ecu" refcount leak

This commit cancels ecu->ac_timer in j1939_ecu_unmap_all(). It also stops
j1939_ecu_timer_start(), j1939_ecu_map_locked() and j1939_local_ecu_get()
from taking new references once the netdev is unregistered or
__j1939_rx_release() has run. The goal is to fix a syzbot-reported ECU
refcount leak, where the timer handler re-maps an ECU after
j1939_ecu_unmap_all() has finished.

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..7346248a18020 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -126,8 +142,39 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>  
> +restart:
>  	write_lock_bh(&priv->lock);
> +	/* Need to shutdown timers now, for module unloading might start
> +	 * relatively shortly after returning from j1939_ecu_unmap_all() from
> +	 * __j1939_rx_release() from j1939_netdev_stop() from j1939_sk_release().
> +	 */
> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		if (!j1939_ecu_valid(ecu))
> +			continue;
> +		switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
> +		case 0:	/* Not active or already finished. */
> +			continue;
> +		case 1:	/* Successfully canceled. */
> +			/* Drop the ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +			continue;

[Severity: Low]
This commit has a Fixes: tag for 9d71dd0c7009, so it will be queued for
the stable trees. Does it depend on the previous patch in the series, "can:
j1939: fix possibility of list corruption in __j1939_ecu_release()"?

That commit has no Fixes: or Cc: stable tag. Neither commit mentions the
dependency.

This j1939_ecu_put() can drop the last reference while priv->ecus is being
walked with the non-_safe list_for_each_entry() under priv->lock. The same
applies to the j1939_ecu_put() in the "already mapped" branch of
j1939_ecu_map_locked(). Both are safe only because the prerequisite moves
list_del() and kfree() into __j1939_ecu_release_work().

Without the prerequisite, __j1939_ecu_release() does list_del(&ecu->list)
and kfree(ecu) synchronously. list_next_entry() would then read freed
memory.

j1939_ecu_valid() and the bool return of j1939_ecu_get() also come from
the prerequisite. A straight backport would therefore fail to build, but a
hand-adapted one could end up with this use-after-free.

Could the prerequisite get a Fixes: or Cc: stable tag, or could this commit
name the dependency?

> +		default: /* Currently executing. */
> +			/* Get a ref, in order to call hrtimer_calcel() without priv->lock. */
> +			if (!j1939_ecu_get(ecu))
> +				continue;
> +			break;
> +		}

[ ... ]

> @@ -149,6 +196,9 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> +	/* FIXME: Calling hrtimer_cancel() under priv->lock can deadlock between
> +	 * priv->lock and cpu_base->softirq_expiry_lock if CONFIG_PREEMPT_RT=y.
> +	 */

[Severity: High]
This deadlock is pre-existing and was not introduced by this patch. Is the
new FIXME right to limit it to CONFIG_PREEMPT_RT=y, though?

j1939_ac_process() calls j1939_ecu_timer_cancel() while it holds
priv->lock:

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	write_lock_bh(&priv->lock);
    ...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
    ...
}

The timer callback takes the same lock:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
    ...
	j1939_ecu_map_locked(ecu);
    ...
}

Suppose the 250 ms ac_timer expires on another CPU while
j1939_ac_process() is running for the same ECU:

CPU A                               CPU B
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                    __run_hrtimer()
                                      j1939_ecu_timer_handler()
                                        write_lock_bh(&priv->lock)
                                        <spins>
  j1939_ecu_timer_cancel()
    hrtimer_cancel()
      hrtimer_try_to_cancel() returns -1
      hrtimer_cancel_wait_running()
      <loops forever>

Without CONFIG_PREEMPT_RT, hrtimer_cancel_wait_running() is just
cpu_relax(). Wouldn't this be a hard lockup with BH disabled on any SMP
kernel?

j1939_ac_process() runs from j1939_can_recv()->j1939_ac_recv() for every
Address Claimed frame. A peer on the bus can reach this window by sending a
second address claim for the same NAME with a different SA.

The new j1939_ecu_unmap_all() already avoids this pattern: it calls only
hrtimer_try_to_cancel() under priv->lock, and calls hrtimer_cancel() after
dropping the lock.

The notes below the --- line say that the fix for the "ABBA deadlock in
j1939_ecu_timer_cancel() under priv->lock" problem is deferred. Could the
FIXME describe the general deadlock instead? Could the deferred fix also
cover non-RT kernels?

>  	if (hrtimer_cancel(&ecu->ac_timer))
>  		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
> @@ -310,6 +360,15 @@ int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
>  
>  	write_lock_bh(&priv->lock);
>  
> +	/* Do nothing and fail if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if ((READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
> +	     !kref_read(&priv->rx_kref))) {

[Severity: Medium]
Does this check fully close the window it is aimed at?

j1939_local_ecu_get() tests priv->ndev->reg_state under priv->lock.
The socket only becomes visible to j1939_sk_netdev_event_unregister()
later, when j1939_sk_bind() calls j1939_jsk_add() under
priv->j1939_socks_lock:

j1939_sk_bind()
    ...
    ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
    ...
    j1939_jsk_add(priv, jsk);

In between, jsk is not on priv->j1939_socks. On a first bind,
j1939_jsk_add() hasn't run yet. On a re-bind, j1939_jsk_del() has
already removed jsk and cleared J1939_SOCK_BOUND.

unregister_netdevice_many_notify() sets reg_state to
NETREG_UNREGISTERING without taking priv->lock or lock_sock().
Nothing orders it against the bind path:

CPU A                         CPU B
j1939_sk_bind()
  j1939_local_ecu_get()
    sees NETREG_REGISTERED
    gets/creates local ECU
                              unregister_netdevice_many_notify()
                                reg_state = NETREG_UNREGISTERING
                                j1939_netdev_notify()
                                  j1939_sk_netdev_event_unregister()
                                    jsk not on j1939_socks
  j1939_jsk_add(priv, jsk)

The socket then stays J1939_SOCK_BOUND on priv->j1939_socks after
NETDEV_UNREGISTER has completed. It keeps its references on the local
j1939_ecu, on j1939_priv and on priv->ndev. So unregister_netdevice()
blocks on the netdev refcount until userspace closes the socket.

The window is narrow. It also needs an interface unregister or netns
teardown racing with bind(). Before this patch the window was wider,
since there was no check at all. Still, the commit message presents
failing j1939_local_ecu_get() as what stops new references after
unregister, and this path gets around it.

Could the bind path re-check reg_state after j1939_jsk_add(), under
priv->j1939_socks_lock, and undo the bind if the device is going
away? Or is there a better lock to serialize
j1939_sk_netdev_event_unregister() against j1939_sk_bind()?

[Severity: Low]
Can the !kref_read(&priv->rx_kref) condition ever be true here?

The only caller is j1939_sk_bind(), and it holds an rx_kref reference when
it calls j1939_local_ecu_get():

j1939_sk_bind()
    priv = j1939_netdev_start(ndev);
    ...
    ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);

On a first bind, j1939_netdev_start() either calls kref_init() on rx_kref
or calls kref_get() on it under j1939_netdev_lock. __j1939_rx_release()
clears can_ml->j1939_priv under the same mutex. A priv found there should
therefore always have rx_kref > 0.

On a re-bind, the socket is already J1939_SOCK_BOUND and keeps its rx_kref
until j1939_netdev_stop(). That only runs after j1939_local_ecu_get()
fails. j1939_sk_netdev_event_unregister() can't drop the reference
concurrently, because bind holds lock_sock().

The commit message also describes this check as effective:

    failing j1939_local_ecu_get()
    when a netdev which is associated with j1939_priv is no longer registered
    (indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
    __j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

Should the rx_kref check be dropped here, leaving it only in
j1939_ecu_verify_get()? Should the commit message be updated to match?

> +		err = -ENODEV;
> +		goto done;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/396b5de7-3fe0-474f-9194-b4816fde7182%40I-love.SAKURA.ne.jp
