Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440C497399
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639839; cv=none; b=ofN3Mg+r18dLYue/44+BpjS87Fm3JEXW/hG4AAvUuQhaXUx8nD4EhbWaiy7T64JVD694AqugxEUgk4ZhNOG8aLU5BdsACBTRmXd8kcr7YdWCp9iP6h55CQW295FILn8bl+s3GGHH71ZXhwLxSzqIg2G22mBAvXgsqdaxbshnMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639839; c=relaxed/simple;
	bh=2bJduQHwRw5S8brZodpJUy/6yVmDVVw8gdoMg3D5GOA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bPHpMHLTFG0f8oEHE3ua/5xG91J1eddf7cTH6mOuj8JZZ/YPombguypFQuMxvGXK30osZpSd0lYNG912wd2NQzUqsaswIupMmWHQWAG23nMlrH+i+d9ka3ntE6J2WZaFv/tr6/sX2C14QAajrcLXc/ZI6tz5+lvJ+8E7pqRQdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxjJOqUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxjJOqUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418761F000FF;
	Sat, 10 Oct 2026 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639837;
	bh=fdwuD7UfcDFVb/eA30lK1vRRVCr3eHwj5yKPpv1z4zA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxjJOqUXxBsTH2d1a1aJX++l8VrFXw0d9mr9Wt/xMQWA73lczY9IBZFTNYHJ3gFn2
	 Ei+lgyOC5ishrXQ8Kq1GQ18bc4qSXuSgSWmpSwlUECtis3BM43Z3zx0gMQYCnxtnly
	 RimSBN10YRb2nHty09HdHFLeIwiiFYIZrM+dwmt59y3YSMSzCcd59EorJp20RL0VXP
	 kga1zvHs1f+PLjAFv/6h6zQWBhP819TH+wQeWxw31lrrfwcdMYwHclfVGYfGFVR3Wd
	 3q5UUiZmwSaR7H4KxTVByoExuarIORPcbcVjChRqsVf0dQ1uditlo5yF1OC4U5cvhA
	 QYoMBaeMQIdJg==
Message-ID: <sashiko-outbox-166601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261009134323.64064-12-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-12-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:56 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: rcar_canfd: silent override of -EPROBE_DEFER for can_clk
--

commit 5f73d63bd97b58e10882cb62531a376bbe264f50
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This patch allows the Renesas RZ/G3S CAN FD clock to be sourced from either
the peripheral clock (fck) or an external clock (can_clk). It adjusts the
rcar_canfd_hw_info configurations and the probe function to support this
fallback routing.

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

[Severity: Medium]
Does this unintentionally swallow -EPROBE_DEFER if the external clock
provider is simply not ready yet?

If devm_clk_get() for "can_clk" returns -EPROBE_DEFER, IS_ERR() will evalua=
te
to true. For devices where info->fcan_pclk is true, this error appears to be
silently discarded since gpriv->can_clk is set to NULL.

Could this cause the CAN controller to incorrectly bind to the peripheral
clock (clkp) with the wrong frequency, rather than deferring the probe to w=
ait
for the intended external clock?

> +		} else {
> +			gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		}
> =20
>  		/* CANFD clock may be further divided within the IP */
> -		fcan_freq =3D clk_get_rate(gpriv->can_clk) / info->postdiv;
> +		fcan_freq /=3D info->postdiv;
>  	} else {
>  		fcan_freq =3D clk_get_rate(gpriv->can_clk);
>  		gpriv->extclk =3D gpriv->info->external_clk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D11
