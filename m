From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v4] can: add tx/rx LED trigger support
Date: Wed, 01 Aug 2012 12:07:32 +0200
Message-ID: <5018FFE4.4010508@pengutronix.de>
References: <5017C8E4.4020003@pengutronix.de> <1343772338-1526-1-git-send-email-fabio.baltieri@gmail.com> <5018F8B3.6080404@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E15744235B95049B9CF044D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37666 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2HAKHf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 06:07:35 -0400
In-Reply-To: <5018F8B3.6080404@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E15744235B95049B9CF044D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 11:36 AM, Marc Kleine-Budde wrote:
[...]

>> +/*
>> + * Register CAN LED triggers for a CAN device
>> + *
>> + * This is normally called from a driver's probe function
>> + */
>> +void can_led_init(struct net_device *netdev)
>> +{
>> +	struct can_priv *priv =3D netdev_priv(netdev);
>> +	void *res;
>> +
>> +	res =3D devres_alloc(can_led_release, 0, GFP_KERNEL);
>                                             ^
> I'm not really sure if this is working. For example, pinctrl [1]
> allocates a double pointer here. The res pointer here and in
> can_led_release simply points to invalid memory. But as long as you
> don't dereference it, it should work.
>=20
> [1] http://lxr.free-electrons.com/source/drivers/pinctrl/core.c#L862

The pinctrl usecase if different, pinctrl needs that extra memory
because they cannot get a reference to their pinctrl they have to put.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1E15744235B95049B9CF044D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAY/+QACgkQjTAFq1RaXHMgqwCfbZzsGCrf76moLMToeQbYiZUb
j6oAniJqfHsMTVdbq5K7wLjl00iWCybI
=dz9U
-----END PGP SIGNATURE-----

--------------enig1E15744235B95049B9CF044D--
