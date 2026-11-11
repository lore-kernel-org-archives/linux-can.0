Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397894;
	b=PcGixKVAZ8ZOl/httm9c/AdC+KZW4RObadCg4v76bdAC8hqVbrYI5Nk//OchYv3t/Jdv
	 V1iCtr28dM4hz2HRzxd6ioRgQLX4s5qYB0pKaBHMtPv0WnFxN6imRT+K20u59OkWsd7IZ
	 mq7X9PhpmjWU7w8it62F4ZpxFps0pYHmdAkkZB51w1jN85bNp8l3NaKTW9WXpj1tZA7km
	 jPePSVvwGm+f037gICkrOyQKwYVw2XGIA7Cuz8Ivelxt2zzLTbGVr4uIHAo1TWUKlxOji
	 5zeOjR8m8ZgI7BL8xKK9TVuOaedsuADYTMpax3/mkgqjfUSDH5Iw4lrPYE9ITflBF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+TennL302etkcAsfrvq5Hr2PPT1QwAtWA+B6ChlrGyM=;
	b=y41fY31VLEHeokJoqXHmp4TIDcwTDXGVqfeRV9AMNB0KE8ERopjCWaBSCUruDQV3RhGv
	 uDcpsWa2RrOb+RGPuyekRnHpQcPFWho7N8/cAeKoM8a9i2gCfzpw3dBIHX/egE8TsaiKZ
	 lPoYHcFVOp3im2rj8bXOE9MTYlW56oGcFwjAzsYIV/tMWGvrp0aDcNx4dhsBIamgR9CPW
	 GfUWoK4Ww+y+cT+yJhK/Ip+PdvOpnHgssuoLlTJpcoCtHU99+Q5+gcGpFhGbB/iDrnK0j
	 CmKiG3kqPXjemKcYBfVxL9IwLscEQLHXOsnVzWnjuRJzxlZ9pVSaEteIsCzGV7gcBPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPXVA303;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F2606A32D
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPXVA303
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E9E1F00A05;
	Wed, 11 Nov 2026 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397894;
	bh=+TennL302etkcAsfrvq5Hr2PPT1QwAtWA+B6ChlrGyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPXVA303BgMy/0HYjmq+UmtfIgy0X6S9/l81wE/3bRUYNe2enCGmt5vFbeQYUPX4N
	 H26JzjMoiufb8ZQwN8/kLSU24SV9VBYVFHpbQGzajpH1aZkXMI3OVmRaOkZpKjiw4M
	 YkV/y9RQjyAZCRfpV30hx3n5kEzxZIpGPrIywdWu7l8nbK5PcsQIGGt37br58E4w4U
	 3kNn033fVsfnJ9fwZDz0j01gIRiosGPoIMRSmDobR0UIlssEp0ZVEnNhi6MG8exAJX
	 JfJDV7ef3gfr/QCoYvo3Ei/pBgnRUdDFPiChbvqPJzdBCFci3yJRG1047HED3LCb+2
	 wI+2lfn9L8D2g==
Message-ID: <sashiko-outbox-208905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 03/12] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-4-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:33 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] can: rcar_canfd: use-after-free in
  rcar_canfd_channel_remove() [1]
--

commit 1df4cf4f9a1348dd6433254810179fc111ec5e51
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adds a struct rcar_canfd_hw_info flag to allow sourcing the
CAN FD clock from the peripheral clock (fck) on Renesas RZ/G3S.

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

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
rcar_canfd_channel_probe() lead to a use-after-free and double free of ndev
[1] during fail_channel cleanup in rcar_canfd_probe()?

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
	gpriv->ch[priv->channel] =3D priv;
	err =3D register_candev(ndev);
	if (err) {
		dev_err(dev, "register_candev() failed: %pe\n", ERR_PTR(err));
		goto fail_candev;
	}
    ...
fail_candev:
	netif_napi_del(&priv->napi);
fail:
	free_candev(ndev);
	return err;
}

When register_candev() fails, rcar_canfd_channel_probe() frees ndev (which
contains priv) without clearing gpriv->ch[priv->channel].  rcar_canfd_probe=
()
then jumps to fail_channel and calls rcar_canfd_channel_remove(), which sees
the dangling gpriv->ch[ch] pointer and passes priv->ndev to
unregister_candev() and free_candev() a second time.

[1] https://sashiko.dev/#/bug/linux-5ba990d8-8cef-4735-85ff-107958a3daf2

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D3
