From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] linux/can: add explicit copyrights to can headers
Date: Fri, 06 Sep 2013 16:32:02 +0200
Message-ID: <5229E762.6030605@pengutronix.de>
References: <1376858497-1700-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PGBkmB8W487rxkNucTEFf35U9NxRsFNrQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37311 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3IFOcT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Sep 2013 10:32:19 -0400
In-Reply-To: <1376858497-1700-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Urs Thuermann <urs.thuermann@volkswagen.de>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PGBkmB8W487rxkNucTEFf35U9NxRsFNrQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2013 10:41 PM, Uwe Kleine-K=C3=B6nig wrote:
> These files are copied to the source code of user space applications (i=
n
> this case can-utils) and so it makes sense to mention explicitly their
> copyright. I added the terms of C code that was introduced in the same
> commit as these headers.
>=20
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Urs Thuermann <urs.thuermann@volkswagen.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I think it is necessary to get the Ack of the three people mentioned in=

> the Cc: commit footers. @Wolfgang: I added a statement
>=20
>     The provided data structures and external interfaces from this code=

>     are not restricted to be used by software with a GPL compatible lic=
ense.
>=20
> similar to the other can headers. Does that suit you?
>=20
> Best regards
> Uwe
>=20
>  include/uapi/linux/can/bcm.h     | 32 ++++++++++++++++++++++++++++++++=

>  include/uapi/linux/can/error.h   | 32 ++++++++++++++++++++++++++++++++=

>  include/uapi/linux/can/gw.h      | 32 ++++++++++++++++++++++++++++++++=

>  include/uapi/linux/can/netlink.h | 11 +++++++++++
>  include/uapi/linux/can/raw.h     | 32 ++++++++++++++++++++++++++++++++=

>  5 files changed, 139 insertions(+)

If've ripped the can/netlink.h from this patch and resend it to the
mailinglist. I've pushed already Acked (by Oliver and Urs) parts to
linux-can-next/testing.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PGBkmB8W487rxkNucTEFf35U9NxRsFNrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIp52cACgkQjTAFq1RaXHNSoQCfT2pMUl8pzgXJQtB2qvGws2zW
NlsAn3GL/cPHaGLT8NB0IW1o3Sa+Ou7h
=mEci
-----END PGP SIGNATURE-----

--PGBkmB8W487rxkNucTEFf35U9NxRsFNrQ--
