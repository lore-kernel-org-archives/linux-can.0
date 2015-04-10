From: Mark Brown <broonie@kernel.org>
Subject: Re: [REGRESSION] commit 0461a41 "spi: Pump transfers inside calling
 context for spi_sync()" breaks Apalis/Colibri T30 with MCP2515 SPI CAN
 controller
Date: Fri, 10 Apr 2015 14:23:30 +0100
Message-ID: <20150410132330.GH6023@sirena.org.uk>
References: <1428670853.7008.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qrdGlhWsTzJpGMIr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428670853.7008.87.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-can@vger.kernel.org, linux-spi@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Stefan Agner <stefan@agner.ch>, Himangi Saraogi <himangi774@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>, Stefano Babic <sbabic@denx.de>, Christian Pellegrin <chripell@fsfe.org>, "DavidS.Miller" <davem@davemloft.net>, Marc Zyngier <maz@misterjones.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-can.vger.kernel.org


--qrdGlhWsTzJpGMIr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 03:00:53PM +0200, Marcel Ziswiler wrote:
> Hi there

Please try to use somewhat more targetted CC lists...

> I also have not yet looked further into what exactly is happening and
> whether or not the SPI stack, the Tegra SPI controller driver or the
> MCP2515 SPI CAN driver is to blame but rather decided to ask Mr. Brown
> and the community first for any insights they might have to share.
> Anybody?

I'd ask for trace logs but obviously we can't turn them on until boot
has finished...  Adding some trace in the relevant bits of code to try
to see where it's deadlocking is the obvious first step.

--qrdGlhWsTzJpGMIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ87SAAoJECTWi3JdVIfQLCQH+gKqUSelufOuwzReQh4vYJls
jWECjIWTrJ6iHlOSrP7ryYU42l6FXR7st6zdabpcmlSJUnzNSqJCAn+Fej3xL0hf
LTcYWaqCUsWDEbb37S0j42KIJAjNUxrVXd23HrxrySrMnZaUikXmkxviPnJyoevd
cieOW7ZeL8B1G9YtJYG/WjjcXNULa707U60GHutRZWsOT6pRD1uhD6+wxTqJBgpz
iBJ/Ijnn6jo0XEhvGyM/p02GxWha6RttvMePG7QKc2CjPjXvj85zRBpVzs/mFk3z
ZNdhYFnnOaiyjFGxIN+MPee4Y5arHgZopVlMtLS0Ph5+MiLOckqvBOmFmwlGzgY=
=ClLh
-----END PGP SIGNATURE-----

--qrdGlhWsTzJpGMIr--
