Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EC397AFF;
	Fri, 16 Oct 2026 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118229; cv=none; b=s25TDg8+qf+HwPAZfEHfH6u6ALE+NUPzAVuB+byUq3CIjyvq+aGJoK/Dc9ngDwkjn7bOFu0vjhu/X5W5p0xjRlxjMzYJgBZfGoaE1Syn2emRgEeqAfhhTYFT6j4IeJwQQjO+In9VP58sk723gRob37uVr8jpTh4bQf3TanSEndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118229; c=relaxed/simple;
	bh=XmbJZ5gVp+VdglOj++8Q85yj9yJmdz54MqAQoP2R/2Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPj9UzZutaqUXofFhScA4+/HXyqfJm33jrS/3ZTm/azoVdzOdn4ZCza8l7XQH/mFIy+4xlsX9RSs2ZGB2vsBVeS/F68FeLjR9ood4pCdMkhcgjw2Gjt1bNbNecBVMahecnaCOgXSBGXtdHmknMfiVHnD+o1iwUEpDsGsAnVAafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsIS3kSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsIS3kSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE28C1F000C6;
	Fri, 16 Oct 2026 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118228;
	bh=e071zChG8ty1BKjvsY62Yo0YM+G7HEVzPLaqm31EDT8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CsIS3kSyqnD8RjdkYrmf5hoYSKS7Oaijq5J2tTNiuh1fS9kCduDjHs+dJTzzH+hjg
	 HwphC9XD1BwV5Pmv/UKZef3GQ1pcM9Q8BUiDB6uxX1Xt0m8P1mjXDtCiDL/1dzGo4s
	 SLqBTi+HRWcDzj0hplA0EeQpRRTAxKjEJSbvt7iAFiiQSKnQ4c8+AY+SqhdStH31Ji
	 TH2aaX6FHHCBsDVFjJCKcmAOwIPc1H1xk/DGn18A8p34gIwsIa2ZVlNOgkB7LGOt/3
	 no6oq/MnVZRatAw68OKiw8gELAKONRu6Sjl3WtQ1tfaB1Pz0i1wFT/iz3sTTiU5Rh+
	 wdiUzGNTZ/hKg==
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock to
 be sourced from fck
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:07 +0000
Message-ID: <179211822725.434549.10997986390340946212@kernel.org>
In-Reply-To: <20261015015336.816543-16-mkl@pengutronix.de>
References: <20261015015336.816543-16-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds a third fCAN source (fck/pclk, used when
  `info->fcan_pclk` is set), but the clock comments and the boot banner…

--

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adds an fcan_pclk hardware info flag. With it set, the fCAN
clock falls back to the peripheral clock (fck) when the external can_clk
is unavailable, the rate is divided by info->postdiv and can_clk is set
to NULL. All existing rcar_canfd_hw_info instances now set fcan_pclk = 0
explicitly.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index b7c4fe3477ac..f9173774387f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  	 */
>  	gpriv->can_clk = devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
> -		gpriv->can_clk = devm_clk_get(dev, "canfd");
> -		if (IS_ERR(gpriv->can_clk))
> -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> -					     "cannot get canfd clock\n");
> +		if (info->fcan_pclk) {
> +			fcan_freq = clk_get_rate(gpriv->clkp);
> +			gpriv->can_clk = NULL;
> +		} else {

[Severity: Low]
Should the clock comments and the probe banner be updated for this new
fck source? Several places still describe only the external and canfd
clocks.

The comment just above this block in rcar_canfd_probe() still says:

	/* fCAN clock: Pick External clock. If not available fallback to
	 * CANFD clock
	 */

With fcan_pclk set, the fallback is fck (gpriv->clkp), not the canfd
clock.

In struct rcar_canfd_global, the field comments also don't cover this
case. Here can_clk is NULL and the fCAN source is clkp:

	struct clk *can_clk;		/* fCAN clock */
	...
	bool extclk;			/* CANFD or Ext clock */

The banner at the end of rcar_canfd_probe() wasn't changed either:

	dev_info(dev, "global operational state (%s clk, %s mode)\n",
		 gpriv->extclk ? "ext" : "canfd",

On this path extclk stays false. Won't the banner then say "canfd clk"
for a controller that has no canfd clock and runs from fck / postdiv?

The later "can: rcar_canfd: Add support for Renesas RZ/G3S" patch sets
.fcan_pclk = 1 in r9a08g045_hw_info. After that, an RZ/G3S board whose
can_clk is missing or has a rate of 0 would print this label.

Also, the new bitfield comment calls this clock pclk:

	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */

The commit message and the code call it fck. Could the comment use the
same name?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
