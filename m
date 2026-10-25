Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792958617;
	b=hhzpqN4wKilM0kC0P7gENio31Dlua5tEVFFDxuKwTlzZ9gDsRYdrK3I5aBV3zdGWIKPq
	 /SYT9FkMMSmVNrpMCHpvzca5xv/6ry+kWedO9Ga3gOsbhPQLXYYCAqHrgVAM27quTLpz2
	 9IlnVkz2jVph4364v1fFXRbC4DA7aiufMY9hara0HcalNnEpqmlVv5XrIAGfs8WnfHqYE
	 IbZgd/w9V3YXzPIvpQ4Qvturt9a0ykOkSVKlCVEW1F3gk3+ptLsF6LbGZrS20jIXPv4F2
	 jV2NPmIhVAkUGEZLcAwgbdxH0nNN/eimH+93DPzgE6Nkuv7tDyH/H3gLkIu1y25MyyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958617;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PuwHAFhx8NlismDOlteTF8+w0txA4iYHttJO39bejgw=;
	b=NXRSQkyC1dmrPMa5mZmYthreq3r/9aggYPsJGgxEheiV4HCqc8KpWGpWPzt0sdcYSJXu
	 XOxXyJ/LHxeVxSOR1IA/cvE7eBHgj9G8ewX804GfqVBah7Uo48m78U1HQENRSWJGATXOk
	 IO9YM9UW2Z9exN+iX4aL0JgxO9SpfTWsNjE3tFu2s52Q0gyMdvBV/Rd5iUOE//5n+Finz
	 Yrtlt9cn0s6tQKaYslB9K1rTXGsIOG7SPCIraOnJXYDTe1mus871hE/hETfCoJDg+/nds
	 wIrJd0X8p+PapJ2ZIb/A0PtulyZYo3Ij1OWw5aDswJU/zUjbCCopS4w+4SGdMToMKtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN1JmRZ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C8606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN1JmRZ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2341F01825;
	Sun, 25 Oct 2026 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792958616;
	bh=PuwHAFhx8NlismDOlteTF8+w0txA4iYHttJO39bejgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EN1JmRZ+B7m3D8xgUoitdA5oVk1JEB9qXZlroe/+vWLZnGTE3myQpN2i40Fwpfq6L
	 k/Y/J+VW6dFjRLdoxLtgBtBs/AxZqi5JuPMJRNz94q+zsAK/Fg76kR8rtd+Xju88L3
	 rV1rZ8/B3qHXfWuKF5F0t+CWQyHRQtmZTd4lFnZw65F9SfsCZrdi+cBrH24YVzkBfe
	 ag8SI1F5jo82saS5kM/3v1cRNpWNcKxgCkQlNU54Tp+mn0Zy5VseHJjB1h2EjQIuCt
	 lV9aid3erohAGQWgSfkHrvblfAde36FleuhV7G6EJdG/bnFNfYeGUAkRbHZTdnYZG8
	 Dsuae7VThzIgw==
Message-ID: <sashiko-outbox-184402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
 <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 20:03:35 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: gs_usb: use-after-free and leak in gs_usb_probe() error clean=
up
--

commit 28ced4be5f6d6693ec0ba1f04a6e081bef998aec
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()

This patch moves register_candev() out of gs_make_candev() into a second lo=
op
in gs_usb_probe() so that all CAN interfaces are completely initialized bef=
ore
registration.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 15f28833f2deb..2564c16727935 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -1621,7 +1612,36 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);
>  	}
> =20
> +	for (i =3D 0; i < icount; i++) {
> +		struct gs_can *dev =3D parent->canch[i];
> +
> +		rc =3D register_candev(dev->netdev);
> +		if (rc) {
> +			const unsigned int cur =3D i;
> +
> +			dev_err(&intf->dev,
> +				"Couldn't register candev for channel %d (%pe)\n",
> +				i, ERR_PTR(rc));
> +
> +			for (i =3D 0; i < cur; i++)
> +				gs_destroy_candev(dev);
> +
> +			for (; i < parent->channel_cnt; i++) {
> +				can_rx_offload_del(&dev->offload);
> +				free_candev(dev->netdev);
> +			}

[Severity: High]
In gs_usb_probe() in drivers/net/can/usb/gs_usb.c, dev is initialized to
parent->canch[cur] where register_candev() failed. Should both error cleanup
loops index parent->canch[i] instead of using dev?

As written, if register_candev() fails on channel cur, both loops repeatedly
operate on parent->canch[cur]. When cur > 0, the first loop calls
gs_destroy_candev() on the unregistered parent->canch[cur] cur times, leavi=
ng
parent->canch[0 .. cur - 1] registered with dangling parent pointers after
kfree(parent). The second loop then calls can_rx_offload_del() and
free_candev() on the same dev pointer for each remaining channel, causing a
use-after-free and double-free on dev->netdev while leaking the remaining
parent->canch[cur + 1 .. parent->channel_cnt - 1] net_device allocations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-gs_usb-fix=
es-v2-0-535d45097f72@pengutronix.de?part=3D2
