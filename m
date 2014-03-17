From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: Fix regulators operation without CONFIG_REGULATOR
Date: Mon, 17 Mar 2014 10:37:57 +0100
Message-ID: <5326C275.9080705@pengutronix.de>
References: <1394786780-24083-1-git-send-email-shc_work@mail.ru> <1394790917.548655659@f79.i.mail.ru> <5322D303.8000601@pengutronix.de> <1394791904.45849417@f382.i.mail.ru> <5322D6B2.90904@pengutronix.de> <53269F3A.1040708@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ks17IAaW0vqKhbFRgEkId0wgeKXEjVL1R"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57295 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbaCQJiI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Mar 2014 05:38:08 -0400
In-Reply-To: <53269F3A.1040708@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ks17IAaW0vqKhbFRgEkId0wgeKXEjVL1R
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/17/2014 08:07 AM, Oliver Hartkopp wrote:
> On 14.03.2014 11:15, Marc Kleine-Budde wrote:
>=20
>>
>> Okay, applied to can-next, that goes via net-next into v3.15.
>>
>=20
> Hello Marc,
>=20
> Linus just tagged 3.14-rc7 with a relaxed comment:
>=20
> 	https://lkml.org/lkml/2014/3/16/166
>=20
> So net-next might close this week.
>=20
> Just FYI :-)

Done, pull-request sent :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ks17IAaW0vqKhbFRgEkId0wgeKXEjVL1R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMmwnUACgkQjTAFq1RaXHPuGACfcXxtC9kWefRMoJYTDGSKEUQx
LQoAoJorphtW65ZGp15zcgiZ1CXK1yd2
=BYq+
-----END PGP SIGNATURE-----

--Ks17IAaW0vqKhbFRgEkId0wgeKXEjVL1R--
