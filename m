Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E4403E97
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756462; cv=none; b=U//S1qsijyTzvV0pj3rFGx3r8n256GhmlQKsJvrg/b/Lky+Vs8mfgU11CdS+AqWu6vyq6Q5rG5qm/NKdNTAOgopx1d+QUsddMBvQofOkH8m576BN/fICClj3W5KPFvCVauowafK3EG5cpoBB3pPH6B0AZJUedKQiexcUNP2McxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756462; c=relaxed/simple;
	bh=r9tnq9PzTZkHZtOznj3ItrGIEfkwFnv7F798SZ+/jgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsQXdjkwCAhEh/biv8UzX9WeVLtJGw+E+3mijjocImn27UK1lht77P1c3sUzuZ7Frz2CDyRF2+b1q3eV8zQB2w40yzE22e/NYJSTJaxrgDEeXGTKS07ihVd7gkPabl5stGfKrseOLQ/YqgdSj6oUpROdD32skOhbI+7JKxekTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E30A82006B6;
	Mon, 03 Aug 2026 13:27:37 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wqqpV-002giq-2f;
	Mon, 03 Aug 2026 13:27:37 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 16A0757A452;
	Mon, 03 Aug 2026 11:00:17 +0000 (UTC)
Date: Mon, 3 Aug 2026 13:00:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <20260803-swinging-pistachio-locust-c61cfe-mkl@pengutronix.de>
References: <20260803101927.17122-1-sean@geanix.com>
 <20260803103319.E155A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j72kxxi2ocwydbqk"
Content-Disposition: inline
In-Reply-To: <20260803103319.E155A1F000E9@smtp.kernel.org>


--j72kxxi2ocwydbqk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
MIME-Version: 1.0

On 03.08.2026 10:33:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
[...]
> - [Medium] The transceiver is not explicitly put into sleep mode via
>   SPI during driver removal if it is powered by a regulator, undermining
>   the patch's intended power savings.

Bad Bot! Read the data sheet. The transceiver/PHY is integrated into the
device, so if the regulator powers down the device, the transceiver/PHY
is powered down, too.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j72kxxi2ocwydbqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanB0vAAKCRDMOmT6rpmt
0lM+AQCuhNJ42clWPAzvLZ5ZE4c8px8gVfVFIUalJVi8XSpKYAEAlbhdgRK+xlDp
b5UfPTNQvgddwIHsvpkEbvVqPpie7w0=
=sm6M
-----END PGP SIGNATURE-----

--j72kxxi2ocwydbqk--
