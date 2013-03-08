From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
Date: Fri, 08 Mar 2013 18:44:54 +0100
Message-ID: <513A2396.4080508@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com> <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XQTHXKXTJEXLFUMSUIVJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab3CHRpH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 12:45:07 -0500
In-Reply-To: <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ludovic.desroches@atmel.com
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XQTHXKXTJEXLFUMSUIVJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> SAMA5D3 devices also embed CAN feature. Moreover if we want to produce =
a single
> kernel image (at least for Atmel devices) it is not useful to be too
> restrictive.

If it compiles on other ARMs aswell we can make it depend on ARCH_ARM.

Marc
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/net/can/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 9862b2e..27311c3 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -65,7 +65,7 @@ config CAN_LEDS
> =20
>  config CAN_AT91
>  	tristate "Atmel AT91 onchip CAN controller"
> -	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
> +	depends on ARCH_AT91
>  	---help---
>  	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
>  	  and AT91SAM9X5 processors.
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XQTHXKXTJEXLFUMSUIVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE6I5YACgkQjTAFq1RaXHNuwwCgh703fYdNpFAeKYMcllEr2dWd
BHQAnA65WPPrp0CmVhh8gkt/Z1I26vw2
=VKX3
-----END PGP SIGNATURE-----

------enig2XQTHXKXTJEXLFUMSUIVJ--
