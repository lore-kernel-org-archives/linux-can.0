From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Wed, 01 Aug 2012 23:00:04 +0200
Message-ID: <501998D4.2040206@pengutronix.de>
References: <50191EA5.1040303@pengutronix.de> <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8C91159FBEC08D7432EAD8F9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35874 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab2HAVAQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 17:00:16 -0400
In-Reply-To: <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C91159FBEC08D7432EAD8F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 08:21 PM, Fabio Baltieri wrote:
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
> ---
>=20
> Hi all,
>=20
> so, v6, change trigger names for fixed size allocation capped to (IFNAM=
SIZ + 4)
> and removed kasprintf as suggested by Oliver (thanks!).
>=20
> This also has the side effect of reducing the error path to just one ch=
eck to
> devres_alloc return value... nice!
>=20
> I've put CAN_LED_NAME_SZ definition with the active function declaratio=
n,
> but used sizeof(priv->tx_led_trig_name) as snprintf length argument in =
the
> code, as it looks cleaner to me.
>=20
> I'm not reposting the flexcan patch as it's not affected by the change.=


Pushed to can-next/master, it even compiles now, as David has included
some upstream branches.

I'm still taking Tested- and Acked-by for these patches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8C91159FBEC08D7432EAD8F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZmNsACgkQjTAFq1RaXHNvZgCghH5WeCl97InJlQge9vrL6UOb
C0oAnRb3F0kYna7RP32+yRpaAUEOGwkU
=Kvty
-----END PGP SIGNATURE-----

--------------enig8C91159FBEC08D7432EAD8F9--
