Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619EC4195C0
	for <linux-can@vger.kernel.org>; Thu, 20 Aug 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244026; cv=none; b=EOvc7B9WuIbpOlQ84vV/dL5yV1bn6N1ziSqjlvx6iGYkKz2bhTfOJNlLx6KfaVV2OYMVLi9d2QsPX4XcN9VAl3nueinxwaX2Ozr3zNdU58+pg2zDSA/C1SuHSWWIQcTk57JTXgTgTdheTizXbgb7Ofh6TBH5a434h2F+D716C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244026; c=relaxed/simple;
	bh=rFN/L1eR6c6VY5cR9F3fHxxRvIPXA1+PxWnT1FhWrgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NqJpWajT0vXR1mCALdPfOL8J7VwccVF7G33XuSCP1lb1/Oo6KkQQtctlIUDR89FFkn1sNscmV3D8oVRtSibuZfNuqXZVE+V4RmfUIGXlW/ifa749TsI/LanRSP4J+347pljL1BRRf/UQ0OGU6hVaksp4AlIiYl8fo+q9Wd378Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT8VJNPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT8VJNPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7891F000E9;
	Thu, 20 Aug 2026 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787244025;
	bh=18pzB/MQk0l2qxtOwcWtxe+5OzDMiVeiURIFIqpflJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gT8VJNPVPK96CaRTc1HcV4mwafXV9PyyRcz6CIIj3lp900+sjkEAo3Dtr0286aczX
	 ZqipShIq5jdYDK8cgELtFlBxPfXTopuqey2Gh7S09mqPLPXe86YLqs1P3p4w9o77/i
	 FK6P1XZJYDlJ3UvA+fG/5ukit43jPL+aKEuIAvn+gDL4jyuLiMKJ5v7eBOjO5E2oKu
	 xVQyY0FdF5Im/B8+s/ztO+sp4dhcsvnH4Fq4HjT6T82ALWNk41SfsODIjjWUjPYhHH
	 UPvT/2tBBs9q1EGbGCaih9Xwk/sYTrK22SlcVoM9EZzBgKqxUyHpPQVq56YFU4ooOD
	 REV4/aYx0R4VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:40:24 +0000
Message-Id: <20260820164024.DA7891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Netdevice refcount leak due to a race condition where the unregist=
er notifier misses a socket during bind or re-bind list manipulations.
--

--- Patch [1]: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when=
 re-bind failed ---
commit 472bfe7c306ed38083d747b95430b318ca86c9cf
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: j1939_sk_bind(): fix j1939_ecu leak when re-bind failed

This commit fixes an ECU and net_device reference leak in j1939_sk_bind().
It defers removing the old ECU references during a re-bind operation until
after the new resources have been successfully acquired.

Closes: https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..24efb25c58c3f 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c

[ ... ]

> @@ -519,22 +517,31 @@ static int j1939_sk_bind(struct socket *sock, struc=
t sockaddr_unsized *uaddr, in
>  		jsk->priv =3D priv;
>  	}
> =20
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
> +
> +	/* drop old references after re-bind() succeeded */
> +	if (was_bound) {
> +		j1939_jsk_del(priv, jsk);

[Severity: High]
This isn't a bug introduced by this patch, but could this create a race
condition with netdevice unregistration during bind and re-bind?

When a socket takes a reference to priv during an initial bind (when
jsk->priv =3D priv is set), or during a re-bind when it is temporarily
removed from the list via j1939_jsk_del() right here, the socket is holding=
 a
netdevice reference but is absent from the priv->j1939_socks list.

If j1939_sk_netdev_event_unregister() executes concurrently during this
window, it searches for sockets to clean up by iterating that exact list:

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
    list_for_each_entry(jsk, &priv->j1939_socks, list) {
        ...
    }
}

Could the unregister notifier miss the socket completely while it is
temporarily unlinked, skipping the mandatory cleanup and resulting in
unregister_netdevice() hanging indefinitely in netdev_wait_allrefs()?

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
> =20
>   out_release_sock: /* fall through */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8063b5c1-6171-4350-=
a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp?part=3D1
