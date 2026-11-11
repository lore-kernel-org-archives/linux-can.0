Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397894;
	b=sLDtXM1ktmsrmb7hYqlUeTK9ZJ94vOS3cWmWFnAdhOz/NqtiQBpxQgLuFVPfd1gMfLoP
	 n5MZ+vl+a51Uft7L0V05hh8l5/UURaYdMHoByo4hBgjKEeZq9c1ylnKe3HoYqNCTV1M7s
	 FIHs9lmENZZUOYn+eBdtwSclZoBMsYNIGSRQXzzo+iDkz0YIEQ6WfbCF/+7fKwSz6mRc5
	 AT0FVb0uAayZizkZoZOIK7oXOmqn7mG1KPWBcMida28x+L+zPbAm948nF2Q67/HQGICdF
	 ZRx/sVWRN66EZnKeF/WLZyer0Wfpku9RIL4NAra3XuHTRZACnWiZzn3wJ4AxLzVGT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yLHOak8jbbjZ7Qx/KrcYIPoHOBZN1+AUkTP2gzQmoNc=;
	b=OptLsojEuYq0IHaB/z2Y3MfUw2Ji837hNWPsoemmBygSGzJoyz5qDjT72bhv0mXd0Owp
	 TX1EC98AcZDuAvtRO82aor7A6HyFgYNcPLPnvFFC0B3QYU5jGwap1u1+dSTn+oB0gxo47
	 +jEB8mV+sSUxQWDGZz5USV//TpcThsDromlQsPlJlFaAyS1jtmCTMVixeWe857zg7+m28
	 PpLM/tE7oIp6PhuZxmuHdjT4jn+b6/jxGVyXs58lMxLwIcmkwhIcv0QiiL7Gz13alEPS9
	 v3/TeVCV7fAfodqlS7C1DtPMHi1CiL10sOGln34G0cuCVe9LSLCAv5d+W7lmOvc0MJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/P1UA7o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D69606A327
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/P1UA7o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722251F00A05;
	Wed, 11 Nov 2026 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397894;
	bh=yLHOak8jbbjZ7Qx/KrcYIPoHOBZN1+AUkTP2gzQmoNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A/P1UA7oDACECAwaIdXiFNi+SzGLbeiAoO8phcL3jN5L3vNXptORv8f/XgfgYvpwS
	 mwBFgvwvnS6kSEoOXfnlk4yQXasF9AIICQ+dYEplp4g5CzlqlaRoNBiUrsCzs82PUV
	 PWBtam5S8eu5HSrxiCW75PzMjLyiNHKr2yVzlPPwm9EK1r+9vyVklzFotHLG53EiMr
	 PvcverKoEEKeDCm8nfh89HsUFeiMNbfWfrIr3bhzGOmyghKxHD8o2D82qV9vDsqZRp
	 kH7VIuSeJGVcG1COgipGujtEu4Rb5UAyovCFdixvsBbJNEgkg5hHTNDjvUKGAqhAxy
	 YB4g3cHxaryXQ==
Message-ID: <sashiko-outbox-208909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-8-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:34 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] can: rcar_canfd: wrong DT clock name logged in
  rcar_canfd_probe()
--

commit 465506d0bf0262439ace49568aa154d5d5ff9172
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Use DT clock names in the probe message

This commit updates the probe log message in rcar_canfd_probe() to report
the DT binding clock names ("can_clk", "fck", or "canfd") for the selected
clock.

Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kern=
el.org

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index bb2d03b75142a..4f5cdfa8211da 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
> =20
>  	platform_set_drvdata(pdev, gpriv);
>  	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> -		 gpriv->extclk ? "ext" : "canfd",
> +		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),
>  		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical=
");

[Severity: Low]
Does checking gpriv->extclk here log "canfd" instead of "can_clk" on SoCs
using r9a09g047_hw_info (such as RZ/G3E, RZ/V2N, and RZ/V2H)?

Those SoCs define their fCAN clock under the DT name "can_clk", so
devm_clk_get_optional(dev, "can_clk") succeeds with a non-zero rate and
rcar_canfd_probe() sets:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
	...
	} else {
		fcan_freq =3D clk_get_rate(gpriv->can_clk);
		gpriv->extclk =3D gpriv->info->external_clk;
	}
}

Because r9a09g047_hw_info has both .external_clk =3D 0 and .fcan_pclk =3D 0,
gpriv->extclk is false even though the "can_clk" DT clock was selected,
causing dev_info() to report "canfd clk".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D7
