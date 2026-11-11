Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399622;
	b=Too0FdgE9hVjGgqIspz/uF39Lsx72uK+P4S4c+6gk9181RwT1atB+rQmJ8wkBDSkNGjW
	 /LeV1cfmX9Bp8qWC+oA/iZbStRrKMWGf1N02h+wA6xCjkEagE2PMZSe9Q+ATS+cjRIqO+
	 tTB3Id2Uhi2XFZpvAjwEH5LJH+1/yktmeSWnurIefNAzp1X/kREfRSq1qObbychWtPrED
	 m4+GsjPAz37Z2aYcElbVsAcb8nhhjFYVDXfQw3BLtVuTxKwyRCwCjJMEeq1ET1R2HC7fu
	 pPT63uIAEwFvpBJfrc9TBDR03XLEgiyFueaRfUa2VxBwcOtaAnj0VNoTn0toV+GMGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399622;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g6AlOl7pEh0+2zU4X/Ja4NXbF9QRyry9fi9lbXK3274=;
	b=Yx8gYFneumZp1VVdueIVn17PSPEqbPPQQHCJKlfvf1qN7rJ/GGi3sb43TfEszA+O4IIH
	 Y+dMb9NgY4cRdlPRUafyCEV7RiAnhPejZS8HCGsSHZqCtGNta8wnbn1lyIPdZlpoZSRar
	 8Fj6bFgIhl2Qo+3yCxeOv0EbVtzBWwmP8PRCbLcTQWqGbqSvnrFQONQKStV8MnFctsV1I
	 DG/jzntgqA8PmLLmZpS8d9DiLKmLw74DvvnNXgLFTx9hE+zQGusA23N67tlg2J0tU2eHX
	 NjyifWN9pr0ClyXkW8RlA1JpMTZCeIH6jBlcuu+51cFkOtt7NIgdxic8l6dgcoNUVug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXdYcrje;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42483606A894;
	Wed, 11 Nov 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXdYcrje
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978371F00A07;
	Wed, 11 Nov 2026 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399622;
	bh=g6AlOl7pEh0+2zU4X/Ja4NXbF9QRyry9fi9lbXK3274=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TXdYcrjefThp/4RoSVY+iLcf/npbZMytyl0RJWwIwy2AxwQxJgVm42vN7K55bcJ7k
	 8RCrcD1v/ESyY40QVsZXiaVTnMmDEzr8vMfTpG4KiC1cGgGknbmOPVG4rZ4ZrS7cPA
	 YJzdnWA8IhFaRzDaHNswz2fVeqyA7ASBFSWGafc0rfjxJy6J6kT/QX7gFtEA46bSed
	 lq5vU4mWeNqMgknJTwwsRRXhwWhEY4BgEKm/6XtYxhC8qt9/niJDOvXpxcfwiBVF36
	 Gjje7HbW03lnV+7doSMfkWTaAQPk7PqJ52nwz+jcHkGMOOPI9RLHh7pU1lCVJQL3df
	 EyRsbxXcObKmQ==
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in the
 probe message
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:21 +0000
Message-ID: <179439962120.2199510.4973904621434857749@kernel.org>
In-Reply-To: <20261110115112.3807247-8-mkl@pengutronix.de>
References: <20261110115112.3807247-8-mkl@pengutronix.de>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In rcar_canfd_probe() (drivers/net/can/rcar/rcar_canfd.c), the
  new probe message works out the DT clock name from gpriv->extclk and…

--

can: rcar_canfd: Use DT clock names in the probe message

This commit changes the clock name in the final dev_info() of
rcar_canfd_probe(). It now prints DT binding clock names ("can_clk",
"fck" or "canfd") instead of "ext" or "canfd".

Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kernel.org

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index bb2d03b75142a..4f5cdfa8211da 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, gpriv);
>  	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> -		 gpriv->extclk ? "ext" : "canfd",
> +		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),

[Severity: Medium]
Is the right name printed when can_clk is in use on hardware where
external_clk is 0?

gpriv->extclk does not record which DT clock was picked. In the branch
that uses "can_clk", it is copied from the hw_info flag that controls
the GCFG DCS bit:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
    ...
	} else {
		fcan_freq = clk_get_rate(gpriv->can_clk);
		gpriv->extclk = gpriv->info->external_clk;
	}
    ...
}

r9a09g047_hw_info has:

	.external_clk = 0,
	.fcan_pclk = 0,

RZ/G3E uses this hw_info, and so do RZ/V2N and RZ/V2H through the
r9a09g047 fallback compatible. Their device trees (r9a09g047.dtsi,
r9a09g056.dtsi and r9a09g057.dtsi) only list:

	clock-names = "fck", "ram_clk", "can_clk";

On these SoCs, devm_clk_get_optional(dev, "can_clk") returns a clock
with a non-zero rate, so the else branch runs. extclk then ends up
false, and the message prints "canfd clk".

None of those device trees has a "canfd" clock, so a successful probe on
these SoCs can only have used "can_clk".

The commit message says the names "match what users see in the device
tree". That does not seem to hold on these platforms. The same ternary
is also still there at the end of the series.

Could each branch that gets the clock set a const char * clock name
instead, rather than working it out from extclk and fcan_pclk?

>  		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
