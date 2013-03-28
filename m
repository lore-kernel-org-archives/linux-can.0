From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Transmitted Data is not to be received by other Application
Date: Thu, 28 Mar 2013 13:21:00 +0100
Message-ID: <515435AC.2040707@pengutronix.de>
References: <515433AF.7000203@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MIFESSHQSBKAEKXMJXMH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53518 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab3C1MVG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Mar 2013 08:21:06 -0400
In-Reply-To: <515433AF.7000203@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Stefan <os252@gmx.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MIFESSHQSBKAEKXMJXMH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 03/28/2013 01:12 PM, Oliver Stefan wrote:
> I'm developing Software for the Raspberry Pi with MCP2515 extension.
>=20
> I have two applications running the same time.
> One is in the receiving mode, and the other can transmit and receive.
> Unfortunately the application that is permanently receiving, receives
> the data of the second application too.
>=20
> How can I turn off this function?

Have you tried this:

  4.1.3 RAW socket option CAN_RAW_LOOPBACK

  To meet multi user needs the local loopback is enabled by default
  (see chapter 3.2 for details). But in some embedded use-cases
  (e.g. when only one application uses the CAN bus) this loopback
  functionality can be disabled (separately for each socket):

    int loopback =3D 0; /* 0 =3D disabled, 1 =3D enabled (default) */

    setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK, &loopback, sizeof(loopba=
ck));

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MIFESSHQSBKAEKXMJXMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFUNa8ACgkQjTAFq1RaXHNcygCggld+kSRER7bfyyBshmB3O4GJ
QuMAn1T1358QC2ayEDxe9mRXPnwFBXCb
=9mT2
-----END PGP SIGNATURE-----

------enig2MIFESSHQSBKAEKXMJXMH--
