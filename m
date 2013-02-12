From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] candump: Add timeout option if no message has been
 received
Date: Tue, 12 Feb 2013 17:56:08 +0100
Message-ID: <511A7428.8040202@pengutronix.de>
References: <511A4C8B.3030605@pengutronix.de> <1360687851-1849-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NKOMGJTCUOLVJNPVJSWB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49586 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab3BLQ4P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 11:56:15 -0500
In-Reply-To: <1360687851-1849-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NKOMGJTCUOLVJNPVJSWB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/12/2013 05:50 PM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v3 (v2 was bogus)
> * Use strtol instead of atoi
> * Change memcpy to direct struct copy
>=20
>  candump.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/candump.c b/candump.c
> index bf3e8bb..457af9d 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -49,6 +49,7 @@
>  #include <ctype.h>
>  #include <libgen.h>
>  #include <time.h>
> +#include <errno.h>
> =20
>  #include <sys/time.h>
>  #include <sys/types.h>
> @@ -121,6 +122,7 @@ void print_usage(char *prg)
>  	fprintf(stderr, "         -d          (monitor dropped CAN frames)\n"=
);
>  	fprintf(stderr, "         -e          (dump CAN error frames in human=
-readable format)\n");
>  	fprintf(stderr, "         -x          (print extra message infos, rx/=
tx brs esi)\n");
> +	fprintf(stderr, "         -T <msecs>  (terminate after <msecs> withou=
t any reception)\n");
>  	fprintf(stderr, "\n");
>  	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets ca=
n be specified\n", MAXSOCK);
>  	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n=
");
> @@ -227,6 +229,7 @@ int main(int argc, char **argv)
>  	int nbytes, i, maxdlen;
>  	struct ifreq ifr;
>  	struct timeval tv, last_tv;
> +	struct timeval timeout, timeout_config, *timeout_current =3D NULL;

I'll change this into
	struct timeval timeout, timeout_config =3D { 0, 0 }, *timeout_current =3D=
 NULL;

To make my old compiler happy.

Applied.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NKOMGJTCUOLVJNPVJSWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEadCwACgkQjTAFq1RaXHMWfQCgjB9Rd7EO8D4f2aCHyzq8tBl2
jncAn0/RbpPFnomB21Na4jgjZzLfpJ0M
=3E6W
-----END PGP SIGNATURE-----

------enig2NKOMGJTCUOLVJNPVJSWB--
