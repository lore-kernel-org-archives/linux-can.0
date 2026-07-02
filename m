Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07135677B;
	Thu,  2 Jul 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016859; cv=none; b=NT7diMb0RpzL/AnH7zD2T4cNyeMdn4kejvdPJgHoyx9Q2+hTUuSr5TJdiHFnT6MWaDB4qSnuQ7dcbO5VddpdV/o9OR8PY9ymuSDZRedo6CDkb8dzChv2qMtbsMfQEfJwjTiG7qpBA7/td+NoF0w19DknCTFs39ztCqaCNOXJvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016859; c=relaxed/simple;
	bh=DeSCQ8pdGrSk9IgVsqX/etUdgJ6A9isrO5fR258BLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWMiYqtZgjRvnnCdeHhGHjD4KZ9C2ubvZUXbiAGeh187vz1/roESUVAc7fdIaoTpemj7o6NsBxF6awhIaD9lQmTnZimJt/wjnbzOPqqfkSJoQWgCoDp0c5WltVGYgEFrAiMNeJ+IEUkfdRoVNLcUIBGrzJw0HyyJ4sU0gfOjkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFeduGhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFeduGhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F7C1F000E9;
	Thu,  2 Jul 2026 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783016858;
	bh=DeSCQ8pdGrSk9IgVsqX/etUdgJ6A9isrO5fR258BLOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CFeduGhZbMxqkISWlGvydQ5dSYo9l+yikN4aOdsG+xSaxfXU64ILiTpR/FHjdPSFu
	 7XHYfRvZ6nLJ/5hFHCsQWdLRTyNsEZE+WZJG7Cvbldw1ASP+Glyi+Ez3neVDGIGSFf
	 o9hJaEzrkoOz48mG3fwx4LiLdBu15rvzxCNSQhceYZ1K0mTb3gvFv3ajonBDY5iPUw
	 SAVRzJS1KcLLQagk+kiZJ6GWK2VPqLWOBdaUHVlM3W5ZwS5Wuk/V0yp6F4PQnIpz6R
	 ovc3hB+8l9cGKqETdPWTL6ggCVg1mJVdQpDNkQRw77L3gpcdwyP9tw8eGiOyZcFhPP
	 6HyGLRfcrQVbg==
Date: Thu, 2 Jul 2026 19:27:34 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-can@vger.kernel.org
Cc: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v1] net: can: mpfs_can: add Polarfire SoC MSS CAN
Message-ID: <20260702-monitor-deodorize-26a5907b93b8@spud>
References: <20260702-lens-constrict-6dc7d287c647@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2gwRrDM2wOky5yI"
Content-Disposition: inline
In-Reply-To: <20260702-lens-constrict-6dc7d287c647@spud>

--f2gwRrDM2wOky5yI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 03:34:58PM +0100, Conor Dooley wrote:
> From: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
>=20
> The Microchip Polarfire SoC has two instances of CAN devices inside the
> MSS block. Add driver to support this MSS CAN.
>=20
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>=20
> Hey Marc,
> I've finally got around to sending this driver.
>=20
> Unfortunately the author left microchip (which is part of why sending it
> took so long). I've done some mechanical cleanup, but left it mostly
> functionally unchanged mainly because I lack a setup to test it
> thoroughly were I to do so.
> I'm hoping that what's here is by and large okay on that front, and
> maybe that sasiko will point some stuff out if there's stuff I missed.
> I did remove/modify some code, so hopefully I caught all the obviously
> problematic stuff.

Apparently there's a lot that I did not catch, given there's a wad of
complaints from sashiko. Certainly feel free to ignore this version
until I resolve the dozen or so things that it has raised.

Thanks,
Conor.

>=20
> The IP that we are using seems to lack an internal reset, so the reset
> for the whole peripheral is used instead, and I wonder if it is
> overeager? Doing ip link set xxx up causes a double reset, for example.
>=20
> There's no binding of course, because that's been upstream for quite a
> while!

--f2gwRrDM2wOky5yI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakatlgAKCRB4tDGHoIJi
0tW3AQDDSpv7nPtGgdoU/g6m5Uo/6OCbMr6TBlbYJ1gvDPgQ4QD/e6guV/XsRxiM
djX8Ip8m4JVdFNe2xtl8J1ulqvbYzws=
=R6q1
-----END PGP SIGNATURE-----

--f2gwRrDM2wOky5yI--
