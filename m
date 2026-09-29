Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D605474266
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672173; cv=pass; b=rWoNCoUeymT0Llp5d8ROg1eHj0pU7ToRtELwsKRXEvl4ZT8BEN5iMQZ5KfujpZwW3QbA2QR4Is/Y84ON1YjPO15+ycbRLP1K8wxUju0Wcp3JbFHaMnQd5cSGzEDo5teTzLCTf7kepY5kJePxqWSLIzc/vj2t43rdNyZQIduzmmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672173; c=relaxed/simple;
	bh=NyzR9s5+jOc9DGMPYHyv8eoacOhjiL2KT4tMI8zhxJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as7GKfy6sZNE4upGtjUtjN6NdxU4lw7PCDf2RqQQ2X9PF2AJ4vAVK7e4Fw1dnKf0rf6o1pIDO+wz71lPlgtJFaxxhZ8GLPui0NvOwGc2rZHFo8FzzA9Ed3UUbtFJjkLXLQFG8ljior7sK9kHyOx6sGfaP7g80KcLrxOk4MtyPyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=J3wsCFg1; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="J3wsCFg1"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 12885200B6B;
	Tue, 29 Sep 2026 10:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790672168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ8k3Y41BSZMBWkZb8qeAoYjIvIp+v7GoFS1O0KvLEE=;
	b=J3wsCFg1OVcTvX0O0Ob2cpXqPIHX6HDT6NVI+f7IuTyl3A23u8B+i0Me9FG2Hn5N/7iwOo
	jgVCw2KKky/+NVJzvVaCalkonTOQnF5aCCJfdeV+Uo+tNEkApFi+Pw4L5EVAh2Xk/7P/02
	z5/lX/gAoMlEzacYV4vN6ispwyXgoai6sRgFEOT//h9LOhEk0mrg/mseGx4e5pPQHNHkGe
	xGnVLqvMzz1DM2RTkxjASryj5AERkOosQC3FJY4AQUxYQ6Lur+ybxIC9W+WIQqj0r2ifbw
	zLCfBb0BewQI6C3ZjVH+7x4J9OoA4aOBKNHTv7/QHuMfTraqa5xWYDT/qvs2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790672168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ8k3Y41BSZMBWkZb8qeAoYjIvIp+v7GoFS1O0KvLEE=;
	b=dKCsy8IG8roHzGZpWSsT9t04tn2lkud1rgfmIkKVcGgciMN6tz8bWKBE9WgR/I5aW85SEI
	nm7VH0A7wDOPxqevwiK0yDk9UDfQNPCVHD1+06+uBlR4V8N24Qyt2RXb+8lIo7cGrEF7Vj
	BPTM2GbV4XOEv8nf9+Wv/EnZ1BD5gEY4QChu1URvL0hQlKdB8OxCZu3JPMZAezCzTE0NSj
	fA4VrNDFjXKTGx7E3gejqrrfRAlzoD+9wUrNmgp0EDbW9DjIEZbWMJNIsaxBRhzwAIzrWB
	4TbncG9fJRE+kWUOxQExXiXB7f+v4uXKYn0+eRfYR3dJb8onunbPtTSbX92Lpw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790672168; a=rsa-sha256;
	cv=none;
	b=NSKvW0jFU1rLRFMCXhZGAiW7nXohW1RIJAl6h7wsetzgB1BG9SZkF6KxmrD8qKo7YLj55w
	PbI+4KD7gUBzVCAiRAznqVsBGwRrH01FqSGJRvgR2pGCQ4OCPgmCIcYkF6oW3RdyFNGs1F
	NYiVN5r/7AlPRBWGuuQ8JAkU1mz9Jye9wcXzdLECwNohMWBK/W5n8cVM9H0FKumTzO+iEE
	QmrGzka5J6dUDBekrGoxRK+ELaR3I9Nc48iAWzYCLkAxomzYT7yzexw+Jn2/banDMa4N4G
	w7p9eVSUgvksajjmiGFQwcqhAwySws5bjLDh8wFC70ryFCR+px3MC6slFKSz2w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBTd9-003MfQ-36;
	Tue, 29 Sep 2026 10:56:08 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A87115B3348;
	Tue, 29 Sep 2026 08:56:07 +0000 (UTC)
Date: Tue, 29 Sep 2026 10:56:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, 
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
Message-ID: <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7fm4new5yhuitvk"
Content-Disposition: inline
In-Reply-To: <20260928193312.553632-7-mkl@pengutronix.de>


--d7fm4new5yhuitvk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
MIME-Version: 1.0

On 28.09.2026 20:45:13, Marc Kleine-Budde wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
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
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Link: https://patch.msgid.link/deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-lov=
e.SAKURA.ne.jp
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I've dropped the patch for now, the netdev bots gave the following
review:

regards,
Marc

--- Patch [6]: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu=
 leak when re-bind failed ---
commit 465afca7f35626e9f75e201bea23194ff9fbfa18
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed

This patch reorders j1939_sk_bind() so it takes the new ECU references
with j1939_local_ecu_get() before it drops the old ones. On a re-bind,
the old references are dropped only after the get succeeds. A failed
re-bind now leaves the socket state unchanged.

Link: https://patch.msgid.link/deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.=
SAKURA.ne.jp

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4..24efb25c58c3 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c

[ ... ]

> @@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struc=
t sockaddr_unsized *uaddr, in
>  		jsk->priv =3D priv;
>  	}
>
> +	/* get new references without dropping old references */
> +	ret =3D j1939_local_ecu_get(priv, addr->can_addr.j1939.name, addr->can_=
addr.j1939.addr);
> +	if (ret) {
> +		/* nothing to undo if re-bind() failed */
> +		if (!was_bound) {
> +			j1939_netdev_stop(priv);
> +			jsk->priv =3D NULL;
> +			synchronize_rcu();
> +			j1939_priv_put(priv);
> +		}
> +		goto out_release_sock;
> +	}

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: sonnet-5
The commit message says:

  If j1939_local_ecu_get() subsequently fails, the function unconditionally
  calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in=
 a
  half-broken state where the old ECU's refcount has already been decrement=
ed
  incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
  no longer perform proper cleanup because jsk->priv is NULL.

Is this description accurate? In the old failed re-bind path, the
references look balanced:

first bind():
  j1939_netdev_start()      +1 priv kref, +1 rx_kref
  j1939_priv_get()          +1 priv (jsk->priv)
  j1939_local_ecu_get()     +1 ecu kref, nusers++
  j1939_jsk_add()           +1 priv

old failing re-bind():
  j1939_jsk_del()           -1 priv
  j1939_local_ecu_put()     nusers--, j1939_ecu_put()
  j1939_local_ecu_get()     fails, undoes its own nusers++
  j1939_netdev_stop()       -1 rx_kref (__j1939_rx_release()), -1 priv
  j1939_priv_put()          -1 priv (the jsk->priv reference)

j1939_sk_sock_destruct() only does this:

	if (jsk->priv) {
		j1939_priv_put(jsk->priv);
		jsk->priv =3D NULL;
	}

The error path has already made that put, so clearing jsk->priv doesn't
seem to skip anything. The destructor also has no ECU cleanup.

j1939_sk_netdev_event_unregister() runs the same sequence (jsk_del,
local_ecu_put, netdev_stop, priv_put, jsk->priv =3D NULL) and treats it as
balanced.

The Fixes: tag also looks off. f214744c8a27 only added the paired
jsk->priv =3D NULL / synchronize_rcu() / j1939_priv_put(). It doesn't
appear to have introduced an ECU imbalance.

If that's right, the reordering is fine as a behaviour improvement. Can
it fix the leak in the syzbot report, though?

Could the leak come from ecu->ac_timer instead? j1939_ac_process() arms
the timer with j1939_ecu_timer_start(), which takes an ECU reference for
250 ms. This also happens for the TX echo of an address claim that the
bound socket sent itself. Nothing cancels ac_timer at teardown.
j1939_ecu_timer_cancel() is only called from j1939_ac_process().

__j1939_rx_release() does:

	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);

If the timer fires after that, j1939_ecu_timer_handler() maps the ECU
again:

	write_lock_bh(&priv->lock);
	...
	j1939_ecu_map_locked(ecu);
	...
	j1939_ecu_put(ecu);

j1939_ecu_map_locked() takes a new ECU reference and stores it in
priv->ents[]. Nothing will unmap it later, because priv is now detached
=66rom the netdev.

The ECU then pins priv and its netdev tracker, and priv pins its own
dev_tracker. That matches the two ref_tracker entries in the report
(j1939_ecu_create_locked() and j1939_priv_create()).

The sequence would be bind(), send an address claim, then close() within
250 ms via j1939_sk_release()->j1939_netdev_stop(). That still works
after this patch. I haven't confirmed that this is the exact syzbot
path.

Would it make sense to revisit the root cause before this goes to
stable? For example, pending ac_timers could be cancelled in
__j1939_rx_release(), or mapping could be refused after the rx release.

> +
> +	/* drop old references after re-bind() succeeded */
> +	if (was_bound) {
> +		j1939_jsk_del(priv, jsk);
> +		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
> +	}

Discovered by: opus-5-5, sonnet-5 =C2=B7 Missed by: gpt-6-astra
After this reordering, no j1939_sk_bind() path ends with the old
references dropped and no new ones taken. Is this comment in
j1939_sk_netdev_event_unregister() now stale?

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
		if (jsk->state & J1939_SOCK_BOUND) {
			/* Neither j1939_sk_bind() nor j1939_sk_release() called j1939_jsk_del().
			 * Make this socket no longer bound, by pretending as if j1939_sk_bind()
			 * dropped old references but did not get new references.
			 */
    ...
}

It could instead describe the teardown directly, for example as what
j1939_sk_release() does plus clearing jsk->priv.

> +
>  	/* set default transmit pgn */
>  	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
>  		jsk->pgn_rx_filter =3D addr->can_addr.j1939.pgn;

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: sonnet-5 =C2=B7 Call=
ed a false positive by: gpt-6-astra
This isn't a bug introduced by this patch, but it is in the code being
restructured here. jsk->pgn_rx_filter is written only when the new PGN
is valid. There is no else branch, and only j1939_sk_init() resets the
filter to J1939_NO_PGN.

Documentation/networking/j1939.rst documents .pgn =3D J1939_NO_PGN as the
way "to disable bind() rx filter for PGN".

Take a socket bound with a valid PGN and then re-bound with J1939_NO_PGN.
Will j1939_sk_recv_match_one() keep dropping frames because of the old
filter?

	if (j1939_pgn_is_valid(jsk->pgn_rx_filter) &&
	    jsk->pgn_rx_filter !=3D skcb->addr.pgn)
		return false;

Also, the comment says "set default transmit pgn", but the code sets the
rx filter. The transmit PGN is jsk->addr.pgn, which j1939_sk_connect()
sets.

>  	jsk->addr.src_name =3D addr->can_addr.j1939.name;
>  	jsk->addr.sa =3D addr->can_addr.j1939.addr;

[ ... ]

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d7fm4new5yhuitvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCart9JQAKCRDMOmT6rpmt
0vr/AQDxFm+elJgdCUI/1E0ucbvTXh10aPDFiFRw9nT+P9I9jwEAzcPqGnM9tFkv
dOKgHVT1Zjzl7W6p9OgyhKivXES2mwI=
=2h7W
-----END PGP SIGNATURE-----

--d7fm4new5yhuitvk--
