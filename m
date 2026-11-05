Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878570;
	b=lK5s62eBrQdt/q++52HcjtNF5al6LfdFanSsMYOX/9VHR425SCRvdLmyZNtfpiLwascj
	 gr0V8F6c7gpcFhJc7Tp8HkTeTvm13ZHV9OqAx9kQcoRn74D0HwVs6KfOub/e39ZH5MZUJ
	 AmFs7lHXeBh6JjXidEk27RX7rTRLS/eJIA5lmTpc3JPxNr4CX7G7KUDWLDpr8Tp8y+2yT
	 RQxURRL3wcEiKf+psrT/5I7pK0dA0Iati8clwmY/Bh7beMZSxSvHIqEp3dy8XuBEkVw+m
	 DAgZfIoth9zQrv6HhnDark01NdV1rkaK7h9U/vknvvAMnLM9V1kMwSS5dxdkFD6zgDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mbbZMDFRKJDEzHgLpHN42W1zIpQ4nZwErYCwhR2np6Y=;
	b=yWf78I+xVNLxgOXQEYyJ2rj21k197xyLOiAYXJ76gnMGbtyyF7rtA5HC86/GPQZaDeAm
	 t9GdZ1zdKLSmEXnDO4mXsb6riWXtvj3pi8yPLPjitXxNxjoNpSf1rihTAHCtir20eFAWF
	 FnrgjxgBrpy1ZsXpklOSlNZly7u43TkwsOjfQEyBl3ln/1JW7MZnHyXFRyqLolB7O4bYC
	 xkL12Qjh14nG9u2XAzPT6F8lyLNhxl/V4E0QfyYBL/p7z5/VDudwMvw0hPalSEVM1nQpi
	 TnHeP1+I+kXufFS7PlUJR4xFRH4lyBF3A9fW/i8eykm4jIEbkS1dNgghBQz02lgYUug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9qnQOnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020A606A31B
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9qnQOnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D1B1F000C1;
	Thu,  5 Nov 2026 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878569;
	bh=mbbZMDFRKJDEzHgLpHN42W1zIpQ4nZwErYCwhR2np6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9qnQOnXb+rOkPoy21+9Pg+anYcR+Rw1cr1lsyHvYvQtHuUg7R+oItKYe1lOoqLjQ
	 4EiBA/b6M3pVu/+TwgwreRxKxj3WZzLfd/TasOU5yI7T5iIMiXeVLAdI/BZdKid/N6
	 +3k9+rUGVsbMgKF6f2qwQcwOiEtcpGXHTl49T1UTAQKZZZZklcOn7/Tx9Tw1qZd48s
	 /zxuJj9ycB3h6KK2s30WfcWRRjPjM2qzK+pSHckzNh79It6zvtzgeRcpMrgsgmYIB9
	 H01JgbAyrt1wV6n8xfpsVAUHmsPAvMq+I0zV1gdH64lPW9oE3C3oNh4jsRLNb6JNPr
	 ldMPf6dXODATA==
Message-ID: <sashiko-outbox-198960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
 in j1939_ecu_map_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <f12e4200-9267-424d-99f2-584774bd8eb1@I-love.SAKURA.ne.jp>
References: <00aae7aa-8351-4d69-8938-4d8e4eee78c2@I-love.SAKURA.ne.jp>
 <f12e4200-9267-424d-99f2-584774bd8eb1@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:36:09 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] can: j1939: duplicate ECU creation and UAF when j1939_ecu_get(=
) fails
--

commit 85d70b39e15375400811d45130221248f1712952
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix "struct j1939_ecu" refcount leak in j1939_ecu_map_locked()

This commit changes j1939_ecu_get() to fail when the associated net_device =
is
no longer in NETREG_REGISTERED state or when priv->rx_kref is zero, prevent=
ing
j1939_ecu_map_locked() from remapping an ECU after j1939_ecu_unmap_all() has
completed.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..11d08b7485489 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -50,8 +50,13 @@ void j1939_ecu_put(struct j1939_ecu *ecu)
> =20
>  static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
>  {
> -	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
> -	return kref_get_unless_zero(&ecu->kref);
> +	struct j1939_priv *priv =3D ecu->priv;
> +
> +	/* Don't get an ECU ref if netdev is no longer registered or
> +	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
> +	 */
> +	return READ_ONCE(priv->ndev->reg_state) =3D=3D NETREG_REGISTERED &&
> +		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);
>  }

[Severity: Critical]
Can this cause duplicate struct j1939_ecu creation, use-after-free when
ecu->ac_timer fires, and a leaked net_device reference when
j1939_ecu_get() rejects a live ECU?

With this change, j1939_ecu_get() returns false whenever
priv->ndev->reg_state !=3D NETREG_REGISTERED or kref_read(&priv->rx_kref) =
=3D=3D 0,
even if an existing ECU on priv->ecus still has ecu->kref > 0 (for example,
while its 250ms ac_timer is pending or while another socket holds it).

However, both callers of j1939_ecu_get_by_name_locked() that manage named
ECUs assume a NULL return means no valid ECU with that name exists, and fall
back to j1939_ecu_create_locked():

net/can/j1939/bus.c:j1939_local_ecu_get() {
	ecu =3D j1939_ecu_get_by_name_locked(priv, name);
	if (!ecu)
		ecu =3D j1939_ecu_create_locked(priv, name);
	if (IS_ERR(ecu))
		goto unlock_priv;
}

net/can/j1939/address-claim.c:j1939_ac_process() {
	ecu =3D j1939_ecu_get_by_name_locked(priv, name);
	if (ecu && ecu->addr =3D=3D skcb->addr.sa) {
		...
	}
	if (!ecu && j1939_address_is_unicast(skcb->addr.sa))
		ecu =3D j1939_ecu_create_locked(priv, name);
}

Because j1939_ecu_create_locked() does not check priv->ndev->reg_state or
priv->rx_kref, a concurrent j1939_sk_bind() -> j1939_local_ecu_get() or
in-flight j1939_can_recv() -> j1939_ac_process() running after reg_state
transitions to NETREG_UNREGISTERING (or after rx_kref reaches 0) will skip
the existing ECU on priv->ecus and append a second struct j1939_ecu with the
same name to priv->ecus.

When the socket later unbinds in j1939_sk_netdev_event_unregister() or
j1939_sk_release(), j1939_local_ecu_put() looks up the ECU via
j1939_ecu_find_by_name_locked(), which checks j1939_ecu_valid():

net/can/j1939/bus.c:j1939_ecu_valid() {
	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
	return kref_read(&ecu->kref);
}

net/can/j1939/bus.c:j1939_local_ecu_put() {
	ecu =3D j1939_ecu_find_by_name_locked(priv, name);
	if (WARN_ON_ONCE(!ecu))
		goto done;

	ecu->nusers--;
	/* TODO: do we care if ecu->addr !=3D sa? */
	if (j1939_ecu_is_mapped_locked(ecu))
		/* ecu's sa is active already */
		priv->ents[ecu->addr].nusers--;
	j1939_ecu_put(ecu);
}

Because j1939_ecu_valid() only checks ecu->kref, j1939_local_ecu_put()
matches the first ECU on priv->ecus instead of the newly created duplicate.
This drops the first ECU's reference (which may belong to its pending
ac_timer, freeing the first ECU while ac_timer is still armed) and leaves t=
he
second ECU at the tail of priv->ecus permanently leaked along with its
struct j1939_priv and net_device references.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/00aae7aa-8351-4d69-=
8938-4d8e4eee78c2@I-love.SAKURA.ne.jp?part=3D2
