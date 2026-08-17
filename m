Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7739EF05;
	Mon, 17 Aug 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985957; cv=none; b=QkZA1RAlbh7NVMiPAdKXmBXsmHcbk81W92DBQWRxaP+9Wy95212bogH38WdFfTzltOtOYqavWrJ73dat8tR0Z0MaaD3ke+JlX+vFY4VBoA3ZxH0Jr6aGyqHeVpyubjn7OIb605a984l71Hc9sgRphs8q4h9lm2ntm53slqmpJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985957; c=relaxed/simple;
	bh=v3znBcnWZS9ZdOO9gQ8LP4UTTT5x8wBVI5adKyp2OhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSbmgeZz0ssNIM9swsgoJQIQU1vp3mdXhDwV0uVDay+GPKN4fxuM90QTA+/8uIjNnF69IOTCrrXoMe9mYELFZhFzjD8O6p0hHT4udgt7ETjBdkqcKjDBMGiVFEv9FXc6pvE63dzVR8CztmD4UNAG9DF941tEzAYouDGWcwn+XjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B51AD2009FB;
	Mon, 17 Aug 2026 18:59:07 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww0fz-001zD9-24;
	Mon, 17 Aug 2026 18:59:07 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4A599584EB0;
	Mon, 17 Aug 2026 16:59:07 +0000 (UTC)
Date: Mon, 17 Aug 2026 18:59:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Message-ID: <20260817-tricky-monkey-of-admiration-3caebf-mkl@pengutronix.de>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <7533fcaa-c676-48f4-924e-bba9195d4871@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rj4diajalgdch7zj"
Content-Disposition: inline
In-Reply-To: <7533fcaa-c676-48f4-924e-bba9195d4871@tuxon.dev>


--rj4diajalgdch7zj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
MIME-Version: 1.0

On 10.08.2026 16:00:16, Claudiu Beznea wrote:
> Gentle ping on this series.

Who takes the DT changes?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rj4diajalgdch7zj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoM92AAKCRDMOmT6rpmt
0lK7AP9+oMyj6ytfdM7z67yrn9wesk0ufamxJGMDNGikBzwafAD+O+VfZ1iehxlN
oS9IMQQ4PpRSF1EcIwYkk7FOReUh3AA=
=Bil9
-----END PGP SIGNATURE-----

--rj4diajalgdch7zj--
