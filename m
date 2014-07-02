From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: m_can: add Bosch M_CAN controller support
Date: Wed, 02 Jul 2014 21:13:07 +0200
Message-ID: <53B459C3.6070807@pengutronix.de>
References: <1403863246-18822-1-git-send-email-b29396@freescale.com> <1403863246-18822-2-git-send-email-b29396@freescale.com> <53ADB1E8.1030504@hartkopp.net> <20140630082622.GB25689@shlinux1.ap.freescale.net> <53B4473B.2050003@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OOJRHjNdD3dTIER8ffBsrqWl8P4dXjfCi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51020 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670AbaGBTNQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 15:13:16 -0400
In-Reply-To: <53B4473B.2050003@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org, wg@grandegger.com, devicetree@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OOJRHjNdD3dTIER8ffBsrqWl8P4dXjfCi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 07:54 PM, Oliver Hartkopp wrote:
> I'm not really familiar with the naming concept in device trees.
>=20
> What is your opinion about the remarks below?

The entries in the DT, at least on freescale baords, follow the naming
scheme of the reference manual. E.g. on the mx25 it's can1 and can2:

    can1: can@43f88000 { ... }
    can2: can@43f8c000 { ... }

And on the mx28, its:

    can0: can@80032000 { ... }
    can1: can@80034000 { ... }

Because the imx25 datasheet uses a "1" based counting scheme, while the
imx28 uses a "0" based one.

So it's best practise to follow the naming and numbering scheme of the
hardware reference manual.....and if you have access to the
documentation of the m_can core, use clock names of the m_can core for
the clock-names property.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OOJRHjNdD3dTIER8ffBsrqWl8P4dXjfCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO0WcMACgkQjTAFq1RaXHPFFwCaAi6n0t6W6LUxGCTUznVssXmU
M0IAn3z/Ckj5p/vjkzqQ3BQtHFTGddpl
=yhAC
-----END PGP SIGNATURE-----

--OOJRHjNdD3dTIER8ffBsrqWl8P4dXjfCi--
