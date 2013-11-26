From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
Date: Tue, 26 Nov 2013 09:26:40 +0100
Message-ID: <52945B40.5020200@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de> <20131126045340.GJ30476@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dRX9KlK0Jovp82fTCObgRFfxBW616S1OK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab3KZI0w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2013 03:26:52 -0500
In-Reply-To: <20131126045340.GJ30476@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dRX9KlK0Jovp82fTCObgRFfxBW616S1OK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/26/2013 05:53 AM, Shawn Guo wrote:
>> this series first fixes a bug in the flexcan driver, using the wrong c=
lock for
>> the bit rate calculcation. The next patch switches the peripheral cloc=
k on
>> i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the =
CIA
>> recommended bit rates.
>>
>> Tested on TQ's mba53 and mba6x [1].
>>
>> Who is taking the series? Due to Lucas' patch:
>>
>>     0a5b8df clk: imx5: introduce DT includes for clock provider
>>
>> this series does not yet apply to my upstream (net-next/mastet).
>=20
> If the clock setting in flexcan driver is already broken, it shouldn't
> matter to have two patches go different tree?  Otherwise, I can have
> both go via IMX tree with your ACK on the first one?

The problem is, that the wrong clock is being used. An all i.mx, but not
on imx6, both clocks are the same, the bug doesn't show up. So before we
can use the 24 MHz clock on mx53, we have to fix the driver.

Feel free to add my Acked-by to the first patch and take it via your tree=
=2E

>> [1] On i.MX6 the following patch is needed (which is already in Shawn'=
s
>>     for-next):
>>
>>     9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock
>=20
> This one already hits mainline.

But not net-next/master, which is my upstream.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dRX9KlK0Jovp82fTCObgRFfxBW616S1OK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKUW0AACgkQjTAFq1RaXHPcmACfcQI90bOrZsgrMBNTeIKlxD2Q
OC0AnAyz8RqfpQu20shp4jICi0NqZGE+
=qpnJ
-----END PGP SIGNATURE-----

--dRX9KlK0Jovp82fTCObgRFfxBW616S1OK--
