From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 10/14] can: raw: raw_bind: bail out if can_family is not
 AF_CAN
Date: Mon, 28 Aug 2017 17:25:57 +0200
Message-ID: <0495bbe6-ddc0-8004-7286-e20337a66864@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-11-mkl@pengutronix.de>
 <58b8814f-a859-217b-7d58-6d652fee337d@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="29Q56On045Kwu2k9lBhRUQtAUXMsvCbQv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37961 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751641AbdH1P0g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 11:26:36 -0400
In-Reply-To: <58b8814f-a859-217b-7d58-6d652fee337d@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--29Q56On045Kwu2k9lBhRUQtAUXMsvCbQv
Content-Type: multipart/mixed; boundary="6NOeRUBVk3v5HCm5lUfTrx7VpjGwiNQiC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <0495bbe6-ddc0-8004-7286-e20337a66864@pengutronix.de>
Subject: Re: [PATCH 10/14] can: raw: raw_bind: bail out if can_family is not
 AF_CAN
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-11-mkl@pengutronix.de>
 <58b8814f-a859-217b-7d58-6d652fee337d@hartkopp.net>
In-Reply-To: <58b8814f-a859-217b-7d58-6d652fee337d@hartkopp.net>

--6NOeRUBVk3v5HCm5lUfTrx7VpjGwiNQiC
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:40 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> Until now CAN raw's bind() doesn't check if the can_familiy in the
>> struct sockaddr_can is set to AF_CAN. This patch adds the missing chec=
k.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Agreed :-)
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

tnx,

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6NOeRUBVk3v5HCm5lUfTrx7VpjGwiNQiC--

--29Q56On045Kwu2k9lBhRUQtAUXMsvCbQv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmkNgUACgkQHv7KIOw4
HPaTYgf6A6nfdogES9PFBDYmDZB2aou8g9lGtuliLW7ZZqzed6v78cjOHf+HoR9n
ZwJkJjrGCaKOCp4k+DOVtKm7J5Uzt/UMTFFh4Bqm3XI0q9XAQilQMWpeJRK+dl3u
bXGJTArD7pPt1Z5MvuUahHtBQmGz+GEqtzOdtiNXsdqhTbEIZItl7zu9eXKwap8q
o85G4H7Unj6iELVK9wbap/xm2aut35ZzaTuDiHfRfAmwzNNu3mgXUCuYrOOcvbkC
pOIiLNXDUePfz73439VQaaKZG0PBhIckllGZbCdzyWZDJWySqI4D1/2oFSk6bG3q
3s+G91L2JDoWyozS8Cl21O4wlDu8vA==
=UFE6
-----END PGP SIGNATURE-----

--29Q56On045Kwu2k9lBhRUQtAUXMsvCbQv--
