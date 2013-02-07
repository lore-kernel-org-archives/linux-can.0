From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] cangen: use long long in time computation for -g to support
 >2.1s
Date: Thu, 07 Feb 2013 11:41:56 +0100
Message-ID: <511384F4.703@pengutronix.de>
References: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net> <1360233489-14471-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QTKFSANQOBCEGDSQTDFX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56286 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab3BGKmE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 05:42:04 -0500
In-Reply-To: <1360233489-14471-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Konrad Anton <konrad.anton@awinia.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QTKFSANQOBCEGDSQTDFX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Konrad,

we're a bit oldschool and discuss the code on the
linux-can@vger.kernel.org mailinglist. Feel free to subscribe.

On 02/07/2013 11:38 AM, Marc Kleine-Budde wrote:
> From: Konrad Anton <konrad.anton@awinia.de>
>=20
> The computation of nanosleep times for the "-g" option to cangen.c (del=
ay
> between sends) overflows when more than 2100ms are given.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>=20
> This is the pull gitorious pull reqeust transformed into a standard git=
 one. :)
>=20
> Marc
>=20
>  cangen.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cangen.c b/cangen.c
> index 7518c12..db4c803 100644
> --- a/cangen.c
> +++ b/cangen.c
> @@ -269,7 +269,7 @@ int main(int argc, char **argv)
>  	}
> =20
>  	ts.tv_sec =3D gap / 1000;
> -	ts.tv_nsec =3D ((int)(gap * 1000000)) % 1000000000;
> +	ts.tv_nsec =3D (long)(((long long)(gap * 1000000)) % 1000000000ll);

What's going on here exactly?

gap is a double - Will it be converted into an int before multiplication
with 1000000? IIRC there is a difference between "gap * 1000000" and
"gap * 1000000.0". In the latter the multiplication is done in floating
point, because of the ".0".

Marc

> =20
>  	/* recognize obviously missing commandline option */
>  	if (id_mode =3D=3D MODE_FIX && frame.can_id > 0x7FF && !extended) {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QTKFSANQOBCEGDSQTDFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEThPgACgkQjTAFq1RaXHPstACghAy1r2kZpQQ+S1WfSCbUYOMI
MvwAoI2xvhfM7tEAyee9N+gz6iy42WMR
=mUX1
-----END PGP SIGNATURE-----

------enig2QTKFSANQOBCEGDSQTDFX--
