Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C223B83F9
	for <linux-can@vger.kernel.org>; Fri,  2 Oct 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933662; cv=none; b=g0c0Jg5Nzl901yy4U+OPyHNvshN8YSlSQMs8XyN5eEpvS4DGMdibZIL6fc9/PKhTU49QBUU1BzHfjfv6BMw+4Gttm2bTX1hV+ETkWPO+jlDnXPO/7h2oglJ6Qu4e4dDJEQP9DKR04QBBi1L2puM+8f++kfElKYo7ByJwZrGAZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933662; c=relaxed/simple;
	bh=Ge07Cujy+FWZ4m89fUiYSfsLSgPJA1LoCcchzJ2JEgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJO7DG8K1b/1aYIOla8VLA5KJ2UQo7KUsgcsNWcLDhNpZ/miOBB8EnS0dMoK6aTJ3976MaKYtTCryPzlZbYODqeb68UGisq2ANTtP8uGioHPQnEejOhLC7LI4UgwmjckDw7lX5IPWdRMty6oCne1YPT1+B0md68WzBAgeGBuq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKhNxl1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKhNxl1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCF31F00893;
	Fri,  2 Oct 2026 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790933661;
	bh=pmqYF0KYXLoe0kerjlAn0Buz0p5CZG4NTpeTL/UfayY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gKhNxl1rAJkeC9W2G1IE247KveBrsFHxmiHlbDZE4Zu55vY7lgR8TQyJSHNja9ryO
	 u7tI5BGeilyBd20pEJccZNdtF2Uy8eZs3trgCzAPoqJI/af1dHhDch9/bn1CyqgKZo
	 MWjoIW9TgHUNYbgYIdKarFg0V29ZSMGR0r9J16GJrbZeuSrCeBiSQTnTMLDgKryPBm
	 mfsnQWRm8UJYQWiO5PyO9vzez5TjhRgFXKs8Am6I2LwAR20NENLrmwK9XgGYgDHcCG
	 pR8h+cvZuceHPQMpZHbx3bCCcm97eeAro7sRPhvcK16R0px4liXVJIE6AJz+Z09JYE
	 KdqvkMqQEd5zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] can: j1939: cancel all pending ECUs on device stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261002091552.737529-1-dmantipov@yandex.ru>
References: <20261002091552.737529-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:34:20 +0000
Message-Id: <20261002093420.ACCF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] can: j1939: refcount underflow of ECU on inactive timer cancel
- [High] can: j1939: unintended global disruption of active address claims
- [Medium] can: j1939: memory leak of ECU from ignored running timer
--

commit 8541ad61eedf789fa9a61f3ebd58354bc6c07318
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: cancel all pending ECUs on device stop

Cancel all pending ECUs in j1939_netdev_stop() to prevent memory leaks when=
 a
stopped device no longer processes ECUs. This introduces j1939_ecu_cancel_a=
ll()
using hrtimer_try_to_cancel() to avoid deadlocks.

Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0b5232b536051 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -96,6 +96,17 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  	write_unlock_bh(&ecu->priv->lock);
>  }
> =20
> +void j1939_ecu_cancel_all(struct j1939_priv *priv)
> +{
> +	struct j1939_ecu *ecu, *tmp;
> +
> +	write_lock_bh(&priv->lock);
> +	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
> +		if (hrtimer_try_to_cancel(&ecu->ac_timer) !=3D -1)
> +			j1939_ecu_put(ecu);

[Severity: Critical]
Does this code inadvertently drop a reference that the timer does not own?

If the timer is inactive, hrtimer_try_to_cancel() returns 0. Since 0 is !=
=3D -1,
the condition evaluates to true, and j1939_ecu_put() is called unconditiona=
lly
for inactive timers. Could this lead to a refcount underflow and use-after-=
free
if a user binds and then closes a socket?

[Severity: Medium]
Will this leak the ECU and the associated j1939_priv if the timer callback =
is
currently running?

If hrtimer_try_to_cancel() returns -1, the -1 state is dropped without wait=
ing
or retrying, abandoning the active timer during teardown.

If the abandoned callback j1939_ecu_timer_handler() begins executing and la=
ter
calls j1939_ecu_map_locked() after unmap_all has finished, might this map t=
he
ECU back into the stopped device and prevent it from ever being freed?

> +	write_unlock_bh(&priv->lock);
> +}
> +

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..1f68ba8037004 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_devi=
ce *ndev)
> =20
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);
>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);

[Severity: High]
Can this unintentionally cancel all ECU timers interface-wide on a single
socket's close event before checking the interface reference count?

Because j1939_ecu_cancel_all(priv) is called unconditionally before the
priv->rx_kref reference check, any user creating and closing a socket could
unintentionally disrupt network interface state and abort in-progress addre=
ss
claims for all other applications using the same interface.

>  	j1939_priv_put(priv);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002091552.7375=
29-1-dmantipov@yandex.ru?part=3D1
