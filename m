Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167850E59B
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678416; cv=none; b=p08wrSNVp3Uq0DI7p0MsuQZcAftT0IUmkyqCIBikzu+e2DOjKALxhDVA80bGNDjA6a9hfCv+YgDtKkzsisCQ35lvzZFwQUnP1Q/Lhda9uj/civUyJ3Kea5xtW9BFGmXRsAnNsXMKVVivRDlxTzOlDFlkzmP7/byFBzJau/bLYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678416; c=relaxed/simple;
	bh=oGiBPduJp31xolOjLsYEv91PDAVwdTZ64pyRxKtgc/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U1+WgHWIb5qRiwPdPqq/Ewa9gCmfV0MWiOH8ieEQblk8Y7o5zCtpR9wv0K0MAC8/x/nARb+S2dh25wq0lYnXRH6A1hCTTbVrKA4lDC2cwxMGQtruoAjt+KWMlDsMM4i55RJMdrao5P0dpdMa8rt4PDCDdFHEGXw15rWdKx/qahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjYKrvKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjYKrvKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C258B1F000FF;
	Tue, 29 Sep 2026 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790678404;
	bh=4jG3fr6fzPQpC3PZECHhbrQzqmsdEG2N6eK+W7uvLK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjYKrvKxPdP6zu6amKV4iuPxcaCuv+cVPPe9222XoXzOm5dUVTmSjzteCH7jDVuOl
	 zCeJD+zvehiqiruv5vVfJAVkkhrKj7bpsLlYgmnTShSZgfcaibl1forC4dbaSxL68P
	 QnfRsgR2QVtIm+V6YZpkceUvWyJ33YV97cEYsH7smdtxnXbsiFAq94gfdW/Uvp0Ysj
	 cqtb74D4RLGZhfAmkqFAp4J/dpgJKWhaYrvl4tfCC6Mwehk5xWUrq8H0k1FB/3GGv3
	 o9z6B9VWdr9hoBqa5dLeBUPqe9QsKdj/UsLw8QMCZ1snlbiZ0r+FROpIIX1yg1mSyo
	 cBhRmmuGFMNWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: j1939: cancel pending address claim timers on
 rx release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <853e770e-4eee-4da8-8cf0-08731f9651ab@I-love.SAKURA.ne.jp>
References: <853e770e-4eee-4da8-8cf0-08731f9651ab@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:40:03 +0000
Message-Id: <20260929104003.C258B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: j1939: list corruption via lockless j1939_ecu_put()
--

commit 0dc29971aa78a56ec257a9c34f0e743a7e1b0390
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: cancel pending address claim timers on rx release

This commit attempts to fix a struct j1939_ecu refcount leak by cancelling
address claim timers before calling j1939_ecu_unmap_all() during device
teardown. It adds a rescan loop in __j1939_rx_release() to safely cancel
timers while avoiding deadlocks.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.55=
3632-1-mkl%40pengutronix.de

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..3a4de839cf9a2 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c

[ ... ]

> @@ -212,8 +212,38 @@ static void __j1939_rx_release(struct kref *kref)
>  {
>  	struct j1939_priv *priv =3D container_of(kref, struct j1939_priv,
>  					       rx_kref);
> +	struct j1939_ecu *ecu;
> =20
>  	j1939_can_rx_unregister(priv);
> +
> +	/* can_rx_unregister() uses call_rcu() internally and is asynchronous.
> +	 * We must wait for an RCU grace period to ensure that any in-flight
> +	 * j1939_can_recv() instances on other CPUs have fully completed.
> +	 */
> +	synchronize_rcu();
> +
> +	/* Cancel all pending address claim timers before unmapping the ECUs.
> +	 * This prevents an orphaned timer from re-mapping an ECU after the
> +	 * rx path has been completely torn down.
> +	 */
> +rescan_timers:
> +	write_lock_bh(&priv->lock);
> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		int ret =3D hrtimer_try_to_cancel(&ecu->ac_timer);
> +
> +		if (ret =3D=3D 0) /* Was not running. */
> +			continue;
> +		kref_get(&ecu->kref);
> +		write_unlock_bh(&priv->lock);
> +		if (ret =3D=3D -1) /* Was running. Wait without lock. */
> +			j1939_ecu_timer_cancel(ecu);
> +		else /* Was canceled. Drop ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +		j1939_ecu_put(ecu);

[Severity: High]
Could these lockless j1939_ecu_put() calls trigger list corruption?

When __j1939_rx_release() cancels the timer, it drops priv->lock before
dropping the references. If this ecu's reference count drops to zero here
(for example, if the timer was the last reference), __j1939_ecu_release()=20
will run locklessly.

Looking at __j1939_ecu_release() in net/can/j1939/bus.c, it modifies the=20
list without acquiring priv->lock:

net/can/j1939/bus.c:__j1939_ecu_release() {
    ...
    list_del(&ecu->list);
    ...
}

Does this deterministic path lead to a kernel panic when other threads trav=
erse
or modify priv->ecus during device teardown?

As an aside, looking at j1939_ac_recv() in net/can/j1939/address-claim.c, it
has a pre-existing example of dropping a reference locklessly. Is it possib=
le=20
that the underlying list deletion vulnerability exists elsewhere as well?

> +		goto rescan_timers;
> +	}
> +	write_unlock_bh(&priv->lock);
> +
>  	j1939_ecu_unmap_all(priv);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/853e770e-4eee-4da8-=
8cf0-08731f9651ab@I-love.SAKURA.ne.jp?part=3D1
