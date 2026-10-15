Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB1379C32
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058238; cv=none; b=IySAkMnLpPU29URHbTmfNDbZiC7pUjv4p4WuxSlmiT7KNeSsQsBFN7svZ9ZI/A2FsGyffFC3Ju9Mm3CtEFBMG63frMw/Q/41R5cfmqgMaX8R18bySHbYgMYMB3CBsAjYX0cZSqu+fZyGYal7HPd0/tAxwqy/7ifdJUNwi2Ov6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058238; c=relaxed/simple;
	bh=Wp9eG9ZcjZzJ4j1MQM5lSaaQwodclVRDoGbAju+Id0o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qI4t6MVBVIr0qCXoVaju2qbq5qLWsxE31YwjmjXS0o733hZlzSAPCJmUfPYWqvW9fgk+P3PnlgxOPuxwCVHiQcAnhV8Qay/bp+BVtQqBodccnVjbYdQtRZPTJIxBixEJMH2N/m7SAe3p6veRUMBCNHjTSxDPd3HJDI7hxq0pZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzYHq+sB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzYHq+sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127551F000C4;
	Thu, 15 Oct 2026 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058236;
	bh=S0Vi7m6/uHrkQ8yVrFGR4mFnQY5vxSbE4JjSQh9p7tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzYHq+sBn+bT8Nfabme5rCy8HZZNY1lzPskR2wEmp5DoxArXKfglq4efx0w/F9St2
	 gLGlWzoaXNa+JKELQo4IUDoZdvMd2yVrA35xVfOwLjlY/ivkaDqTJ2MGwLn5/G+fsh
	 KegPCaUZLZ+/x5Zjdibn8pNt/9K31RUoIUrfUpq0doURYSqbpGEMWaKj9eRWx1tAys
	 IWpm9pBPpbY7sp84Vw3Fkztd8Qhk7GjFpa0EpfHx4I2K0O6WnCnGKySSYBDqOR9sFX
	 qwzMhyfqLUAkfunhYF454GYAmCM9clyb5aayG8fThoI7NDQ+3TsiuZJAh1PUGC6Lpt
	 DhMiF54+04Vnw==
Message-ID: <sashiko-outbox-172613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/6] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-3-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
 <20261015-rockchip-canfd-restart-close-v5-3-ae77327037c9@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:57:15 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: rockchip_canfd: missing mask flush before free_irq() risks st=
orm
--

commit 761946c971cc50dc5c7a42016ab27b61a872001e
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: cancel bus-off restart before closing the device

This patch fixes issues in the driver's close and restart paths by reorderi=
ng
operations in ndo_stop(). It synchronously cancels restart work earlier, ma=
sks
device interrupts, and synchronizes IRQs without disabling the shared IRQ l=
ine.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..4b3db07242395 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
[ ... ]
> @@ -356,7 +357,18 @@ static int rkcanfd_set_mode(struct net_device *ndev,
> =20
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		rkcanfd_chip_interrupts_disable(priv);
> +		/* Flush the interrupt mask write before suspending the handler. */
> +		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
> +		/* Keep shared IRQs from accessing the device during restart. */
> +		WRITE_ONCE(priv->irq_suspended, true);
> +		/* Wait for handlers that already passed the suspended check. */
> +		synchronize_irq(ndev->irq);
> +		rkcanfd_timestamp_stop_sync(priv);
> +
>  		rkcanfd_chip_start(priv);
[ ... ]
> @@ -758,6 +775,7 @@ static int rkcanfd_stop(struct net_device *ndev)
>  {
>  	struct rkcanfd_priv *priv =3D netdev_priv(ndev);
> =20
> +	close_candev_cancel_restart_sync(ndev);
>  	netif_stop_queue(ndev);
> =20
>  	rkcanfd_chip_interrupts_disable(priv);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does rkcanfd_stop() also need a readback flush after disabling hardware
interrupts, similar to the one added above in rkcanfd_set_mode()?

Without a readback flush before the subsequent free_irq() call, if the
shared IRQ line receives an interrupt before the posted write reaches
the bus, the CPU could receive the interrupt after the handler has been
deregistered. Could this cause an unhandled interrupt storm that disables
the shared IRQ line entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-rockchip-c=
anfd-restart-close-v5-0-ae77327037c9@qq.com?part=3D3
