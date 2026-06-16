Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA423A48DF;
	Tue, 16 Jun 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607113; cv=none; b=bhpVPD6lvy18/jQEI945zEDJYaPqzXa6+8XtwMwR7OZ/Kujgac5Ac4kuQ5Ufw//5FILhUojaEWepDINj5jn+2AfYuoGKomrteygHjNef7e3OMZVw4SsdzE5NrgLzGaR46Iit2I7VoW8Pm6SZ1Uv55mRLG6/vYy1spqiL5Maq62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607113; c=relaxed/simple;
	bh=V1Kwt7TyLnU/7DbayuPez28inATbVxqUxI7CkjBfJDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGAHkcKcJ1oECT/5gmyKqpMUBwJaSIhhMhNz43vaLlIan5hxLFHqSCqKGWUGl1Trvx8TmjY4hmCKInlUQXcblMXH0IEy8Eizg0ls+Q9svHsQMJVW17kRMAkXmWkHZQJOKjD1eEFoL99Clim9FyB+/VkVS2iZakUK0W0Sf30MmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuthUyef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuthUyef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECA21F000E9;
	Tue, 16 Jun 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607112;
	bh=qb3hHTkGBvWX9ZKLJfrerMdfITuZ/qOqDoRCAH55njE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OuthUyefTY8T1XJzwWKyQ+gUgs+RoFe8OKnkZoCpOcUPLt1aE0fYeIKeX5YoDVsc7
	 YrI3JART8Pzr0IkhNfFq5h3/m1wSxPOSnyzUhZA0Tv9x7fmtb5t1MH0bmIO1EfUCTS
	 73QnO0QY1FqfeM+B4SvIg3dy9NocshKYlskfAVtZgS1PqoC3MTOKV2gkMEaI6QP/y7
	 sxzy6CGYL6s4+IEZsDqrT5BDpXqeZRjOQEgyo4w9RnXQSCJKUf+/cLU2m19yL3xWbn
	 SuYs4MKyIgFQWwLcChP5+GGXmqV4BJL2HMDqBnKzHs39BCK+/Vlmm4z2+PZrDHJ6LX
	 83OE9X0z2/ZUw==
Date: Tue, 16 Jun 2026 11:51:48 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?5bSU5Zu95peX?= <guoqi0226@163.com>
Cc: sashiko-bot@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org,
	mailhol@kernel.org, o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net,
	linux-spi@vger.kernel.org
Subject: Re: Re: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Message-ID: <eef5cf87-ef9e-49f6-adb8-0cff1658052c@sirena.org.uk>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
 <20260616103018.105612-1-guoqi0226@163.com>
 <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
 <15819af8.9491.19ed00ac23e.Coremail.guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iw7yWma0LZoO+2IQ"
Content-Disposition: inline
In-Reply-To: <15819af8.9491.19ed00ac23e.Coremail.guoqi0226@163.com>
X-Cookie: Password:


--iw7yWma0LZoO+2IQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 06:47:06PM +0800, =E5=B4=94=E5=9B=BD=E6=97=97  wrot=
e:

> Hi Mark, While fixing the mcp251xfd driver, I found a latent flaw in spi_=
get_device_match_data(), so I sent both fixes as one patch series for unifi=
ed review. There is no hard build or runtime dependency between the two pat=
ches. They can be merged separately into the SPI and CAN subsystem trees re=
spectively. Thanks, guoqi

That's not a good idea since it creates a cross subsystem series which
means the flow for getting things merged gets a lot less clear.  It is
better to keep things for different subsystems separate since that's a
lot easier to manage.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--iw7yWma0LZoO+2IQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxKsMACgkQJNaLcl1U
h9BQkQf/TdTY1AZB2W1FtVclSoiymPwh+izqvbMm+aq5xzXK9fHi/tqKMJBd05If
4dm1gxBggbGZSOZ85stnRNLmVX0bZ0a8PLxPbSVdL3t5vL184PjDneV0VRx1qy3Z
YGUYpu8WKpxeRQ3VDWAg4Fk1C4Mgzzpw3WB8gG/xYYsHVppLoHNXmdVA8hqihMw1
Sebv/Z64zv6OhOwLwg1r0/4jhBNzo9bXd2whvRPIMsKZ0Ik7cQiXY+pjVSlCIauk
NQ/A1WcGVRDP9T08irm0a2iGygmJE/U1ie5lWXQhGOD3NZSqW6n4GHG761w/I0nu
SXBIwvf01t9DJuGV1R59rcH8f8km7A==
=6Ioy
-----END PGP SIGNATURE-----

--iw7yWma0LZoO+2IQ--
