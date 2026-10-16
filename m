Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A23AB47A;
	Fri, 16 Oct 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157990; cv=pass; b=XHI8a1W6LHVw7INkqoKSD65Eg5NMA/JmdCVKI8B218cHUwm6SZsoZ/5c9ESRjw4tOgZJE1qdXW5chucCTiKdEmZVSRmMHSE9unYeHGKWvNpmmTo5tabxYrcOPXiEOYWLL0Yjq8FI3IICLhgbaAIGpPVZRwLuNli9kRW5FZqSapk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157990; c=relaxed/simple;
	bh=RkEuwiz7CMoqd02J4J862y1UPKC937IIDmhLWBkJLi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anXjEt7ptS9wnlVp/2U0jalvfEBY6EwzHGGO82xNW1qVTWa5ssLzAGgBrkbyc3bGj7nclPHdRnDohYlsWGvhe7b+zUC7TtEoGRlXufF1YDt0qDmHuyztEB+GGYnwGGC+/Gt5b2Xq/B6iHEv5R5f7X4KZ2mDjxyTGjXRLIge0mM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=L9i5wY/q; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="L9i5wY/q"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A41F20281B;
	Fri, 16 Oct 2026 15:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC4tGwyrQluzJbCsPuT7nKVmerbpNass4RgUs/pvp0g=;
	b=L9i5wY/qqsvVkMArHGHVdiCUlPugBS/bJfiO8K7EqrTZQFRVKxSpqmibtJe4ypr4LuapM6
	g/x37yp0qvUGFk2B1Nfk5YhbFwyQb1gvV1CDdGTbOPBEmvypCHrgblT3uWfrjXoBVDLlvU
	I0y6GzFHe7fnP9+YoKSjM9POOVCCvfVlIM2eMe6GctYkh+VnOEySDysDPbmSA9cpMA77SW
	mJXWffibwn4G0NnN0SX+jv/g87i5veOnpug9Tb3P8ORkYeSPMCXd/8nyW4ICi1T4yLZbwB
	LVIOINgzzhWjhVGKKzd70IGL9Jk/V2lvAKc8DB68weH49W48s8n2jw1qhoi3Rw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792157985; a=rsa-sha256;
	cv=none;
	b=TrGYnSsMjFy8I/ySJLh8GyCSTosYMUVu/3Ihv0PyD/WfCx0hYD/ZGyZdLSujxh3jAGyz1D
	l4288v9WHtrFYxvTIcAwm/Ds4WdXnZrL7xOJIIN2UDIcgzSkML/XSedMGqG8K2DZDnCl2U
	pGq9ZGukVAYKcy/gR2N77GnQuMdRoQWy6fVsrLDp345uLVwUDabNcCRP9iPNf/0iYoNsf3
	ykiW3GuzNlGEiTON5TU21qoldD0ZJ+hPrpbLOG+Q1mpJtOQge5OyVwD5QEDYKro1wp1RWs
	umRbicXQkTeB4+c+rXqRr2LlGrbMFNbzaBBot1SQ10lWeQ78S2Aeh2TmJxAZ7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TC4tGwyrQluzJbCsPuT7nKVmerbpNass4RgUs/pvp0g=;
	b=eCFs2SK1ViIEaDbacUL56jmHxIZFJkhGSNrqkCyBJzJyJqcMUdf0ZRyTr2N/92iWLag5Au
	WUVc0bUwD+pkHsY20BHHUCe7Ih/GvwIjaqv0KgR5sY0UmnmliJ6ZjvcnGyY7LHHH6yC/qe
	nzfe/QhgkmFHUMPZffdjEF6yTConCEe9HbZCoDe/2d5T+/5vhzBNRNpHY9YvflNUjMRxM0
	1xPRdke3+yVKZSfocgm9DisSSiLBk2AKiAuYvygm8wzyEF2trv+FdBMsaXpFFqSxbBYGRh
	Fhy4T4JMeCPNj2mgdreTiYd0LJEE/w7XxjKn2Vt9thjoWcypgICDaY3+mPOuKA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHi9x-006C3A-13;
	Fri, 16 Oct 2026 15:39:45 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F40705C626A;
	Fri, 16 Oct 2026 13:39:44 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:39:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Message-ID: <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4hrk6g2tdbfwvwo"
Content-Disposition: inline
In-Reply-To: <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>


--t4hrk6g2tdbfwvwo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
MIME-Version: 1.0

On 02.09.2026 17:15:40, Claudiu Beznea wrote:
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b7c4fe3477ac..f9173774387f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[...]

>
>  /* Helper functions */
> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
            ^^^^^^^^^^^^^^^^^^^^^

As sashiko.dev [1] pointed out here's no check for -EPROBE_DEFER.

[1] https://lore.kernel.org/all/sashiko-outbox-173569@kernel.org/

The netdev bot found more issues.
pw-bot: cr

regards,
Marc

--- Patch [15]: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD cl=
ock to be sourced from fck ---
commit 4ef0042ccf34457229cdde398a008bebaab54e69
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adds an fcan_pclk hardware info flag. With it set, the fCAN
clock falls back to the peripheral clock (fck) when the external can_clk
is unavailable, the rate is divided by info->postdiv and can_clk is set
to NULL. All existing rcar_canfd_hw_info instances now set fcan_pclk =3D 0
explicitly.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr
Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b7c4fe3477ac..f9173774387f 100644
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

Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =C2=
=B7 Confirmed by: gpt-6-astra
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
=2Efcan_pclk =3D 1 in r9a08g045_hw_info. After that, an RZ/G3S board whose
can_clk is missing or has a rate of 0 would print this label.

Also, the new bitfield comment calls this clock pclk:

	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */

The commit message and the code call it fck. Could the comment use the
same name?

[ ... ]

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t4hrk6g2tdbfwvwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIpHgAKCRDMOmT6rpmt
0gYWAQCwZCCXatLpvq2GXTrFVQyQcI4yInN6TKxsyZGdBvD3XwEAt/ypBmMiCjgd
5slGEe1rcUdcjGJdBiChstBRzHUaEwg=
=6nSw
-----END PGP SIGNATURE-----

--t4hrk6g2tdbfwvwo--
