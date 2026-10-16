Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83BA4CE680
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158034; cv=pass; b=J/bQ9pnu+9a8PCke9IpkmIvy+dXxP/ZhiJ4qtPtw1lj9TbaT3EMeXod2VTBl3VmOWiOt1buQtNexnnGHVPIa2J2ss0b1rhvnei2RtJ/o0HP+FkftK27xiJn6bKgS3FkEaGJ2mQfUG1C/kLUhY6HDM60Cvvs2/eZ3qZWJytTru1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158034; c=relaxed/simple;
	bh=zvz7PPBS8UeCok6aPB5jfdWr8odP8fFCu5QvHKVw/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EowyNpXw+qHvErdw1Sq3X0wzgZ/omsAxJhzdUdkBilUUELFj/84MroodjszhtWz6zNN2ep0RuCBDZb8lM6UoFr64UsE0P4KCAtbPF+6yLdYAbwEKZz0TaS6ofgYNCzUNekrDteR2CoYAseXrBd8tXsSAx4/u7jN/LPxQ9QPYKvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=BsqSGqwC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="BsqSGqwC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E9A7020281E;
	Fri, 16 Oct 2026 15:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792158029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ17pEBUlz2IjjV0eLyEMnOI2UjE82rXP39FKzTFEU=;
	b=BsqSGqwCyM5ht7maVTzcF/5Ha5B4/xCDOhdi3HrYubdRrVLABmY340XrMXw+5S7SXlrC0i
	GAEBHWPIjZnzxx9qm/Eqv3CKSRh3TdjLPUlm6NZcatHof+Nww4SK6KeSy0Iu8pG+aLN/dS
	CFJDkNeJ9HCmd4CD0h7V3NUJ7xWPovAkRJkk6VlbaGO6Ky/tU3A5+Llo33bJwLaVDg+CLa
	iff/GDr3c4T110lWkvuF81+aXTs4JlQLYCLltaWDrima44/iNx+WsvNiimD5yG1QE5xIzm
	wgPcziUlj+XCg9qPstJQvrLmFd66ufWXmVvjj3CqQFZbc9juGgv6DYG0kSucAg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792158029; a=rsa-sha256;
	cv=none;
	b=b9vLV0NWIKfbHz1PzPnDnF3CYPWGufbxe+gwv4kDH2P7OauU3yGMI3bZl3jd1rgqeM2716
	ivqk4mMF5V3GM4gey3jbWlDbY9n2/wRhnhqJQYO9eYvSvLOLm9tG0AhdL+kDEuTB3dONQC
	Q6u1uAbf+VPYsP0Zxy5zeeSlXEfPSnwenQLyKCjZ1ufn+JceUjgj40emzRUzDPwNUcEpcD
	FhdhPEMubSxsBS8TWpF/rW9hTaic8syZtQfa9S4cw1bIvmjyNLHwa0R5ZeLEzRNbhacVda
	nzI11pZ0GgoWhICLsiZtC2U+wwGq9uua/bJBLI0xPmhRbQBkUNT5mi/+wwK2jw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792158029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ17pEBUlz2IjjV0eLyEMnOI2UjE82rXP39FKzTFEU=;
	b=ITNbDfrYAfD750S21dwpytQdetnjBecBuA7kHf1PYRRB4ZX3TqYzLKmiW/JzKFE+bJQvD2
	Vtn6EBvcTbuvxJN0ZV2JLJRp/vfw2sZIN3I4kqvJSWAcaJKhwbu8Ev/atn2s/5BYT6j0Di
	0/gmr8vwzEY2Vf2sfycZMr6SqvUfRd+Hjzv5u31Vmt/I/4t1vRd1Jo3w0NPkqr/ePGfk1U
	ZaCegoQbnw0UyaoEmvZbbD0+GwcFYFcSsuTb6IZTNwkkaoPt6JcQjuv+YQ0oSGEXHjZq1x
	2N+Vuo8SeP8jd+oasoLRtq2xOfjVBM5QEZaaBGHjixKd05mPIaZ9wkLIaHYY+Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHiAf-006C3G-2i;
	Fri, 16 Oct 2026 15:40:29 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9B3FD5C6270;
	Fri, 16 Oct 2026 13:40:29 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:40:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
Message-ID: <20261016-delicate-phoenix-of-improvement-716a97-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-16-mkl@pengutronix.de>
 <sashiko-outbox-173569@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tzxsxwbsrez6bkpy"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-173569@kernel.org>


--tzxsxwbsrez6bkpy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
MIME-Version: 1.0

On 16.10.2026 01:54:00, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/r=
car_canfd.c
> > index b7c4fe3477ac5..f9173774387fa 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> [ ... ]
> > @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_dev=
ice *pdev)
> >  	 */
> >  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> >  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)=
) {
> > -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> > -		if (IS_ERR(gpriv->can_clk))
> > -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> > -					     "cannot get canfd clock\n");
> > +		if (info->fcan_pclk) {
> > +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> > +			gpriv->can_clk =3D NULL;
> > +		} else {
> > +			gpriv->can_clk =3D devm_clk_get(dev, "canfd");
>
> [Severity: Medium]
> In rcar_canfd_probe() in drivers/net/can/rcar/rcar_canfd.c, if the can_clk
> provider is not yet probed, devm_clk_get() will return -EPROBE_DEFER. Does
> this check incorrectly catch the probe deferral and route it to the fallb=
ack
> paths instead of propagating it to the driver core?

that's a valid issue

pr-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tzxsxwbsrez6bkpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIpSgAKCRDMOmT6rpmt
0jxOAP40+WjnJGXI4GPuA5Mvl4Du9e7LfGB+2uxog4Yxw5nkIQD+KmqLfoC021Uc
zdhb3R+/anaGvHBMfEhEjUTTmQb6bA8=
=kvkC
-----END PGP SIGNATURE-----

--tzxsxwbsrez6bkpy--
