From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: Add timeout option if no message has been received
Date: Tue, 12 Feb 2013 11:51:13 +0100
Message-ID: <511A1EA1.7050607@pengutronix.de>
References: <1360665082-14256-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QGENXANKPQXMCXLDGENP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52161 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3BLNxR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 08:53:17 -0500
In-Reply-To: <1360665082-14256-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QGENXANKPQXMCXLDGENP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/12/2013 11:31 AM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

I get a new warning with your patch:

candump.c:231: warning: 'timeout_config' is used uninitialized in this
function

I think the compiler is not smart enough :)

> ---
>  candump.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/candump.c b/candump.c
> index bf3e8bb..7fce1d3 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -121,6 +121,7 @@ void print_usage(char *prg)
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
> @@ -227,6 +228,7 @@ int main(int argc, char **argv)
>  	int nbytes, i, maxdlen;
>  	struct ifreq ifr;
>  	struct timeval tv, last_tv;
> +	struct timeval timeout, timeout_config, *timeout_current =3D NULL;
>  	FILE *logfile =3D NULL;
> =20
>  	signal(SIGTERM, sigterm);
> @@ -236,7 +238,7 @@ int main(int argc, char **argv)
>  	last_tv.tv_sec  =3D 0;
>  	last_tv.tv_usec =3D 0;
> =20
> -	while ((opt =3D getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:he?")) !=3D=
 -1) {
> +	while ((opt =3D getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:?")) !=3D=
 -1) {
>  		switch (opt) {
>  		case 't':
>  			timestamp =3D optarg[0];
> @@ -351,6 +353,16 @@ int main(int argc, char **argv)
>  			}
>  			break;
> =20
> +		case 'T':
> +			timeout_config.tv_usec =3D atoi(optarg);

tv_usec is a long, please use strtol() instead.

> +			if (timeout_config.tv_usec < 1) {
> +				print_usage(basename(argv[0]));
> +				exit(1);
> +			}
> +			timeout_config.tv_sec =3D timeout_config.tv_usec / 1000;
> +			timeout_config.tv_usec =3D (timeout_config.tv_usec % 1000) * 1000;
> +			timeout_current =3D &timeout;
> +			break;
>  		default:
>  			print_usage(basename(argv[0]));
>  			exit(1);
> @@ -594,7 +606,10 @@ int main(int argc, char **argv)
>  		for (i=3D0; i<currmax; i++)
>  			FD_SET(s[i], &rdfs);
> =20
> -		if ((ret =3D select(s[currmax-1]+1, &rdfs, NULL, NULL, NULL)) < 0) {=

> +		if (timeout_current)
> +			memcpy(timeout_current, &timeout_config, sizeof(timeout_config));

You may use:

    *timeout_current =3D timeout_config;

instead.

> +
> +		if ((ret =3D select(s[currmax-1]+1, &rdfs, NULL, NULL, timeout_curre=
nt)) <=3D 0) {
>  			//perror("select");
>  			running =3D 0;
>  			continue;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QGENXANKPQXMCXLDGENP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEaHqQACgkQjTAFq1RaXHP3FgCgib1oZR0aaIw+dPnfGrNrYlUz
1oAAnjMY4QDu/Ni7ulVyFZ3qRy4u+mxi
=D1Nr
-----END PGP SIGNATURE-----

------enig2QGENXANKPQXMCXLDGENP--
