From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 01/14] can: af_can: can_pernet_init(): add missing error
 handling for kzalloc returning NULL
Date: Fri, 25 Aug 2017 10:31:51 +0200
Message-ID: <8a67c172-5bcd-350b-583a-66e24c545048@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-2-mkl@pengutronix.de>
 <8ec07d87-eef5-e054-f8c5-50c4ca4737ab@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3WxcvAll2cB4p2RsgmVRxIPnHVMtTlUXE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34941 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754942AbdHYIb6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Aug 2017 04:31:58 -0400
In-Reply-To: <8ec07d87-eef5-e054-f8c5-50c4ca4737ab@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3WxcvAll2cB4p2RsgmVRxIPnHVMtTlUXE
Content-Type: multipart/mixed; boundary="VmDl03hMLJFI4tpsCodxhL8GMWPJgk7jv";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <8a67c172-5bcd-350b-583a-66e24c545048@pengutronix.de>
Subject: Re: [PATCH 01/14] can: af_can: can_pernet_init(): add missing error
 handling for kzalloc returning NULL
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-2-mkl@pengutronix.de>
 <8ec07d87-eef5-e054-f8c5-50c4ca4737ab@hartkopp.net>
In-Reply-To: <8ec07d87-eef5-e054-f8c5-50c4ca4737ab@hartkopp.net>

--VmDl03hMLJFI4tpsCodxhL8GMWPJgk7jv
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 02:42 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch adds the missing check and error handling for out-of-memory=

>> situations, when kzalloc cannot allocate memory.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VmDl03hMLJFI4tpsCodxhL8GMWPJgk7jv--

--3WxcvAll2cB4p2RsgmVRxIPnHVMtTlUXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmf4HcACgkQHv7KIOw4
HPZY7ggAqyubC6Wd/5hB+5BKVA4cPGnC2BB2l79wciyQYgnHhWJAFxTm0UdUKbIJ
8/YoPuH3HMChfq+MzW299h0/JsTqlDrwUTFMbxTWWvpRiDbPxu7sLHlkwOpMXCQF
GFW+YQYg9ZBXbj9/7dbF2DvYk9onTHbmASoMXhoMsKZgtWREAPCoqmPydqaOZPvT
detanVQjaxHREXTY4UZcK/2BTnT2xpGuLWL8w3g1lXvx3dfP6ylYF7RfKx3PIAip
Dh48nAzYXlECVfLK+VYSqrsqSAJoiyHuNsSylQzjpxAdiDnKSyBE4OGPr6m+E6UP
iR5GbOVwwPeFyqZRV4ovATfrHHjtJg==
=Bhlr
-----END PGP SIGNATURE-----

--3WxcvAll2cB4p2RsgmVRxIPnHVMtTlUXE--
