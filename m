Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CF3D9531;
	Sat, 10 Oct 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640975; cv=none; b=GKpC9EzJPcukNJkeMb6eHZDKOblYQXGPoUJGInSkgeHttPuGnh0uHC7b6/4vhdDBN3zVLaFd8sEDb820FVSxLtZrYDETxDa9z46L7DK0eakEGcNTXggCMevxhjIzOVR4CzMZB4odSFPchP5ZYm4KMCqN20g68YD0BHFPpQNF8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640975; c=relaxed/simple;
	bh=vjEdeYUAZAjSEA3e/NmOUYHCqZ5Dk15C5/Ixe8AbHZI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ybkh50xHdZyPluacHh5QfUNHIBp4JSq22b+C5s6QN34JGJGMFIpzmjxTLXcSRVIYr/WnNGdz/3tBTtt4lCH/m+WeZqEgwID+rWqHk4FqLOKZ3y4ScDntjZEvMdcmOQeoZW91g9HdaMx2jMSOBKrPyDusp7dMA0PEqf7PtuTsHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCjS20Cj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCjS20Cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FFD1F0089A;
	Sat, 10 Oct 2026 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640973;
	bh=IopOv4ikvxkOWz7gDIsV1hvtvWWvZx1w/HcV+e2O8Wc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VCjS20CjKX1ECEZInVBA0O3nWSv27gkzpSMWZ7w2twoosETI3i7TmYea4X+ifDL2U
	 jFFK8iJpqmY41DzpOPtLOn0Xzg2H9/dXIrKLFrFFqbyWYgQznEMNaRN3jnA2IadLyF
	 v+w9qdC5KwR4mSVEz0a847i7WjqYxvyXL6RTR/qaQkfdGqvmDOzOQ605JRWZOJYOCY
	 8heatTSTIIGd/KIeSCcRDbX4v432tWpu66Ck8pLN+gFnkTkeoZI5DkX4fFuKjooIdC
	 6TBCTu7IBHYcPBpG0nmJxuU18lmbvR5CG9WOFWH5KZtg2vEwvYFI9Jl8ZRrs4SPbU0
	 24i7Wv1dafskw==
Subject: Re: [PATCH net-next 11/37] can: rcar_canfd: Allow the CAN FD clock to
 be sourced from fck
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:52 +0000
Message-ID: <179164097285.434549.6062793759549422767@kernel.org>
In-Reply-To: <20261009134323.64064-12-mkl@pengutronix.de>
References: <20261009134323.64064-12-mkl@pengutronix.de>
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

- [Low] The patch adds an fCAN source taken from fck (`info->fcan_pclk`)
  in rcar_canfd_probe(), but the comments and the probe log still…

--

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This patch adds an fcan_pclk hardware flag to struct rcar_canfd_hw_info.
When the flag is set and can_clk is missing or runs at 0 Hz,
rcar_canfd_probe() takes fCAN from the peripheral clock (fck) and divides
it by postdiv, rather than looking up the "canfd" clock. Every existing
hw_info instance sets fcan_pclk to 0.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index b7c4fe3477ac5..f9173774387fa 100644
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

[Severity: Low]
This isn't a bug, but should the comments and the probe log message be
updated for this new fck path?

The comment just above this hunk in rcar_canfd_probe() still describes
only two choices:

	/* fCAN clock: Pick External clock. If not available fallback to
	 * CANFD clock
	 */

When fcan_pclk is set, the fallback is fck (gpriv->clkp) and "canfd" is
never looked up.

On this path gpriv->extclk stays false. The dev_info() at the end of
rcar_canfd_probe() will therefore still print "canfd clk":

	dev_info(dev, "global operational state (%s clk, %s mode)\n",
		 gpriv->extclk ? "ext" : "canfd",
		 ...

But no canfd clock was acquired, and fCAN actually comes from fck.

The field comments in struct rcar_canfd_global are also out of date:

	struct clk *can_clk;		/* fCAN clock */
	...
	bool extclk;			/* CANFD or Ext clock */

On this path can_clk is now NULL, and there are three possible fCAN
sources, not two.

Every hw_info sets fcan_pclk = 0 in this commit. Later in the series,
r9a08g045_hw_info sets .fcan_pclk = 1 and is used for both RZ/G3S and
RZ/G3L. None of these comments or the log string are changed elsewhere
in the series. On those SoCs, the boot log would report the wrong fCAN
clock source.

> +		} else {
> +			gpriv->can_clk = devm_clk_get(dev, "canfd");
> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq = clk_get_rate(gpriv->can_clk);
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
