Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE630F7E8
	for <linux-can@vger.kernel.org>; Tue,  9 Jun 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030949; cv=none; b=mBt+2vo/uGHYUSTr2aCSlviSRBx2+tfH5pIyZN/adSS5pp3sdOeWB3p4EPY7zfb5zQYChGaK5CCDysLY3U9C827o8Wo9HY9G6Zf5rbcNbh9e/RMRggZGILsqpbJr5ht+VYBKtDqBzJ5+N9P0mU+BPy/lt9QUDJiBpTnyNOGUUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030949; c=relaxed/simple;
	bh=2Rie+Ec8bZS24b1oSix1V3LFKQZatObr5xpkdE/7xpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ir6Pjzw+AhmvHBBG0fhdWxl9DuzbQ8P8OlVmAmX+SP3CrkG3TfTu7qX5zcC4W9vIWGKhPYycbFK8how0QL/wdOZAsLlbIAsMYvkjlvMs2jSPDdW789g/885nS/rFV63pUoVGOuqMO7qnUJFDcFL5MCtOXNR1CSaoHDCeUlBzH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbAegGdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbAegGdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E121F00898;
	Tue,  9 Jun 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030946;
	bh=TisqxpHbWY6lkT/zq+NuGOYgflKKXHiQSM+5oiWrtZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RbAegGdvb26zFiINVWUe2KG69mUG0LBdnxHeY+eHMBplSi3PcRUl0H0PvEilglCQ9
	 PUb1/7BnxejpMduWF+2ER7O1CeQ1YF6fa59OATJnp/KzKqdlLglKWDN6xqlvEWTERz
	 p7q2gA6yykb63EvQwi2bXbJnM5mBLons5k5H8rJ7OhrsKSGUHuicu+d36wobwtdgF9
	 32fgxaDYc+/jVxpnhZ9tpbxwm+R2YW2gJhobDNfRW4gH5mAFKz9yb1vC/Xe5c7QWLR
	 nFjCJvS8c8gGCmX02xtgtkbXzHBa53cbbffGEtpxGUfFq/uYTeOspsirlSuRhrOnAr
	 k8RJR9C8eeBVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 (repost)] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
References: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:49:05 +0000
Message-Id: <20260609184905.D1E121F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `j1939_netdev_start`, if `j1939_can_rx_register` fails, the err=
or path forcefully calls `kfree(priv)` instead of properly dropping the ref=
erence via `j1939_priv_put(priv)`. This causes a use-after-free if a concur=
rent CAN RX interrupt accessed `priv` and created a session or ECU.
- [High] The destructors for `j1939_session` and `j1939_ecu` do not explici=
tly cancel their embedded hrtimers (`txtimer`, `rxtimer`, `ac_timer`) befor=
e freeing the memory.
- [High] Using `gfp_any()` under a locked context (`priv->lock`) may resolv=
e to `GFP_KERNEL` and cause the thread to sleep while atomic.
- [High] Double dropping of SKB references in `j1939_session_destroy` cause=
s premature SKB freeing, refcount underflow, and potential Use-After-Free.
- [High] Unprotected list deletion in `__j1939_ecu_release` risks list corr=
uption if `j1939_ecu_put` is called without holding the global write lock.
--

commit 7da6da8c70916fd416a2173c592294f932e47769
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tra=
cking

This patch converts j1939_{priv,session,ecu} tracking to use the
netdevice_tracker API. It replaces dev_hold() and dev_put() with
netdev_hold() and netdev_put() to help debug a reference count leak
reported by syzbot.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index dc374286eeb6e..cdc3c0a719379 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	list_del(&ecu->list);

[Severity: High]
This isn't a bug introduced by this patch, but does this unprotected list
deletion risk list corruption if __j1939_ecu_release() is called without
holding the global write lock?

If the lock is not held, it races with other readers/writers of priv->ecus.
Conversely, if the lock is required to be held, calling j1939_priv_put(priv)
later in this function could free priv while the lock is still held, leading
to a use-after-free on the lock itself during unlock.

> +	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);

[Severity: High]
This is a pre-existing issue, but does kfree(ecu) risk a use-after-free if
called while ecu->ac_timer is pending?

If this memory is freed without explicitly canceling the hrtimer, an
asynchronous timer callback might subsequently execute on the freed memory.

>  	j1939_priv_put(priv);
>  }
> @@ -155,6 +156,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j193=
9_priv *priv, name_t name)
>  	if (!ecu)
>  		return ERR_PTR(-ENOMEM);
>  	kref_init(&ecu->kref);
> +	netdev_hold(priv->ndev, &ecu->priv_dev_tracker, gfp_any());

[Severity: High]
This is a pre-existing issue, but will passing gfp_any() while holding
priv->lock cause the thread to sleep while atomic?

The gfp_any() helper checks in_softirq(). If priv->lock (an rwlock) was
acquired via write_lock_irqsave or write_lock in process context, in_softir=
q()
will evaluate to false, causing gfp_any() to return GFP_KERNEL. Allocating
memory with GFP_KERNEL while holding an rwlock can cause the thread to sleep
while atomic.

>  	ecu->addr =3D J1939_IDLE_ADDR;
>  	ecu->name =3D name;
> =20

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 9937c04241bc3..5e5e6c228f225 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c

[ ... ]

> @@ -298,7 +298,7 @@ struct j1939_priv *j1939_netdev_start(struct net_devi=
ce *ndev)
>  	j1939_priv_set(ndev, NULL);
>  	mutex_unlock(&j1939_netdev_lock);
> =20
> -	dev_put(ndev);
> +	netdev_put(ndev, &priv->dev_tracker);
>  	kfree(priv);

[Severity: High]
This is a pre-existing issue, but does this kfree(priv) risk a use-after-fr=
ee?

In j1939_netdev_start(), priv is created with a kref of 1 and exposed via
j1939_priv_set(ndev, priv). The call to j1939_can_rx_register(priv) then ma=
kes
priv accessible to incoming packets.

If a packet arrives concurrently, the rx handler could take a reference to
priv and create sessions or ecus. If j1939_can_rx_register() subsequently
fails, this error path forcefully calls kfree(priv) unconditionally, bypass=
ing
the reference count. Any concurrently created sessions would then access the
freed priv memory. Should this use j1939_priv_put(priv) instead?

> =20
>  	return ERR_PTR(ret);

[ ... ]

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da7..158433511552e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -283,6 +283,7 @@ static void j1939_session_destroy(struct j1939_sessio=
n *session)

[Severity: High]
This isn't a bug introduced by this patch, but does the loop in
j1939_session_destroy() underflow the skb reference count?

Looking at the loop just above this context:

	while ((skb =3D skb_dequeue(&session->skb_queue)) !=3D NULL) {
		/* drop ref taken in j1939_session_skb_queue() */
		skb_unref(skb);
		kfree_skb(skb);
	}

j1939_session_new() only took one extra reference via skb_get(skb). Calling
both skb_unref() and kfree_skb() drops the reference count twice for each
dequeued skb, which can underflow the refcount and cause a use-after-free
if the original owner still holds a valid pointer.

>  		kfree_skb(skb);
>  	}
>  	__j1939_session_drop(session);
> +	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
>  	j1939_priv_put(session->priv);
>  	kfree(session);

[Severity: High]
This is a pre-existing issue, but does freeing the session here without
stopping its timers risk a use-after-free?

If the session is destroyed while session->txtimer or session->rxtimer is
pending, the asynchronous timer callbacks could execute after kfree(session=
).
Should the hrtimers be explicitly canceled before the memory is freed?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2bc332e0-b250-4679-=
a075-1c413ad843ce@I-love.SAKURA.ne.jp?part=3D1
