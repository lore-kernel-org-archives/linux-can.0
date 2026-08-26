Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9F3DFC7F
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743899; cv=none; b=kMwNzzALodJWPHA74CE9Ei51JYh2d3HJrqSUApqCAqL9US0BRX9QpPWFn52l/tMCZH+yY8QdAePT1VbQcpEe3ZnikWWMAeKYzAUmZ1DucZv3oVRKQHRudvqX1E3JHcGk3jaw6N2OnJLGXxgIRfALMNcxucSxNFtDhPs+zEZUGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743899; c=relaxed/simple;
	bh=vbJ2nBeDrUij5o0YhRQzeuGns/bJEnXGn3V7tMF6njs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzyQJZBfIJrf2cu2TzVBnJ/3PAX0xZ874ft8oB0kWbhx3dbAh+NiGk6OaE5AmnYPDeXPJyxzJaHCmGyQLK0gJUFratusrSlP0Jj6kahkXr3jRyPCSeqNQznHx8rLi3pi0qFl03bG1oPa08ksbfIk3+xEO1iET4p0IagD+X6qILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2DC55202101;
	Wed, 26 Aug 2026 13:31:34 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzBqw-003QlJ-0I;
	Wed, 26 Aug 2026 13:31:34 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C51C058CCB4;
	Wed, 26 Aug 2026 11:31:33 +0000 (UTC)
Date: Wed, 26 Aug 2026 13:31:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Message-ID: <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zndadupxarh74msv"
Content-Disposition: inline
In-Reply-To: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>


--zndadupxarh74msv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
MIME-Version: 1.0

On 21.08.2026 01:28:13, Tetsuo Handa wrote:
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
> Analyzed-by: AI Mode in Google Search (no mail address)

Nitpick: can you convert this into "Assisted-by:"?

See https://github.com/torvalds/linux/blob/master/Documentation/process/cod=
ing-assistants.rst#attribution

regard,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zndadupxarh74msv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCao7OkwAKCRDMOmT6rpmt
0jFKAQCXs53Fys0pHl8gV2PlgghCpS2SqVoaZX7+0cULU1C/AAD/f1vhVV44CzkI
FptiQF8utFdVBmVmp5bX7uQ9x6PaMA8=
=KQWt
-----END PGP SIGNATURE-----

--zndadupxarh74msv--
