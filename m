Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004653750D7
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753808; cv=none; b=gNRU8LmgP3z3+eTQFZVjndqeIfCNtKud32S0eFJAOnUZyUxloYK2dDtogAlIG2uZXJx6X6xx0wNGLvJ01Emm9NvCoZ35Am6dHx/44Lxffa+0gMOTutl9Fo7BjxjAKSWO0gEPQoDkLLGkMBG5MbxpCmPAqNl1Y6qYc/H06GzlLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753808; c=relaxed/simple;
	bh=IX1LlyM5MJIhXTA4fSz0C1+LejLc7t/MMpHiK4HXH9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GFHeDDa6KEvxf1snq4t1KV+Iu+g1D4gn7tonLyNTAegtn9/6j33KT/9S+G72ywZNziKhZL0muEf2Du7EjfCOZqN6Mu6ie7VUNLWS1sdyD/qJYuKhffh3yRV2SnJP7mVGqVUPddMKwRBqPV/0EgVdDq0Go7oP7wGaBCv+tDaqNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+IU8ODT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+IU8ODT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E3E1F000E9;
	Mon,  3 Aug 2026 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753806;
	bh=smxvsVgyIeqjjwhEoK7OdGJZDfSK1rXZWdIfBBlb+Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+IU8ODT9Af91vLB3FV+Uiggr8nKkj0V3xosIbjWt6VSJAFiYSdtcc2TQT8VM3fhS
	 mmKMn+c9mxMCT2Cio1ylQpW/EFmfHrZAsTKYm8IM4CvAyFV9jHNjpbkZa4VgZ24U61
	 ltdrtJJWDgRPtXv5XK7Wm374myF3dwZs4dZlV2z7ItyowTNTE1sznXc5MwCPfQ5avi
	 vpz9bWhZSHzJimoXI25K2o/d3mzR3h74SvmfUSHMyynp0G7qCuve/e0br9h8rVXC4y
	 8l6pQNakhjYFLmdC1rHWw6snWzJd51hv/QSBzeEpAXKpX1DP9RiRPNrb5KIoOTLltg
	 LbG+ghuvwa37A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can v2] can: j1939: avoid address-claim timer deadlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Hoffmann" <f3lix.dev@gmx.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260803101503.21023-1-f3lix.dev@gmx.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
 <20260803101503.21023-1-f3lix.dev@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:43:24 +0000
Message-Id: <20260803104325.C2E3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless calls to `j1939_ecu_put()` can drop the last reference to=
 an ECU, triggering `__j1939_ecu_release()` and modifying `priv->ecus` lock=
lessly.
- [High] Permanent memory leak of `j1939_ecu` and `j1939_priv` when the net=
work interface is brought down while an address claim timer is pending.
--

--- Patch [1]: [PATCH can v2] can: j1939: avoid address-claim timer deadloc=
k ---
commit 08d11140bccb342c8267ab26aee9e24877e324a3
Author: Felix Hoffmann <f3lix.dev@gmx.de>

can: j1939: avoid address-claim timer deadlock

j1939_ac_process() holds priv->lock while synchronously canceling an
ECU's address-claim hrtimer. The timer callback takes the same lock. If the
callback starts on another CPU after the receive path takes the lock, the
callback waits for priv->lock while hrtimer_cancel() waits for the callback
to finish. This deadlocks both CPUs and makes the system unresponsive.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..eb9a3fd847f42 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -10,10 +10,19 @@
>   * Since rtnetlink, no real bus is used.
>   */
> =20
> +#include <linux/net.h>
> +
>  #include <net/sock.h>
> =20
>  #include "j1939-priv.h"
> =20
> +#define J1939_ECU_TIMER_RETRY_DELAY_MS 1
> +/*
> + * J1939 does not specify a lock-contention retry count. Five retries ar=
e a
> + * pragmatic threshold for warning about an unusual address-claim delay.
> + */
> +#define J1939_ECU_TIMER_RETRY_WARN 5
> +
>  static void __j1939_ecu_release(struct kref *kref)
>  {
>  	struct j1939_ecu *ecu =3D container_of(kref, struct j1939_ecu, kref);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	list_del(&ecu->list);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to list
corruption?

If an ECU is concurrently unmapped (dropping its primary reference) while
another thread holds a temporary reference (e.g., in j1939_ac_recv() or
j1939_ac_fixup()), dropping the temporary reference locklessly via
j1939_ecu_put() will reduce the refcount to 0.

This triggers __j1939_ecu_release(), which performs list_del(&ecu->list) on
priv->ecus without holding priv->lock.

Can this be triggered remotely by sending precisely timed address claim and
release packets to cause a use-after-free or panic?

[ ... ]

> @@ -109,6 +118,8 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
> =20
>  void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  {

[Severity: High]
This is a pre-existing issue, but does this leak j1939_ecu and j1939_priv w=
hen
the network interface is brought down?

When a J1939 interface is unregistered, j1939_ecu_unmap_all() clears mapped
ECUs from priv->ents, but it only iterates over mapped ECUs and ignores ECUs
in priv->ecus that have a pending timer:

net/can/j1939/bus.c:j1939_ecu_unmap_all() {
        for (i =3D 0; i < ARRAY_SIZE(priv->ents); i++)
                if (priv->ents[i].ecu)
                        j1939_ecu_unmap_locked(priv->ents[i].ecu);
}

It seems this fails to cancel pending ac_timer hrtimers for ECUs in the
middle of address claiming.

When the uncancelled timer subsequently fires, j1939_ecu_timer_handler()
executes and maps the ECU back into the now-abandoned j1939_priv.

Since interface teardown (j1939_netdev_notify()) won't run
j1939_ecu_unmap_all() again, does this cause a permanent leak blocking
unregister_netdevice()?

> +	ecu->ac_timer_retries =3D 0;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803101503.2102=
3-1-f3lix.dev@gmx.de?part=3D1
