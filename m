From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN timestamps
Date: Tue, 24 Nov 2015 14:42:44 +0100
Message-ID: <56546954.1070005@pengutronix.de>
References: <565460FE.7060401@sevenbyte.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LsXSJKJ8mD8smOXKemK2pwdPraJNkU0FR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbbKXNmw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Nov 2015 08:42:52 -0500
In-Reply-To: <565460FE.7060401@sevenbyte.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Tatschner <rumpelsepp@sevenbyte.org>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsXSJKJ8mD8smOXKemK2pwdPraJNkU0FR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/24/2015 02:07 PM, Stefan Tatschner wrote:
> I did some google work to find out how to retrieve timestamps of
> received messages. I have found this:
>=20
> http://socket-can.996257.n3.nabble.com/PATCH-Add-timestamps-description=
-to-can-txt-td1430.html
>=20
> It seems that this patch has never been applied to the kernel tree. Are=

> there any reasons (besides being forgotten) for this?

Maybe it was the time when mainlining the first bits and pieces to linux
kernel. Can you port this patch against a current linux kernel?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LsXSJKJ8mD8smOXKemK2pwdPraJNkU0FR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWVGlUAAoJEP5prqPJtc/HkhoH/RkOEuXIB9h8GM5VQkwB9c0m
VuRS4+wiezucZCUZP3KIwRIFa0d0vpbrmsDaMQXBpBma9yPcgxva4pqTTGAIsqt/
j9oS0CA7Ggp4dQt5bNVySCxJ+W4D8hPRyyifR9mFnk2LzEFIs/9IMJzFsCTHtWfX
d0u5kk896pOIkcx/nEaTMTPSIocLVdv0gr8vpSDb+Dd7sp2GTC9jeyoui1UHVUgI
2+3tyz7Eh/Q8suxXjde/Eq0F+qkC2IIwY2WG3wQfcbsZYMvDKQ8shkPjFizF54NJ
Y72KPg2B5IENZJ9EvK+FUfo0EKHx2TDs92DTiojfgeKmNDWd5h/xSCSqzeLGyZk=
=0WPI
-----END PGP SIGNATURE-----

--LsXSJKJ8mD8smOXKemK2pwdPraJNkU0FR--
