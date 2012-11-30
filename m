From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Fri, 30 Nov 2012 09:19:05 +0100
Message-ID: <50B86BF9.6020202@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de> <1354197491-31205-4-git-send-email-mkl@pengutronix.de> <50B85681.8030502@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6365E037873F94F858AE59E7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55405 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab2K3ITS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 03:19:18 -0500
In-Reply-To: <50B85681.8030502@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6365E037873F94F858AE59E7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/30/2012 07:47 AM, Oliver Hartkopp wrote:
> On 29.11.2012 14:58, Marc Kleine-Budde wrote:
>=20
>> As CAN_RAW is the basic CAN protocol, switch it on by default.
>>
>=20
>=20
> Hello Marc,
>=20
> you are probably right, that most users will at least need CAN_RAW sock=
ets.
> But i asked myself, what the Linux distributions will do once we point =
out
> that a specific protocol is *preferred* to be enabled?

I hope they enable it by default. However CAN_RAW will be only switched
on, if CAN support is enabled.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6365E037873F94F858AE59E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC4a/0ACgkQjTAFq1RaXHN9NACfSIpiEnfXTdbeF3ky5aZNwXy/
2uMAnA83nT/S1DOs2Ag6SiaWUdas2On+
=PXz5
-----END PGP SIGNATURE-----

--------------enig6365E037873F94F858AE59E7--
