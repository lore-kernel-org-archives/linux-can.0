From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] add 'v' command response
Date: Thu, 7 May 2015 16:24:33 +0200
Message-ID: <554B75A1.8030407@pengutronix.de>
References: <1431008428-22567-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Cu8cv56cX8pVG4dTjTew6eiAP5xTEs8iB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50302 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbEGOYh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 May 2015 10:24:37 -0400
in-reply-to: <1431008428-22567-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bombilee <chenglung@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cu8cv56cX8pVG4dTjTew6eiAP5xTEs8iB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello bombilee,

On 05/07/2015 04:20 PM, Marc Kleine-Budde wrote:
> diff --git a/slcanpty.c b/slcanpty.c
> index c062a027da41..f485ac775a53 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -185,6 +185,13 @@ rx_restart:
>  		ptr =3D 1;
>  		goto rx_out;
>  	}
> +	/* check for 'v'ersion command */
> +	if (cmd =3D=3D 'v') {
> +		sprintf(replybuf, "v1014\r");

Is there a special meaning behing "v1014"? Where does the string come fro=
m?

> +		tmp =3D strlen(replybuf);
> +		ptr =3D 1;
> +		goto rx_out;
> +	}
> =20
>  	/* check for serial 'N'umber command */
>  	if (cmd =3D=3D 'N') {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Cu8cv56cX8pVG4dTjTew6eiAP5xTEs8iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVS3WhAAoJECte4hHFiupUniQP/23xxP78kaSKn5XOPwf6DC2y
FX9RU5HrbK3PHiwY1dHsndMQmHkQ4NYF9yZPIYgOzZXNCQoM4Y4/PcZBOJ2BCZWE
04bAlMayjVh0nolU/lQLRMh5uMbuQYVuGVn1plvIxEv4npTaPtjQm9n8rJId3F6V
O325XPNiDziJCLNnDNViwPP4BfqlspFpi7CN/Or35v/nhE6FPy6UkSGgekXykERh
3fmDfmp3dwiAbqlJShL8xxDfOJAlpOI+bhgmdMAtjSEt7j92w+/CYyG10ETKldQo
EdIMwunw6RuJB55stsm999RTJDa9vUldSFV6LtbReCSZr1Wv3vG9YqKj4/RKGVm8
CyhdETAAcVp4wwDnKgi5PqVjW0fD7EpL63VZdgsQGCkk0wWm3+VXTz1FiGMWLxk6
7hOj3Mb8yONx8US14RAEuxAuocNhTxGIwe5tYQKgJCZp4A75ri614jmRKsyPHrCq
LoEYwH85nLAut6cNdj8W4phTGqNjf5bEmkyG8yXRtlMCPH6e/cWe4DZK0VS07u/z
t4uqq0YoKC0WGLRfpw3Rnofoyg6WhCC+KbyWQSWTkIVWbXjfdF5wiYI+pkDNAG1b
Y/o/KQWKZ3fKKlnqDvBbgXLEn0zncuZxXt2MDEOeBavCLYE7G2qrTMhQmC/QBaMK
LW3tuJnQTuPfLeFjkVGL
=5t9S
-----END PGP SIGNATURE-----

--Cu8cv56cX8pVG4dTjTew6eiAP5xTEs8iB--
