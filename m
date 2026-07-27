Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF453E6DEB;
	Mon, 27 Jul 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147743; cv=none; b=RHyj1DIFN/9CyIWKRoOlqCAgcw6ruRFHpyywfZmYbnp7y0clQ7qVOV9DNFKFb9I6gZzBq2mgD2uCPPwMgpt8OwCxx9mmK8CusoOrQer8VapinutdNLVw+K9dKyH7BZW7e+kvtG5zJnDOPFyjqA5mShYi7B06keHKzl1NV6Tqro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147743; c=relaxed/simple;
	bh=VbjEC9cIOgyaD1FD8mtlU/MuFMqd4z2trmz72xWQ1C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv+Z5LCDkOw2caBbsvS/Z7V64wfiBa3kW3Vezb7paJzYgIbhh1DRoqj22NDI33aD0rvABglVx9BVdvNK1iDb8gmh99eVlgpEKdxMV6+jHmCEfG/QOB71AYLCnbNtYsIEVi+Bl4WCoz3Y+D91feKqkd6Ph1CQ/tuVV94L+w0cVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5D4CA2010E2;
	Mon, 27 Jul 2026 12:22:18 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1woITS-001WiB-0u;
	Mon, 27 Jul 2026 12:22:18 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8D4B8574258;
	Mon, 27 Jul 2026 10:06:37 +0000 (UTC)
Date: Mon, 27 Jul 2026 12:06:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
Message-ID: <20260727-merciful-unstoppable-pigeon-4286de-mkl@pengutronix.de>
References: <20260727094900.1214157-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ug2k6q7cakif7qli"
Content-Disposition: inline
In-Reply-To: <20260727094900.1214157-1-sean@geanix.com>


--ug2k6q7cakif7qli
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
MIME-Version: 1.0

On 27.07.2026 11:48:59, Sean Nyekjaer wrote:
> Put the tcan4x5x transceiver into sleep mode when the driver is

Ah, the device has an internal transceiver.

> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
>
> Note that the reset pin is needed to bring the device out of sleep
> and back into standby mode again.

Please add a comment, that the reset pin is needed and maybe refer to
"8.4.3 Sleep Mode" of https://www.ti.com/lit/gpn/tcan4550

Does it still work, if you move the regmap_update_bits() to
tcan4x5x_power_enable()?

> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> I havn't come across any drivers that leaves the devices in the lowest
> power mode when unbinded. But we need this to enter our lowest power
> mode in suspend.
> If it doesn't fit in, I'm happy to carry this out of tree...

The mcp251xfd driver puts the device into sleep mode.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ug2k6q7cakif7qli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamctqQAKCRDMOmT6rpmt
0jaWAQDBYRFintTueqsVK/UF4xNRS11PDNKNfJJWBGTYFIpxJAD/Q4wh9VAaXgk2
nRE14j0VSB022raMfgGMoklVhbUX9ww=
=AiFj
-----END PGP SIGNATURE-----

--ug2k6q7cakif7qli--
