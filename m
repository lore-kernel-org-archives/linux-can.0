Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44020233941
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772589; cv=none; b=lZxB19iR7dFEH5aHFroLLY18Qth/JY1GIFncjDtPZH1Jjy/jU3yMB3kaUXe/wKv+RFv4IXhDHpgDxHG/byFdA76ilkl5rs7w+J7qvoCX/UG+l9lOpbtkf5L6B5U3GX8A4qDgWR+8eVpiMcokkLtgnz7betHBIkE6RhjxqQqdYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772589; c=relaxed/simple;
	bh=nbtvISY1bZT0TTXXd6PFflzn5z6sCOrcZ/I7Wyt9/zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7IfCR2Qyv4HT+mnVgOSxbTv2TVN/MxwVKPU+QXoDoZNRhYgK4kIBfVSZfDRkYoKGQIn26W8TpWMZ4E0+IMNq6Jy81ffoYWv7eTrt/Wz5m0WtR7/5Xq0/uGXHslD1ozyFyg9zimF9mJsy3A7sS1RzC7XRVLbAIW0lvb9oNH6i4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcfI/ZHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcfI/ZHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A301F000E9;
	Sat, 11 Jul 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783772588;
	bh=8sa0L4Inlsln+f67aAVXY9EkkUQKgcqL7NKXeu3WBFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcfI/ZHgGo3ljK5CVZqU3KfpqPO/8bK8w4ctQzKlGFJoeTNZpKIPt+rIaEWLQr9AB
	 F8YYEqd81luaW1F0/7MuuuzxkyZZi+Hezm1hqBkyaXk90All8aPnr/7TMNNcrDKJHM
	 7Vlb+3YpuEcgitxicyum/E755Zv0jZbV7CTP3j+Dr8inV9c0AeIi2uhnhBVMLiUmkg
	 UPjYh2PuHvyvYZlo0HKKOnbiyDF4EKvjTn/H5nEPAMY9gDWzFMi+HyEyln7F9nKy92
	 SpZGTdxZ58U7/OqVkT5RV78c8ieiQg66EMG6W1E9j+P2iSDCax2p/QueTYmLkGFnq5
	 v5bcBQ/lDs+Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260711-isotp-fixes-v7-1-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
 <20260711-isotp-fixes-v7-1-f03af24d8397@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:23:07 +0000
Message-Id: <20260711122307.B2A301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional synchronize_rcu() in socket release path allows un=
privileged users to spam RCU grace periods.

Pre-existing issues:
- [Critical] Missing rtnl_lock() in isotp_bind() allows race with NETDEV_UN=
REGISTER, leading to leaked CAN RX filters and a use-after-free on the sock=
et.
--

--- Patch [1]: [PATCH v7 1/5] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit ab2ff810b0276df9b5c38648b4470daa9abe3c97
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit addresses a use-after-free timer callback on a freed socket. It
makes isotp_release() unconditionally call synchronize_rcu() before cancell=
ing
timers, regardless of so->bound, to prevent races with NETDEV_UNREGISTER.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer =
restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
[ ... ]
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();

[Severity: Medium]
Will this unconditional synchronize_rcu() allow unprivileged users to spam =
RCU
grace periods?

If an unprivileged user repeatedly creates and immediately closes unbound C=
AN
ISOTP sockets, it seems this path will be hit every time. While previously =
this
required a successful bind to a valid CAN interface, this patch makes the c=
all
unconditional, which might allow it to be triggered on any system with the =
CAN
ISOTP module available.

> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

[Severity: Critical]
This is a pre-existing issue, but does isotp_bind() lack rtnl_lock()
protection?

Looking at isotp_bind(), it acquires lock_sock() but does not appear to acq=
uire
rtnl_lock(). Can this allow a race with device unregistration?

net/can/isotp.c:isotp_bind() {
    ...
	dev =3D dev_get_by_index(net, addr->can_ifindex);
	...
	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, "isotp", sk);
    ...
}

If an unprivileged user concurrently binds a CAN ISOTP socket to a virtual =
CAN
device while deleting the device, it seems this could race with the device
unregistration notifier in isotp_notify().

If the notifier runs before so->ifindex is set, it might fail to unregister=
 the
filters, allowing isotp_bind() to register the filters on the dying device.

When the socket is closed, isotp_release() handles it:

net/can/isotp.c:isotp_release() {
    ...
		dev =3D dev_get_by_index(net, so->ifindex);
		if (dev) {
			if (isotp_register_rxid(so))
				can_rx_unregister(net, dev, so->rxid,...);
    ...
}

If dev_get_by_index() fails because the device is now unlisted, it appears =
the
CAN RX filters are never unregistered, which could leave a dangling
struct receiver in the device's dev_rcv_lists.

If a delayed packet is processed before the device is freed, could isotp_rc=
v()
be invoked with the freed socket pointer, resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-isotp-fixe=
s-v7-0-f03af24d8397@hartkopp.net?part=3D1
