Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D423CD8BB
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900907; cv=none; b=Le+cX37lzho+F5RU8C4wfs/zdVpabWJUh2Qxfv9RYY6wQV8O9Tzu9dzXsE+9HVuWb4DgWPJ2Sif5CjaD7sJh6Ig+LATzWs2EwlBLaovDV49Hafytd94J0WNAt5rEamktqVtoU3yTO7Y5EMtpYM9yrIyn5XfrfHbq7Ya+hqPu/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900907; c=relaxed/simple;
	bh=4aiJmXn9yXFrIB17oLYSdAElWT/Vqqq7ieU3Z6TBn3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uScH14FtyFrS558OHsGEW+aU6Hw505FsWe3M4CBBOUUVhFTh5rjmFrJQYYpp6lKJ7I7k+5l/HTecLvoJYXM/vlnOrohQe/1XbDp56Ld/8fM+bbIntU507qHcObrx23+awkr8BpnNbAJpqBa0/yqS5+5Y84z5exgXxn2/6N/E0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG/B6+XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG/B6+XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559901F00A3A;
	Fri, 28 Aug 2026 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787900905;
	bh=R7sZ6b0GGywpjdP35DGt587mZJEcPuEiwc+XZ166O8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XG/B6+XYSkHgdt0zSSZF6n9W70XTRliapg24HOayRjzsP1xqo0jaAQphHsLWLkm24
	 yWFiyvzP1rt1hzSUnw0YOp2dMg2sx+G8bfDdXMZx7qAZ6mVNjlPUzofv0ZQGRYqdDe
	 NKZGO856zuYfj/hJeuOlDZL/IOC+UM8dIKqP9gmSnxzuWGj0eWJznSckDzseg2fvaR
	 i123vE2XstIs0VMmanUKBCqQY6vJWeYhsQyQ9HuuZQWa5XCt7o6sko+uzaAO8kDsdY
	 E43OKSsR3YaI2K5B3an5TMHVRc9HE5Q3fysIMJW20UjFMv3697HNKTTJcLUUVYwvbn
	 ZlE31eWNYh2ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] can: j1939: make hrtimer callback lockless and
 free ECUs asyncronously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260828064621.91364-1-dmantipov@yandex.ru>
References: <20260828064621.91364-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 07:08:24 +0000
Message-Id: <20260828070825.559901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing bottom-half disable in __j1939_ecu_work() causes a deadloc=
k with softirq RX handlers.
- [High] Lockless read-modify-write of ent->nusers in j1939_ecu_map_atomic(=
) causes lost updates and accounting corruption.
- [High] Asynchronous ECU removal work is not flushed on module unload, cau=
sing use-after-free panics.
- [High] Publish-before-initialize TOCTOU race in j1939_ecu_map_atomic() ex=
poses the ECU pointer before taking a reference.
- [High] Delayed removal from the ECU list causes concurrent list traversal=
s to encounter an ECU with a zero reference count.
--

commit ff05e907d647c94fe0051f49164f837f1fa99aa5
Author: Dmitry Antipov <dmantipov@yandex.ru>

can: j1939: make hrtimer callback lockless and free ECUs asyncronously

This patch removes the lock from j1939_ecu_timer_handler() and uses cmpxchg=
()=20
to map the device. It also defers removal to a workqueue to avoid concurren=
t=20
modification of the list.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..a347594b8c1c5 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -14,17 +14,27 @@
> =20
>  #include "j1939-priv.h"
> =20
> -static void __j1939_ecu_release(struct kref *kref)
> +static void __j1939_ecu_work(struct work_struct *work)
>  {
> -	struct j1939_ecu *ecu =3D container_of(kref, struct j1939_ecu, kref);
> +	struct j1939_ecu *ecu =3D container_of(work, struct j1939_ecu, work);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
> +	write_lock(&priv->lock);

[Severity: High]
Does this code expose the lock to deadlocks with softirqs?

Because __j1939_ecu_work() runs in process context and uses write_lock(), a
network softirq could interrupt this and try to acquire the same priv->lock=
 via
read_lock_bh() or write_lock_bh() during frame reception.

Should this use write_lock_bh() instead?

>  	list_del(&ecu->list);
>  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
> +	write_unlock(&priv->lock);
> +
>  	j1939_priv_put(priv);
>  }
> =20
> +static void __j1939_ecu_release(struct kref *kref)
> +{
> +	struct j1939_ecu *ecu =3D container_of(kref, struct j1939_ecu, kref);
> +
> +	schedule_work(&ecu->work);

[Severity: High]
Does scheduling the removal work leave the object on the priv->ecus list wi=
th a
zero reference count?

Concurrent network paths traversing the list under read_lock_bh() might
find this zero-refcount object and call j1939_ecu_get(), triggering a
kref_get() on a zero refcount and causing refcount saturation.

Should the object be removed from the list synchronously before scheduling =
the
work?

[Severity: High]
Does this deferral create a use-after-free regression during module unload?

If the last socket is closed, dropping references and scheduling this
work, and the module is immediately unloaded via rmmod, the workqueue might=
=20
execute __j1939_ecu_work() after the module's memory is freed.

Is there a missing flush of the scheduled work in the j1939_module_exit() p=
ath?

> +}
> +
>  void j1939_ecu_put(struct j1939_ecu *ecu)

[ ... ]

> @@ -46,26 +56,23 @@ static bool j1939_ecu_is_mapped_locked(struct j1939_e=
cu *ecu)
> =20
>  /* ECU device interface */
>  /* map ECU to a bus address space */
> -static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
> +static void j1939_ecu_map_atomic(struct j1939_ecu *ecu)
>  {
>  	struct j1939_priv *priv =3D ecu->priv;
>  	struct j1939_addr_ent *ent;
> =20
> -	lockdep_assert_held(&priv->lock);
> -
>  	if (!j1939_address_is_unicast(ecu->addr))
>  		return;
> =20
>  	ent =3D &priv->ents[ecu->addr];
> =20
> -	if (ent->ecu) {
> +	if (cmpxchg(&ent->ecu, NULL, ecu)) {

[Severity: High]
Does this cmpxchg expose the pointer to concurrent threads before its
reference count is incremented?

If another thread concurrently unmaps the object and calls j1939_ecu_put(),=
 it
could drop a reference that this mapping thread has not yet acquired. If the
refcount drops to zero, the object would be queued for deletion, and the
subsequent j1939_ecu_get() here would increment a zero refcount.

Should j1939_ecu_get() be called before the cmpxchg?

>  		netdev_warn(priv->ndev, "Trying to map already mapped ECU, addr: 0x%02=
x, name: 0x%016llx. Skip it.\n",
>  			    ecu->addr, ecu->name);
>  		return;
>  	}
> =20
>  	j1939_ecu_get(ecu);
> -	ent->ecu =3D ecu;
>  	ent->nusers +=3D ecu->nusers;

[Severity: High]
Does this unprotected arithmetic race with other threads?

Since the update to ent->nusers is no longer protected by priv->lock,
concurrent threads could perform read-modify-write operations on ent->nusers
simultaneously, causing lost updates to the user accounting.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828064621.9136=
4-1-dmantipov@yandex.ru?part=3D1
