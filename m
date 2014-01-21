From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Tue, 21 Jan 2014 12:37:54 +0100
Message-ID: <52DE5C12.70503@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de> <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de> <52D93885.5040109@pengutronix.de> <20140117203605.GF25911@pengutronix.de> <52DA7106.5000300@hartkopp.net> <20140121095337.GR25911@pengutronix.de> <52DE5B3F.3010900@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GRMIv9npFRcunq73tTVcjnP6FumqfaHSs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49267 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbaAULiA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 06:38:00 -0500
In-Reply-To: <52DE5B3F.3010900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7Y=?= =?UTF-8?B?bmln?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GRMIv9npFRcunq73tTVcjnP6FumqfaHSs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/21/2014 12:34 PM, Oliver Hartkopp wrote:

>> @Marc or Oliver: Can you please give me a ping as soon as the headers
>> hit your public repo. Thanks.
>=20
> Indeed I would vote for your latest patch set (v5) as the only missing =
thing
> there would be to move isotp.h from include/socketcan/can/isotp.h to
> include/linux/can/isotp.h and delete the socketcan directory then.
>=20
> In Marcs patch set (v6) the license updates got lost at some point.

Uwe's patchs never included the actual import of the kernel headers,
which bring the license information. I'll post a follow up patch v7,
that import the kernel headers, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GRMIv9npFRcunq73tTVcjnP6FumqfaHSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLeXBIACgkQjTAFq1RaXHMFEwCcDVz7obvNsSPS3QVfCsSYsCRp
QvAAniiF7UrqoiCK0w0wqvLmxByGDau6
=tumZ
-----END PGP SIGNATURE-----

--GRMIv9npFRcunq73tTVcjnP6FumqfaHSs--
