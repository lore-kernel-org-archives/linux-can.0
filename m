From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 3 Dec 2015 12:44:29 +0100
Message-ID: <56602B1D.90601@pengutronix.de>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net> <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QWhQBE81xnitnIQXq8vEdmIKdcR6t2GPX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47021 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752503AbbLCLop (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2015 06:44:45 -0500
In-Reply-To: <20151203112319.GA5230@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, s.grosjean@peak-system.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QWhQBE81xnitnIQXq8vEdmIKdcR6t2GPX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2015 12:23 PM, Andri Yngvason wrote:
> I tried it and it's not enough. The sja1000 on the peak pci is an FPGA
> implementation that claims to be sja1000 compatible. Is it possible tha=
t peak's
> FPGA implementation is slower than the original sja1000?

Maybe buggier :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QWhQBE81xnitnIQXq8vEdmIKdcR6t2GPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWYCsdAAoJEP5prqPJtc/HhDMH/iBRcChTnDu9XFaPErN/GdRA
eLZjp1zMmiWNI+5L7LrYQbtRK0J70qqEwpBD7yMl8TWhy35a0SZ7SWwPgAEKHyu5
kkmj42Z3il6pBS8Us/DAzp6nq5iT7Fq5C9csglR4q9VPBBb2H/gnqGBFHamhnMlG
folPMwpsIjlPDd7L8UhLPR/xg4BnsrXdxSSFqbvgjn/DVjJmY4rqffmhaEqvlLAF
E0X1TRDWqmiyfYMMInwtkQG+ZSVnKt+U9M9h8lWmTysKpVfaf/U5W38FnOCj96XX
BIbibAwW0GaLGJEB3LZu0dZUXY6EINtUvGF7El6s+u0cKfW0jqIXSqN7OtucBMw=
=uRcS
-----END PGP SIGNATURE-----

--QWhQBE81xnitnIQXq8vEdmIKdcR6t2GPX--
