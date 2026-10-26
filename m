Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017905;
	b=3GAZOoN1GvVOxyEXLPit1xxxWOA61y550a+wsmY/aoTjuyQbyPMtm2YhK+QBLU7I4uuU
	 GM54EpiDpXW4hBQt4D4/bO1LeUsubB0DG2QkaD+z4mjkKS+WhTwt20Cucuq2Dp3ILvlGw
	 3ImoWSzDDpMLpztbKPhEcTKCrHH87y/4AEL4JO5Qj1Gj877+lOzs19dWWHxeXE+7RyQzk
	 pduHuZv1Kmbrn0tUok6X7JHq9h+YTQHzL0+lL80fKMMvREHTr7+gSSR15Sm5zVRTzmYJH
	 jveTf2E/ZNks7smDv3bE+K/eCoG1VVcrP7JbwFwaxbmR47UjI2zEXPHpOCvvjJ1PeqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7DUMER6uCtX5xCptokPQoGxMU5xElCP0ac6vFNZbgDE=;
	b=PHOJeoHDkVBFdbDWf07um50VZVeR3aCjBFisRW/J1mhcIvUvsy5ZRraX8mh1nuQ4G0sG
	 ujXig6zJNo79Yih1o5A0tSfAC0r48plcglVGIab1M0vEYJd72bUbMKUIujJmm5UmaiHTv
	 fY/boGjpJfkfkFF4c+DLdmRk9ceL45NS481B8kcd0MFrbVpezHA3uO4Sfrh7nlnTWimrn
	 3THhwUDsoWHgDZ2ikgSiRLWdDlmuPW0dvkcwMczHG5forZTlv9gbOUtSaru2xZSYrHZ+q
	 5e1TyVaKPH0K1To9aUmRyZdNtyJNgOwc3aL0CowamJiPLxoWtXhV9nyT/u368vIj3WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZogP5Wv3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB061606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 12:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB061606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZogP5Wv3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 54E1D200AD1;
	Mon, 26 Oct 2026 13:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793017896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DUMER6uCtX5xCptokPQoGxMU5xElCP0ac6vFNZbgDE=;
	b=ZogP5Wv3LV+t02Uq8gB9yDt1ymOwDMlMJ1SJUIIr6U0+QrRrZ33SJfdJrso9AsJUOUAM8w
	hl4PzwtN0i/J6DEpZGKYUgdNcJIiv9EsS7iAvpfazHP3zkOtm30mH1uUqxLluvMxrHl7Gk
	98+ahmjws2VLIOaZ+st35uoLiiHxGLjP3OoMUj8udNseACJNJQLr5NnUbL5pTAtMSdhPSP
	aFJDX/og+RvssuN07VLh3K5IT+9sbCSapblKVTwFIpb0yV3Zdohy/1jnxYBDam+yZ7oKy7
	jMgUx/aOuXvxDcCouNyfqoPGtOcqliaHPawX0my2g8W3Qe7/OKhwrZKml3bOIg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793017896; a=rsa-sha256;
	cv=none;
	b=UgUvPY+pPcglL+PmrDo8a4KLT3pBRT3abuCLDKPB7T1NCYdGuI7H0eQaYlfZRRkgGX3Wm5
	Vo9eSJiGDMg/a2hCYgE7T12RMKmanlh9jNgwLicmbNizwnwmPhXKjCpBjRaAaGshc5+Oof
	RZgmsW0M0vgJvrI12wxAq2MtSak2EKMV6yEJZJroVtou4JTHIzkKn7opDcAPdQDhNFLrjo
	ioMkqUUqb77nc83ZSzZrgzHr7waRDJq4aLz1Z2I/xv4PfEgrrtoIQA+Knq7x0GBPYhlihD
	Z7NDal4Bi6RbVtWM99KmCBFvQnaOQdn/orDiQt2RyFNBrAlgilQsMk81vGX2YQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793017896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DUMER6uCtX5xCptokPQoGxMU5xElCP0ac6vFNZbgDE=;
	b=Xlxj2WQLb7rsMeFkr7pwmJNx7fA2PtXKX7XJakg4SyBnyD+fp4X7TpkbBeDFInAIodR/na
	JGbFXAyd8ZBvvGLpM7C7LNyw/vNX7i5Wc0PRbVXnhnfn3MBiYd70Yu2gib7Oz+57cKuiy+
	XEiSumMsUdAebE8RPDliiTmagskc+bX4YGi7JByZIWZITdEpifrYSJ3Y/dvOmo9F6i4qZv
	tla9DRuqxMNpZxZCznvLYDQnR7Jfphjl10UIQG0siTIuY33T6/adhNHiwulmmXEienbFc8
	VwrQ983MQgnBI1nn8zJX9OUNzwY1dz4RxvzlDHf390H82Ix97XZdNjJUjm4HRA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLJrU-001HRK-0o;
	Mon, 26 Oct 2026 13:31:36 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D40965D6D8A;
	Mon, 26 Oct 2026 12:31:35 +0000 (UTC)
Date: Mon, 26 Oct 2026 13:31:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261026-masterful-native-loon-48313d-mkl@pengutronix.de>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>
 <20261026-belligerent-labradoodle-of-beauty-b07263-mkl@pengutronix.de>
 <c270fdfd-79b3-4f27-93bf-84d51b48c21a@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="5igsie7wohsdw7cu"
Content-Disposition: inline
In-Reply-To: <c270fdfd-79b3-4f27-93bf-84d51b48c21a@hartkopp.net>


--5igsie7wohsdw7cu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 26.10.2026 13:03:42, Oliver Hartkopp wrote:
> > On the other hand. As Paolo Abeni mentioned this series could go in via
> > net/, it should better be based on "net/main" (without "can: raw: remove
> > redundant NULL check before netdev_hold()"), as that patch will _not_ go
> > into net/main.

> This is really annoying!

yes it is

> What is your plan with all the patches/fixes in linux-can-next/testing th=
en
> when I would re-post my series against net?

I'll take your series first based on net/main and rebase the relevant
fixes from linux-can-next/testing ontop.

> Will they be a follow up to my series then?

Yes

> Or should I post it against your linux-can tree?

Yes, please make it based on linux-can/main or net/main.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5igsie7wohsdw7cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat9IJAAKCRDMOmT6rpmt
0rclAPwKPdj/B0U5pRSGqkIZu2vkKG/WdY8xEjC904PbnBNYCgD9HtHTp+GNv6lm
hZ45jtWeRrinpK058vVu1oSLBlC3Xwo=
=OybJ
-----END PGP SIGNATURE-----

--5igsie7wohsdw7cu--
