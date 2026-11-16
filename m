Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855069;
	b=QbLNZLVKw1DEl8CTsVKUiJ19rgi2JWnKm2JrYjOPgHbg59IwMKLx537dy2c9bjeYfwza
	 JryCpldm9jMXXTo1YLRUFBDwRYc7IpABMZxqehJ7ud3vu60HXKlSEWGFtAHH0uf57EOqg
	 CipuWk3oyhBhgde6+CwRxGaifFy3NLlfTxxHfff5PtJWn7dUKl/einsQR0xDU+eTQJZXU
	 DmVCOzYomiZm7qBfCWhNfssdmpUpUBNp6WkDGezdRjNa/zuKk/NvlrHnVbc9PJ4rITBC0
	 Ji3p9jaZ9/inaIOMnQ8zGKWsHDD30/7kDNm3KfcOl2JdvCRrGuDnw2TrpSLvQZCat+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855069;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4HPsToxqYoKMAp1DxFXDjYqZQkEUKkOsV9aa2SSVtm4=;
	b=C2lzs3yUKstZqv7VFbTysqMf+WoZDGSYwhweM/d920HfMc75ExnwJyI1EWetXvjyAZ+p
	 43/JkmjbnQzQOGi7/XeLU5f2pIx81Fjq88zwWKPI3Ud70xO0hoP/762IDvbznCzzVNJc2
	 qACvq0Q1+IQD/QB1MaYhschTQw+9lGHw816Sx5wqqD0d+V3ZOr1DnRQxh4wHhhqbzIvn1
	 SPUGtsGPN6O/cTg5mkVWaPNu2/lrq2yiHCJKWMSYppNEoCjEbmkMWv3uEcqbEMmP7z0k6
	 lFIEleb3NhRQDnU/rbMzNqj6uVcOsIjmvaUZu3T29vBA+8tC7XZtEPy+1IopQD7ww/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vuO19Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C36606A322
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vuO19Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60041F000C9;
	Mon, 16 Nov 2026 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855069;
	bh=4HPsToxqYoKMAp1DxFXDjYqZQkEUKkOsV9aa2SSVtm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z8vuO19QfohqhQqKq3nfCAfUGczZ2aOqaLby3gNuvrQoSDcV/uvDOqqAGoYuTPQcR
	 GkooGQ1NIG25IGBooNvT5s4X5NHA7TWE355OxE7iYPWlz6HTpKiuf5bgPkoRxiRZST
	 YbgRPKp5YIAStReKT8lbmCnm+9H6GK103FC1YHZm55O4JUANMsDJZVh4JrrptOjnPs
	 kASIaTpxhwhUiRZbe1T79YAirzhR13AJQBucmNfzmUb7cB+BIj4gwaxuYv8ZYiuw6r
	 E+JaTpIKPxtfdmMam4KBC1RS9YP/OQOIPamGb+MYM+xPZjoy507YOhtQ86Z/bnuzn6
	 8NS+Ac6dwjbaw==
Subject:
 Re: [PATCH v13 4/6] can: j1939: add a safeguard to __j1939_ecu_release_work()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Mon, 16 Nov 2026 18:51:08 +0000
Message-ID: <179485506852.3132.632621305382559314@kernel.org>
In-Reply-To: <37069926-e687-4062-97a9-db0643645f82@I-love.SAKURA.ne.jp>
References: <37069926-e687-4062-97a9-db0643645f82@I-love.SAKURA.ne.jp>
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

- [Low] The commit message for "can: j1939: add a safeguard to
  __j1939_ecu_release_work()" describes a bug that cannot happen in the…

--

can: j1939: add a safeguard to __j1939_ecu_release_work()

This patch adds a hrtimer_cancel() of ecu->ac_timer, wrapped in WARN_ON(),
to __j1939_ecu_release_work() before the ECU is freed. The commit message
says this fixes a use-after-free where a pending ac_timer fires after
__j1939_ecu_release() or j1939_module_exit().

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 0aeeee1491e4f..3924404152a2f 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -22,6 +22,11 @@ static void __j1939_ecu_release_work(struct work_struct *work)
>  	write_lock_bh(&priv->lock);
>  	list_del(&ecu->list);
>  	write_unlock_bh(&priv->lock);
> +	/* There can't be any ref on this ECU because __j1939_ecu_release()
> +	 * was already called. But we need to make sure that
> +	 * j1939_ecu_timer_handler() is no longer running before kfree().
> +	 */
> +	WARN_ON(hrtimer_cancel(&ecu->ac_timer));

[Severity: Low]
Is the commit message accurate about what this fixes? It says:

  Since pending ecu->ac_timer is not canceled during j1939_ecu_unmap_all()
  or __j1939_rx_release(), ecu->ac_timer can call j1939_ecu_timer_handler()
  after __j1939_ecu_release() or j1939_module_exit() (i.e. causing UAF).

A pending ac_timer always holds an ECU reference. j1939_ecu_timer_start()
takes one before it arms the timer, and does not arm the timer if that
fails:

net/can/j1939/bus.c:j1939_ecu_timer_start() {
    ...
	if (!j1939_ecu_get(ecu))
		return;
    ...
	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
		      HRTIMER_MODE_REL_SOFT);
}

That reference is dropped only in j1939_ecu_timer_handler(), or in
j1939_ecu_timer_cancel() when hrtimer_cancel() actually dequeues the timer:

net/can/j1939/bus.c:j1939_ecu_timer_cancel() {
	if (hrtimer_cancel(&ecu->ac_timer))
		/* Drop the ref from j1939_ecu_timer_start(). */
		j1939_ecu_put(ecu);
}

So __j1939_ecu_release() can't be reached while the timer is queued. The
ECU's reference on priv keeps priv alive. Since "can: j1939: fix
possibility of UAF on module unload", priv also holds a try_module_get()
reference, so the module stays loaded too.

Doesn't that mean the hrtimer_cancel() here always returns 0, so the
WARN_ON() can never fire? The comment above it says the same thing.

The only effect of the added hrtimer_cancel() is a wait in
hrtimer_cancel_wait_running(). It waits for a handler that has already
dropped the last reference but hasn't yet returned to __run_hrtimer().

For a HRTIMER_NORESTART callback, __run_hrtimer() doesn't touch timer
memory after the callback returns. That makes this extra hardening, not a
fix for a pending-timer UAF.

The patch also doesn't change j1939_ecu_unmap_all() or __j1939_rx_release(),
the teardown paths the message names. Not cancelling the timer there causes
a refcount leak rather than a UAF. A later patch in this series fixes that
leak: "can: j1939: fix "struct j1939_ecu" refcount leak".

This patch carries Fixes: and Cc: stable. Could the commit message describe
the change as a hardening wait for an in-flight handler, rather than as a
fix for a pending-timer UAF?

>  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7cc08b0f-290e-464b-ab13-0a5ce3c57f4f%40I-love.SAKURA.ne.jp
