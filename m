Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AB2F1FE4
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115642; cv=none; b=eV2TAqcl4hdIsKu9qqX1u7EHBzEfWNPUNEmnyhQ4r3Bwjze32pVFUtbzVM+7mt9mFHy8tPJf/ekVh/sXuVc7GDnzpNWyb+WqjSpnyvN0ad4FVauwcVg3Y5LZ3C0EjmUQgcWI2e8KdZ2goLcpfZOoFMGtuYVkob0Y6CRdAFx+OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115642; c=relaxed/simple;
	bh=Rwcl0y5hlMB1Kkf7w/A2VCRd+FzIObqhxLxy3RadKV8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C6PLMB9GeG1ChDtMuN3VudrgBqnwYC7RL/iux5SzwHUcIEB4+5Mfx4o5RuJVFvW/X+Onsaq1Co3NvsoJVlk0yMqnVMIlwJAEHVUrAqQtCs3AQxClsRHDUMO6twQP/qSjUDK6c6Fxa22+035DlWddsuKNPOR4QWb5mBqLnkCjIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3u4VEp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3u4VEp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD91F000C4;
	Fri, 16 Oct 2026 01:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115641;
	bh=bWtJlRuqpyIlzf/YSt876fA8iHPpjEw/oooQst2nmH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3u4VEp65GgADRJsH8lO4SGPqqBcctHjOtepnZ7tGWlKDmITIvG9yRrupOZmgt/vm
	 BCmCIfel52oUBcJgKoF3YvTXCg73eJ9TmQCet/shwDZxeMXPj7F4+ZWIfPS5pRek8G
	 eeglfPLe6+j9nBtT9LL1T9k7Xpb9WGtjvA2/iI3srKIixM3qLbqxR3GJsAZu8ZnOvb
	 KyyiJe84lFVLZAv/chsi3HMeOZBeMzTrpvOAkr5XNFSFWsZVblT9GX7IyWU1HwqL9J
	 H3K895OGc2AZZBXeVtbd8lRfG1rf/5gUcDJaQYZ9VSmmdFNW7t3j8jrYIxNHujY+CH
	 +a3rs9+cl71EA==
Message-ID: <sashiko-outbox-173569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-16-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-16-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:00 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: rcar_canfd: incorrect EPROBE_DEFER handling for can_clk
--

commit aa101d1e763b7f726a08a669b292613af929a1c2
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adjusts the CAN FD clock handling for the Renesas RZ/G3S to all=
ow
sourcing from either the peripheral clock (fck) or an external clock
(can_clk). It adds a new flag fcan_pclk to the hardware info structures to
support this configuration.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr
Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b7c4fe3477ac5..f9173774387fa 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
> -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> -		if (IS_ERR(gpriv->can_clk))
> -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> -					     "cannot get canfd clock\n");
> +		if (info->fcan_pclk) {
> +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> +			gpriv->can_clk =3D NULL;
> +		} else {
> +			gpriv->can_clk =3D devm_clk_get(dev, "canfd");

[Severity: Medium]
In rcar_canfd_probe() in drivers/net/can/rcar/rcar_canfd.c, if the can_clk
provider is not yet probed, devm_clk_get() will return -EPROBE_DEFER. Does
this check incorrectly catch the probe deferral and route it to the fallback
paths instead of propagating it to the driver core?

If info->fcan_pclk is true, it appears the driver will silently swallow
the deferral and fall back to using clkp. If info->fcan_pclk is false, the
driver attempts to fetch the canfd clock and might fail with -ENOENT,
permanently failing the probe rather than waiting for the external clock to
become available.

Would it be better to use devm_clk_get_optional() here, or explicitly check
for -EPROBE_DEFER before falling back to the secondary clock sources?

> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D15
