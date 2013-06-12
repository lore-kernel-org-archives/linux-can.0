From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Wed, 12 Jun 2013 14:06:19 +0200
Message-ID: <51B8643B.1020507@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com> <20130612114159.GD13274@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TUJTWFEIUKFFNXRHJWOX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60353 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab3FLMGb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Jun 2013 08:06:31 -0400
In-Reply-To: <20130612114159.GD13274@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TUJTWFEIUKFFNXRHJWOX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/12/2013 01:42 PM, Shawn Guo wrote:
> On Wed, Jun 05, 2013 at 04:27:24PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Instead of using a GPIO to turn on/off the CAN transceiver, it is bett=
er to
>> use a regulator as some systems may use a PMIC to power the CAN transc=
eiver.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |  2 +
>>  arch/arm/boot/dts/imx28-evk.dts                    | 11 +++++
>>  arch/arm/mach-mxs/mach-mxs.c                       | 54 ++-----------=
---------
>=20
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Tnx, I (back) ported the patch to current net-next/master, resulting in
this diff between the patches.

        of_platform_populate(NULL, of_default_bus_match_table,
--                           mxs_auxdata_lookup, parent);
-+                           NULL, parent);
+-                           mxs_auxdata_lookup, NULL);
++                           NULL, NULL);

Hope it's alright to keep your Acked-by. I will post the resulting patch
set soon, but I want to test it on real hardware next Monday.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TUJTWFEIUKFFNXRHJWOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG4ZEAACgkQjTAFq1RaXHMtTACgjGjg3bGwF4RdrtCK+UDqeeNT
0kEAnRq9oKtvkT3bzdIYOtQboo8GF3ZA
=oql+
-----END PGP SIGNATURE-----

------enig2TUJTWFEIUKFFNXRHJWOX--
