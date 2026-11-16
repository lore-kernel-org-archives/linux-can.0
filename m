Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823088;
	b=GOf6DOjSnc5fQkd1UAPTdcB8yJb5AlJ0A5OIaIdzN1DYefOlVJp72Sd+Cdk9rk5FnNsG
	 6UZTjzTaohASYCktJZv9H3Rv26YNEXplpVJKn0qCYhYRO6cCoC8geJ9fD/hA6ASVeQuv0
	 vqNUUUACBEaxayAZpisgHMmuhVMnL+OpASeQIk1BBE9y5tYaKG7IegZkXv5mrVOEMQABg
	 9la9N4p96xeHuGsM4hekx6ehOdvJyEkfdA3z2KCkO9lTDG6yoS81yXbg5+XRbe0juJkJ7
	 BMGe91F6cqcxDB2lL1XZ4+U/G1D/aOJY0LdQm2ArJaFtxKVz8BM9fC/aNEO1V9mLDQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DN0MCKVI2MfphO3U523XC6aEY/+1F3400hNih4l7Jts=;
	b=XaudJKqgad0ksGs+yNYfdu0a8YbvEWO6Ig+dbbLeFKzaD+4QAmwyg8o1zX0ab0ll/Sdx
	 xPfzi4Ma3dj+3lmDrMNf9o/ZnNa/3A+JV4x0/XTpF1LeeLYR+Dx9mazIOdS8y8zm8PtdW
	 QGVjCkutadb942rwZwOEnC+naC+Mc5QE66YjxVlmbx4rShmLjU8tvXREZC17+TpihCvYB
	 HPgEh/jvTNCnuug3lyvbLFPQYdnqbkBQevApxsKFNmV3WnStpWxb6LwwhPppMCIYZBdhz
	 EYgI9aYWeJjYNzYmiFIBW+Rdjtzqcn2b/jia/0ckhO80/xdKtvZZ89qcd+dHc0iaV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiWQNSOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59D606A323
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiWQNSOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167CC1F000C4;
	Mon, 16 Nov 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823088;
	bh=DN0MCKVI2MfphO3U523XC6aEY/+1F3400hNih4l7Jts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CiWQNSOLT7/AVUMbq0Tk9o14jyzkt6yGYp4X7Zyz+denffp2bpU1jtIaszKZLg/4p
	 ZMVpC0hIwBYU8VgTKocYkxKnIx6e/GMpqybr/JIW29Wga/E770JDgBs5n8o898r+vd
	 nJuFVUw5+Wds+9V8OO35oIqwc6ALE4HmLUEmAOlo4psldOqPMXbsN3Hy2raeITaWrf
	 6gkxsVNjZXYfVUN0rgz8g98b8PzUhHVjkj46QHk9nQp+m9tQToS7R2SuK32xFD963R
	 QIuWo2LkQStdaNPzAr7ALXz8lR7Hul2+vF6gMdSWz+pbj+giEK99mwjzSnd9S7LWd6
	 9CEEwO2DYG/kg==
Message-ID: <sashiko-outbox-216678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/9] can: isotp: use a private mutex instead of
 lock_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261115095746.709371-7-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
 <20261115095746.709371-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:58:07 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] can: isotp: missing active TX/RX state check in
  isotp_setsockopt_locked() [1]
--

commit fb285f445bf95b5048922b684bed21d449cf9cea
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use a private mutex instead of lock_sock()

This commit replaces lock_sock() in the CAN_ISOTP protocol with a private
conf_lock mutex in struct isotp_sock so generic SOL_SOCKET options that
sleep on user space access under sockopt_lock_sock() cannot block
isotp_notify() while holding RTNL.

Link: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-4-634c0e04bc72=
@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 7a90ba3f1cf1c..8229b6a69ecd0 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1831,9 +1834,9 @@ static int isotp_setsockopt(struct socket *sock, in=
t level, int optname,
>  	if (copy_from_sockptr(&val, optval, size))
>  		return -EFAULT;
> =20
> -	lock_sock(sk);
> +	mutex_lock(&so->conf_lock);
>  	ret =3D isotp_setsockopt_locked(sock, optname, &val);
> -	release_sock(sk);
> +	mutex_unlock(&so->conf_lock);
>  	return ret;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can
isotp_setsockopt_locked() [1] modify socket options while an ISO-TP
transfer is still active after NETDEV_UNREGISTER?

When a bound device is unregistered during a transfer, isotp_notify()
clears so->bound under so->conf_lock while the TX or RX state machine
continues running until its timers or work complete.  Unlike isotp_bind(),
which rejects rebinding while so->tx.state or so->rx.state is not
ISOTP_IDLE, isotp_setsockopt_locked() only checks so->bound:

net/can/isotp.c:isotp_setsockopt_locked() {
	if (so->bound)
		return -EISCONN;
	...
	case CAN_ISOTP_LL_OPTS: {
		...
		memcpy(&so->ll, ll, sizeof(*ll));

		/* set ll_dl for tx path to similar place as for rx */
		so->tx.ll_dl =3D ll->tx_dl;
		break;
	}
}

A concurrent setsockopt() after NETDEV_UNREGISTER can therefore mutate
so->opt, so->rxfc, so->ll.mtu, and so->tx.ll_dl while frame construction
is in flight, causing data races and writing past skb->tail when
so->ll.mtu is reduced from CANFD_MTU to CAN_MTU mid-transfer.  Should
isotp_setsockopt_locked() also check that so->tx.state and so->rx.state
are ISOTP_IDLE?

[1] https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115095746.7093=
71-1-mkl@pengutronix.de?part=3D6
