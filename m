Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4638886C
	for <linux-can@vger.kernel.org>; Mon, 31 Aug 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211474; cv=none; b=t0/8H/OBYLFqotYCAi27ma7linQ9oqYoulrrJAe3jIlkMEuolJEFfF9DvczdqYzvWDHIMsKk1cbGVY7hVBxNgOtyHw5qhHlgL8kzmrwQNWonUnstm934Ep7Jis3mvIpazQIbIawJl1UoiocyWNevmezbSwOF9KVKNxOTzz6WLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211474; c=relaxed/simple;
	bh=WhYc6w6MN6dV5tLuenU4s9w9lCyVO5w28VOVA2/bEEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8EVmGu/uCvu6n4hkmnk5u/32zoa2ZFbW3f1CyEn2sjvMYMW29TR2d+yW/bKy+XIQmPun+5XTTVjUvP96ohgLQduprx+DbGA/oXSr7IhAU1fHDryCdmW1k1hzIvo97qgOpbhd7wWyNRXHJW+zojs/nsnMtgvKOkHCMzyIlBdSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDRjksfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDRjksfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B51F000E9;
	Mon, 31 Aug 2026 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211472;
	bh=OCGeARD/EaB0se7d79tUsBwDc0lHqU5M69aAlfRf7y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDRjksfx0Ap9bT5y36An2yLAhTyi1ireeFgCb6ZoyBXsoQ+AN6n5rexNTCpLRddWo
	 TXzyUzbSe4sogi8OhHHs5MwmNrn2jSTfaKJBblI+xHI9/acJdWxyklnMa2C21bMHuw
	 oJoWzkMBNIaXNAfgtLqGOUZdr/W78mvraTL5xqVHCB2TNrfg6iXpj1fyNUIKtPDcxI
	 G61sVRkBZojCx+/EXCL5fsmq2qII3RRJJ2moAkjDuvBGUFL4zSll9uPd0TemDo6oVn
	 u4uHaQIN9VbY8MCvEe1nifAMW3l6rywbBiMM8drUQIWIQtbRuv3lBs2f1y5iEUffnO
	 2SrdPjU86AuPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: notifiers: remove CAN filters independent from
 namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260831185654.16701-1-socketcan@hartkopp.net>
References: <20260831185654.16701-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:24:32 +0000
Message-Id: <20260831212432.6C2B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the namespace equality check in `bcm_notify` exposes BCM =
sockets to cross-namespace `ifindex` collisions. Unprivileged users can exp=
loit this to disrupt BCM sockets in the host or other namespaces by spoofin=
g `NETDEV_UNREGISTER` and `NETDEV_DOWN` events.
--

commit e5738773c45b8a30848fd2bb47977b2587f26903
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: notifiers: remove CAN filters independent from namespace
   =20
This commit removes the namespace equality check in the netdev notifiers
for BCM, ISOTP, and RAW CAN sockets. The goal is to ensure CAN filters
are correctly removed when a device is unregistered, even if the socket
and device network namespaces differ due to a namespace change. It also
updates the can_rx_unregister() calling sites to retrieve the namespace
from the device instead of the socket.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8=
E@doyensec.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..aaa5163c46cc2 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1794,9 +1794,6 @@ static void bcm_notify(struct bcm_sock *bo, unsigne=
d long msg,
>  	struct bcm_op *op;
>  	int notify_enodev =3D 0;
> =20
> -	if (!net_eq(dev_net(dev), sock_net(sk)))
> -		return;
> -

[Severity: High]
With this namespace equality check removed, are BCM sockets now exposed to
cross-namespace ifindex collisions?

Because ifindex is only unique per namespace, an unprivileged user could cr=
eate
a virtual CAN device in a new network namespace with an ifindex matching a
target BCM socket in another namespace.

When this spoofed device is unregistered or brought down, the events proceed
into the rest of bcm_notify() which compares the integer ifindex instead of
a device pointer:

net/can/bcm.c:bcm_notify() {
    ...
    case NETDEV_UNREGISTER:
        ...
        /* ANYDEV ops */
        if (!op->ifindex) {
            spin_lock_bh(&op->bcm_rx_update_lock);
            if (op->if_detected =3D=3D dev->ifindex)
                op->if_detected =3D 0;
            ...
        /* tx_ops */
        list_for_each_entry(op, &bo->tx_ops, list)
            if (op->ifindex =3D=3D dev->ifindex)
                hrtimer_cancel(&op->timer);
        ...
        /* bound device */
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
            ...
            WRITE_ONCE(bo->bound, 0);
            bo->ifindex =3D 0;
            notify_enodev =3D 1;
        }
    ...
    case NETDEV_DOWN:
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
            sk->sk_err =3D ENETDOWN;
            ...
}

Could this allow an attacker to falsely clear ANYDEV claims, cancel active
transmission timers, forcibly unbind the socket (ENODEV), or inject ENETDOWN
errors into victim BCM sockets across namespaces?

>  	switch (msg) {
> =20
>  	case NETDEV_UNREGISTER:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831185654.1670=
1-1-socketcan@hartkopp.net?part=3D1
