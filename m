Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF526A0B9
	for <linux-can@vger.kernel.org>; Sat,  1 Aug 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591797; cv=none; b=NxuK5IJvxoXl9JdmDO1RWp6taCsvcM236WXUdjULBPpcfw6qUKxIHqOe3aw/5JoKpr44wJgMLskLbdV7WQTm8MLyiRDjp2mRrTFx3qp9sKIoFOaViqtuB1gwyzxtCY5C9eSGEhIsd+NYYmx6IprsW81a9VuKVELCeKaMLWrO2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591797; c=relaxed/simple;
	bh=EI/u70y8gtAvBSo65ZENXEQdWC3euJsSXXJqLR8S46U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PyhkAlp8e9CV8c8q0U09DPNHYRrZpbUnUjPjdmrvNIZXzk7IfZ4KHcExIijXdBC27hkSEff+8X62Hq2Wio64XwKNXgnvTrvTrHJmwf/VSMLBhEYMitGMMbAJvbmIT04BDbrFNZEy+TuoO2iMujxOAnXx/t3GGPwWRvF31WowM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=albWTtqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="albWTtqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929641F00AC4;
	Sat,  1 Aug 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785591795;
	bh=/a0HBDNs1Hu4SY+fNre865AXVNBC6r/K3FLUdxtR/JA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=albWTtqQFNSorQdYtGcV8cIH4qbNHXjY1/CSCk3AREeJTI5zS6fVXAMi5GJSnlBQM
	 UqoN+Zu+NaktA5CZc1L67t+upWFD18M4nvQgXqZ5ukZisBlLH//sY4AzRF2jUpfAX6
	 NBFE3sVLCEPMiX42TW1yX9OF0C0RGP+AARsxUSiENrhaFwcgmB3KYXh2gORDY6h7LX
	 co2x2wrNHDZoY/BctKFUjSVhzt9fZCR6f4FEHV6JlHL24lbZXkTj8pr2IHWSYBZg2N
	 J2VGxmqUxJDlqCR/eWaephktM0jynqK7T3ynI8CJVxZYFuzl2cXzY4VpC927p3HXi2
	 A3L914yG1N/hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: j1939: avoid address-claim timer deadlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Hoffmann" <f3lix.dev@gmx.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260731134255.1002902-1-f3lix.dev@gmx.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 13:43:15 +0000
Message-Id: <20260801134315.929641F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free on `priv->lock` during ECU timer completion.
- [High] Data race and unprotected `list_del()` causing list corruption on =
ECU release.
- [Medium] Memory leak of unmapped ECUs and `j1939_priv` due to missing tim=
er cancellation.
- [Medium] Logic Bug: Resurrecting lost address claim contention.
--

--- Patch [1]: [PATCH net] can: j1939: avoid address-claim timer deadlock -=
--
commit a5db6a778fcc4768a707910335bdf934adc29468
Author: Felix Hoffmann <f3lix.dev@gmx.de>

can: j1939: avoid address-claim timer deadlock

j1939_ac_process() holds priv->lock while synchronously canceling an
ECU's address-claim hrtimer. The timer callback takes the same lock. If the
callback starts on another CPU after the receive path takes the lock, the
callback waits for priv->lock while hrtimer_cancel() waits for the callback
to finish. This deadlocks both CPUs and makes the system unresponsive.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..ac654dc8872e6 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -131,7 +131,17 @@ static enum hrtimer_restart j1939_ecu_timer_handler(=
struct hrtimer *hrtimer)
>  		container_of(hrtimer, struct j1939_ecu, ac_timer);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
> -	write_lock_bh(&priv->lock);
> +	/*
> +	 * j1939_ac_process() cancels this timer while holding priv->lock.
> +	 * Don't block here, otherwise the timer and receive paths can deadlock

[Severity: Medium]
This isn't a bug introduced by this patch, but does j1939_ac_process() alwa=
ys
cancel the timer?

If a new address claim takes precedence over an existing claimant (prev),
prev is evicted via j1939_ecu_unmap_locked(prev). However, it appears its
pending ac_timer is not cancelled.

If the winning ECU vacates the address before prev's timer expires, could t=
he
address slot become free, allowing prev's timer to fire and blindly re-map
itself without broadcasting an Address Claim message?

> +	 * waiting for each other on different CPUs. Retry shortly if address
> +	 * claim processing currently owns the lock.
> +	 */
> +	if (!write_trylock(&priv->lock)) {
> +		hrtimer_forward_now(hrtimer, ms_to_ktime(1));
> +		return HRTIMER_RESTART;
> +	}
> +
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
>  	j1939_ecu_map_locked(ecu);

[Severity: Medium]
This is a pre-existing issue, but can this lead to a memory leak when an
interface goes down?

When a network interface goes down, j1939_ecu_unmap_all() clears the ECU
entries from priv->ents. If it fails to cancel the pending ac_timer for the
ECUs, could this handler execute and call j1939_ecu_map_locked(ecu)?

Since the slot was cleared, the ECU would be successfully re-mapped and its
reference count incremented, potentially leaving it leaked along with the
j1939_priv object since the interface is already down.

> =20
>  	/* The corresponding j1939_ecu_get() is in
>  	 * j1939_ecu_timer_start().
>  	 */
>  	j1939_ecu_put(ecu);
> -	write_unlock_bh(&priv->lock);
> +	write_unlock(&priv->lock);

[Severity: High]
This isn't a bug introduced by this patch, but could this write_unlock()
trigger a use-after-free?

If the timer holds the last reference to the ECU, j1939_ecu_put(ecu) drops =
its
refcount to 0, invoking __j1939_ecu_release(). This in turn calls
j1939_priv_put(priv).

If this drops the final reference to the j1939_priv structure (e.g., after a
network interface teardown dropped the base reference), priv is synchronous=
ly
freed via kfree(). Immediately after j1939_ecu_put() returns, the handler
dereferences the freed memory by calling write_unlock(&priv->lock).

[Severity: High]
This is also a pre-existing issue, but is there a risk of list corruption
when j1939_ecu_put() drops the final reference without priv->lock being held
in other contexts?

While priv->lock is held here, j1939_ecu_put() is called from functions
like j1939_ac_recv() in address-claim.c without holding this lock.

If j1939_ecu_put() drops the final reference, __j1939_ecu_release() executes
list_del(&ecu->list), which assumes priv->lock is held for safe modification
of priv->ecus. Could concurrent operations trigger this and silently corrupt
the list?

> =20
>  	return HRTIMER_NORESTART;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731134255.1002=
902-1-f3lix.dev@gmx.de?part=3D1
