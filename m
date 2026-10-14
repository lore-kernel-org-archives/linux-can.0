Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3753A896
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984952; cv=none; b=c8li+/dmUJZ8q7mGxDnDHlJUWW7OJ0+FtVuq6kJygzG/cgqDslhcoW5q7BVk9D0zSiLtOzlNkdQam77f2rMDo+MxwBP6EDfEimssIqKsUak5HyMdArpkuLZdTQcNtpUTjtDO8iCP+ZVi+jgcs2mQAWOgR3EMYfQpUCSEov5Imj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984952; c=relaxed/simple;
	bh=NbeuxkOvT/JHm7Vp3+xP6m4NpaokJBzLyBQxz0LfZX4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GvZW3kPeabkUZrYLdmvrgx2F0pS2AGRh4gZF82irwNaPThFiAhuXQi/fiSmgIQ2eZJ7nPGdwA02lhe/TEwJN8RzqHnLECS40Uo09zNN95TzpxsduidxKjnkycUGfHqICHzyl15swcMmMipPAGMY39aHHfLXTb+giXKKihGOgA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz4PEuI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz4PEuI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604091F00893;
	Wed, 14 Oct 2026 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984943;
	bh=DJB2rUZwrilo+2mpkJSKfuMgyAJ9O7gxwzAqtYgMZqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cz4PEuI3Wo0wZUGRzZGh81iq43VueB/o4HwsZQDQZNyKiWDALRjgkf4xdbq3WOClI
	 kNFHdInWLN2GRyru1VrNGWyl/T/zgGrX1kG5Y5m3UCs5LI2NNaNJNRu9LYsmvWHBHx
	 lae4CFNy7ZkuOIA9lMj7yUTxZqDZvMnD5D+/BlhPJ0V1QUmG1U5aLBLpsuiZCTzE75
	 WtVS/VyCCIVuJ6Qp7O9XOk3kZgG3OgAtjTrEHSwqHRErjNXn1vO8/g266ObLOCbMQC
	 STwcf9SORKLr7miULTBdzcS6v0o2yZ3/3dgZjxzTYiFXpUiarB/+U29RHE7Cd/HMI/
	 sr5PchueN8C4w==
Message-ID: <sashiko-outbox-171362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/5] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v3-3-f0eb41090242@qq.com>
References: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
 <20261014-rockchip-canfd-restart-close-v3-3-f0eb41090242@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:35:42 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pm: async pm_runtime_put() before pm_runtime_disable() leaves ha=
rdware active
--

commit 614c95a9bb5ead8b95b8b6a430415575bc664f43
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: cancel bus-off restart before closing the device

This commit fixes a race condition during device close by cancelling the
bus-off restart work early. It adds synchronous cancellation to ndo_stop()
while resources are still available, preventing late restarts. The patch
also improves interrupt handling and RX offload enablement.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..4b3db07242395 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c

[ ... ]

> @@ -758,6 +775,7 @@ static int rkcanfd_stop(struct net_device *ndev)
>  {
>  	struct rkcanfd_priv *priv =3D netdev_priv(ndev);
> =20
> +	close_candev_cancel_restart_sync(ndev);
>  	netif_stop_queue(ndev);
> =20
>  	rkcanfd_chip_interrupts_disable(priv);

[Severity: Medium]
Later in this function, pm_runtime_put(ndev->dev.parent) is called.

Since pm_runtime_put() queues an asynchronous idle request, it can leave the
hardware active.

When rmmod is executed, the removal path calls rkcanfd_remove() which calls
rkcanfd_unregister():

static inline void rkcanfd_unregister(struct rkcanfd_priv *priv)
{
	struct net_device *ndev	=3D priv->ndev;

	unregister_candev(ndev);
	pm_runtime_disable(ndev->dev.parent);
}

unregister_candev() synchronously brings the interface down by calling
rkcanfd_stop(), followed immediately by pm_runtime_disable() in
rkcanfd_unregister().

Because pm_runtime_disable() detects and cancels the pending async
idle/suspend work queued by pm_runtime_put() in rkcanfd_stop(), the device =
is
never suspended, leaving the hardware clocks enabled and powered on
indefinitely after the driver is removed.

Could this be a regression? Should pm_runtime_put_sync() be used in
rkcanfd_stop() instead of pm_runtime_put() to ensure the hardware is suspen=
ded
before pm_runtime_disable() cancels the work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-rockchip-c=
anfd-restart-close-v3-0-f0eb41090242@qq.com?part=3D3
