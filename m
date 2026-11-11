Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399619;
	b=ox6zrbzadZf3kABVMGSSp6+3f9idiMVbbWInMM5zjwp5mNUVJPGzTdQbbxovxti4v16/
	 Ypt8VFGV+ex60leh1wYCCiWrAr2yxsmRsDEPGG32BXcxy0/YXnP9FWa6pymXfbE7Dhn7U
	 7uGvtCwi6o90yNxLOUdslOee+driMpOszc/GvmRRoLuKTV2LEysDnRW5NqgjUhZoSzkR3
	 sU1jEhGAHraYIIx5ekGwfZFrK/ZYFXJ00+YAU7EYK06IdCsrjTOBEnNd5tCI8Vr4oNDS0
	 Gper6coE36VfHiM9egP/QTMFeka/hYJlNML9GTD7RbGyU83/sWa2JW8ZfhyMzTGcVMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399619;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GD9dHGPBBQDjALH35Lw200yocihggwV/VfdrlhPEkuw=;
	b=IjRovq9pzOB764xkf02WXACN9/2Ou4ocPD25afrlImWZaL0K1HmUqIOSjJ7OC93cwYgf
	 GiTCOP6e+pehlENR99QGS10l2OFJgDryCO6IGvLGpkYouqbNmBAMIEoxSVKXpmlG0v8iv
	 YIE/vBk40X0PuZflschHuUdZ3mBJ/SfeUCmr8Yg7eqzt5POJ+kNblf7BqlwJJx1hiwtBF
	 LuBJA9/oxXHWTrmDCqe/h4z7WZXPF83K8R8A0WBBnK9d9gdCj9/rAPGASp7dtcC9ySMf8
	 bcFell+9XYr3v8JKJI5+1WHS4BkQgoDTSpRDQWPhQDbH5nfdaxIkve6AXzzlcKokUxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5jcvi1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFC606A335;
	Wed, 11 Nov 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5jcvi1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684B71F00A06;
	Wed, 11 Nov 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399618;
	bh=GD9dHGPBBQDjALH35Lw200yocihggwV/VfdrlhPEkuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5jcvi1qiUzOAVlXFI5M3wREL8MD1mrOAH62kDpqbNcYMPWmupiAEd3ytJYCfjA6j
	 aRI93/45UAeMGPJ8NAyGluz6hgjWoYD/Y9wzWXgq1TEk895/BO+ehvovoz0vTfVyib
	 yzDSOpqwpcPsE8lY4XSODLo5yEwC1/kCiCBn9AKRw0aPR8pfn8u5TbMybOewVDxBVB
	 nEVYVke6+BRApclY7EwmtAGrn2CqKdXtPP5C6ZD/l6Ai7/Bz5OUUi8nJd5q7vMuZYw
	 fGIc0e4pEhDz0YFz5/BWf+uAKY3cdEApp2S/S5ZQK2DYO1IQNmA7hpikKy1yVODUUS
	 +jCeYMoa1pVpw==
Subject: Re: [PATCH net-next 03/12] can: rcar_canfd: Allow the CAN FD clock to
 be sourced from fck
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:17 +0000
Message-ID: <179439961796.2199510.1566111456942297897@kernel.org>
In-Reply-To: <20261110115112.3807247-4-mkl@pengutronix.de>
References: <20261110115112.3807247-4-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds a third fCAN clock source in rcar_canfd_probe().

--

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adds a new fcan_pclk hardware feature bit to struct
rcar_canfd_hw_info. On the RZ/G3S, fCAN can then come from the peripheral
clock (fck) when no usable external can_clk is present. Existing hw_info
instances are updated to set fcan_pclk = 0 explicitly.

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
This isn't a bug, but should the comment on the extclk field in struct
rcar_canfd_global be updated as well? It still describes a two-way choice:

    bool extclk;			/* CANFD or Ext clock */

With this new branch, extclk stays false while the fCAN source is fck,
not the "canfd" clock. So on fcan_pclk SoCs, extclk == false no longer
means "CANFD clock".

Later patches in the series update the fallback comment above this block
in rcar_canfd_probe(). The commit "can: rcar_canfd: Use DT clock names in
the probe message" also updates the dev_info() string to report "fck".
The extclk field comment is still unchanged at the end of the series,
though.

> +		} else {
> +			gpriv->can_clk = devm_clk_get(dev, "canfd");
> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq = clk_get_rate(gpriv->can_clk);
> +		}
>  
>  		/* CANFD clock may be further divided within the IP */
> -		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
> +		fcan_freq /= info->postdiv;
>  	} else {
>  		fcan_freq = clk_get_rate(gpriv->can_clk);
>  		gpriv->extclk = gpriv->info->external_clk;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
