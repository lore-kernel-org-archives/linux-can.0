Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794398482;
	b=ZkI0W/EwA051CdcVGffRSqUkWeJ+u63TfDgexYjI5uTtkhsodkgPfFogdVYNuTvdy9ux
	 stYMtvqPSwJwNQW/ZHQiHpcKGdBaEFWKMvFiFIgZ/0QX1Zlb55XL252+rSkzlxlYbFaoW
	 KLL71WKsBFCJDhXNrXkpIVanJy99uPWSH3fCQr1iWFbSfvR7CBCVBV3nKBlIHF9b1YqQ4
	 k9E0/PfVed0qD/1Zz9jl56vo7ZiWocjltsoilnqOMjdwp/6SADgHY9oXZveZTIs2ea152
	 YvzBN08kqId7CdlzUfDX8NNiUC7T/GTNizqFTaJ/dj76AzI7GjUd9iUhrbK+SySGqqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NUIA5Dj/cSXn5vTmt4kuMZqqVY+/n24BEGwYcGOr1Nw=;
	b=Ewbm22Q84SBq/2j/sxVBR9Fjwp+JnyHrZBPT9+hftaSz/Gg8dxHzwt0TXXdmpe82VXKi
	 Z7rWoKrYeFR1MWMezls2w9XgrRcdZS/IQ7JUR+9Ys0U1tWJKJxsASKmT2iCE+D31pi66d
	 GGf08/e/KoTHsuUO8RaWHVZvoVaOLAzJaC0QhMhO5S5dpmujm3PdOuUKLmO0tzfg1j+Ap
	 MLQpVi4vweA+KuGy1boxe4cg4IQscv5fh7ZpFYJbf5JYYVU0JpUQ8kF3fJgPqgO82rdZ0
	 T43mGFCjKbqW6XquNVObG2HUV84PRnjMQJnNyLLbrM97NQuzDLfgL73J7cdQtlIGlsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Yi6EbIoW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F714606A327;
	Wed, 11 Nov 2026 12:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F714606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Yi6EbIoW
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D991F2016E5;
	Wed, 11 Nov 2026 13:01:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794398472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUIA5Dj/cSXn5vTmt4kuMZqqVY+/n24BEGwYcGOr1Nw=;
	b=Yi6EbIoWl8c7ng6mEIMa2vJoUvQuS7g4VCz4YQKEYNCamu+TKuhY7K43Kqdde92dJpVYsZ
	maonRDgrieAtLo8w5mWDnAqt9sznpNJQs+R9uwfRKcOUYtZXWMkFvbeakGtmZ6NfDkxcP4
	TQYn4uSzsQ8dtGAsCm88lylNkTzTda2+PC+z1Ilp5B94XpZo3ZO7IP7JSCCbpp22uXWkkK
	P76Ew7ZmwAJcOnmRn14kHOFLJHnGH1ykYJVAQOe/98RGtndpmveKXr/Bg9o8uta2HPGo7y
	+0hrcEqVTsBiQ0IeItPneRdicihH2W7si7kSNsWiTmqrsChcGkwH82l272N1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794398472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUIA5Dj/cSXn5vTmt4kuMZqqVY+/n24BEGwYcGOr1Nw=;
	b=LdaUbBY6ksP+OWfZ6PgCp76/0oM0YF7C2PHYXTmzdZR8eLKo3hbeCEEo7I72wBmh38Dqcs
	zkrpCL2M+mmtJDbw2HHeRtUbFsRlx2J6R/DvPyCi+fBO61o2BghYWSpWRqtMuD72+o9nt5
	3Pfh5Z4Fp3DCpet4ixYud3Krj4L5B9FxAsN1SZZjQALChAb82pSOVq1u94da9etxnp37y7
	WMf/X05r+PqIScfqxP9TROwmZyjGyBqxhCyqEr6XUH130C7/tAsCcm1/UHFx3jx0HI9Dad
	vdpjSikSe0IwWrPwPgkcqCNW3ITi5buQSAf0vrTKpHbWw1Wl06jYuETtLJOWNQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794398472; a=rsa-sha256;
	cv=none;
	b=ahsXaWcRBSjrw3XpQIAGc3kdYZ5zXtybvyAT6MlP4eCTdK8+TI9+MaYQAOXhOcIFVTFkL3
	n+VK96gIgB56UkIwEGsYPsxzM/RJq5Q0OU6S7QEt5qOYI8xSS/xaUIVbkZK6lhpBTc+j+T
	2Mvu06vYavEPLhSmCEwMrh3hFoib9m4bNjx5iqtjwWqHPWpfSUIsFAuYe3Xv0imuNN5VYD
	II+6NQXgo3sNoSrLbe+d5SJdqyJbnUYld5TYIyiX+4XnqwvfHGTWST0lSfVc8l35QkGcXN
	6UY0xPzMORwVK27gJ0r6batXR14Z0r69/WF67yfnQBMyaSZpUbFQuTOfkIEG2g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xR70q-003eAF-2X;
	Wed, 11 Nov 2026 13:01:12 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 86C475E7CCF;
	Wed, 11 Nov 2026 12:01:12 +0000 (UTC)
Date: Wed, 11 Nov 2026 13:01:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
Message-ID: <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-8-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4ljzh537fe3fl5p"
Content-Disposition: inline
In-Reply-To: <20261110115112.3807247-8-mkl@pengutronix.de>


--q4ljzh537fe3fl5p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
MIME-Version: 1.0

On 10.11.2026 12:41:30, Marc Kleine-Budde wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Print the DT binding clock names when reporting the selected clock at the
> end of probe. These names are part of the DT ABI, so they are stable and
> match what users see in the device tree.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@ke=
rnel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>


The netdev sashiko/clashiko found a medium issue. Can you comment on it?

If you re-spin the series, take a look at the low issues, too:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-=
1-mkl@pengutronix.de

regards,
Marc

--- Patch [7]: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names i=
n the probe message ---
commit d7a69a85fec4c0746ff8cbfad2799f58cd2059c3
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Use DT clock names in the probe message

This commit changes the clock name in the final dev_info() of
rcar_canfd_probe(). It now prints DT binding clock names ("can_clk",
"fck" or "canfd") instead of "ext" or "canfd".

Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kern=
el.org

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index bb2d03b75142a..4f5cdfa8211da 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>
>  	platform_set_drvdata(pdev, gpriv);
>  	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> -		 gpriv->extclk ? "ext" : "canfd",
> +		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),

Is the right name printed when can_clk is in use on hardware where
external_clk is 0?

gpriv->extclk does not record which DT clock was picked. In the branch
that uses "can_clk", it is copied from the hw_info flag that controls
the GCFG DCS bit:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
    ...
	} else {
		fcan_freq =3D clk_get_rate(gpriv->can_clk);
		gpriv->extclk =3D gpriv->info->external_clk;
	}
    ...
}

r9a09g047_hw_info has:

	.external_clk =3D 0,
	.fcan_pclk =3D 0,

RZ/G3E uses this hw_info, and so do RZ/V2N and RZ/V2H through the
r9a09g047 fallback compatible. Their device trees (r9a09g047.dtsi,
r9a09g056.dtsi and r9a09g057.dtsi) only list:

	clock-names =3D "fck", "ram_clk", "can_clk";

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

>  		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical=
");
>  	return 0;

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--q4ljzh537fe3fl5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavRZBQAKCRDMOmT6rpmt
0pBBAQCK5KjhmVwBlTd7VS8xi7KldygI81TnRzD/C7CwZVyMBQEA/DmkcFAtR+wh
01CPr7JPV0J3luub3WMhzEWD3FH7rwU=
=oI+B
-----END PGP SIGNATURE-----

--q4ljzh537fe3fl5p--
