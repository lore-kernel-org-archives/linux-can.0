Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821624;
	b=GOou5gy/JnFzyNvgAXkovhotcEZL40QeZccsHMfnfZjvNmQhIQFcH966NvxIPOLsX9bw
	 yw7EPWqgS5Kp9eGD5XFOZU858XHThhNvCOxRPNxu/1VFZx9W2AWqNBOzwQeBNEBXkSRji
	 oTAVgL2xQSiUA+ebazevs7NDjseJuhK5tLQ6Ueq6H13HALvXDt6LTvyuDMylRtvwoMIMX
	 EGgziRGHaObp9NYZBsJyNTcXZQeFAhHjcU7SEohuZKJ+6OEI9Jn1tcRSQNvKKqCnyqtWJ
	 O/mYqBsesEdNyOudiePt4SukKwjA9qG7pIcB+Z2FKJhfsMt1/zFY92qk0fi1SmYumLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6z5OhMnFuS1UaIav28i+20EyR8KiBd5DxaM0Def0+7c=;
	b=sEF0RServcCc8fxi8onR0wPkpoSSjJUY+kw4HUB/qDylYL/4xoLtX6JngbiN1iSZvisc
	 P0huEtFznaZ+cK1uBYRhsgvm+UH9bw66YXxmXdxMs/FcNmL1FbJHWTPgxD35WCmVDPUZz
	 wDo0Z1FMeS6GbpINSbSI8eSgoloH6PIJaPwdUuEQ1sNCkMsoXhWk+oFW9/QlyDgFbxcbP
	 xl1FXHSm7kjsvH3gbsvmNTo+6yeqSpwU2iAHKLGSDHuj/Yq9N8Hl+KxSJbj/CyapMKD7k
	 Iji0f4xEnzZdxaRFE3GvAxu/22VFSWxZm47QZmiqyikEgZepfU/DHqc584kncrJYHgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eHqtYwFd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE1606A330
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 09:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DFE1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eHqtYwFd
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D03D420011E;
	Mon, 16 Nov 2026 10:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794821621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z5OhMnFuS1UaIav28i+20EyR8KiBd5DxaM0Def0+7c=;
	b=eHqtYwFd+eRX5YkA2wWySobxp6lGDz8k/RNKtX2tmR3RL+hS3XCyX6ABoaPyBkRxPaD1Er
	VKJ+EJW5zCUkjA7OCBMN+UG1jW/CnI8kUgwE2DnKw0AIUazlPqR+cThVRy2lwDci4DdHr3
	dN3nt0VpmHksk+3XZFOhKvsbBB+nM8VVGrXBscgz3gBeJkChdstzbaZshwCHceFYLWZxCE
	731JOGBHfdS6+hRV6uKyE8YXV26t7P/rqDztadxDMf6JXn07WEybJR88MoN0WhZHVRBgRm
	aZCcma9yem6OXECHFvLO18MfotRGhbEqNAHairyvOCOmR8/VJdXLg6WQ/yCCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794821621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z5OhMnFuS1UaIav28i+20EyR8KiBd5DxaM0Def0+7c=;
	b=avoc8FjSPA0Wn3QOcZIOpPw2hmqlrU+02CQ72OkmvIMOPiITLMMGVTGdPy18ZZ49bytEUH
	3dX24sIrEc5LpEmW5wnPOcNRLNZ3C+AdxRlIV78fdKnlnexIGDjudVEx+/LV8WhcM8XCOo
	MGFaeUBgAEr8h22q/oPrbLqK2WAGEqfwCdXMw2Pdj3/7cvlsz+wtcWilMOEdF/gkTxYRf5
	Pmg+8omSCNYs7ldGFgc4RsmrQfazYwD1Ei9qGleMiA04dPo78A2UBpfPB10Y9OtpvrO+bz
	YiT6PTpf/yOrKc6iUsh7BDVBaOYKuo2Mfvf0CPTjQ/Bk3Y1uWs69LL4bUw/3VQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794821621; a=rsa-sha256;
	cv=none;
	b=d0mb8ALWW6khZKo0YSgEyXg/TnzzJm66zVlrxV2MUTMoa6XtuTZPB76+0l+o2UfH3DtMZx
	oiCZRyPlAesY7/grk4aaesd424Pjy+dEoLVOSAnN5HF1sbBBsw66XcRGI9HrdJKiEDnlsg
	x11SlScJWUmSUb4/GycGu5bBu60vCmaT0WyCn3wG4avfJmVSxB8wcsLCwtieaXxvfikYsc
	Nl0qT67OZCG+3xw9ADmBJl6FS7BcdlKSoN3orC5c8rMgWAnkCm3G7AkRc1+ZEoyeIkW4Tu
	w8gK5XXwv+r6B+zwKhKtC6bdAKY6e/efLDnE7h+6qa32PpsFs52TVSsZt9gk8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSt5p-0001A8-0j;
	Mon, 16 Nov 2026 10:33:41 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 71BA75ED18D;
	Mon, 16 Nov 2026 09:33:41 +0000 (UTC)
Date: Mon, 16 Nov 2026 10:33:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
Message-ID: <20261116-innocent-capybara-of-tranquility-8ce8ff-mkl@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-1-2d82025e9646@pengutronix.de>
 <sashiko-outbox-214574@kernel.org>
 <avrJ54bCPy5K1QcJ@monoceros>
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
	protocol="application/pgp-signature"; boundary="pwxewz23fzdgwxfw"
Content-Disposition: inline
In-Reply-To: <avrJ54bCPy5K1QcJ@monoceros>


--pwxewz23fzdgwxfw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
MIME-Version: 1.0

On 16.11.2026 10:23:02, Uwe Kleine-K=C3=B6nig wrote:
> On Sat, Nov 14, 2026 at 01:33:34PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [Medium] can: c_can: c_can_plat_probe() rejects c_can_id_table matches
> >   with -ENODEV
> > --
> >
> > commit e910ae3e03adb41c30f60d29d9b4c11824109fe5
> > Author: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > can: c_can: c_can_plat_probe(): reject devices without match data
> >
> > This commit rejects devices in c_can_plat_probe() when
> > device_get_match_data() returns NULL.
> >
> > > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can=
/c_can/c_can_platform.c
> > > index 75607b1afd2e9..b6012cd713cee 100644
> > > --- a/drivers/net/can/c_can/c_can_platform.c
> > > +++ b/drivers/net/can/c_can/c_can_platform.c
> > > @@ -266,6 +266,8 @@ static int c_can_plat_probe(struct platform_devic=
e *pdev)
> > >  	struct device_node *np =3D pdev->dev.of_node;
> > >
> > >  	drvdata =3D device_get_match_data(&pdev->dev);
> > > +	if (!drvdata)
> > > +		return -ENODEV;
> >
> > [Severity: Medium]
> > Does this reject non-fwnode platform devices matched via c_can_id_table?
>
> It does, however there are none of these since commit 17b6e0280f31
> ("ARM: OMAP2+: Drop legacy platform data for am3 and am4 dcan") from
> 2019. So a useful followup cleanup is to drop c_can_id_table[].
>
> For now I suggest to mention that in the commit log. (Though if there
> was such a device, the patch would make the probe function return
> -ENODEV instead of dying with a null-pointer exception, so it doesn't
> break anything that worked before.)

I'll drop this patch and remove the id_table from the driver instead.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pwxewz23fzdgwxfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavrN8QAKCRDMOmT6rpmt
0nXPAPirHYs/SIrRvicqronV2ZpJSYM0C42D894Gs/My61xOAQCSYpQCgDC/rkTc
ZXvxUIXYNzt9iglEZYzEVPAEihZsAw==
=coew
-----END PGP SIGNATURE-----

--pwxewz23fzdgwxfw--
