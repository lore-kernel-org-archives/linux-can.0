From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN driver for the Holt HI-3110
Date: Wed, 15 May 2013 09:24:22 +0200
Message-ID: <51933826.80205@pengutronix.de>
References: <5039321.EyQMEif55R@heinz.site> <519337CE.1010505@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ESSREFPXGKUBRHVHQGDO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59330 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3EOHYY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 03:24:24 -0400
In-Reply-To: <519337CE.1010505@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-15?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2ESSREFPXGKUBRHVHQGDO
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/15/2013 09:22 AM, Marc Kleine-Budde wrote:
> On 05/15/2013 12:18 AM, Heinz-J=FCrgen Oertel wrote:
>> does someone know if it exists for the Holt Integrated Circuits Inc.
>> CAN controller HI-311[03]? It has an SPI host interface.
>> http://www.holtic.com/documents/371-hi-3110_v-rev-dpdf.do
>=20
> I don't think so. The only mainline spi driver is for the mcp251x.

And it's sloooow. Don't use an SPI CAN controller if possible. Do you
have the option to use an USB CAN adapter instead?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2ESSREFPXGKUBRHVHQGDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTOCYACgkQjTAFq1RaXHPa9ACfd6vQKj2dzwG3tKjWezJIu8s3
VAYAnjOSZzJlC2F7IrWFcaO1PolF3AFb
=3drD
-----END PGP SIGNATURE-----

------enig2ESSREFPXGKUBRHVHQGDO--
