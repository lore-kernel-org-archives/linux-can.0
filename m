From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] cangw: introduce optional uid to reference
 created routing jobs
Date: Tue, 9 Jun 2015 09:19:00 +0200
Message-ID: <55769364.80708@pengutronix.de>
References: <1433829910-7872-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tWAvboLovFP9qdP5fpxuCqgnAFeFesiK2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57568 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbbFIHeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Jun 2015 03:34:13 -0400
In-Reply-To: <1433829910-7872-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tWAvboLovFP9qdP5fpxuCqgnAFeFesiK2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2015 08:05 AM, Oliver Hartkopp wrote:
> Similar to referencing iptables rules by their line number this UID all=
ows to
> reference created routing jobs, e.g. to alter configured data modificat=
ions.
>=20
> The UID is an optional non-zero value which can be provided at routing =
job
> creation time. When the UID is set the UID replaces the data modificati=
on
> configuration as job identification attribute e.g. at job removal time.=

>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can-next.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tWAvboLovFP9qdP5fpxuCqgnAFeFesiK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVdpNkAAoJEP5prqPJtc/HjwsIAJJm4Vqfb8T9/SRYYsWc/SkB
GcHQDn7gqH/x3zSMet7MGS4lWk4wCd4ufE1Ba5bd2Wk3/ny/AYK2fQDatiPWOO1M
9/yDXhlvsVZQoa7H4EjrG5w7ktcAXahXXqfYVcTbxv9y76XBjDYgcS0zvsIW7OuL
+9t8cTp6eR9NS1StzLXmCXQv0uaFqIPlWGPycSvu+gZESxwJX5UvyvsvzJwICYFW
QySe1TnAh5Y9WRUIEwIuI/HSMvWKoPFtAHRkm8/bw7EvL1fL2x7aeahu0gNbtILE
viLOU5rej3Ub7Quzt3B49kIdj4WgUdlT6rzwhHAVbw8U8ielYCIHHI4D9pGu+ZM=
=dJ2Z
-----END PGP SIGNATURE-----

--tWAvboLovFP9qdP5fpxuCqgnAFeFesiK2--
