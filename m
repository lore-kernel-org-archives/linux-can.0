Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881491;
	b=iTk9dSDZgi79TMCsKFfjy7Iprt+ZGoOG9fj+SQXvyemNikVuDfelKW+RBvmEsAGy4mNa
	 V7lFaq6+3mZhzQs3JgEAOUlRMmA02upUr19SB2iU1uAK+dW28KID2UXL+z8gxgXiZBdf9
	 DQ2Z/9X968JmwXTTb3A7qcv3EZUOZtPVefr5O6ahejewAUAtXnpBrJOOpJR+4ozotaYnc
	 ceV+n1TKXBjHoVocZwp1G9bxcA2ijzJx09zzuTNdfX3QMmrl1fTFPOfiEGRoBafQSSi55
	 m4dLnR9nkk8pJIQmTa8i5pvJEo6S/ZgJgscNdtaiysUjulXYL8GodvUYEhnoFpRiTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=redncw5Sv/eqVjywOyl9QMNApsnqxj+RyslFZeIq2fA=;
	b=z/VTIDcQrY4zShN1nsjXWBi+WbwBODQ0O0Epx7dL2KFjgL5ekxrUR2UR/qRsUTjSEfmg
	 bcM5GOKsORYEzJT+O27HvKL44GF6iudy5NV6YpG9t95zdry5bcL5hKPwux/xLyN9cYcXj
	 lxPZnxmPBt+zkK/ySAuA7C+/Bhqs10wOxdvgB0gpZAzpOH2XAiUEa743j55ByFbYKutDX
	 aC5zCda6MhYPcyoqR69xoLNcQxmHh7CyYQRiR3EydYeNCSr72nr+zKtNp/9IehAc6kjln
	 WPaOlFcUi6dm59ftCfWLdiE5zfmxwLreIAnJNrGdr32orIYcOWj093tI6YhN3pT7iRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD4CGOQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD339606A31B
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kD4CGOQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DA1F000C1;
	Thu,  5 Nov 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881490;
	bh=redncw5Sv/eqVjywOyl9QMNApsnqxj+RyslFZeIq2fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kD4CGOQWdCYtRoL5HLYZ278R/gs+xINaa9uLD6cjFoD4alAqfYGwfXS/JIyXikAiq
	 M+bo6IECRmK2aOVibjP+0neoD5R/UIN5yumkSm4P6zfedNtpIL5odBDDtY93zvxt4+
	 rTSTnguln6TO6rl1DWDwzpulRPSDmBzzw73uX9GJEM0rFNJO2FpOBoE5fksU0Tk+HU
	 3FHFcQkBX8ujz9m7A+MonSRkDRLSH8BGtzzOl+Jrdv3eZCL/HAwqvp7yxLpt1aLVJD
	 bxprZWC2iRBHBJUX5F1jU5qFBwyKJ0HPRDJstYdPyKinjPgcbMBD6lVwcjgH8VdIcG
	 UT+9p6MdBcIwg==
Message-ID: <sashiko-outbox-199025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] can: j1939: fix "struct j1939_ecu" refcount leak
 in j1939_ecu_map_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
References: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
 <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:24:49 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: j1939: use-after-free in j1939_ecu_timer_handler() on module =
exit
- [High] can: j1939: missing reg_state check in j1939_local_ecu_get() on bi=
nd
--

commit 4a42bc98a7b7f2c36e99bd97ffdcb80e028003ad
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix "struct j1939_ecu" refcount leak in j1939_ecu_map_locked()

This commit fixes a struct j1939_ecu reference count leak when
j1939_ecu_timer_handler() maps an ECU after __j1939_rx_release() has already
unmapped all ECUs. It drops the ECU reference in j1939_ecu_map_locked() and
rejects ECU creation in j1939_ecu_create_locked() if the net_device is no
longer registered or priv->rx_kref is zero.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 3422e31338004..77b6788060573 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -84,6 +84,15 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
>  	if (!j1939_ecu_get(ecu))
>  		return;
> =20
> +	/* Drop the ref if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if (READ_ONCE(priv->ndev->reg_state) !=3D NETREG_REGISTERED ||
> +	    !kref_read(&priv->rx_kref)) {
> +		j1939_ecu_put(ecu);
> +		return;
> +	}

[Severity: High]
Because ecu->ac_timer is not canceled during __j1939_rx_release() ->
j1939_ecu_unmap_all(), can this cause a use-after-free if the can-j1939
module is unloaded while ecu->ac_timer is still armed?

When an Address Claim frame is processed in j1939_ac_process(),
j1939_ecu_timer_start() arms ecu->ac_timer for 250 ms while holding a
reference on ecu. When the last J1939 socket is closed via
j1939_sk_release() -> j1939_netdev_stop() -> __j1939_rx_release(),
ecu->ac_timer remains active and holds its reference on ecu, so
__j1939_ecu_release() is not yet called and ecu->release_work is not yet
queued on j1939_ecu_wq:

net/can/j1939/bus.c:__j1939_ecu_release() {
	...
	INIT_WORK(&ecu->release_work, __j1939_ecu_release_work);
	queue_work(j1939_ecu_wq, &ecu->release_work);
}

Neither struct j1939_ecu nor struct j1939_priv holds a module reference on
can-j1939; only open sockets hold a reference on j1939_proto.owner. If the
module is unloaded during the 250 ms window before ecu->ac_timer expires,
j1939_module_exit() destroys j1939_ecu_wq immediately because no work is
queued on it yet:

net/can/j1939/main.c:j1939_module_exit() {
	can_proto_unregister(&j1939_can_proto);

	unregister_netdevice_notifier(&j1939_netdev_notifier);

	destroy_workqueue(j1939_ecu_wq);
}

When ecu->ac_timer fires afterward, wouldn't j1939_ecu_timer_handler()
execute unmapped module text or queue ecu->release_work onto the destroyed
j1939_ecu_wq?

[ ... ]

> @@ -179,6 +188,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j19=
39_priv *priv, name_t name)
> =20
>  	lockdep_assert_held(&priv->lock);
> =20
> +	/* Don't create a new ECU if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if (READ_ONCE(priv->ndev->reg_state) !=3D NETREG_REGISTERED ||
> +	    !kref_read(&priv->rx_kref))
> +		return ERR_PTR(-ENODEV);

[Severity: High]
Does placing this check in j1939_ecu_create_locked() rather than in
j1939_local_ecu_get() still allow j1939_sk_bind() to succeed on an
unregistering net_device and leak references on struct j1939_priv, struct
j1939_ecu, and struct net_device?

In j1939_sk_bind(), the initial check of ndev->reg_state runs without
rtnl_lock before jsk is added to priv->j1939_socks (and is skipped in the
re-bind branch after j1939_jsk_del() removes jsk from priv->j1939_socks). If
unregister_netdevice() runs j1939_netdev_notify(NETDEV_UNREGISTER) ->
j1939_sk_netdev_event_unregister() before j1939_sk_bind() reaches
j1939_jsk_add(), j1939_sk_netdev_event_unregister() will not see jsk in
priv->j1939_socks.

When j1939_sk_bind() then calls j1939_local_ecu_get(),
j1939_ecu_create_locked() is bypassed whenever name =3D=3D 0 or when
j1939_ecu_get_by_name_locked() finds an existing ECU in priv->ecus (such as
an ECU kept alive for 250 ms by an uncancelled ecu->ac_timer):

net/can/j1939/bus.c:j1939_local_ecu_get() {
	...
	if (!name)
		goto done;

	ecu =3D j1939_ecu_get_by_name_locked(priv, name);
	if (!ecu)
		ecu =3D j1939_ecu_create_locked(priv, name);
	...
}

net/can/j1939/socket.c:j1939_sk_bind() {
	...
	/* get new references */
	ret =3D j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
	if (ret) {
		j1939_netdev_stop(priv);
		jsk->priv =3D NULL;
		synchronize_rcu();
		j1939_priv_put(priv);
		goto out_release_sock;
	}

	j1939_jsk_add(priv, jsk);
	...
}

In those cases, j1939_local_ecu_get() returns 0 and j1939_jsk_add() adds jsk
after j1939_sk_netdev_event_unregister() has already finished. Should the
reg_state and rx_kref check be placed in j1939_local_ecu_get() under
priv->lock instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3d7e48fa-9af5-43e2-=
84f7-884e61f9d179@I-love.SAKURA.ne.jp?part=3D2
