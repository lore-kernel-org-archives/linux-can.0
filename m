From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN driver for the Holt HI-3110
Date: Wed, 15 May 2013 09:22:54 +0200
Message-ID: <519337CE.1010505@pengutronix.de>
References: <5039321.EyQMEif55R@heinz.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MANJVBUBXWIEHLMVKUJV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59325 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab3EOHXB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 03:23:01 -0400
In-Reply-To: <5039321.EyQMEif55R@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-15?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MANJVBUBXWIEHLMVKUJV
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Heinz-J=FCrgen,

On 05/15/2013 12:18 AM, Heinz-J=FCrgen Oertel wrote:
> does someone know if it exists for the Holt Integrated Circuits Inc.
> CAN controller HI-311[03]? It has an SPI host interface.
> http://www.holtic.com/documents/371-hi-3110_v-rev-dpdf.do

I don't think so. The only mainline spi driver is for the mcp251x.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MANJVBUBXWIEHLMVKUJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTN9IACgkQjTAFq1RaXHPrFQCbB20L+3qp/0BnE0mNGfiKYgQ1
jMsAn20TpeCIdYuw6WnrX+uYLqBIR94x
=R6+U
-----END PGP SIGNATURE-----

------enig2MANJVBUBXWIEHLMVKUJV--
