From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Mon, 23 Sep 2013 15:46:15 +0200
Message-ID: <52404627.7000807@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DA147.7090403@pengutronix.de> <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com> <523DD2C3.7000505@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WUwOxtOXuvUcmjHVXQtxO08vPkRBVNa8f"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab3IWNqW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Sep 2013 09:46:22 -0400
In-Reply-To: <523DD2C3.7000505@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUwOxtOXuvUcmjHVXQtxO08vPkRBVNa8f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2013 07:09 PM, Marc Kleine-Budde wrote:
> On 09/21/2013 06:37 PM, Sebastian Haas wrote:
>> As Oliver already pointed out there are a bunch of applications outsid=
e
>> which may require a can4linux-like chardev API.
>>
>> But I also agree that merging an additional CAN framework makes not
>> much sense. I prefer to port can4linux drivers to SocketCAN for not
>> yet supported devices. But we may also think about an emulation of
>> chardev based APIs like can4linux to support legacy applications.
>=20
> The emulation could probably be done in userspace. I'll ask our
> userspace graphics guys how they emulate legacy /dev/fbX on top of drm.=


They use CUSE, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WUwOxtOXuvUcmjHVXQtxO08vPkRBVNa8f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJARioACgkQjTAFq1RaXHPCawCeLJP8q3s/kYB9S7S5XbfkIDv3
aaIAoJceUQ0s4KefGYAiIyNg2qficM/j
=Vsss
-----END PGP SIGNATURE-----

--WUwOxtOXuvUcmjHVXQtxO08vPkRBVNa8f--
