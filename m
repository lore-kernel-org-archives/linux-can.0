Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197213B47D0;
	Tue,  7 Jul 2026 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420411; cv=none; b=Y2VjY0zFq05UIjxt6ger9QZfSifL1aEe95GqakSFFfYqPy2yjsEeNcmZJIKSopzkogtHt+4tzvJ13YEi9/sLMAltE2Mu7Qr52QuGxVr4jlL5bKclxwJoY7aeYgt4rOoCU1OOMPsaAhDixJlZQrl4Z7bvTLWGjGaxrfN1XZLXyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420411; c=relaxed/simple;
	bh=1RcZfF8fA2kad4mum3yJyos1gfcKrxHYs1UO/DkzJMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY/159yfx6d1Fde5yRKUqh6FJG0RokYx+ezd7704IVv3JwUolSXfqR98uYOLSne8psoH1W51P2Wir/Pj3JJX4Xkdla3vHlNZhpw9ZLY3JPy7Y8yPk6/0O49c8sycWkXbaO+saUVBovJqk49u5IFwR9q/9YzQC3zlKywEUhLu3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxV64MX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxV64MX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9561F00A3A;
	Tue,  7 Jul 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420409;
	bh=XnC/zt2QZCOV500ok7D6tnGd+z8RbxANfyh2cvrGJOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxV64MX4xeZ8X0SZ1/Zx5bVizDwYi7GMGMzRqg7S1fWGznpIvTEbF4HsBskLMOGef
	 hnuirFgjlro2lOhWenZU/VvUDGiCZDe04e3ixTOfVip20h7Otohspsp61ZqWh2y6Fo
	 I+cqtcbb6EdbUdVZ8bmm3XfHixIbHA1D4OWfGjI9W3xO4JiSJ6kzX8LFSHd6x0w1H7
	 0vccY2rK9dVuUyTyXTtSlNZVMB9ykIbmJuuSP0shk3y4jEBWT3RqTIE0IJeKgaNcZh
	 gG44Uz5FeBRcvAg5SBfHOkwAdkZ9U0Rc8EfWkcY/lxKcekawTbpqvqXtPxugwAiecv
	 4s+RJQBGmNrVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, linux-can@vger.kernel.org, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707102418.1646159-5-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-5-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:33:28 +0000
Message-Id: <20260707103329.3E9561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized variable usage when 'canfd' clock is missing on plat=
forms where 'fcan_pclk' is 0.
--

--- Patch [4]: [PATCH 4/8] can: rcar_canfd: Allow the CAN FD clock to be so=
urced from fck ---
commit 0fffa3e660d5596983dd22ee45ce4eb746f70520
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adjusts the CAN FD clock handling in the R-Car CAN FD driver to
allow sourcing the clock from the peripheral clock (fck) for the RZ/G3S
platform, changing the "canfd" clock lookup to be optional.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b40ae5998c1da..6ec2d7a031238 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -2190,13 +2196,18 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
> -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> +		gpriv->can_clk =3D devm_clk_get_optional(dev, "canfd");
>  		if (IS_ERR(gpriv->can_clk))
>  			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
>  					     "cannot get canfd clock\n");
> =20
> +		if (gpriv->can_clk)
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		else if (info->fcan_pclk)
> +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> +

[Severity: High]
Does this code leave fcan_freq uninitialized on legacy platforms if the dev=
ice
tree is missing the "canfd" clock?

Because devm_clk_get_optional() returns NULL when the clock is missing,
gpriv->can_clk will be NULL. On platforms where info->fcan_pclk is 0, both
conditions in this if/else block evaluate to false.

>  		/* CANFD clock may be further divided within the IP */
> -		fcan_freq =3D clk_get_rate(gpriv->can_clk) / info->postdiv;
> +		fcan_freq /=3D info->postdiv;

If fcan_freq is uninitialized here, it will divide random stack memory and =
pass
that downstream to configure CAN bus bit timings. Should there be an error
returned if neither clock source is available?

>  	} else {
>  		fcan_freq =3D clk_get_rate(gpriv->can_clk);
>  		gpriv->extclk =3D gpriv->info->external_clk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D4
