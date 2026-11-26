Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682151;
	b=LQDM3YYYtBCPtRUIdf/oydHU1FFc8aZwB7ZPNnMfWqfX9Wulh2S010DkFsgput2pzhuN
	 enupagxD9mljqo4+tK6aPtNfuD5HvaSOZWLGYs4m5aTSQMUHd1abb2QYXG/O4ytecx29E
	 GQiQ/R4+nLiJxMcUgQmraADXsZkV6TiPHJP39uO3S2qcsilK/b3xb4KosUTrC+srFwAcO
	 hj+EEwWczswX8R1sHvX915h/7c6sqgJYVhRp4BQb/bSWRNIiZgPM3ifkPYkA/Et3EOuwg
	 b6UYjk8DiY0kSD+PcITtOGMzeBcJqskfk5P3WrTyR2amPk4mcyaAiP9AeJ7DSW/B6aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mvvYspxkHaEnDdWCxiNARmqZM3t9M2asb+D/ao1UIq0=;
	b=lOWYDo3hYWZaMeBMNlkE1rrso7lvDIwRM2T7z1RfciwnDfw1GSGdyBPrLbu+iNmbh9vC
	 hl3w93iRRLtKfXTweVPSKxPhiN9w17g403QmOaMhyABDEcgB0KGuUXnDEuMaK4c9vDBvN
	 G7HyTUcW65ysBODUhVc3yck37WheKduIYjHljrpi7A9LiYYhUdOwtbAai6mxsdHf1K3sB
	 MjTfZabOOaKga80TAtH7zuCOksWdwR4+wxlCURVQ1NFXGxj2+q8GZQVSIz7fXedYPIt/w
	 GBThHy9CRgkMQwtdqvHs8iunqfAFb8I+ILgk/qaasqHyffOIFoLb+B9sMipHZUz38FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyEPnwm1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066A606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyEPnwm1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974B31F000C6;
	Thu, 26 Nov 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795682150;
	bh=mvvYspxkHaEnDdWCxiNARmqZM3t9M2asb+D/ao1UIq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyEPnwm1guup5aqHo/oyhvgetIp0TPVPzb1wpWfysXNRo+enl/8HhyzLOtN/9Z0Kq
	 HRLoY5nP1Z7QlS5Y58UDOUxRQaSHZ66YTwrKVSo+A0LubVmHrwf4RGgeC16BjKUuK2
	 6wB5WBDSCREtKKb+WIOd9m39jC/iNwlKXkO+bXvPHQQ07IVWSivDaOcNuURp2GTnqG
	 /9E1LVmRoFnwGuvd5PVMDrkVKStoDV5zV0rnJb07TfGOqwesumdM1agtV+iJDYmoAK
	 VlugUfaba0++9FN05BDPwUyXp/x4647dZ3AkJA8KrDiBoCc1HQglG4nLyjF7xpk8Kc
	 AddTkL+cZWh4A==
Message-ID: <sashiko-outbox-235040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device
 stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261126082257.491041-1-dmantipov@yandex.ru>
References: <20261126082257.491041-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:35:50 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Critical] can: j1939: refcount underflow and UAF in
  j1939_ecu_cancel_all()
- [High] can: j1939: premature j1939_ecu_cancel_all() in
  j1939_netdev_stop()
- [Medium] can: j1939: ECU leak in j1939_ecu_cancel_all() on in-flight
  ac_timer
--

commit 93803049529a18174c52d42d8612110310952b12
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: cancel all pending ECUs on device stop

This commit adds j1939_ecu_cancel_all() and calls it from
j1939_netdev_stop() to cancel pending ECU address-claim timers and drop
their ECU references.

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
> +	write_unlock_bh(&priv->lock);
> +}
> +

[Severity: Critical]
Does checking hrtimer_try_to_cancel(&ecu->ac_timer) !=3D -1 drop an unowned
reference on ecu when ac_timer is inactive?

hrtimer_try_to_cancel() returns 1 when an active timer is cancelled, 0
when the timer is not active, and -1 when the callback is running.  For
an ECU whose ac_timer is not active (for example, an ECU that has already
completed address claiming and is mapped in priv->ents[ecu->addr].ecu, or
a local ECU whose timer was never started), hrtimer_try_to_cancel()
returns 0 and j1939_ecu_cancel_all() drops a reference that ac_timer does
not hold.  When the mapped reference in priv->ents[] was the only
remaining reference, this frees ecu before __j1939_rx_release() ->
j1939_ecu_unmap_all() dereferences priv->ents[i].ecu, causing a
use-after-free and refcount underflow.

Should this check hrtimer_try_to_cancel(&ecu->ac_timer) =3D=3D 1 instead?

[Severity: Medium]
Can an in-flight j1939_ecu_timer_handler() still map and leak ecu when
hrtimer_try_to_cancel() returns -1?

CPU0                                  CPU1
j1939_netdev_stop()
  j1939_ecu_cancel_all()
    write_lock_bh(&priv->lock)
                                      j1939_ecu_timer_handler()
                                        write_lock_bh(&priv->lock)
    hrtimer_try_to_cancel() -> -1
    write_unlock_bh(&priv->lock)
  __j1939_rx_release()
    j1939_ecu_unmap_all()
                                        j1939_ecu_map_locked(ecu)
                                          j1939_ecu_get(ecu)  <-- leaked
                                        j1939_ecu_put(ecu)

When ac_timer expires on CPU1 while CPU0 holds priv->lock,
hrtimer_try_to_cancel() returns -1 and j1939_ecu_timer_handler() waits on
priv->lock.  If j1939_ecu_unmap_all() runs before CPU1 acquires
priv->lock, j1939_ecu_timer_handler() subsequently maps ecu into
priv->ents[ecu->addr].ecu and takes a new reference that is never
unmapped, leaking ecu, priv, and their net_device references.

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index d9384cf0e356f..4b62da9fd96dc 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_devi=
ce *ndev)
> =20
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);
>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
>  	j1939_priv_put(priv);
>  }

[Severity: High]
Should j1939_ecu_cancel_all() be called inside __j1939_rx_release() after
j1939_can_rx_unregister() rather than unconditionally in
j1939_netdev_stop()?

All J1939 sockets bound to the same net_device share a single struct
j1939_priv, and each socket release calls j1939_netdev_stop().  Running
j1939_ecu_cancel_all() when priv->rx_kref > 1 cancels pending
address-claim timers for other active sockets on the same interface,
leaving their ECUs unmapped so later NAME-based sends fail with
-EADDRNOTAVAIL.

Even when the last socket closes, calling j1939_ecu_cancel_all() before
__j1939_rx_release() calls j1939_can_rx_unregister() leaves a window where
incoming Address Claim frames in j1939_can_recv() can start a new
ac_timer after j1939_ecu_cancel_all() has already returned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126082257.4910=
41-1-dmantipov@yandex.ru?part=3D1
