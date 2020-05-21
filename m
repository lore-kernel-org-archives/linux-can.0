From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Date: Thu, 21 May 2020 22:08:53 +0100
Message-ID: <20200521210853.GK4770@sirena.org.uk>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler-ssbZdu+FE1GzQB+pC5nmwQ@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Glauber <jglauber-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Robert Richter <rrichter-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 01:19:16PM -0700, Tim Harvey wrote:

> Should I be submitting this patch with logic that only does
> half-duplex if the spi controller doesn't support it (if
> (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
> acceptable to simply make the driver half-duplex like this for all
> cases?

It seems likely that making the transfers explicitly half duplex will
perform better, especially for PIO controllers since there's less FIFO
stuffing to do but also just generally on longer messages.  You will
get some overhead setting up two transfers on write then read messages
which might offset that but my best guess would be that it'll be
negligable on most controllers.  It's also just a more accurate
representation of what the transfers are actually doing which seems
nicer.

If there *is* a performance win for doing full duplex messages on some
controllers we should probably look at optimizing this in the SPI core
since it'll affect a wide range of hardware and we already have some
code for forcing full duplex anyway.

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7G7eUACgkQJNaLcl1U
h9AOJQf+MicpOYZXR/CuHGZ9nB2XYZVgilr2bOVHAgmW9Ptv934QL7ohdwoxOi6/
envwoCqrTmi8Ii1y2aVCj4/fnoFzYhYOEIAifJyecrnU8HJVouLN55z7OtMcd1W2
hT/hVhXtPkT16rWo2/hMxJvljs7xRG3ezBy7kfsOgrvkN8T7P7pGo9IZrStLWM22
FLUt6FH54mF1A8eqCHevlaIIzP6deQ4WaWyi+tpwc8zoJXSDWAVlYqOugiVSYRvC
5UFPKCQXLVaymi0BcHpXkZv9ctDmpQHH3ZKsi/uuePlqMmyHxe+IAv3kZBJY6R1F
xLQSJezpEy6QAujKHOtwiM9zTPEsCw==
=Mz9E
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--
