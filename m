Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30264AA598;
	Wed,  7 Oct 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379552; cv=pass; b=JCG/X6d7SStFO52yrVKO5G57T17knN3Ki7D9gWCN6tCuSJDTfDtDVeC0v9EtNQ6cvayuYc94hqRyifb48pPPmPJWFX2KGn3KYPbsvfs0XPtO7bYMU9ZMOWQmJrHanlT9NdYHTrnQfxG65mnwUG1DU+6PtyiE7C2v030v74NGCP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379552; c=relaxed/simple;
	bh=LKaBawnOrn5fMkx9UKu815xxeUdtkS2sVALgatYC15o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppc8kMHKVuIFvAPv6UtAI/FOF7d2Mj/u9Mz5EyEXLZ5/J6rNqj2P8GwjFSJdCMFZDf2SsJKsmRa0hS1DLNVX/454LHIV37W0w45LXbvT6TrO08QGBMIEtEVe91USyH/E04wibMX1j5j3CcR3BZH0IJGQW4H3/H3fu4EIYSx1F3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OZfAAxjU; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OZfAAxjU"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9BAA320238F;
	Wed, 07 Oct 2026 15:25:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791379534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CASj4ghHAeR3XLISvynRB2j1qVq65D/wFBbPtv5sijU=;
	b=OZfAAxjUvgErVftMdhkzExrL9jadJU16C7WP5vSdhQhvFJwNw2SOsXdD/LgHEjjmw0bWRe
	/LUzIuFVYPyDqy0CIoP6A9rBVYqyrOeMNmigAFEA1rVTRCwmxRVGAH9srGNrd4amaco2Zx
	79wuOiBdfe4fe19AwYnaSUXU6KnupraWzO6h/wS2ypZDmli+L4QAb3f44cUdJS5VIA7E2z
	VTBkyOVck3oTHq4asHn/ibgCeHbdRR4yTp4SliZk/4XVDNic2K91X5DJksIzHPV9oLBkv4
	2xLUfUI67igrYxXdGeYhhQegiFmao9NAABX23IisD3LaXBev9VYarGJTt0htdw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791379534; a=rsa-sha256;
	cv=none;
	b=eWox0GVB9RwnNAn/PjKkjiQyINYMl1Tobc3Jf2p1NXiKW6N12JECIHwyU26o9fCf5B1yku
	Al6WngNYm1FJ1czj+WysHfe/5bcIgGTlYhC973mNkFR/BcuQzbjYyhYt/9v4ccUJwcm7zQ
	q4scy1aoQRTLuxOtSqsB7hjRNpCUVJ4o9iMGABIVNNExDMrISMuH3qHKjoEWfQdRnkQC+t
	fTBJfAKiCqKyLv1veDZwn0QQUQKdDUnNpd2++lAbH3+FgKXgixZyDRZiKWhxh4s6L7koG9
	0cxRM5bSIaJE/rmfgYPcjBWpNplTfh3s8rr3R4H9Z902SCpT06cm/BnbH4ittA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791379534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CASj4ghHAeR3XLISvynRB2j1qVq65D/wFBbPtv5sijU=;
	b=I52Oe3aIFsff3/E15M3I1dzutmc32I7E9LV8sLSDSzR3iHhGFO5wyG59wQyg97raAVSO67
	+aM508UM9j1rAapbylrZppgqV8Rq8Hn2dpnPOF2h0RK38tCO66fSIu7ZUn8dQkkcOAMtHp
	jAHrvd1us3DCuwWGBP06lEgiEJSAwZZMXoy2ebu+HHtD4/5QX+uETH79lRaPZMy76WM2g8
	F7usGMvfWg/UJS+FVFh1rfjW8mybsHi+/UetTBcgSNe5Rn0eMityXaEO8mSUEVxtwGN14F
	fbwQFtZ8io/owSQpd29X+TYfD2Iymj9xHR3Y3Xf6oJ+A/64DT3eDnp7+H8ROFg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xEReI-004iwW-1j;
	Wed, 07 Oct 2026 15:25:34 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1D17C5BBAD6;
	Wed, 07 Oct 2026 13:25:34 +0000 (UTC)
Date: Wed, 7 Oct 2026 15:25:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: mailhol@kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, s grosjean <s.grosjean@peak-system.fr>, 
	kuba@kernel.org
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
Message-ID: <20261007-deft-mustard-kingfisher-9000d0-mkl@pengutronix.de>
References: <20261005-ancient-viper-of-swiftness-c884c3-mkl@pengutronix.de>
 <597196165.930416749.1791299468914.JavaMail.root@zimbra65-e11.priv.proxad.net>
 <20261007-nostalgic-wapiti-of-fascination-ee80b0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="juxu7vhqzmuumzv6"
Content-Disposition: inline
In-Reply-To: <20261007-nostalgic-wapiti-of-fascination-ee80b0-mkl@pengutronix.de>


--juxu7vhqzmuumzv6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
MIME-Version: 1.0

On 07.10.2026 14:55:58, Marc Kleine-Budde wrote:
> I think this is the best way to move forward! As these issues are found
> by bots, the current consensus is to mainline them via net-next. I think
> you should add a Fixes tag. I'm not sure if we should add stable on Cc.
> For now try without and let's see what the humans and the bots say to
> this approach. :)

What do you think about registering yourself and maybe role address at
Peak (e.g.: socketcan@peak-system.fr) in the MAINTAINERS file? This way
you get access to a database with all issues sashiko found in your
subsystem.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--juxu7vhqzmuumzv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasZISwAKCRDMOmT6rpmt
0hdsAP4jBprP/4J/4cyqG/b+uohyvCEYUOcr9wAukTZ7iFPMCwEA23Nybg0lyIUb
zFk4cp0wLLlunaF2UbpAYXdyjd2Euww=
=1A3P
-----END PGP SIGNATURE-----

--juxu7vhqzmuumzv6--
