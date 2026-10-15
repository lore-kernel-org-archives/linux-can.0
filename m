Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009722A4EE
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043636; cv=none; b=uw7EfwOnaBz7gfmIFn1mdZ2rl1nVoDPzbRUxtfpz7qKOejN6hFPWechpedFHLTk5wGx5YNfltLxCgMoDPr7r4/dKW+PzmmkgdM4tvZ5jOqSd+ooH024OJnDqLTzzCzo1QlI+XiQ4PQbLm3Lb3JIWkmL5x36DIk6MHHamACg+fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043636; c=relaxed/simple;
	bh=Zt1Ivxd95PshkKUej+arl2giQ8TSkq45x8J09LCi+uM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eAtT0BrJ1oSD5nIJ7aaugFR3cGSeE1FNu6/5II7Dzm7hp30hOwoMK1jbgvrQigJQpimB/4AysxMVDra1/e0DrftPin8vupbU1VdfcvUPjTYB37pxo3C3V7rWaNPEVN0ji7CPzqQax+vLUOyIMcSCxofQuXMWDuTVBX4Loty29fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLaCN/ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLaCN/ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF61F000C4;
	Thu, 15 Oct 2026 05:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792043634;
	bh=UGL4rzidzyL9CXMtaFkbnwgdOgbPyc5oNFKHMMitKy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLaCN/aePyNGi/Vn5SyBbQPDoMm54Lm5fh0+CQwoSN4PgI3PKo7jVBZnaor1yB8KS
	 Mzw1LxnkzX4kCR/1PcI+pJwUddAvNMTAauNI/YsNr7/IZbhS1mFpDaK5ML3dvfhNTC
	 8QbwbSKi8zlSV8cM/40LAuctBuviaJV00mn6MB6MS2WXwN+34w/hm/ZUk6qg0jDUBT
	 8kSP8Yac+ZuLCc56IYOBEJIkUu53Ni1+WMr3Sv00vrBKJxk/ZrVRchw4l64oNi+wpQ
	 YYHrxCeKL4mucugm6hD2Asdk0Ew7fifvf01wUYaUWlpYalt+0c+lFXptYY/frBIq3Q
	 mF220hqAOt/tg==
Message-ID: <sashiko-outbox-172325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 5/6] can: rockchip_canfd: serialize TX with
 bus-off and restart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v4-5-ad149ff79450@qq.com>
References: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
 <20261015-rockchip-canfd-restart-close-v4-5-ad149ff79450@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 05:53:53 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] can: rockchip_canfd: echo frames leaked as RX frames on bus-off
- [Medium] can: rockchip_canfd: data race on priv->bec berr statistics
--

commit 15287fe0f7062cc51e49632555a904f260da449d
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: serialize TX with bus-off and restart

This commit serializes TX submission, RX-side completion, and retry using a
private lock and an enabled flag. It disables TX before publishing a bus-off
state to prevent concurrent senders from modifying echo slots.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-rx.c
> index 24e87daa1df00..9b357bb8fc70e 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
[ ... ]
> @@ -237,15 +240,18 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd=
_priv *priv)
>  		return 0;
>  	}
> =20
> -	if (rkcanfd_get_tx_pending(priv)) {
> -		bool tx_done =3D false;
> -
> +	/* Do not consume echo SKBs, retry TX or wake the queue after bus-off
> +	 * has handed ownership of the echo ring to the CAN restart path.
> +	 */
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	err =3D 0;
> +	if (priv->tx_enabled && rkcanfd_get_tx_pending(priv))
>  		err =3D rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
> -		if (err)
> -			return err;
> -		if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
> -			return 0;
> -	}
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +	if (err)
> +		return err;
> +	if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
> +		return 0;

[Severity: Medium]
Could this leak echo frames as RX frames on a bus-off event?

When priv->tx_enabled is false, the code skips calling rkcanfd_rxstx_filter=
(),
leaving tx_done as false. This bypasses the early return for echo frames.
Since the hardware pushes self-transmitted frames to the RX FIFO, wouldn't
any echo frames already present in the RX FIFO then fall through and be
allocated and queued as regular RX frames?

> =20
>  	/* Manual handling of CAN Bus Error counters. See
>  	 * rkcanfd_get_corrected_berr_counter() for detailed

[Severity: Medium]
Is there a data race on the priv->bec statistics here?

This patch introduces tx_lock around parts of the IRQ handler, but leaves t=
he
updates to priv->bec outside the lock. The netlink command
can_get_berr_counter() invokes rkcanfd_get_berr_counter_corrected(), which
accesses priv->bec from process context without driver-specific
serialization. Concurrently, NAPI loop execution decrements priv->bec.rxerr
and priv->bec.txerr right below this block.

Could this result in torn reads or lost updates to the error counters being
reported to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-rockchip-c=
anfd-restart-close-v4-0-ad149ff79450@qq.com?part=3D5
