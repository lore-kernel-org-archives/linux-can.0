From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v5 1/2] can: add tx/rx LED trigger support
Date: Wed, 01 Aug 2012 13:59:21 +0200
Message-ID: <50191A19.6030202@pengutronix.de>
References: <5018F8B3.6080404@pengutronix.de> <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig42AA82735C4BE3425E727619"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45051 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2HAL7b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 07:59:31 -0400
In-Reply-To: <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42AA82735C4BE3425E727619
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 01:49 PM, Fabio Baltieri wrote:
> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.
>=20
> Triggers are called from specific handlers by each CAN device driver an=
d
> can be disabled altogether with a Kconfig option.
>=20
> The implementation keeps the LED on when the interface is UP and blinks=

> the LED on network activity at a configurable rate.
>=20
> This only supports can-dev based drivers, as it uses some support field=

> in the can_priv structure.
>=20
> Supported drivers should call devm_can_led_init() and can_led_event() a=
s
> needed.
>=20
> Cleanup is handled automatically by devres, so no *_exit function is
> needed.
>=20
> Supported events are:
> - CAN_LED_EVENT_OPEN: turn on tx/rx LEDs
> - CAN_LED_EVENT_STOP: turn off tx/rx LEDs
> - CAN_LED_EVENT_TX: trigger tx LED blink
> - CAN_LED_EVENT_RX: trigger tx LED blink
>=20
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>

Applied to can-next/master.

But as net-next is still closed, feel free to send Acked-by or
Tested-by. Or even code improvements.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig42AA82735C4BE3425E727619
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZGh8ACgkQjTAFq1RaXHMl/ACbB2xGplscZ57fuSmTi1B+Dyt0
XkoAni+Ne+Yq5/FTF49Kx67yHXLcNvAE
=2DYB
-----END PGP SIGNATURE-----

--------------enig42AA82735C4BE3425E727619--
