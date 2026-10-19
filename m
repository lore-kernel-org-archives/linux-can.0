Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CE291C10;
	Mon, 19 Oct 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405313; cv=pass; b=WjaLkJK+2BrByu5aJLKtINdUTQefHWNX+6F+ptPWbi0OUFwaRtbuMi1VhLsE4I3VEe/6qI+sarZ+TYGAm1F0+a3fQHS1y+fbNUMgKSprdu4w/dfqeNpMgV5vkQuuPp2T4FuiC6FF8+AzU92ruXhcb9WotviOodIZhG6PfF6Z30w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405313; c=relaxed/simple;
	bh=dqsU2k+j2h/jlU9K90a1b8H/2C2guTNSlwlML51Pmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOQnbVmoEKOjShDJ+uD70Wpq6bPwpTzASX5ygiA9X3yk9uPFvl9Nh5VByGf+C2S3y404ypaegyvB+BD4upv0dX94atRI6L1c6MGzltAlQGxCA8dvskeyjEUUVpUkXYv7Qxtj7144kdlvEzHiBc7Wzrux486HaUNsRUI1+GAAYjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XIZIFLNM; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XIZIFLNM"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 80B242005A6;
	Mon, 19 Oct 2026 12:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792405307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gLGTyZVae2UoxIdOnGHqtMC2VcU6jvzG6cGMRiNPqg=;
	b=XIZIFLNMW3e6kz6LqSCkZl8ko9cMp/xXoWh08Iwt1WA3AjxVOenq3kU9oDfN94XoVY5CrG
	PT2kz3z9i/KdJxpIk7q3o+ccIpnBzaKs1Zlq9JOtR7GwP/lIp2ea4j6nddaMRBwY4s2Y+S
	NHvpvcT8rT+Rj00s/8q9SyviLw2Tn1YerZdnFwMirHFZxLEAzR/1xD11IRH+eN45fIVbBz
	cb3kM3t7Z3cmFrG3XxMFQX+Rfom1NDumTSLptgQ8UDZsyCWALtJuKpbcjeTTrVGl5qqu47
	GQFOnbVqa47tmV87CAZBulg+V6n6N2MXqkmj2ak3QINOWmjH/+3HKoKRFNfU6w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792405307; a=rsa-sha256;
	cv=none;
	b=enCnV/XP4qDh1aGLyqae6IQ6xIlOdnR7wendVtenyN+fj8sXfGWN4bO2C0T6tL4KM/Lpjg
	88HRkiFDEayX4RBzhU0uJcSi5m1mrRZSv2rfArbXEG696+fgDjRNLgOdPBPDXsWu0lRZPz
	zAlDWJMEhMmkU13np3JnsspTJcoXZutyqc5SQH9xmLgunjeAMXCzYhA7vdk4QpkTrLISpk
	wq4LQsb6P1KpS6xubm7wNXKDAtwZ4pAxuwKeYYk+2cIWt+pPvNdaKGzZUuwPcfC93J/Vg+
	dwiZpr+LjdAquuOaScfNrv/FSEX6UFqQ2Yui+Oir1kEoUxpEdNv31e/e3/o18Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792405307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gLGTyZVae2UoxIdOnGHqtMC2VcU6jvzG6cGMRiNPqg=;
	b=bkFSWblRRD9jAm/ia6ooniECkY6l5ntZN/2h6vHvtpO5vol1oVpvCpabbEd/bo1TBYz22z
	IohVc9tLKDwAoNgFOgvqmxM43mqJj29ELaqs5x5xhOMGSCgXAdV3zMg064oiRh3wGJGbdw
	fWLYKdPagpJHzKGHU4RzCCanAt1D6a8ka+Td3rADPlz5ejZQo3bCJCi5U1mHCS1APQ9odJ
	C5pc68iq+PsaCUOLemhsMDa7CocDY8JGWM94fMQ33UxWRDYewcU+VMRzp1reyJJSP/GyWw
	uQjEkLAXyYblKsSXE1PJHLMHGNHyoWY4kFld99bd+NCchMposw7f6ratYLeDEA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIkV1-000D3H-1M;
	Mon, 19 Oct 2026 12:21:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 15AA15C8610;
	Mon, 19 Oct 2026 10:21:47 +0000 (UTC)
Date: Mon, 19 Oct 2026 12:21:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Message-ID: <20261019-fantastic-beaver-of-action-e065bb-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
 <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
 <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>
 <20261017-weightless-poetic-mayfly-bbdf75-mkl@pengutronix.de>
 <4a9e32a8-8a2e-4b70-8057-2d51e6d38b98@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zb6jkvi7dmft3zzc"
Content-Disposition: inline
In-Reply-To: <4a9e32a8-8a2e-4b70-8057-2d51e6d38b98@tuxon.dev>


--zb6jkvi7dmft3zzc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
MIME-Version: 1.0

On 19.10.2026 12:58:24, claudiu beznea wrote:
> Hi, Mark,
>
> On 10/17/26 23:01, Marc Kleine-Budde wrote:
> > > > >    /* Helper functions */
> > > > > @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platfo=
rm_device *pdev)
> > > > >    	 */
> > > > >    	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> > > > >    	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =
=3D=3D 0)) {
> > > >               ^^^^^^^^^^^^^^^^^^^^^
> > > >
> > > > As sashiko.dev [1] pointed out here's no check for -EPROBE_DEFER.
> > > This looks to me a pre-existing issue.
> > >
> > > The newly added support does:
> > >
> > > fcan_freq =3D clk_get_rate(gpriv->clkp);
> > >
> > > At the time this is executed the clkp was already checked against any=
 errors
> >                                     ^^^^
> > > (above) including -EPROBE_DEFER.
> > It's not about "clkp".
> >
> > What's missing is, that "gpriv->can_clk" is checked against IS_ERR():
> >
> > > > >    	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> > > > >    	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =
=3D=3D 0)) {
> > but if it's a -EPROBE_DEFER, IS_ERR() returns true. I think in this case
> > you want to return with dev_err_probe().
> >
> > There's also a difference between "can_clk" not found (e.g. not
> > configured in DT), and there was a problem with "can_clk". I don't know
> > if this is important for this driver, but if you want to distinguish
> > between those, you can use devm_clk_get_optional(). I will return NULL
> > if the clock is not found, -EPROBE_DEFER if not available yet, the clock
> > or, in case of an error -errno.
> >
> > Thinking about it: if "can_clk" is not available, I would consider it
> > intentional, so the driver should use the other clock. If the clock has
> > an error, the driver should not fallback to a probably untested clock
> > configuration.
>
>         /* fCAN clock: Pick External clock. If not available fallback to
>          * CANFD clock
>          */
>         gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>         if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=
=3D 0)) {
>
> Based on the comment on this code "If not available fallback to CANFD clo=
ck"
> I think the intention with IS_ERR() is to allow probing go forward, falli=
ng
> back to CANFD clock, in case of any error of devm_clk_get().

=46rom my point of view it's not consistent to continue probing if the
"can_clk" has been configured in the DT, and it fails for some reason.

> The device trees that I've checked sets the can_clk to a fixed clock with
> rate =3D 0 or have the clock provided directly by the SoC clock
> provider.

Using a clock rate of 0 to signal something to the driver sounds like a
hack to me :)

> I
> think the intention with IS_ERR() was not only for -ENOENT but for any ot=
her
> kind of errors. We can return in case of -EPROBE_DEFER, to ensure the
> expected clock is used, when it's available and sane.
>
> I'll switch to something like:
>
>  gpriv->can_clk =3D devm_clk_get(&pdev->dev, "can_clk");
> +if (ERR_PTR(gpriv->can_clk) =3D=3D -EPROBE_DEFER)
> +	return dev_err_ptr(dev, ...);
>
> The devm_clk_get_optional() would involve changing more lines:



> -       gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> -       if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=
=3D 0)) {
> +       gpriv->can_clk =3D devm_clk_get_optional(dev, "can_clk");
> +       if (ERR_PTR(gpriv->can_clk) =3D=3D -EPROBE_DEFER)
> +               return dev_err_probe(dev, -EPROBE_DEFER, "cannot get can_=
clk");
> +
> +       if (IS_ERR_OR_NULL(gpriv->can_clk) || (clk_get_rate(gpriv->can_cl=
k) =3D=3D 0)) {
>                 gpriv->can_clk =3D devm_clk_get(dev, "canfd");
>                 if (IS_ERR(gpriv->can_clk))
>                         return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
>
> Please let me know otherwise.

I was thinking of not ignoring errors:

       gpriv->can_clk =3D devm_clk_get_optional(dev, "can_clk");
       if (ERR_PTR(gpriv->can_clk))
               return dev_err_probe(dev, ERR_PTR(gpriv->can_clk), "cannot g=
et can_clk");

       if (!gpriv->can_clk || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {

If you plan to keep the current logic and always fall back to "canfd",
please:
- add -EPROBE_DEFER handling
- add a comment that all other errors result in fallback to "canfd" clock
- add a comment that a "can_clk" rate of "0" means don't use the clock

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zb6jkvi7dmft3zzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatXvOAAKCRDMOmT6rpmt
0vIjAQDCdKOia/1Z2wcV8Hyu9YLCFuKeIpWcjdfxHAiHwjy3AQEAkQe4TbjPGsBw
IBsZGeflQTA6q6c9qVsQRViPf33qAgA=
=W+FB
-----END PGP SIGNATURE-----

--zb6jkvi7dmft3zzc--
