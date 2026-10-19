Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9803415B6A;
	Mon, 19 Oct 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406539; cv=pass; b=rq/w7rDqHbGYwuvrdZem8oSAdlWI7HvPeiUo8VVjU/efWgSzSAo8NRyy2Bb5WOndpHOO92bVQOcZKrFhJQ9N/QGtyNsZj5reErI+hR1pZJD9c5Ez8VdOg6MbstWlvElFfCQXe31vSzGMk2NU5vTRIESl13ssCA8EUT0fPeHN5sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406539; c=relaxed/simple;
	bh=r2txO8LwL6B4kIrW/JjS2jabOqNO3iK88Vhg01OQoR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiVpWPa/7/zeOSYiV5fvXf/4W1vejOpyTntEgx9LKI8mPWZ5b9ovc91+7Bl7dzUtA7MMN4HaVeWW7gLkQEL0X0jk3VdG8DoayMzQNkYzNrRcBHE6ZTYl22hGOLBx3jYIAmWxGQVCIq7ekpB8VcqeV+Fwi1nY0eoXB/ehvzFev68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=hJj0Vwk7; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="hJj0Vwk7"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BCB97201F3E;
	Mon, 19 Oct 2026 12:42:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792406534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjFBzs55SxEI4PMHLNNqH1UBL55RCKxE/w+9WxhyCrw=;
	b=hJj0Vwk7MitnVdosvO2sXXagBkU91W3h5V0zRQ79SwPhJcKPi2qStwAaUef7uBDUdbeFWR
	tlwZUDaCu18O0GSZuoA6mLGCy6gs2xq0aK1hFe/rS4mHgBJSnuoHAAReq8tuRkswqLR5K3
	8sQsCSjbqGUyFoJmG9Sac9V92fYtSqFFHIxKH33XYQFWdqukb3PZKf4rDVRoCTFw2Y1xQX
	NxYGgI/xAClFDsfQGLSi6LO4VlVlZ7noJxnq9kzp02CGWHKa0nsnLt/yTrs2fCffPCYxbq
	+r5DoTBWzUCjfg5+P8akv09uIFdJ9WkGugyNuD02vEAiMQn4HHjRsQNJon5wTg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792406534; a=rsa-sha256;
	cv=none;
	b=KD/bJClXPAqhkN/lQoRZpIqV+MveAwnEWopB2jy4OJlP55CCKLUYvHgOU+AU5bhGwM2RJz
	CeZMvPz1q5mjWKUcR6lvViuA67d/3oMuK7gMSqppwKqA/G7OwPvbT/MlAp9x+2ccAsdliw
	9yJtMpkLyxxROCrCo6EutVtF+0lMwsxZXjq0QQ7Bt2wC8U2NnnASdnWtxjWcgLOGfl28Cq
	dM2fw8AJAd9knxweYHDnec00OvXm2OBYvw3FQ2BntvLb8/Jt7iwRbj72pjAGXxzNEsruDy
	MT2xmFroLmLimDWWuZtxdrSp+lC0G1cv1nh3CIYFvqv5R8jL8w8Iv6wNOTcPlA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792406534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjFBzs55SxEI4PMHLNNqH1UBL55RCKxE/w+9WxhyCrw=;
	b=YqQ41J4+S1ndOb/LpTRF2GG80JHMIlF0MI3OzSLAm5WH5UFmLqe8UNrIQWwJ5XI/dkxQVN
	7tUqFoenlTP73dZhz+iaLesu6Fd2flJ9OwDt/UytCWN8GuSp9yDayh5JOj3+sowFnsnXCd
	GSxZtGgSjmpuaGv3nintRyQaLdaIeG0GOkHUiBUM3XjRKgEe7zkMku7am7JEZTU3Xmvd0W
	EuBYRetMfoDYG0ifGyAq+AJknE+dkfQf30QnrosOxQDlqhgbGdibTw0cENE33Qgs4AplBk
	7UrLPNDouNdOssYQIi4cHZPF7ZCwZOc7QCCUHPF+pdxWqfztD3UW2ZCtX/YwvQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIkoo-000D8b-24;
	Mon, 19 Oct 2026 12:42:14 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 51A785C8F04;
	Mon, 19 Oct 2026 10:42:14 +0000 (UTC)
Date: Mon, 19 Oct 2026 12:42:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Message-ID: <20261019-precise-auburn-bison-8b0d0a-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-4-claudiu.beznea+renesas@tuxon.dev>
 <20261016-durable-meticulous-owl-7a9eed-mkl@pengutronix.de>
 <69826962-0c21-4616-9cd8-6eb0478a422b@tuxon.dev>
 <20261017-weightless-poetic-mayfly-bbdf75-mkl@pengutronix.de>
 <4a9e32a8-8a2e-4b70-8057-2d51e6d38b98@tuxon.dev>
 <69f0c77d-8c23-4949-bbb3-0a07da506b7a@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxuy43c4eewdhgv5"
Content-Disposition: inline
In-Reply-To: <69f0c77d-8c23-4949-bbb3-0a07da506b7a@tuxon.dev>


--zxuy43c4eewdhgv5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/7] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
MIME-Version: 1.0

On 19.10.2026 13:36:49, claudiu beznea wrote:
> > Based on the comment on this code "If not available fallback to CANFD c=
lock"
> > I think the intention with IS_ERR() is to allow probing go forward,
> > falling back to CANFD clock, in case of any error of devm_clk_get().
> >
> > The device trees that I've checked sets the can_clk to a fixed clock
> > with rate =3D 0 or have the clock provided directly by the SoC clock
> > provider. I think the intention with IS_ERR() was not only for -ENOENT
> > but for any other kind of errors. We can return in case of
> > -EPROBE_DEFER, to ensure the expected clock is used, when it's available
> > and sane.
> >
> > I'll switch to something like:
> >
> >  =C2=A0gpriv->can_clk =3D devm_clk_get(&pdev->dev, "can_clk");
> > +if (ERR_PTR(gpriv->can_clk) =3D=3D -EPROBE_DEFER)
> > +=C2=A0=C2=A0=C2=A0 return dev_err_ptr(dev, ...);
>
> On the other hand, returning -EPROBE_DEFER here means the driver may never
> probe if the can_clk provider fails to probe, even though the fallback cl=
ock
> is available. That would go against what I understand to be the intent of
> the IS_ERR() check: letting the probe continue when can_clk can't be
> obtained.
>
> Please let me know how you would like me to proceed.

If the clock continuously fails with the error -EPROBE_DEFER, your
=2Econfig/DT/system is broken. I don't think it's a good idea to ignore
these errors.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zxuy43c4eewdhgv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatX0AgAKCRDMOmT6rpmt
0gJ9AP41dKtMW7cUCCiHJonGpGvq7Jc8qJ/nsOySLUTxctUFbwD/ZirMVU+4uAVI
jeVcdjNv83Tw0I65tcTz/VUU9aLUqQs=
=y0Zq
-----END PGP SIGNATURE-----

--zxuy43c4eewdhgv5--
