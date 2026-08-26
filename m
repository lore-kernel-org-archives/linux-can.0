Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0641B8EB
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754422; cv=none; b=Yeb6c5FzIz3FvF9fLMpNvcZDG9mnyqOKtRu0417NFyfslqvgrx8EKS9Iarr5pTq6WlpnkNCp/rR2JlAUnufrnMYf4I8s+gAV0CMd2ZtK6XrOaiNMVhAvmzlaQCRv/8oM7WI1ncD9gDvtnAZaKnLkZxV/rG9cMgeibSb4xUkq06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754422; c=relaxed/simple;
	bh=HSvzh4lwQz4QBg561KFqi8OtKN1l5RRWggN7fRK2WEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdzJjhSVKRz7gVzSuYpYJNuv60iWiXx2ZdD7unVO8eqHNT25/cVzZbwlb/WIJdBkTGHW7sxnY+wnol1Yq5q1TKwGRMWM2od+uIz8ZDElrjBX5FeAaMjHf7T/HZjzRmKwgNm8iH6wXhNPa8k3WJZk/inAFoEnYgV/BPbzwoYTgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5D2E0200F45;
	Wed, 26 Aug 2026 16:26:50 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzEaY-003SCl-0u;
	Wed, 26 Aug 2026 16:26:50 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0097358CF10;
	Wed, 26 Aug 2026 14:26:49 +0000 (UTC)
Date: Wed, 26 Aug 2026 16:26:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Message-ID: <20260826-dangerous-keen-cuscus-c51817-mkl@pengutronix.de>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
 <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ktmqtvy4lzbmjz65"
Content-Disposition: inline
In-Reply-To: <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>


--ktmqtvy4lzbmjz65
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
MIME-Version: 1.0

On 26.08.2026 23:18:57, Tetsuo Handa wrote:
> syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
> netdev_hold() is called during ECU creation but the corresponding
> netdev_put() is never executed because the parent "struct j1939_ecu"
> object is leaked.
>
>   unregister_netdevice: waiting for vxcan1 to become free. Usage count =
=3D 3
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
>        j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
>        j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_priv_create net/can/j1939/main.c:140 [inline]
>        j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
>        j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The root cause lies in the error handling of j1939_sk_bind() during a
> re-bind operation (binding an already bound socket to the same interface).
> Currently, the function prematurely drops the old ECU references by calli=
ng
> j1939_local_ecu_put() before verifying whether the new configuration can =
be
> successfully acquired via j1939_local_ecu_get().
>
> If j1939_local_ecu_get() subsequently fails, the function unconditionally
> calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in=
 a
> half-broken state where the old ECU's refcount has already been decrement=
ed
> incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
> no longer perform proper cleanup because jsk->priv is NULL. As a result,
> the old "struct j1939_ecu" remains orphaned on the priv->ecus list,
> permanently leaking both the ECU object and the net_device reference held
> inside it.
>
> Fix this by deferring the removal and release of the old ECU references
> until after j1939_local_ecu_get() has successfully acquired the new
> resources. As a side effect of this change, the socket's state no longer
> changes when the re-bind operation failed.
>
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd
> Assisted-by: Gemini-Pro
> Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() =
immediately when j1939_local_ecu_get() failed")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks for the v2.

For future patches, please:
- collect all trailers, like Acked-by, etc...
- don't reply to the previous vX, start a new thread
- consider using "b4"
  You can use the b4 "web submission" instead of using Thunderbird.
  It bypasses all mail system completely.
  https://b4.docs.kernel.org/en/latest/contributor/send.html

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ktmqtvy4lzbmjz65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCao73pwAKCRDMOmT6rpmt
0p1yAP47ugRWWm6CF1iC2nyL42ot6qOBCAO+Qrdw1P3+VdUIAgD+OkGCVNUIfVN1
pOAgqcs6D8sEfZHHr98DtFYL1nHZ1gU=
=LBD4
-----END PGP SIGNATURE-----

--ktmqtvy4lzbmjz65--
