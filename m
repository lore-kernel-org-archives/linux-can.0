From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] usb_8dev: add LED trigger support
Date: Tue, 18 Dec 2012 15:05:12 +0100
Message-ID: <50D07818.9000108@pengutronix.de>
References: <1355779189-23289-1-git-send-email-krumboeck@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC83342F91F2A643121FBB88"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2LROF0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Dec 2012 09:05:26 -0500
In-Reply-To: <1355779189-23289-1-git-send-email-krumboeck@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, fabio.baltieri@gmail.com, Bernd Krumboeck <krumboeck@universalnet.at>Fabio Baltieri <fabio.baltieri@gmail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC83342F91F2A643121FBB88
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/17/2012 10:19 PM, Bernd Krumboeck wrote:
> Add support for canbus activity led indicators on usb_8dev devices by
> calling appropriate can_led functions.
>=20
> These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
> otherwise.
>=20
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>

Thx. Fabio, can you queue this patch your tree and include it in your
series when you send the next iteration?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBC83342F91F2A643121FBB88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDQeBwACgkQjTAFq1RaXHPMSgCfTrPncDvcddKjcGgvn3imHLQ6
xiEAoIVmmFxT6T0qjnPf/zrQKo3rryD+
=G4DI
-----END PGP SIGNATURE-----

--------------enigBC83342F91F2A643121FBB88--
