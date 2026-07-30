Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34459403E88
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408649; cv=none; b=PJqFgNS7VFa3MKkQLsqC15/egbDtW16A1f6gDd2VzfyqpGF09aM6fiymhaxmiqsACJ5sdp9GC0iWEm34xFNMiLdAt21iysFpsq09dHX3qvQx++jSNNmXX+fcQF+HwqLNtOm3CvEvt9w4/JGXMHVAjHitjIMD4lN0rgF3kPcI+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408649; c=relaxed/simple;
	bh=V2MB2NYbtBl+QcSx74LS6TCJeG+ol9dHQJh4BXRKuFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDGMC4tsfRG8ctmNACZp9W/ODvB1/p+ImaOULRoqJMdH6EsY7oZ9pHC6bxNv9e3m6P1m0ogqgnBBQwJAQA9kZLtnAPYMMVHTVgM8QfEHHfBR0l3AHtPXZ4V/bpF7dWwIeyK13w8Sg0UFgylJtPoW8W7O4bAVpfmLs/Fq8IhcolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOaaQxgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOaaQxgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC21F000E9;
	Thu, 30 Jul 2026 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408647;
	bh=B236ooxY/xBh9tefumOz4g8Y8yKvO31/7dKDPzG8Q78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOaaQxgxiSMUdcYKkSK8dl8Ltv2mNOO8Ej0+d5zXJDX2j1re6abCcJe57JFuFirvo
	 YedxpcSV+NfOeNmAGDxDusqpRqaLw4jOOIrNpF/H6aLjjigThJjHdt67oJ2LwHnyOV
	 nBeyD9BeZgT1cjtVxqE2d9iYa4Z1KRL8vkGJPxtqcWnJbg+w/qHvkQ4RXz6IVCAZ2u
	 MREbCClaSD1vbGfiEr6NDkmlVDTT9DEFiSml2sN7QGuYSZeYbgpDqjsChDp5LkFcfc
	 ekMdgq1C3CijUw6P4mpKTk5qmvkhOqKU4sUSr4bzr+EALkPSwmY1Kn1E6U6D1dUYDf
	 wOvTY1U+cdvjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] can: rockchip_canfd: serialize TX state and
 command writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <tencent_73A6685E6540120E468C02F21189FCE69A09@qq.com>
References: <20260730-master-v2-0-572974052400@qq.com>
 <tencent_73A6685E6540120E468C02F21189FCE69A09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:50:46 +0000
Message-Id: <20260730105047.51EC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `tx_lock` fails to fully serialize `RKCANFD_REG_MODE` writes a=
gainst the interrupt path, leaving a race that can break the bus-off state.
--

--- Patch [3]: [PATCH v2 3/3] can: rockchip_canfd: serialize TX state and c=
ommand writes ---
commit 2a5b1a8235e0f295b950d48868b11a6ee290c521
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: serialize TX state and command writes

This patch adds a TX state lock to protect tx_head, tx_tail, and the
echo skb ring. It also serializes the MODE/CMD/MODE sequence between
the transmit and interrupt paths to address errata 6 and 12.

Fixes: ae002cc32ec4 ("can: rockchip_canfd: prepare to use full TX-FIFO dept=
h")
Fixes: 83f9bd6bf39d ("can: rockchip_canfd: implement workaround for erratum=
 12")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index c4ecdc9411cc6..c3811d3179b61 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

> @@ -141,6 +158,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, s=
truct net_device *ndev)
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
> =20
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but sinc=
e=20
the commit message mentions using tx_lock to serialize the MODE/CMD/MODE=20
sequence between the transmit and interrupt paths, does this leave a race w=
ith=20
the bus-off error handler?

Looking at rkcanfd_chip_set_reset_mode() in=20
drivers/net/can/rockchip/rockchip_canfd-core.c, it places the controller in=
=20
reset during a bus-off event by writing 0x0 to RKCANFD_REG_MODE, but it doe=
s=20
so without holding tx_lock.

If a bus-off event occurs concurrently with a packet transmission, could th=
e=20
following sequence occur?

CPU1 (Interrupt path):
rkcanfd_irq() -> rkcanfd_handle_state_error_int() -> rkcanfd_chip_stop() ->=
=20
rkcanfd_chip_set_reset_mode()
    rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);

CPU2 (TX path, holding tx_lock):
rkcanfd_start_xmit_write_cmd()
    rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);

Could this overwrite the bus-off reset mode and bring the controller back o=
ut=20
of reset prematurely, potentially causing the node to continuously disrupt =
the=20
CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v2-=
0-572974052400@qq.com?part=3D3
