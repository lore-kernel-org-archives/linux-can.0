Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935830;
	b=kPFc4dXsCmDYdytwKAcGjGDHzY+J+Oy7PdweDnysQqpgJHqE1ygitvxsoJ9HDscEGi4N
	 cX2URoe7wBSNgiPztPnKJB5RsfIyzmB6/GZNDJvU65hjfzklIhfYE2OQy8on1dhZZ9JPy
	 9eSvPGk7oVp+OaujgSGpftI/ufqFbYVmOdNE6U+kLUfC1jONFL2tNRCxyoCi8QQXUX6qI
	 BFDIP2755CKlqPN6lWIJIrH2X0ztXHxYNmdOXPTzFgJyzwhRvk/iH6iYZPbkFGMsRh4qM
	 AGVtdNjeB+gaHPFF8L82imcY26TbXk899pw7nnJbmJC++g3x5bnCOPn+yVRgNaBilLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7qUhz/klBgddeuIr8zSUIDJBI8QZ+KJ91V1QcEPev3k=;
	b=GidqduT5LUZjks64ng3ekX8BPbW25FZq+bho+9MKxaaDUIowyhUt7V8vPCE1IyW3ywFA
	 tCchfy+TAa/g8mmU+OXIfH40t5p+EHnsXeOgRjlyOgS8TPxUTdH3pJz/enOYZNJCWZlGl
	 1ZK5V/FDq1Om7bvyVXvzY3GfyswxznZaD+GBUBNw8wt8m8PAV9IJeQFO2171ayt0ldbIx
	 m0WxE27DihgsmUb6igNV7jEqdtnS/tGbWpy3cdvd7Mx2R70XOxhHenVrlQBPX1YRbKI08
	 lVtestjpBwEMqNzFWHlOVWIizgfDiW5jCeyFcZcsOF/RqNzHcIJJUgU4OTf/gGVtEAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD+wTz3T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B7606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD+wTz3T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A4C1F000C4;
	Tue, 17 Nov 2026 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935830;
	bh=7qUhz/klBgddeuIr8zSUIDJBI8QZ+KJ91V1QcEPev3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GD+wTz3TRiP1AWALC7h3nSJB00ROnmD7yaQFE80h4+Z5tm9BUA4XItKQAtIhoopsu
	 hXnos/oTES0UpEvUwiVj3ZCgE5RulrphtStPtVV6oYxkaT6FkX2wkzSInKtDx49Hdl
	 lXZkOP8QW/FOdv3ncy+/3/HOkw1wiSfBmQROKX4V0ZTLfSdnNkBUr1dYU9zvLmYlFT
	 go/11Bc8ta5qfZzwc0N7ljdE71MqlsWhttBzwEkLHrnsVB5wODW+BZjRj7M/eXqskK
	 FgovOqe5slsIGoIR8h/anHNn0rQWuNvHuDwm/B8wR8syzO/siYWqGiWSfTyriFKsSK
	 UmaWJWNxPkPpA==
Message-ID: <sashiko-outbox-219222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] can: isotp: reject socket options while a
 transfer is active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
 <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:17:09 +0000
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
- [Medium] can: isotp: race in isotp_setsockopt_locked() while rx.state
  is ISOTP_IDLE
--

commit 2bbcd6c26df0af71086da24b238251d946bf05f7
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: reject socket options while a transfer is active

This commit rejects changing CAN_ISOTP socket options in
isotp_setsockopt_locked() when so->tx.state or so->rx.state is not
ISOTP_IDLE.

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
Can isotp_setsockopt_locked() still race with an in-flight isotp_rcv()
handler while so->rx.state is ISOTP_IDLE?

isotp_notify() clears so->bound on NETDEV_UNREGISTER without waiting for
an RCU grace period or acquiring so->rx_lock.  Meanwhile, isotp_rcv_ff()
resets so->rx.state to ISOTP_IDLE before sending an overflow Flow Control
frame or transitioning to ISOTP_WAIT_DATA, and isotp_rcv_cf() sets
so->rx.state to ISOTP_IDLE before checking padding options.  Because
isotp_setsockopt_locked() and isotp_bind() check so->rx.state without
holding so->rx_lock, a concurrent setsockopt() can still modify so->ll.mtu
between alloc_skb() and skb_put_zero() in isotp_send_fc():

CPU0 (<softirq>)                  CPU1
isotp_rcv()
  spin_lock(&so->rx_lock)
  isotp_rcv_ff()
    WRITE_ONCE(so->rx.state, ISOTP_IDLE)
                                  isotp_notify(NETDEV_UNREGISTER)
                                    so->bound =3D 0
    isotp_send_fc(..., ISOTP_FC_OVFLW)
      alloc_skb(so->ll.mtu, ...)
      /* allocated with CAN_MTU (16) */
                                  isotp_setsockopt_locked(CAN_ISOTP_LL_OPTS)
                                    /* rx.state is ISOTP_IDLE */
                                    so->ll.mtu =3D CANFD_MTU (72)
                                  isotp_bind()
                                    so->ifindex =3D ...
      dev =3D dev_get_by_index(...)
      skb_put_zero(nskb, so->ll.mtu)
        <-- skb_over_panic (72 > 16)

Acquiring so->rx_lock around the state check and option update (or
waiting for in-flight RCU readers on unbind) would close this window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-can-bcmloc=
k-memcg-v6-0-6826a6227d36@hartkopp.net?part=3D7
