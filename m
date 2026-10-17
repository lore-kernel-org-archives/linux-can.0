Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA598381B0A;
	Sat, 17 Oct 2026 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267312; cv=pass; b=OHDNtOfeDlqkMTmLnQrZ70mbUrQ9Ry0gtshsb8BC36pebzGhztftqjqcKc6dwO2BsClEaP7eq2AX50ZX+PrFGV1v1BlqXm92lL2gB/fz35lrMCFhY8wJY5i3h9ABSOaB9w401/OvcILnH8JFnMrT2D6L1nD1AXk6eoowAjNUrDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267312; c=relaxed/simple;
	bh=BSF8ZYO/ksN5cN1sb3I+djgPNhQfLdn3064wBT77a6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk0T99iY/aV+gjba8gmaroh+2wHTjsAF4JiUBJzKeHwJnaHOTkjm8vCNG35evQS4+2/kJJuBvSkoFMcuNu6e5BNwtR0InQrdyUK7pcI/vjw84nFLse6pAUioxnHqjD5jjr2fAhHwla2BI+hgY9Hd1tJFlZYSp27yqBdmBk8chhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=BDZCLPZW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="BDZCLPZW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 78ACB202804;
	Sat, 17 Oct 2026 22:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792267307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUdkvKnlbGB/f/DfsSMX3ajY9qegEEfKGoLtzC+e42g=;
	b=BDZCLPZWU2qfjIWEcqGYa8KnpWGrFAXSOQDKHDjl5IyWhaAs1LqMroeCyYo3vfMORPj1hX
	Oyn/S5AdKvpGAxUclyy0meWB+V4qPlzS57SRc6a63dj/T2cAjFyPAyZDq5m3LCmY3W4Mx2
	UrjKwfRTpcoaCBzj50cfIGZ/Xw0elhkgAboQdmUZ5MXRdvaP6pFpIEW/nSabIdcLCpm17r
	Vr696mSVAnMp9GoiCb7L7C759wofZlgrYIPo3+KGHmnmISYaKFlaoCet5685KAxS15U0pa
	6iPsKY6d52XZaURw5IA4NIguMCFOiq9dUgqRmyyN8PqvpJzkGsSRF60isBe8Ig==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792267307; a=rsa-sha256;
	cv=none;
	b=a9TCQej+AQzqgOsPedsM2D+G8Oy+/eHUqBQsdB/dgHCYPmXg9pLr6Nr9SGU6YejxZvL2PF
	N4lp+B6qWlOZQLsdbWfBF7i89MLkJyEFHHLayZRJqvaWSChfvJoupu1Aw+x9N+81JRlppK
	RDaHTb73XW362r1vn7Y/j1d0/I4iwHJtScWVUkk1lUXw+XqV+L3R2wySmWHcNR2utXaTSV
	2k8phizZ+mwELOVlgS+b6mISktDhN0b81veH+fmCXw4Qfgb2e0zDJVr/rCZeuRfuNmuRvN
	Y3AAqn1ddAbaqgfT5GkJMXTWmK6BGud9xyTwKxNLgV0ApRK1YFEUdaRhrR57ig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792267307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUdkvKnlbGB/f/DfsSMX3ajY9qegEEfKGoLtzC+e42g=;
	b=LG3dHEazp6+aPxQH+LwInOStvjMsDUthoBk98lAOPXM6ZVmzVQFB2Lv1JNzvbCZo9LQVMq
	i5mrseOd22029CI09kAkzI+t77lIFbm1845Rkjrqa+K+UNfrSDS9lii1t/FC/ocyyNcQOj
	PCaacftRzJlcSURn2iuhEhJBpEHwmGoJ534bW4dOGLaGB26nYIb4HKzkqGGzAgQu2S8yZN
	/9hWroviaD3HYMtkXQIAv2JqVgexoGxH//ige8AEI6ZpoMJMO4EdAHKvZ6um7b3wkImQux
	6XX7SyZMyjP6BPamgDAisP3LDLkorDauu4DpwHLoSFss27lGrshYWu00pKfFfQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIAbD-006Sus-1E;
	Sat, 17 Oct 2026 22:01:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 122E05C6EBD;
	Sat, 17 Oct 2026 20:01:47 +0000 (UTC)
Date: Sat, 17 Oct 2026 22:01:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Message-ID: <20261017-weightless-poetic-mayfly-bbdf75-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
 <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
 <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hx3gzkeulhb4oh3l"
Content-Disposition: inline
In-Reply-To: <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>


--hx3gzkeulhb4oh3l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
MIME-Version: 1.0

On 16.10.2026 21:07:07, Claudiu Beznea wrote:
>
>
> On 10/16/26 16:39, Marc Kleine-Budde wrote:
> > On 02.09.2026 17:15:40, Claudiu Beznea wrote:
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar=
/rcar_canfd.c
> > > index b7c4fe3477ac..f9173774387f 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> >
> > [...]
> >
> > >
> > >   /* Helper functions */
> > > @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_d=
evice *pdev)
> > >   	 */
> > >   	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> > >   	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D=
 0)) {
> >              ^^^^^^^^^^^^^^^^^^^^^
> >
> > As sashiko.dev [1] pointed out here's no check for -EPROBE_DEFER.
>
> This looks to me a pre-existing issue.
>
> The newly added support does:
>
> fcan_freq =3D clk_get_rate(gpriv->clkp);
>
> At the time this is executed the clkp was already checked against any err=
ors
                                   ^^^^
> (above) including -EPROBE_DEFER.

It's not about "clkp".

What's missing is, that "gpriv->can_clk" is checked against IS_ERR():

> > >   	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> > >   	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D=
 0)) {

but if it's a -EPROBE_DEFER, IS_ERR() returns true. I think in this case
you want to return with dev_err_probe().

There's also a difference between "can_clk" not found (e.g. not
configured in DT), and there was a problem with "can_clk". I don't know
if this is important for this driver, but if you want to distinguish
between those, you can use devm_clk_get_optional(). I will return NULL
if the clock is not found, -EPROBE_DEFER if not available yet, the clock
or, in case of an error -errno.

Thinking about it: if "can_clk" is not available, I would consider it
intentional, so the driver should use the other clock. If the clock has
an error, the driver should not fallback to a probably untested clock
configuration.

> Please let me know what is the procedure now. Should I re-send the series
> and address the fixes? Should I send follow up patches?

netdev's sashiko's classified this as low. So the patch should go in as
is, if it comes to the same conclusion I in my next PR. Please send a
follow up series.

> > --- Patch [15]: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN F=
D clock to be sourced from fck ---
> > commit 4ef0042ccf34457229cdde398a008bebaab54e69
> > Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
> >
> > This commit adds an fcan_pclk hardware info flag. With it set, the fCAN
> > clock falls back to the peripheral clock (fck) when the external can_clk
> > is unavailable, the rate is divided by info->postdiv and can_clk is set
> > to NULL. All existing rcar_canfd_hw_info instances now set fcan_pclk =
=3D 0
> > explicitly.
> >
> > Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@=
wanadoo.fr
> > Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+r=
enesas@tuxon.dev
> >
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar=
/rcar_canfd.c
> > > index b7c4fe3477ac..f9173774387f 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> >
> > [ ... ]
> >
> > > @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_d=
evice *pdev)
> > >   	 */
> > >   	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> > >   	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D=
 0)) {
> > > -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> > > -		if (IS_ERR(gpriv->can_clk))
> > > -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> > > -					     "cannot get canfd clock\n");
> > > +		if (info->fcan_pclk) {
> > > +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> > > +			gpriv->can_clk =3D NULL;
> > > +		} else {
> >
> > Discovered by: opus-5-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemini =
=C2=B7 Confirmed by: gpt-6-astra
> > Should the clock comments and the probe banner be updated for this new
> > fck source? Several places still describe only the external and canfd
> > clocks.
> >
> > The comment just above this block in rcar_canfd_probe() still says:
> >
> > 	/* fCAN clock: Pick External clock. If not available fallback to
> > 	 * CANFD clock
> > 	 */
> >
> > With fcan_pclk set, the fallback is fck (gpriv->clkp), not the canfd
> > clock.
>
> We can update the comment as follows to comply with the clock name in the=
 driver:
>
> /* fCAN clock: Pick External clock. If not available fallback to
>  * CANFD clock or peripheral clock in case fcan_pclk =3D 1
>  */
>
> or, to comply with the clock name in the bindings:
>
> /* fCAN clock: Pick External clock. If not available fallback to
>  * CANFD clock or fck in case fcan_pclk =3D 1
>  */
>
> Please let me know what is prefered.

Use the clock names from the binding. (Even in the linked clock tree the
clock have more than one name :))

> > In struct rcar_canfd_global, the field comments also don't cover this
> > case. Here can_clk is NULL and the fCAN source is clkp:
> >
> > 	struct clk *can_clk;		/* fCAN clock */
> > 	...
> > 	bool extclk;			/* CANFD or Ext clock */
>
> There is already a pointer covering the clkp:
>
>         struct clk *clkp;		/* Peripheral clock */
>
> >
> > The banner at the end of rcar_canfd_probe() wasn't changed either:
> >
> > 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> > 		 gpriv->extclk ? "ext" : "canfd",
> >
> > On this path extclk stays false. Won't the banner then say "canfd clk"
> > for a controller that has no canfd clock and runs from fck / postdiv?
>
> That could be updated with "clkp" to comply with the driver name or "fck"=
 to
> comply with the bindings or with "peripheral". Please let me know what is
> preferred.

IMHO: Use the clock names from the binding. The binding name is ABI, the
driver's internal name can change.

> > The later "can: rcar_canfd: Add support for Renesas RZ/G3S" patch sets
> > .fcan_pclk =3D 1 in r9a08g045_hw_info. After that, an RZ/G3S board whose
> > can_clk is missing or has a rate of 0 would print this label.
> >
> > Also, the new bitfield comment calls this clock pclk:
> >
> > 	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
> >
> > The commit message and the code call it fck.
>
> The commit message mentions: ...the CAN FD clock can be sourced either fr=
om fck
> (the peripheral clock) or from an external clock (can_clk).
>
> The driver uses clkp (peripheral clock) to refer to the fck.
>
> fck is the clock name used in the bindings. In bindings I kept the same
> clock name and provided the proper phandle in the device tree. I don't
> consider we should change the driver and the bindings for this thing. Ple=
ase
> let me know otherwise.

Fine :) The binding cannot be changed, it ABI.

> The clock diagram is something like:
>
>                         +----+
> pclk (fck) -> 1/2 div ->|    |
>                         | mux|---> fcan
> ext  (can_clk)--------->|    |
>                         ++++++
>
> b/w () are the clock names in bindings.
>
> The full HW block with the clocks involved can be found at
> https://github.com/claudiubeznea/logs/blob/master/canfd-clk.png
>
> Please let me know what is the procedure for this. Should I re-spin the
> series? Should I send follow up patches?

Follow up patches is fine.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hx3gzkeulhb4oh3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatPUKAAKCRDMOmT6rpmt
0i4lAQCr72p6Ik2Ie6m4vM5yrr1HM6Id10p2tq6jY1Q3gSlGYwD/eK/w6kAA2GnT
B5S5TzIna/rI63Dk4xTGtigrZHH3agw=
=Hco6
-----END PGP SIGNATURE-----

--hx3gzkeulhb4oh3l--
