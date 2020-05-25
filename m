From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Mon, 25 May 2020 13:57:43 +0100
Message-ID: <20200525125743.GF4544@sirena.org.uk>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
 <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a337c8ea-66e2-13c2-f625-fbe93e367d44-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler-ssbZdu+FE1GzQB+pC5nmwQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Glauber <jglauber-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Robert Richter <rrichter-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 02:41:31PM +0200, Marc Kleine-Budde wrote:
> On 5/25/20 1:31 PM, Mark Brown wrote:

> > This isn't something that every individual driver should be doing, such
> > rewriting should happen in the core so that everything sees the benefit.

> The core could merge several half duplex transfers (until there's as cs_c=
hange)
> into a single full duplex transfer.

Yes, that is what I am suggesting.

> I think it's not easy to detect and reliable to split a full duplex trans=
fer
> into half duplex ones. How can you tell, if the controller is supposed to=
 tx 0x0
> or actually receive.

I don't understand how that could possibly work or why it would make
sense?

> I think spi_write_then_read() can be extended to generate one full duplex
> transfer instead on two half duplex ones it does a memcpy() anyways.

This has the same problem as doing it in any other driver code - it
causes a needless incompatibility with three wire and single duplex
devices. =20

> To get a feeling for the use cases, this is what I do in the regmap read
> function of a (not yet mainlined) CAN SPI driver.

Like I say it's probably better if code like this gets pushed into the
SPI core where we've got more information about what the controller can
do and there's more win from doing the tuning since more devices and
systems can take advantage of it.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7LwMYACgkQJNaLcl1U
h9C0Ygf/TEq8Q1B3DlwNyeM6Tbrf9vdtDAFqlVRm7tVdnaBiGW/jm2VM+TuMEfDN
gZvtAJd++hQiSGDWh8VoMILzAtwnX+0kewHsVGjBt/RIhmPbmtsA6de7IQG0B8pK
AoOvRBhpXusQ3zaiQThhBgmCAaJRcaG+LRzClVmBn5olZegFZVKD8KYNxRCKN2Af
q4pFAWj5bNIbbPjoQUqrFNDOvW21JRU/2PVMo0oxBuLhAEX+1JBZtMRMCjEI2DXk
zHs8AOYmzMvNtNuFJkdDY1Xlr6dJEXkfgsuxg//aEbz4MfnF6v0ycL/md43Kobt4
4b5Zk3kmL8wuWdQKXrvR94OhpraPuQ==
=yo2+
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
