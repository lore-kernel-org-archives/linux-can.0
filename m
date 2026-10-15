Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FB50B8B1
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058206; cv=none; b=uAsN1cvU8tq89isDJvi7iBpmw8SNaQOFDCBuyoKzwJBwU93mDf0X2eiZQdTc+DoveLZbG0wm6uC0aGuDkqzDvYIyD11PPEXoYWjzBDsMLjqbGVyNo0DIC+205ezh0NX2RnSb2UIQhWSpeKqVA4r55mtL+o0cR3ai84U12dQOUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058206; c=relaxed/simple;
	bh=YhC0yfmIWGzfBjNmyAZ4taF7hIA+viR4FGcBnhERTRw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ftLBa40N2wBg5re0VOeeXTKXw0CSg/vUUn8ME5Qcl9bLAlAYWcZAWAFDaVnPjyR7SdUa2KdtAQHFej0Q0y+MwEUs64KrjrxQagpdcZ8zHdqBYmQpP5/rVbWro3pRIFLKRanhmvX54TSq9a6nKm7ckQxbMe8mq9472vMrEwapnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvtUDya6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvtUDya6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306181F000C4;
	Thu, 15 Oct 2026 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058205;
	bh=a9+BXgCcahiwGhlvc6BPFyl/upLTkULY5k1xwP9O3dQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvtUDya6HHItVTvpYasEdVPYbGTQcYMMcet8zfFArZj6F2MdXJGR/TgI5wgl50ZMG
	 wDYI7HnfHsZexh5r0iWbKB1LzYzDcdVr3l8sP0cHK46iDK+OqqDe+c6sV6R+hglcYY
	 etAuz7OBKvQNF3u0ywjNHrEBzY7ni4JTYRafCHRG3/Y9MV2XiHEhWrGuwBpPGyfIkz
	 rjoi7DjL/GQ/emxTJC66QTFzZYBv78Re0YXcgUR4aYNqfcW+Fm88ounfc4X/5WHCJf
	 eoUe36qALUy/3ZlsVu4jweMcc6DVskS3EfIHWfN8CPXZLJv/lSz4oBi2JX7w5IOIDn
	 8oE7PzbFr+pMQ==
Message-ID: <sashiko-outbox-172612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/6] can: dev: prevent bus-off recovery when the
 interface is not running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
 <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:56:44 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: dev: TOCTOU race in can_restart() allows accessing hardware w=
ith disabled clocks
--

commit 4e524e53df8c23d434660cf0e7c4868293520f98
Author: Cunhao Lu <1579567540@qq.com>

can: dev: prevent bus-off recovery when the interface is not running

This commit adds a check for netif_running() in can_restart() and
can_bus_off() to avoid executing bus-off recovery on an interface that
is in the process of closing.

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..92492c503446e 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
>  	if (!priv->do_set_mode)
>  		return -EOPNOTSUPP;
> =20
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +

[Severity: High]
Can this lockless check create a time-of-check to time-of-use (TOCTOU)
race that results in accessing hardware with disabled clocks?

If a bus-off event schedules the delayed restart work, can_restart()
could check netif_running() and evaluate to true. If the workqueue thread
is preempted immediately after this check, and concurrently the interface
is brought down:

dev_close() clears __LINK_STATE_START and calls ndo_stop().
In drivers like at91_can and rcar_can, ndo_stop() disables hardware
clocks before calling close_candev() to cancel the restart work:

drivers/net/can/at91_can.c:at91_close() {
    ...
    clk_disable_unprepare(priv->clk);
    phy_power_off(priv->transceiver);

    close_candev(dev);
    ...
}

Since close_candev() blocks on cancel_delayed_work_sync(), it waits for
can_restart() to finish. When the preempted workqueue thread resumes,
it has already passed the check and will proceed to call
priv->do_set_mode().

Will this attempt to access hardware registers while their backing clocks
are disabled, potentially causing a synchronous external abort or system
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-rockchip-c=
anfd-restart-close-v5-0-ae77327037c9@qq.com?part=3D1
