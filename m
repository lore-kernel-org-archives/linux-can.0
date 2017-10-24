From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: sun4i: fix loopback mode
Date: Tue, 24 Oct 2017 13:04:15 +0200
Message-ID: <a277b826-d5a1-8fbb-0355-19266eb70b28@pengutronix.de>
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
 <bfe80104fb201b9e05f5275ba9d09149def5e318.1502971879.git.info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6JRj1Q4RiSD3gMQnnQfL9QdUgsfsXJJPg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58635 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932393AbdJXLEU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Oct 2017 07:04:20 -0400
In-Reply-To: <bfe80104fb201b9e05f5275ba9d09149def5e318.1502971879.git.info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6JRj1Q4RiSD3gMQnnQfL9QdUgsfsXJJPg
Content-Type: multipart/mixed; boundary="bFTRu8jqEMM03Kk0kECLF4D7NoGUwShgd";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org
Message-ID: <a277b826-d5a1-8fbb-0355-19266eb70b28@pengutronix.de>
Subject: Re: [PATCH 2/2] can: sun4i: fix loopback mode
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
 <bfe80104fb201b9e05f5275ba9d09149def5e318.1502971879.git.info@gerhard-bertelsmann.de>
In-Reply-To: <bfe80104fb201b9e05f5275ba9d09149def5e318.1502971879.git.info@gerhard-bertelsmann.de>

--bFTRu8jqEMM03Kk0kECLF4D7NoGUwShgd
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:59 PM, GBert wrote:
> From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
>=20
> fix loopback mode by setting the right flag and remove presume mode
>=20
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Added to can and added stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bFTRu8jqEMM03Kk0kECLF4D7NoGUwShgd--

--6JRj1Q4RiSD3gMQnnQfL9QdUgsfsXJJPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnvHi8ACgkQHv7KIOw4
HPaoBggAl1KkXso5uz45MuuvfjNPAarsFSkksjSsjlniBPrcAC7MmWzyIfLmqmaL
X/tQSFyj/Jkw0AXBAH4C4V638+U7bVTr6iYiSvuUGxBsXWG5R2uEco53vkbJcbxH
zFjJQG7DrJnQ35GYeqrZ5n88qVMe5/XCyGT6hFanJRO8BUBHOpolZOR4ij3a6jjy
lLy/S/gZc2QZspOLxe6MhmgNyHmm0/6Dr5sqBw27NyXuMK3xjSz5eegBQbCnpZrk
xcQzrXfxaBy9PPOGBg0Utsictg/vmAoMD2kCnhjhGUn/NIFKBIJ8X5sLGp90mvO5
nSq5yQlwjNxDVpHxfPHAwdkjLlh9pA==
=YcN2
-----END PGP SIGNATURE-----

--6JRj1Q4RiSD3gMQnnQfL9QdUgsfsXJJPg--
