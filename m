From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when provided
 via the environment
Date: Mon, 19 Aug 2013 10:24:21 +0200
Message-ID: <5211D635.2090508@pengutronix.de>
References: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de> <520FCFDD.7010308@pengutronix.de> <5210A9C5.5070309@hartkopp.net> <20130818204930.GM30496@pengutronix.de> <52113E45.4090300@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="35DORHaVxr3TIcADDCVmQHFtRva9s3VJi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45813 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3HSIYd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2013 04:24:33 -0400
In-Reply-To: <52113E45.4090300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35DORHaVxr3TIcADDCVmQHFtRva9s3VJi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2013 11:36 PM, Marc Kleine-Budde wrote:
> On 08/18/2013 10:49 PM, Uwe Kleine-K=C3=B6nig wrote:
> [...]
>=20
>>> 1. good idea - I already pushed it to the git tree
>> Thanks, but you somehow messed up the attribution. All three patches I=

>> sent in the last few days appear with author=3Dyou :-(

In order to apply patches with git, I use:

    git am -s /path/to/path

Then the author is not lost and you are tracked as the committer.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--35DORHaVxr3TIcADDCVmQHFtRva9s3VJi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIR1jYACgkQjTAFq1RaXHPv1gCgmOjyZQ8lnwbfY64+qBab26ea
PZkAn3+RXvGpaz2UTRtS8RtReSJ2Nys3
=OlMP
-----END PGP SIGNATURE-----

--35DORHaVxr3TIcADDCVmQHFtRva9s3VJi--
