Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4783D7D66
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676889; cv=none; b=WDrMqaKjoeb7lU5VKXBFzf0LRX/7WiJCXPlAXxHj4f9f32heWz+G1wDnQd6dUhaTsFy1xMOru6Mrv9gt0B5NHtNujNjBmlRfFYlRB5oTRZMBvh+Eb3qAEpbSBZUQWrbIjPwAdRf+nPJFUtRz4ljSQj0bRkVb0LZKRy4Ofa3mgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676889; c=relaxed/simple;
	bh=s4bK2/SqpkyhsM9PAP3grKdIpJam/F+GatrNBc/6NRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioHS84RlHu1nvC3+eMP6sOLrStSzP/w4WHHv612Ioce4dRiANxInLQaXTxhRkyBQrxUxENt97ZD1hHPVe2juYn8CUVKocwc/JUmUT5Fj+yINddE6j6FI8DEf9UnMCo6UOmcS973ErRIENIfN16tIBeDhsoJ9bEJVuAIH1MDWZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elr6lCkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elr6lCkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50DD1F000E9;
	Fri, 10 Jul 2026 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676888;
	bh=30uNxxC9TNRI1sjnT/N2YHgH6MzxkgVgFcwrelH7jqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elr6lCkp8ahOobVdcy8U4q68z3/aM/J4bFE4QLlEPWZRHyOTWGNg0osyY3UstMwHj
	 WXgooVP6IsIpw3PeswiTPf6NHAiwAZ+EoAOVQIOW2MnvR7Hv75uU3fqVbx+XzXkzPJ
	 eE5Sv7ZI674B59FgmasgvALt7NV2cX1sdXQe9jUDmITCLO/hutakkrRaFs89wFjnMY
	 9DUCjjbzI6jYb9qE8BgL0hEKrY8XqaiRBujjLAfvRndoVpulaz+8Cz+SiUImqWCi40
	 EcqdAMpRWOROgSZUrP3p5acOthpi8QY98equCg+swHYr9/OjSdqIUUC3eFgSyJQdEA
	 2eHKpbxXC8MIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] can: isotp: fix use-after-free race with concurrent
 NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260710-isotp-fixes-v1-2-75a1d11d7df9@hartkopp.net>
References: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
 <20260710-isotp-fixes-v1-2-75a1d11d7df9@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:48:07 +0000
Message-Id: <20260710094807.A50DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing state cleanup on NETDEV_UNREGISTER allows cross-interface =
data injection during socket rebind.
--

--- Patch [2]: [PATCH 2/2] can: isotp: fix use-after-free race with concurr=
ent NETDEV_UNREGISTER ---
commit 604ae1715e00f0c538a10b8cc5f6f3cb4fbf984c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This commit fixes a use-after-free in isotp_release() by holding a tracked
reference to the bound net_device in the socket from bind() onward. It
also serializes bind() and release() with rtnl_lock() to ensure the device
pointer remains consistent with NETDEV_UNREGISTER events.

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index d30937345bcdc..9db8f9f12a0db 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1354,16 +1354,25 @@ static int isotp_bind(struct socket *sock, struct=
 sockaddr_unsized *uaddr, int l
>  	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>  			isotp_rcv_echo, sk, "isotpe", sk);
> =20
> -	dev_put(dev);
> -
>  	/* switch to new settings */
>  	so->ifindex =3D ifindex;
>  	so->rxid =3D rx_id;
>  	so->txid =3D tx_id;
>  	so->bound =3D 1;
> =20
> +	/* bind() ok -> hold a reference for so->dev so that isotp_release()
> +	 * can safely reach the device later, even if a concurrent
> +	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
> +	 */
> +	so->dev =3D dev;
> +	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does rebinding the socket here safely
handle old transmission state?

If a socket is unbound via a concurrent NETDEV_UNREGISTER, the state
machine (so->tx.state) isn't cleared. Could a subsequent bind() to a new
interface cause still-active hrtimers to transmit the remaining frames of
an old packet onto this newly bound CAN bus?

[ ... ]

> @@ -1582,10 +1591,12 @@ static void isotp_notify(struct isotp_sock *so, u=
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

[Severity: High]
This isn't a bug introduced by this patch, but does NETDEV_UNREGISTER need
to reset the transmission state machine or cancel active hrtimers here?

When isotp_notify() handles NETDEV_UNREGISTER, it clears so->bound and
so->dev, but leaves high-resolution timers (like isotp_txfr_timer_handler)
running. Is it possible for these active timers to inject cross-interface
data if the user immediately rebinds the socket?

>  		release_sock(sk);
> =20
>  		sk->sk_err =3D ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v1-0-75a1d11d7df9@hartkopp.net?part=3D2
