Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0B33291F;
	Tue,  7 Jul 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441011; cv=none; b=E1aRAOyw8nwr9pgcj1OvNHRCYuWkMrph1rsRgo0qrl9P/r2dLBk1lBo3edcH5V0eOikI33YFEzTqQEVFXNpRDbafbBOEVhwB0OTXxLEzVcLiZMDOVRmv49X8zEC/0rLXg/+uzWyx2ogQ7EEWpV9Fg740RR53/7d3WwWt8gjkZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441011; c=relaxed/simple;
	bh=eJkZScH+2tUpPvrz10Rhvl4xlNR1MRvbgEd4Iyhc5xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7bnFToITRAk7uaPu81fT9UjOtkBeoLcPw4qT3IGBDpdE0pDoZRfmBXdSDoB9JVkGNXe7omHk+3KMzxiHwcKbd1dP+TNjXd7aBVYLZkp3D4BklxrlJnSsE/oUxB6fypOq2blXRkz92hJObDurpd++CO/X5tDHZOPsKmmGUAqbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwHp8YDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwHp8YDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212CE1F000E9;
	Tue,  7 Jul 2026 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783441009;
	bh=BRTWTtCF/TnwArUxZSwcgJyax6Qi1uu00oQiI0rI0uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwHp8YDUX9RDnLOs9agp75luftXSWn5gLU2QXfbsH+X7GpQ4Akn0Whoa/lIll7mng
	 rberCHmBpbbxHdA9O6ymUFiO3sjiIJ8VgT0L1xCVJaL+40L7QtfTD8yOxRvssSrMW7
	 f80sfKLKngKZIGr2LM8yc6+E72ncSVvMcAP0mriNv0GB8Zk1O/XqmDyDA1glIUR1Uy
	 GDC+3vKq9mynsZR1NbiVDqsTIgtVOkYIz5Q50e2iyBUiPMnaS2/ydZ6A5YkzlrowdU
	 2pJTjxji3/LVIjffS2qm9k3st5RwrpD06LPyu7mV27X4SrMORN8qTU8bg2LlJAm64y
	 qnGpwyMWz+k2A==
Date: Tue, 7 Jul 2026 17:16:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	bmasney@redhat.com, biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com, fabrizio.castro.jz@renesas.com,
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Message-ID: <20260707-suffice-panorama-7083120803cc@spud>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vvr7ueiVvdUxT5x"
Content-Disposition: inline
In-Reply-To: <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>

--9vvr7ueiVvdUxT5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 01:24:12PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatib=
le
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 128 acceptance filters, compared to 64 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
>=20
> Since:
> - the SoC clock generator provides to the CAN IP only the peripheral and
>   the RAM clocks
> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>   inside the IP itself by dividing the peripheral clock
> - the assigned-clocks and assigned-clock-rates properties are specific to
>   the CAN-FD clock
> the assigned-clocks and assigned-clock-rates properties were dropped from
> the required properties list of the Renesas RZ/G3S SoC.
>=20
> Add documentation for the Renesas RZ/G3S SoC.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

No idea if patchwork will pick up the response to Sashiko, but the thing
it raises about the fd properties seems valid.
pw-bot: changes-requested


--9vvr7ueiVvdUxT5x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0mbAAKCRB4tDGHoIJi
0rtdAQCT+LGnXwr1M/rIKrgiH02r2W9lRu1Yof4RbsBDQnSnTQEAjPWj+nHIbYt/
ry4uBSNCnAZDQFSiCGgSrRzEw/pN4Ak=
=4Yrq
-----END PGP SIGNATURE-----

--9vvr7ueiVvdUxT5x--
