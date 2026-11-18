Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039817;
	b=QxULAyhbE1Y5sCcaSIDHv5DUZSWe1LkHg7jIl//Z3vi3aRgrHAbAddcW1pntT77Tq9rm
	 Yg5hwkDM17mml8a59LnFmvBk+GyKCYuiojy8ycqGLjeBhwnRhBumh6MVdbwak0bxNM7ek
	 7LqjEHKjtBr4I+aLW3Ob4aaGTK8G5XlKKfhd0ogbxzWA243tETF+UCIY+fG4DOg8807CE
	 WnnTwIxBAY3cm8GRlsfrMAWh4noJRXDguHqU255PPVl5axI7GOhQaZaJl9HdU69dPg2zj
	 tf5MGc5FI9viLulriq6r6YQ3piWmOpXiIIoMbmyvt8QaQQ+D1hhG/4EE9lpncFMNLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SEXgvoj5Wc9F/npxu0uCGN0N7x6AVslw5w9J7+rhC3k=;
	b=MymaPiKtju8Tc2bn7IkDaOsqn6hjHi1Ye1LQomKi+Q7Mcm8fI32dAxSnW3JdDC0lVadU
	 ktD66/nHvsyy0eBWBeKreULM8LNNBU9ikebN8AvY2fuigLsbzT7KSLlPlipo17KLRhLAK
	 dc1j8CzOCHpLQD35Ub/bk5+8tGVD1xfl7ZG7PDHwJpDjUgeqy8wT8oGsCmWCrzA8TtkKb
	 VTkjSzBVzPqiWZOmAqSPh41eJTIzztpOOq9BwRzlCKAz+SoExKv++CStmGQg2+V21nPIE
	 C/q06e4BDMfCodcyOo6ZA6G9SRZm/3xG9LIxIeGHeeyuUlyAL3auErN4Fc1M4aacHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWAfBHmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C4606A31C
	for <linux-can@vger.kernel.org>; Wed, 18 Nov 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWAfBHmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A51F000C6;
	Wed, 18 Nov 2026 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039817;
	bh=SEXgvoj5Wc9F/npxu0uCGN0N7x6AVslw5w9J7+rhC3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWAfBHmxwzGV23m9qsmdPbnXbBO+Bp1WwMh5GdMKrX05HJjhjKUFpA2fzzL/DWIfk
	 AUGaZ6NI4rVT+w8B3CPfbAbJxENUrnElV1vTLXxcOF+XalUdDu+cnwKghgtEDneilb
	 qT8VYcAThfdtwbGGyaDd18BXy4CWUuaxWEz/b+ELVhoudVPOfzTwNBWQg6XL6bIbFZ
	 6Rf3ry98Zq6DNgO/zc99XF4aybGJkhm9GXjv5FjN5fRb+JPmKealaYhzxFkbCxcWCA
	 rxZgzH3QFDeFRdAxDMJmkFrSBrhCgpc+Jg64YKdFvdiIxSPTNvIOmzCmy0AqHdLLs+
	 xbGhIYZYqn2Og==
Message-ID: <sashiko-outbox-222095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 07/11] can: isotp: reject socket options while a
 transfer is active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261117220818.1142581-8-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <20261117220818.1142581-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:10:17 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] can: isotp: rxtimer left disarmed in isotp_rcv_cf() on
  invalid cf->len
- [Medium] can: isotp: isotp_sendmsg() reads socket options outside
  tx.state claim
--

commit 5df2197329153084f3880aee22e4689e00328a28
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: reject socket options while a transfer is active

This commit rejects setsockopt() calls with -EAGAIN in
isotp_setsockopt_locked() when so->tx.state or so->rx.state is not
ISOTP_IDLE, preventing socket options from changing while a transfer from a
previous binding is still draining.

Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-7-6826a6227d36=
@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0293d590186c4..32c88749d75e7 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *=
sock, int optname,
>  	if (so->bound)
>  		return -EISCONN;
> =20
> +	/* A transmission or reception that outlived a previous binding
> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
> +	 * socket options, see isotp_bind().
> +	 */
> +	if (READ_ONCE(so->tx.state) !=3D ISOTP_IDLE ||
> +	    READ_ONCE(so->rx.state) !=3D ISOTP_IDLE)
> +		return -EAGAIN;

[Severity: Medium]
Can an invalid consecutive frame leave so->rx.state permanently in
ISOTP_WAIT_DATA with so->rxtimer disarmed, causing isotp_setsockopt_locked()
(and isotp_bind()) to always return -EAGAIN after an unbind?

isotp_rcv_cf() cancels so->rxtimer before checking cf->len against
so->rx.ll_dl, and returns early on a length mismatch without restarting
so->rxtimer or resetting so->rx.state to ISOTP_IDLE:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);

	/* isotp_rx_timer_handler() may have raced us for so->rx.state
	 * while hrtimer_cancel() above waited for it to finish =3D> recheck
	 */
	if (READ_ONCE(so->rx.state) !=3D ISOTP_WAIT_DATA)
		return 1;

	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

If a peer sends a First Frame followed by a Consecutive Frame with an
invalid length, so->rxtimer is disarmed while so->rx.state stays in
ISOTP_WAIT_DATA, so the reception never times out.

[Severity: Medium]
Does isotp_sendmsg() still read socket options outside the region where
so->tx.state is non-idle and so->bound is verified?

CPU0                                  CPU1
isotp_sendmsg()
  ae =3D (so->opt.flags & ...)
  wait_tx_done =3D (so->opt.flags & ...)
  wait_event_interruptible(...)
                                      isotp_notify(NETDEV_UNREGISTER)
                                        so->bound =3D 0
                                      /* previous tx finishes:
                                       * so->tx.state =3D ISOTP_IDLE */
                                      isotp_setsockopt_locked()
                                        /* updates so->opt.flags */
                                      isotp_bind()
                                        so->bound =3D 1
  WRITE_ONCE(so->tx.state, ISOTP_SENDING)
  if (!READ_ONCE(so->bound)) ...
  /* builds first frame with stale ae, while
   * isotp_send_cframe() later reads new ae */

isotp_sendmsg() reads ae and wait_tx_done at function entry before claiming
so->tx.state =3D ISOTP_SENDING and rechecking so->bound.  In addition, at t=
he
end of isotp_sendmsg(), cf->flags =3D so->ll.tx_flags is read after publish=
ing
WRITE_ONCE(so->tx.state, new_state), starting tx_hrt, and dropping
so->rx_lock, where an incoming FC abort or timeout can reset so->tx.state to
ISOTP_IDLE and allow a concurrent setsockopt(CAN_ISOTP_LL_OPTS) after unbind
to modify so->ll.tx_flags before cf->flags is assigned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117220818.1142=
581-1-mkl@pengutronix.de?part=3D7
