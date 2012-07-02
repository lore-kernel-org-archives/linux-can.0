From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] arm: imx: enable flexcan on imx25, imx35, imx53,
 imx6q
Date: Mon, 02 Jul 2012 09:54:08 +0200
Message-ID: <4FF153A0.3030404@pengutronix.de>
References: <1341175565-13218-1-git-send-email-mkl@pengutronix.de> <1341175565-13218-2-git-send-email-mkl@pengutronix.de> <20120702075054.GF2698@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4DA5515A74A6F47DB6C7FBD4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2GBHyR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 03:54:17 -0400
In-Reply-To: <20120702075054.GF2698@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sascha Hauer <sha@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DA5515A74A6F47DB6C7FBD4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 09:50 AM, Sascha Hauer wrote:
> On Sun, Jul 01, 2012 at 10:46:04PM +0200, Marc Kleine-Budde wrote:
>> Cc: Sascha Hauer <sha@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/Kconfig |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index eff4db5..c296851 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -52,6 +52,7 @@ config SOC_IMX25
>>  	select ARCH_MX25
>>  	select COMMON_CLK
>>  	select CPU_ARM926T
>> +	select HAVE_CAN_FLEXCAN if CAN
>=20
> Do we need the 'if CAN' here? It seems yes, since HAVE_CAN_FLEXCAN is
> inside the "CAN Device Drivers" menu which depends on CAN. Shouldn't th=
e
> HAVE_CAN_FLECAN be outside the menu?

Yes, we can move the HAVE_CAN_FLEXCAN outside of that menu, but it still
depends on CONFIG_NET.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4DA5515A74A6F47DB6C7FBD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xU6QACgkQjTAFq1RaXHOY9wCdE2dW81o/qw3aR69CwjPkRPBp
NZAAn1A61t/XcscWw/4A69JnZmkBN+4g
=+Alb
-----END PGP SIGNATURE-----

--------------enig4DA5515A74A6F47DB6C7FBD4--
