Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982096;
	b=wp93rGzP9Fk2PCzqau2UryGv31MbWGEIgXaYusLvMD8ALquoWBsvXMf793YHxq/yhX88
	 vHFOz52cnqyjWpJQPkl6v0ESIlI0m0XcYKM0a+6w6cQcD9Ws/rKToy9K7PCbVkaFqUPdz
	 890XT5RO48QOPQIxSXXVoUe3XWLHEytPE+vRyyMNhnI05oLVMUj5mqTwkDoKgkquREo3V
	 dkN6+suKsv+BTrk0D8VEzvi3hHNP1aR/rLh2MZ3/rNfVrMAnLtNUohh4/NvWafMY4ZvFD
	 G1xMjddz3+PtG5bpR4awjO6B577iKQWnHLnCq6BQGoyLbvptliB06Zn5saTqxPdz/HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982096;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hvvtq9mC/1Unjgx0ZR0ubj+hVDUqaPuxqzSmoP8alEY=;
	b=K255gFQGet21j/uVcsjKljPSNpsIJysi3xvi8NyZNcbDFyAE45adXev6DHKyjhtYHq3u
	 +QlrS9J0hy/KPdD0CWuKv4s8kp59vp43pzpirQCZdfXEI3jaqSM2N0CH50tRDgPQVOpVU
	 y+9tm8iPJn+E2+7AVVp7wSUn53v1ndHSy9ZC6TpncOasDGVkV5t635r7mTKgG/ltVQcfn
	 E9Rgvf8x90MK4yRuAU7n5XLn4x9t59vjeU6uPsWxY1EJbSRipDr7UflLEs407o0UsD01P
	 9voy6RU1xXydScw8WXjCeT9443nJrkvJjBtTBKIUHrBV9+kKvhiJawe9AFgUFJmn07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDrHFDMz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0152606A326
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDrHFDMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B26D1F0089F;
	Fri,  6 Nov 2026 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982095;
	bh=hvvtq9mC/1Unjgx0ZR0ubj+hVDUqaPuxqzSmoP8alEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDrHFDMzjd56/LqSts7xBczcN9OT26DGWlEMYrSUq5V+EjjsrGGtH2vJoThrOCVhI
	 BOqzlC8xIH/AFl2h9BI0FEJpzJF0wjsP2iHVyniKQV+/owcebaHM2/h4YDu5FxE+In
	 3Sm8rVd/hKkNpIfmke+wXVAQcDVAZxnE7FdoztX6TiU0LdI5J+cZXt3DZXo1HgE4MQ
	 9iwBjzi6Fg97rARQaeIjn3FQo97YW0GDdh+N7U+JtLl466yWBXLFZBx1KIn+17BP6I
	 d3GBud9Vtn2FhKl4YTc36qTBeQuhb58oAxcjVLYiIn5iG7QLUvSlFK1vriu2Thd5CG
	 V+1rYkhgwQthA==
Message-ID: <sashiko-outbox-201792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <489aa8c0-c9c8-4aeb-9479-f7cb4c6a03df@I-love.SAKURA.ne.jp>
References: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
 <489aa8c0-c9c8-4aeb-9479-f7cb4c6a03df@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:21:34 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: j1939: race between j1939_local_ecu_get() and
  j1939_jsk_add() on unbind
--

commit 375037b053830bc33027e7901e38a9d908bf0157
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix "struct j1939_ecu" refcount leak

This commit cancels ECU address-claim timers during j1939_ecu_unmap_all() a=
nd
blocks taking new ECU references or binding local ECUs once the netdev is no
longer registered or rx_kref reaches zero.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..7346248a18020 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -310,6 +360,15 @@ int j1939_local_ecu_get(struct j1939_priv *priv, nam=
e_t name, u8 sa)
> =20
>  	write_lock_bh(&priv->lock);
> =20
> +	/* Do nothing and fail if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if ((READ_ONCE(priv->ndev->reg_state) !=3D NETREG_REGISTERED ||
> +	     !kref_read(&priv->rx_kref))) {
> +		err =3D -ENODEV;
> +		goto done;
> +	}
> +
>  	if (j1939_address_is_unicast(sa))
>  		priv->ents[sa].nusers++;
> =20

[Severity: Medium]
Can j1939_sk_bind() still race with NETDEV_UNREGISTER between
j1939_local_ecu_get() and j1939_jsk_add(), leaving the socket bound and
holding references to struct j1939_ecu, struct j1939_priv, and priv->ndev
after j1939_sk_netdev_event_unregister() has finished?

In j1939_sk_bind(), the socket is not on priv->j1939_socks (or has just been
removed by j1939_jsk_del() on re-bind) when j1939_local_ecu_get() runs, and
j1939_jsk_add() is only called after j1939_local_ecu_get() drops priv->lock:

net/can/j1939/socket.c:j1939_sk_bind() {
    ...
	/* get new references */
	ret =3D j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
	if (ret) {
    ...
	}

	j1939_jsk_add(priv, jsk);
    ...
}

Because unregister_netdevice_many_notify() sets NETREG_UNREGISTERING without
holding priv->lock or the socket lock, the two paths can interleave:

CPU0                                  CPU1
j1939_sk_bind()
  j1939_local_ecu_get()
    write_lock_bh(&priv->lock)
    reg_state =3D=3D NETREG_REGISTERED
    j1939_ecu_create_locked()
    write_unlock_bh(&priv->lock)
                                      unregister_netdevice_many_notify()
                                        dev->reg_state =3D NETREG_UNREGISTE=
RING
                                        j1939_netdev_notify()
                                          j1939_sk_netdev_event_unregister()
                                            /* jsk not in priv->j1939_socks=
 */
  j1939_jsk_add(priv, jsk)
    /* jsk left bound after unregister */

j1939_sk_netdev_event_unregister() misses jsk because it only scans
priv->j1939_socks, so jsk remains bound with its ECU, priv, and netdev
references held until the socket is closed, blocking unregister_netdevice().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/396b5de7-3fe0-474f-=
9194-b4816fde7182@I-love.SAKURA.ne.jp?part=3D2
