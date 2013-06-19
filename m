From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] README: fix mainline linux typo + add linebreak
Date: Wed, 19 Jun 2013 08:54:55 +0200
Message-ID: <51C155BF.10809@pengutronix.de>
References: <1371587622-21734-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HXWNDREDHOFLIRFCVXNI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154Ab3FSGzH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2013 02:55:07 -0400
In-Reply-To: <1371587622-21734-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Bernd Krumboeck <krumboeck@universalnet.at>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HXWNDREDHOFLIRFCVXNI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/18/2013 10:33 PM, Marc Kleine-Budde wrote:
> ---
> Hello Bernd,
>=20
> that was my first markdown patch, doesn't look as expected :( The docum=
entation
> says two or more tailing spaces will be converted into <br />. And I wa=
nted to
> say mainline linux.
>=20
> regards,
> Marc
>=20
>  README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/README.md b/README.md
> index 2b80717..8a32d0f 100644
> --- a/README.md
> +++ b/README.md
> @@ -3,7 +3,7 @@ CAN driver for UAB "8 devices" USB2CAN converter
> =20
>  Note
>  ----
> -The "8 devices" USB2CAN converter is supported by main linux since ver=
sion 3.9.
> +The "8 devices" USB2CAN converter is supported by mainline linux since=
 version 3.9. =20

The git magic (or you) removed the two trailing whitespace, according to
the original documentation two (or more) trailing whitespace are a line
break.

I wanted that this:

>  THIS SOFTWARE COMES WITHOUT ANY WARRANTY!

to go into a separate line.

But I'm fine with the current README, no more patches :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2HXWNDREDHOFLIRFCVXNI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHBVcIACgkQjTAFq1RaXHNTuwCdEfa09pn7BIm3sSaH7e6J0QPk
TtAAoIgBTmDDm4j5CGibyNjS+9T1pyOf
=rB72
-----END PGP SIGNATURE-----

------enig2HXWNDREDHOFLIRFCVXNI--
