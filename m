From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: Add documentation for CAN FD driver configuration
Date: Fri, 18 Sep 2015 11:30:06 +0200
Message-ID: <55FBD99E.3010701@pengutronix.de>
References: <1442567415-4271-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wKB0csxpAeb8Iv866Wk6JLsnEJSfUndGe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33491 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbIRJaO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2015 05:30:14 -0400
In-Reply-To: <1442567415-4271-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: corbet@lwn.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wKB0csxpAeb8Iv866Wk6JLsnEJSfUndGe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2015 11:10 AM, Oliver Hartkopp wrote:
> With Linux 3.15 the infrastructure for CAN FD hardware drivers had been=

> introduced into the kernel. Now the M_CAN driver and the peak_usb drive=
r
> support CAN FD. Update the documentation to show the latest CAN related=

> configuration options of 'ip' from iproute2 and describe the CAN FD spe=
cific
> options to set the data bitrate and protocol version (ISO/non-ISO).
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Jonathan, are you taking the patch?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wKB0csxpAeb8Iv866Wk6JLsnEJSfUndGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV+9meAAoJEP5prqPJtc/H8AQIAJ3xkNKTwlgMf3esUnO2NYbN
vKm11cRNGD0FhJR4y+4BMrq7G0oQFmiW+An+SxEm4Aidj9PZTgl7P8qs5bOUMgeE
P//leOBOUHi6lKwldmyVrqi2s3zOVWPh+6kFLzOEZx5GgjAWth/qFb5ecFZTiKJd
f4ZQxoazDnghAEM38AHUtd/AnSQHd/GiIALaPoQ2R/VT9nKSItHlrRBcj1fYodqq
rgFB6kFYl70ch3gHOBCwSlC+MUBKBRskw+pZ+R/mvDe0u1OsRCFNNSErO6TTxjMj
JgRwStWKxsz6SbJLN1fSlGIsoTarpIRQ9PMktSbu/bcPZ3oAE8NMEeDFmRvNrRM=
=+8SN
-----END PGP SIGNATURE-----

--wKB0csxpAeb8Iv866Wk6JLsnEJSfUndGe--
