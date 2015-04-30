From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: kvaser leaf and SocketCAN
Date: Thu, 30 Apr 2015 08:04:11 +0200
Message-ID: <5541C5DB.3000909@pengutronix.de>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org> <55406A03.9060105@pengutronix.de> <20150429104528.GA5712@linux> <loom.20150430T051006-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="j9MsonCX9nM9onTmikEwHnRKoorq3lUmS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbD3GE2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Apr 2015 02:04:28 -0400
In-Reply-To: <loom.20150430T051006-395@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j9MsonCX9nM9onTmikEwHnRKoorq3lUmS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/30/2015 05:11 AM, Leo Stan wrote:
>=20
> Thanks a lot everyone for your help, it finally works!
>=20
> The example code output :
>=20
> can0 at index 4
> Wrote -1 bytes
        ^^

This doens't look that good. When write() returns -1, something went
wrong. Have a look at "errno".

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--j9MsonCX9nM9onTmikEwHnRKoorq3lUmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQcXbAAoJECte4hHFiupUT78P/Av9hv0VUDjLFQOTboGhuxNl
sTk15PuxRqAhYqYHJ4Xi6OGWDJA/yH2y6beB+fOKu1OBHzvVaMNpVeqv+qaKbgVn
YQ4dGIU/T0muUVR7LEY5TBENbSE8W1kLXzq1O40SPTy90uGaPP16Ogv67Z9/h8rK
vxJuhwr5bOYjffvXd5X9f/7YvH+PuY8R68yU6ID5vELv6UW0r8lei/7+lPvdFfD0
GriwG5ytc3PSSiSNypnG8ndA9bNZFfzbYvnTwdJmOM1YHNN+iworyeupCq1nKkhL
HlfxkTUbNeghYfKI2ZXlm50VGCRpQC+i4OobuoGqaF+Xb1B0euW29EQzU0WI0jbc
H5+FzESsNg/P6yP+NE74NAhsG5G+Og7jKDj+lAfOdc9Q6FCDFzRF1Nh+uu5zmkdw
GF3pcEYN6TuNxXQJw5YFLLxJikKnRyU8elypv7oWTBOxibmRQ8QAebrEw2CVFgXi
DCSXEEJLcTxJImnv8KrlYlE8aFAEWBwshZUzUzWX8Hs9/AnRK0rZLqvD2+F4dINI
cMPKo2EgrmBVU98ShbNEY6Gs6/aOkZA03mTpH7k+FQ1WxVw7BuIxEwhQhdAM1YW7
TcmxEq2sTAtJYmHau6AblKshZKiUfr7xhOvz+0oLTjq8xw8BHXI94uBhI6Cv0cWQ
Vt44AVApsxAbaIE52LC8
=eB4X
-----END PGP SIGNATURE-----

--j9MsonCX9nM9onTmikEwHnRKoorq3lUmS--
