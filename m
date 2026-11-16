Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855067;
	b=QCAedXtaIeAyteN9LyLGqMzu4iYPrPpfIq+SHcrRwA/vthPawl+dBxRmBovtfpfHvrmf
	 kR7VaKDYF3FHjgPudnKxmqML5h+zN7mBDtTgkkcgA3gWEqE5iGQGybNUB28Rm1aWQrpLt
	 ZkxwpIWQlaLyTLIz0DsKInPO/Nk+yE83MnqFEBmayIdTru4emA6BYSa8ttKD2cFykQndl
	 mIZOqoQQ5V9O8Cg7xqyzCQhv7YQQ8KgfVH/Ieli8pnaQMvmef7JEm54ASNujFdM2wFsNF
	 r/ps9XA9XMfIIjzIMouAicgtLQjUhz1qkKa+rOHM0CYJTUT7DGMjrCMnjHQzA8wpcsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855067;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E1ZZtPSpwBQf00Eg3khRUWeWxhFOXBKZqtxemq1RUjk=;
	b=ziFe6AxkA70B6WWLC7q+MYKPezCh8EZYt3JIK3ucB0DNWIh62TEXvklEaCMFjfOFoQ9o
	 t19UKWAWEHnwLQsijFUW151kGHv3Zaa8x+ZomS2RzcZTPDu1TLXEG3+q54+qJyjJRq6Vu
	 /+5z31H/D259t2pUnz7JpK+hQ2XZEAI7euX7SNoV4K1pdS+CFSKwMuFEmZGn4LrABwboT
	 si9BW0pwTHugFIyXrN31fDoaOLicUap266MrPj1wyfKf1EILSyV7x1jBSDdjp8Yz1Ku5V
	 9lEHOQrg2vRZjz5772ezvkALPiCf7QKSB3Qg0utnAcBmNCoPWubs54oImq8SAs9Za4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czdWOdOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5964606A31C
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czdWOdOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB56E1F000C4;
	Mon, 16 Nov 2026 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855067;
	bh=E1ZZtPSpwBQf00Eg3khRUWeWxhFOXBKZqtxemq1RUjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=czdWOdOtvWE0L16OhFHeYjTP7UwWF6AVxeHihgHH203EpZneztt72qOCwjjaB0IX7
	 U0C4s9mF9qL57rV/lmqj9RJ6QD+HHD8ghBoZ8b/GgxDD7uMoLoH4iFq0fLgIG/aXhX
	 433aem++eGUznTL/6zHqNwjh5EdXZL+/2BFydP527TAhRlx/joNPglUiyIjk1R3cLr
	 MeLymzRg+x1mPNjJa2VUZM8ZkgklAsGGvCMi7CcR0BEvLQkd91qsw+Ov4rNbQmFMep
	 shLhJxjJDDCUE2MdnIZ7Z58W10ls81OtarcwRXLQLyWfdgIBmycxlY1mmiFjZhDHEs
	 5ONuIJBqebpPQ==
Subject: Re: [PATCH v13 2/6] can: j1939: add a safeguard to
 __j1939_priv_release_work()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Mon, 16 Nov 2026 18:51:06 +0000
Message-ID: <179485506647.3132.15248710248812614118@kernel.org>
In-Reply-To: <3e4669b1-fbc8-4e69-8e73-6ee35cbd13e4@I-love.SAKURA.ne.jp>
References: <3e4669b1-fbc8-4e69-8e73-6ee35cbd13e4@I-love.SAKURA.ne.jp>
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

- [Low] The commit is tagged `Fixes: 9d71dd0c7009` and `Cc: stable` and
  says it closes a use-after-free.

--

can: j1939: add a safeguard to __j1939_priv_release_work()

This commit adds a write_lock_bh()/write_unlock_bh() pair on priv->lock at
the start of __j1939_priv_release_work(). That delays kfree(priv) until any
current priv->lock holder has dropped the lock. It is meant to guard against
a caller that drops the last j1939_priv reference through j1939_ecu_put()
while holding priv->lock.

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 0b8ac4fe0479d..930a95bab2120 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -164,6 +164,29 @@ static void __j1939_priv_release_work(struct work_struct *work)
>  	struct j1939_priv *priv = container_of(work, struct j1939_priv, release_work);
>  	struct net_device *ndev = priv->ndev;
>  
> +	/* Wait for priv->lock owner to release the lock.
> +	 * This is a protection for
> +	 *
> +	 *   (1) Read priv from e.g. ecu->priv.
> +	 *
> +	 *   (2) Take priv->lock.
> +	 *
> +	 *   (3) A user who unexpectedly became the last user of "struct j1939_priv"
> +	 *       indirectly calls j1939_priv_put() via e.g. j1939_ecu_put(ecu).
> +	 *
> +	 *   (4) j1939_priv_put() calls __j1939_priv_release() because it was the last
> +	 *       user.
> +	 *
> +	 *   (5) __j1939_priv_release_work() which was scheduled via
> +	 *       __j1939_priv_release() starts and calls kfree(priv).
> +	 *
> +	 *   (6) Releases priv->lock, but this is UAF if (5) already called kfree().
> +	 *
> +	 * pattern.
> +	 */
> +	write_lock_bh(&priv->lock);
> +	write_unlock_bh(&priv->lock);

[Severity: Low]
Can any in-tree caller actually reach this sequence? The commit carries
Fixes: and Cc: stable tags as a use-after-free fix. However, every
j1939_ecu_put() made under priv->lock seems to run while some other priv
reference is still held.

The puts in j1939_ac_process() all run under j1939_can_recv(), which holds
its own priv reference for the whole call:

  j1939_can_recv()
    j1939_priv_get(priv);
    ...
    j1939_ac_recv()->j1939_ac_process()
      j1939_ecu_unmap_locked() / j1939_ecu_timer_cancel() / j1939_ecu_put()
    ...
    j1939_priv_put(priv);

j1939_ecu_unmap_all() has two callers:

  - __j1939_rx_release(). Here j1939_netdev_stop() drops its priv
    reference only after kref_put_mutex() returns.
  - The NETDEV_DOWN notifier, which holds a reference from
    j1939_priv_get_by_ndev().

j1939_local_ecu_put() runs while the socket holds a priv reference. In
j1939_sk_netdev_event_unregister(), j1939_priv_put() is called only after
j1939_local_ecu_put() has dropped the lock.

j1939_ecu_timer_handler() holds only an ecu reference:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
    ...
	j1939_ecu_map_locked(ecu);
    ...
	j1939_ecu_put(ecu);
	write_unlock_bh(&priv->lock);
    ...
}

Before that put, j1939_ecu_map_locked() takes one of two paths:

  - It takes a new ecu reference for ents[], so the put is not the last one.
  - It skips because ents[addr] already holds a different ecu, and that
    ecu holds its own priv reference.

The non-unicast early return in j1939_ecu_map_locked() should not apply
either. j1939_ac_process() sets ecu->addr and starts the timer only for
unicast source addresses. So priv's kref looks like it is always at least 2
at that put.

Given this, would it be more accurate to describe the change as hardening
and drop the Fixes: and Cc: stable tags?

There is also a backport problem. __j1939_priv_release_work() does not
exist at 9d71dd0c7009; there, __j1939_priv_release() frees priv
synchronously. The function is added by the earlier patch in this series,
"can: j1939: fix possibility of UAF on module unload". Could the commit
message mention that dependency for stable backports?

Later in the series, "can: j1939: fix possibility of list corruption in
__j1939_ecu_release()" moves the ecu release into
__j1939_ecu_release_work(). That function calls j1939_priv_put() after
write_unlock_bh(&priv->lock).

Once that change is in, can the example in this comment ("indirectly calls
j1939_priv_put() via e.g. j1939_ecu_put(ecu)") still happen? If not, the
comment is out of date by the end of the series.

The same "unexpected last user while holding a lock embedded in priv"
pattern would also apply to priv->active_session_list_lock, for example in
j1939_cancel_active_session(), and this safeguard does not cover it. All
current callers there hold a priv reference too, so this is not a live bug
either.

>  	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
>  
>  	WARN_ON_ONCE(!list_empty(&priv->active_session_list));

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7cc08b0f-290e-464b-ab13-0a5ce3c57f4f%40I-love.SAKURA.ne.jp
