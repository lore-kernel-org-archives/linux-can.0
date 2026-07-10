Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D642A787
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688838; cv=none; b=ryww7jh8K1NDBNN35HButexH5tOrTIxUSibEIYxNUfJIyAI1qjwIE+Gh72t93DOEMtVr4bhSJTYHuVN/ghRJgsmc5i0X0VPaob07pltgn5UpW5WhvYa/WScCT2ol8/6ZmvvizJ3FF3AqhCb4sq6fqMtDPslSfg9qjKnZa27BnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688838; c=relaxed/simple;
	bh=+t3S+x1TKL7jvkykTgDZy0wQYbz+5QIDgjEk0MoxhIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jz1KWWrWTK/u+x5tJr7UphyrXVQ0tVlo35jN02TfKSYz42wjvC9Tp6Ti/iy/PDUBfDuOI6MxuLm1C1zUvsSLvaGBOSAsJUB2N9V1TwbzOoDrE2Eddne2tia5cBN6FNNEG/otPrDz87uOuFtXI/8qbROI8tC9S+6xK8FC3wCWQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTBa5f8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTBa5f8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E921F000E9;
	Fri, 10 Jul 2026 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783688836;
	bh=3p/qkimippzsfTdqa9C24UrBag3A+kpL5ScQDPvODwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTBa5f8zgRLZCTGl9KvVvyFXF0SzmRDW05iz9I1CYBHJvfcK2kPn6qU0YLAV4X0DV
	 Pqb+lSVFMxClA+XpLfBX1tMeM/dR84ui9dZjUXWbeGWv6ieBcGOjTertd5WJ0OfPvB
	 GICpxy+kqXZSduKEXElNB6WWd+61Vkc1dhE1o5VjyUpi7C6RQy3f8jxo70O1VTfCCP
	 sUB5Ff1rdXO5lJ53o/Eb5EEkWeYJZ2JHTIVkIMN5S5xm9mgts9/2ksZVHdaD2XdjXZ
	 0fxL34FJ6OQ6loV5Td4dDE8xlKThQ01wapxRankw9UWsg+Z7iC1tJhyNRZ6z173oHh
	 KmezZetVvSQXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260710-isotp-fixes-v3-2-08db68e27d0b@hartkopp.net>
References: <20260710-isotp-fixes-v3-0-08db68e27d0b@hartkopp.net>
 <20260710-isotp-fixes-v3-2-08db68e27d0b@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:07:16 +0000
Message-Id: <20260710130716.89E921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless check of `so->bound` in `isotp_bind()` creates a TOCTOU r=
ace that bypasses the newly added wait for `ISOTP_IDLE`, allowing cross-dev=
ice packet injection.
--

--- Patch [2]: [PATCH v3 2/2] can: isotp: fix use-after-free race with conc=
urrent NETDEV_UNREGISTER ---
commit e4c5bbbd972ba76bfee06412e3abf69c164cec65
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This commit fixes a use-after-free race in isotp_release() and isotp_notify=
()=20
by taking a tracked reference to the net_device and serializing bind/releas=
e=20
with rtnl_lock(). It also adds a wait in isotp_bind() to ensure any active=
=20
transmissions settle if the socket was unbound by a concurrent device=20
unregistration.

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index d30937345bcdc..d98863bad0d9f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1310,6 +1319,18 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr_unsized *uaddr, int l
>  	if (!addr->can_ifindex)
>  		return -ENODEV;
> =20
> +	if (!so->bound) {
> +		/* A transmission that outlived a previous binding (unbound
> +		 * by NETDEV_UNREGISTER) must settle before so->tx can be
> +		 * reused; the FC/echo watchdog timers bound this wait.
> +		 */
> +		err =3D wait_event_interruptible(so->wait,
> +					       so->tx.state =3D=3D ISOTP_IDLE);
> +		if (err)
> +			return err;
> +	}
> +
> +	rtnl_lock();
>  	lock_sock(sk);
> =20
>  	if (so->bound) {

[Severity: High]
Can this lockless check of so->bound bypass the wait if the socket is=20
unbound just before acquiring the locks?

If a user initiates a bind to a new device while the socket is currently=20
bound and transmitting, the initial if (!so->bound) check will be false,=20
skipping the wait for ISOTP_IDLE.=20

If a concurrent NETDEV_UNREGISTER runs and clears so->bound before this=20
thread acquires rtnl_lock(), the inner if (so->bound) check will then=20
evaluate to false.=20

Does this allow the bind to succeed while the state machine is still=20
transmitting, potentially injecting the remaining payload onto the newly=20
bound CAN device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v3-0-08db68e27d0b@hartkopp.net?part=3D2
