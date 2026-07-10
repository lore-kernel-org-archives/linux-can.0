Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDC1F0E29
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684011; cv=none; b=KYJSwFxGU9nC9Bvbsv7SYAKBkwjL1OtdKdvgw/vToq6wg5Mp2kONIBnMvus901qP7D6CdmTlKX+z2pszorzrknNNhWjD2TNtZEg8jMbureryQ804vpl/0pqL/4mCBKfdsdShihh9WaHFtQT5jJdSpULzuIQFXfLvoVl+60ZwRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684011; c=relaxed/simple;
	bh=Ps8HZe9Qseb5Iurd5JpZU3VhIcGvKI2vZIWGh4KnwPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oxyYSB6RSHoqIAmf/rrMETuGylURnDO0zStIODDDQgzLNU3zHrP05UKBDbk0fuKABeWr5p9FKsXr5u1W0JYiOeXprO9lgO4a8gGuLZJevOddlUgAzGJs4vBzPKNF4fAHerqznVUIi0UNdKS5Kn26zgq7FYznQwxsKiL6Mm6Ve8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzOXMWVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzOXMWVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7711F000E9;
	Fri, 10 Jul 2026 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783683998;
	bh=rFgiGS735p9VgvUhi4YXwM0+uLNZyr+D4bbDxnv9pD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzOXMWVDzwwxm9o4/N4NcIW/XlcOl0gaXHqckIbcRXqU1HC/Nx4ZySXWeF0UV9ONl
	 jwFjBR+Beo26hB24CPynIuZKCiSZFOpo/69hFZtW6uxxDImgtbajkdYFXFn+ch/Cde
	 f9IlTB+MiDinr2LL0dW/9jogLTt3yClCuApsOjzMgwgH583N7v5vqZQ/oHOKNTWEVa
	 W63ZhmnCdBzRHh7KMWzhvYY1CP3uAnFhzBXvJ84IAy1rrfJm1gy0oEgvw/NNMGezBS
	 pcbbsWUVGyOV60OHx03U+IzxFG3Dm1pMJCR3LV7rTiZW6cP5wUcj2HB/4RvQV5MhtN
	 Y3PG0F8oZKuKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v2-2-bc57e26594b2@hartkopp.net>
References: <20260710-isotp-fixes-v2-0-bc57e26594b2@hartkopp.net>
 <20260710-isotp-fixes-v2-2-bc57e26594b2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:46:37 +0000
Message-Id: <20260710114637.9A7711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Forcibly resetting `so->tx.state =3D ISOTP_IDLE` in `isotp_not=
ify()` breaks the lockless mutual exclusion mechanism used by `isotp_sendms=
g()`, leading to concurrent execution, memory corruption, and an Out-of-Bou=
nds (OOB) write.
--

--- Patch [2]: [PATCH v2 2/2] can: isotp: fix use-after-free race with conc=
urrent NETDEV_UNREGISTER ---
commit 92f3ac957278bcac43777c1cbfa4e2bf1989b7c2
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This patch fixes a use-after-free race condition by holding a tracked
reference to the bound net_device in the socket from bind() onward. It
serializes bind()/release() with rtnl_lock() and resets the tx/rx state
machine and hrtimers in isotp_notify() during NETDEV_UNREGISTER.

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index d30937345bcdc..d076226ac713f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1582,10 +1599,30 @@ static void isotp_notify(struct isotp_sock *so, u=
nsigned long msg,
>  			can_rx_unregister(dev_net(dev), dev, so->txid,
>  					  SINGLE_MASK(so->txid),
>  					  isotp_rcv_echo, sk);
> +			netdev_put(so->dev, &so->dev_tracker);
>  		}
> =20
>  		so->ifindex =3D 0;
>  		so->bound  =3D 0;
> +		so->dev =3D NULL;
> +
> +		/* wait for in-flight isotp_rcv()/isotp_rcv_echo() calls to
> +		 * finish so they can't leak stale tx data via a re-armed
> +		 * timer after a rebind.
> +		 * synchronize_net() is expedited here since rtnl_lock is held
> +		 */
> +		synchronize_net();
> +
> +		hrtimer_cancel(&so->txfrtimer);
> +		hrtimer_cancel(&so->txtimer);
> +		hrtimer_cancel(&so->rxtimer);
> +
> +		/* reset tx/rx state so a following bind() starts clean */
> +		so->tx.state =3D ISOTP_IDLE;
> +		so->rx.state =3D ISOTP_IDLE;

[Severity: Critical]
Does forcibly resetting so->tx.state to ISOTP_IDLE here break the lockless
mutual exclusion mechanism used by isotp_sendmsg()?

isotp_sendmsg() relies on cmpxchg() to protect the state machine without
holding lock_sock():

	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) !=3D ISOTP_IDLE) {

If a thread is actively sleeping inside isotp_sendmsg() (for instance,
waiting for buffer space in sock_alloc_send_skb()), a concurrent
NETDEV_UNREGISTER will invoke isotp_notify() which clears the state here.

Because the state is externally reset, a subsequent bind() and sendmsg()
could successfully claim ISOTP_SENDING again, allowing two threads to execu=
te
isotp_sendmsg() concurrently on the same socket.

Could this concurrent execution corrupt the shared so->tx state machine,
allowing so->tx.idx to exceed so->tx.len?

If so, later in isotp_send_cframe(), the space calculation would become
negative:

		space =3D so->tx.len - so->tx.idx;
		for (i =3D space; i < so->ll.tx_dl - SF_PCI_SZ4 - ae - off; i++)
			cf->data[SF_PCI_SZ4 + ae + off + i] =3D so->opt.txpad_content;

Can this cause a backward out-of-bounds write into the SKB headroom?

> +		so->cfecho =3D 0;
> +		wake_up_interruptible(&so->wait);
> +
>  		release_sock(sk);
> =20
>  		sk->sk_err =3D ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v2-0-bc57e26594b2@hartkopp.net?part=3D2
