Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196483AEF55
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392794; cv=none; b=eBfGAtNIWYRzIUrYsXW5yxJHv7lSF3hBlaWQfD359UDQSKFRU4ackNj3KZevktPrVocU6hxT3ZBCxRLeLyC52PAljthSxaKu1vtnbqoOhU/V6SMTTbCOnLFnuKOoJzlzWfbCSt+yqN+Ktyy6qUdQ7JdiguFYHy0gxgSt3FzARNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392794; c=relaxed/simple;
	bh=msb4YsztBdQg9IrNHC7LUkdbs97rzQ2yV6L2nHL/RIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9MpmdYzew6Wpdg6a7/OcwtOwdCV8EUfhXznDsmRzTtAh4iam3qLpC/gUh5XMWnnQil8Z9tDEY+Mh/kKZ0/C/DcO/KCULL5gx2zo6fGXVRS7egTBCX/S8tAOZNBNrNUUBVwdv2JhUo7FlDlFFf7hqfNCAaG+Khgslm/5n1i1i3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcXW2VsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcXW2VsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF4E1F000E9;
	Thu, 30 Jul 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392792;
	bh=yrFozQtGXs1usd56LHVAk2wnCiJRoDtWX8jNfp+KGvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JcXW2VsQQjBkjgcHVBCq557MmoK0aVJjkgUqm1gb021ETuvChXNW3ZK5FRKBIvISg
	 d+/gQTLbW163wDjlZFsazn2tpx9TW8Oa2IV2AwuKqKSpQdvUWRy0PZ9jNt/4e7UlZA
	 pcCBZAJG9L5Igd7U4yypZi6pSn0/mse7dIIMG6p1WRbmNVUF73hrN9IGljAL4+0fqg
	 pbWKtOSTaoOzbjVK3ct3p9Gwkjhge4fhbWd31+GbTKp/jr+OlvNkihdvf9GbqCnz7D
	 vA6RAiEY/t6maEAi8rue7UGlFLpYI5J/Wp25h7lgDvVknimCrG8KRiGqMBiVCMNa+u
	 GednoxqdhYqgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <tencent_803FA8A6621A5D198504BC91BE003D442007@qq.com>
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
 <tencent_803FA8A6621A5D198504BC91BE003D442007@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:26:31 +0000
Message-Id: <20260730062632.6DF4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a data =
race on hardware registers RKCANFD_REG_MODE and RKCANFD_REG_CMD in rkcanfd_=
start_xmit_write_cmd() between softirq and hard IRQ contexts.
--

--- Patch [2]: [PATCH 2/3] can: rockchip_canfd: retry the outstanding TX bu=
ffer ---
commit 008079a4d397736133d0b75cae9351b6c5be751d
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: retry the outstanding TX buffer

After the FIFO depth was increased to two, tx_head selects the next
free buffer instead of the outstanding one, breaking the erratum 6
workaround. This patch fixes the issue by using tx_tail to select
the outstanding buffer for retransmission.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index d2cbe25c46d6c..c4ecdc9411cc6 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -57,8 +57,8 @@ static void rkcanfd_start_xmit_write_cmd(const struct r=
kcanfd_priv *priv,
> =20
>  void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
>  {
> -	const unsigned int tx_head =3D rkcanfd_get_tx_head(priv);
> -	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);
> +	const unsigned int tx_tail =3D rkcanfd_get_tx_tail(priv);
> +	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_tail);
> =20
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);

[Severity: High]
This isn't a bug introduced by this patch, but does this call expose a race
condition on the hardware registers between softirq and hardirq contexts?

rkcanfd_start_xmit() runs in softirq context and calls
rkcanfd_start_xmit_write_cmd(), which performs non-atomic register writes
to RKCANFD_REG_MODE. If a hardware RX interrupt preempts execution between
these writes, rkcanfd_irq() (hardirq) will call rkcanfd_xmit_retry()
which also calls rkcanfd_start_xmit_write_cmd().

The hardirq will restore priv->reg_mode_default, so when the softirq
resumes, RKCANFD_REG_CMD is written without the required SPACE_RX_MODE
bit set, bypassing the RK3568 Erratum 12 workaround. Could this lead to
hardware misbehavior under heavy load?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v1-=
0-6945fdd4f0ff@qq.com?part=3D2
