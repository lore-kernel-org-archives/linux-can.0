Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A563BD252
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145213; cv=none; b=OapYVUrm8sg+oe5IO6G+KMzZGRXZRPIMuGCZyNtT55HxjokSGYmY/tUREYtkRcDyggUZHTrB6SxAvVsVZR+x2x2T3EFU2AfS6FPas2c6xDx4pHesVfS9O345SW5j1hqC+cimZ6e+bxHqUODDCxVFuJpthPMdnV531KpHk9FU1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145213; c=relaxed/simple;
	bh=cO/Q9QE3gJ7kFAodiazkd5TVyF6moDP8XZ0YuA3VVoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQySF20d2kPrloHMqxU7p7K4DjAFiOfzQseXcTWyfuOg4TX+dI/lSIPnPS3oyfgG2ditqycPc5bDYhlbWQ40VGADqE+boBXHwUoZTXIqMT8UDYsgqwP68DTGv/gIoVrCuiiT6RflxOcgkgSSr9vqIjuS8W1iZSqQJiZgm+pLaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzw4E-0001zF-38; Tue, 10 Mar 2026 13:20:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzw4B-004h7M-2w;
	Tue, 10 Mar 2026 13:20:05 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F31994FD4CB;
	Tue, 10 Mar 2026 12:20:04 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:20:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] can: rcar_can: Convert to FIELD_MODIFY()
Message-ID: <20260310-magnetic-cuckoo-of-emphasis-608eef-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <ee2e6aaacd5e061c972716ecaf8a929be7ef5f2e.1772705647.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gfvgmbjzx7mqevv5"
Content-Disposition: inline
In-Reply-To: <ee2e6aaacd5e061c972716ecaf8a929be7ef5f2e.1772705647.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gfvgmbjzx7mqevv5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_can: Convert to FIELD_MODIFY()
MIME-Version: 1.0

On 05.03.2026 11:14:37, Geert Uytterhoeven wrote:
> Use the FIELD_MODIFY() helper instead of open-coding the same operation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gfvgmbjzx7mqevv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabAMcgAKCRDMOmT6rpmt
0nq4APjuEWbwqTShPwvqA98gsQ3QJfIbajRnidIKMVuhu+LbAQDX51VOvUt/fHmO
zdMpFtQIWyselfQtIoP24+IACcNYAw==
=vvWP
-----END PGP SIGNATURE-----

--gfvgmbjzx7mqevv5--
