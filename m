Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8783B777C
	for <linux-can@vger.kernel.org>; Sat,  5 Sep 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602338; cv=none; b=tR2KwWiCudBd4Q150UEW1zerU7nqED6ghJhPW5AuYGHzrS4n0ont8RMu5FgxZ5WY+ZBSpARa8vYA8cMU4usWs9OCGzhcisEiXIuntVzyX8b7Zel+B49VnpL9ns2Hhy8/GDS2vSS3dJqc8ZSP7tu2ntW++GDZ7m/OfG5XwXStJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602338; c=relaxed/simple;
	bh=C6Cfr8I9+GMqBLk7AHidt3735occ4UWvvNZxD7jT30c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YH2qOEBJKbrnUDBbRheY+DJ5uLdzWTPtAUnRKjCZjSLBQZTyjQfi8iqGAizUMZZc6fmkpF6gY99zRRjNK5cCG52AzFLJDgdVZhBPxtviyldkFRJYvJ2gNUctCMoCBb1XQSULXbhmtKxLN/B1UnZ9iKaE6KimSCF1Fp6ip+uVyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs3I6eEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs3I6eEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510841F00A3D;
	Sat,  5 Sep 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788602336;
	bh=vkTxFhRLlf4cXmrcY0sh4YRe11c85Tgpflf5M/jgkgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vs3I6eEhci5BTDMIEFs59+k2K+WQ3rMkyqiULg036BWWqyDEgYEkR7zcW2+nk1T48
	 0epMsDSAshM1uvz4xamjs5TPmCnYMxNO+N81/4cwOOQCKdeq6t+bSTvetvKzhJZJfw
	 LOJ5kMqvHldMpXDkgxizfEbBRsoSALwvM7bccb3bkkUbExv4zamxUmtL3pFXgu2KKo
	 cpFjg73gIWSaQvkAP27q9EB9eEuLTEd2WPeNfVqf8tgJMHqACvWTdlfAPMhvPoD11O
	 JbMw/yRjrmL/N0Tqbr31JxsOAzgxWdhks+lrO1ZmPXnoiUoqLdqnj70k4mJt0dWEh/
	 elaQduoRgVfTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 (repost)] can: j1939: j1939_sk_bind(): fix j1939_ecu
 leak when re-bind failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp>
References: <deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:58:55 +0000
Message-Id: <20260905095856.510841F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between socket re-bind and netdevice unregister lea=
ds to a permanent netdevice refcount leak and indefinite hang.
--

commit b8691a5ee88f84f344aebc052218bc8abf2cba8a
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed

This commit defers the removal and release of the old ECU references during
a socket re-bind operation until after successfully acquiring new resources.
This resolves a netdevice refcount leak that occurred when
j1939_local_ecu_get() failed during the bind process.

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..24efb25c58c3f 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
[ ... ]
> @@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struc=
t sockaddr_unsized *uaddr, in
[ ... ]
> +	/* drop old references after re-bind() succeeded */
> +	if (was_bound) {
> +		j1939_jsk_del(priv, jsk);
> +		j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
> +	}
> +
>  	/* set default transmit pgn */
>  	if (j1939_pgn_is_valid(addr->can_addr.j1939.pgn))
>  		jsk->pgn_rx_filter =3D addr->can_addr.j1939.pgn;
>  	jsk->addr.src_name =3D addr->can_addr.j1939.name;
>  	jsk->addr.sa =3D addr->can_addr.j1939.addr;
> =20
> -	/* get new references */
> -	ret =3D j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
> -	if (ret) {
> -		j1939_netdev_stop(priv);
> -		jsk->priv =3D NULL;
> -		synchronize_rcu();
> -		j1939_priv_put(priv);
> -		goto out_release_sock;
> -	}
> -
>  	j1939_jsk_add(priv, jsk);

[Severity: High]
This isn't a bug introduced by this patch, but does this sequence leave a r=
ace
window between socket re-bind and netdevice unregister?

When the socket is temporarily unlinked via j1939_jsk_del() and then added
back via j1939_jsk_add() in j1939_sk_bind(), can a concurrent netdevice
unregister operation completely miss the socket?

If an interface is being unregistered (e.g. via ip link del) while a socket
is re-binding to the same interface, j1939_sk_netdev_event_unregister()
could scan the priv->j1939_socks list during this gap:

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
    read_lock_bh(&priv->j1939_socks_lock);
    list_for_each_entry(jsk, &priv->j1939_socks, list) {
    ...
}

If the unregister notifier iterates the list while the socket is removed,
doesn't the unregister process bypass cleaning up this socket?

Could this result in the socket permanently holding a reference to the
net_device via j1939_priv, causing an indefinite hang in
netdev_wait_allrefs()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/deb3ac27-5eaf-406a-=
9bf4-733cc43ecaba@I-love.SAKURA.ne.jp?part=3D1
