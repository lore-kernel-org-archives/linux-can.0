From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v5 2/2] can: flexcan: add LED trigger support
Date: Wed, 01 Aug 2012 23:02:11 +0200
Message-ID: <50199953.3050100@pengutronix.de>
References: <5018F8B3.6080404@pengutronix.de> <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com> <1343821782-1346-2-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE5CB769F107D3A04FE2D286"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab2HAVCR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 17:02:17 -0400
In-Reply-To: <1343821782-1346-2-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE5CB769F107D3A04FE2D286
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 01:49 PM, Fabio Baltieri wrote:
> Add support for canbus activity led indicators on flexcan devices by
> calling appropriate can_led_* functions.
>=20
> These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
> otherwise.
>=20
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---

Applied to can-next/master

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDE5CB769F107D3A04FE2D286
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZmVMACgkQjTAFq1RaXHMHKACbB2dDNrcDiq2GkQNYsjtQLz7O
vAUAn2HToZH+W6b/4k8UYdjXge0cI3xf
=DU+H
-----END PGP SIGNATURE-----

--------------enigDE5CB769F107D3A04FE2D286--
