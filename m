From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: Add possibility to specify logfile
Date: Wed, 21 Aug 2013 10:28:23 +0200
Message-ID: <52147A27.9020601@pengutronix.de>
References: <1377073026-30202-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kBu1940v5h7cxD9gCuK9Fc6hPt5413DuW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39126 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3HUI2d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 04:28:33 -0400
In-Reply-To: <1377073026-30202-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kBu1940v5h7cxD9gCuK9Fc6hPt5413DuW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 10:17 AM, Alexander Stein wrote:
> You need to use -l/tmp/logfile (wihtout space!) because -l takes an
> optional parameter.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Please use the Kernel Coding Style.

Marc

> ---
>  candump.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/candump.c b/candump.c
> index c865bd7..72193fc 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -115,7 +115,7 @@ void print_usage(char *prg)
>  	fprintf(stderr, "         -b <can>    (bridge mode - send received fr=
ames to <can>)\n");
>  	fprintf(stderr, "         -B <can>    (bridge mode - like '-b' with d=
isabled loopback)\n");
>  	fprintf(stderr, "         -u <usecs>  (delay bridge forwarding by <us=
ecs> microseconds)\n");
> -	fprintf(stderr, "         -l          (log CAN-frames into file. Sets=
 '-s %d' by default)\n", SILENT_ON);
> +	fprintf(stderr, "         -l[logfile] (log CAN-frames into file. Sets=
 '-s %d' by default)\n", SILENT_ON);
>  	fprintf(stderr, "         -L          (use log file format on stdout)=
\n");
>  	fprintf(stderr, "         -n <count>  (terminate after receiption of =
<count> CAN frames)\n");
>  	fprintf(stderr, "         -r <size>   (set socket receive buffer to <=
size>)\n");
> @@ -231,6 +231,7 @@ int main(int argc, char **argv)
>  	struct timeval tv, last_tv;
>  	struct timeval timeout, timeout_config =3D { 0, 0 }, *timeout_current=
 =3D NULL;
>  	FILE *logfile =3D NULL;
> +	const char* fname =3D NULL;

chat *fname

> =20
>  	signal(SIGTERM, sigterm);
>  	signal(SIGHUP, sigterm);
> @@ -239,7 +240,7 @@ int main(int argc, char **argv)
>  	last_tv.tv_sec  =3D 0;
>  	last_tv.tv_usec =3D 0;
> =20
> -	while ((opt =3D getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:?")) !=3D=
 -1) {
> +	while ((opt =3D getopt(argc, argv, "t:ciaSs:b:B:u:l::dxLn:r:heT:?")) =
!=3D -1) {
>  		switch (opt) {
>  		case 't':
>  			timestamp =3D optarg[0];
> @@ -324,6 +325,7 @@ int main(int argc, char **argv)
> =20
>  		case 'l':
>  			log =3D 1;
> +			fname =3D optarg;
>  			break;
> =20
>  		case 'd':
> @@ -566,22 +568,27 @@ int main(int argc, char **argv)
>  	if (log) {
>  		time_t currtime;
>  		struct tm now;
> -		char fname[sizeof("candump-2006-11-20_202026.log")+1];
> +		char filename[sizeof("candump-2006-11-20_202026.log")+1];
                                                                    ^^^^

Space between  ) and +
> =20
> -		if (time(&currtime) =3D=3D (time_t)-1) {
> -			perror("time");
> -			return 1;
> -		}
> +		if (fname =3D=3D NULL)
> +		{

if () {

> +			if (time(&currtime) =3D=3D (time_t)-1) {
> +				perror("time");
> +				return 1;
> +			}
> +
> +			localtime_r(&currtime, &now);
> =20
> -		localtime_r(&currtime, &now);
> +			sprintf(filename, "candump-%04d-%02d-%02d_%02d%02d%02d.log",
> +				now.tm_year + 1900,
> +				now.tm_mon + 1,
> +				now.tm_mday,
> +				now.tm_hour,
> +				now.tm_min,
> +				now.tm_sec);
> =20
> -		sprintf(fname, "candump-%04d-%02d-%02d_%02d%02d%02d.log",
> -			now.tm_year + 1900,
> -			now.tm_mon + 1,
> -			now.tm_mday,
> -			now.tm_hour,
> -			now.tm_min,
> -			now.tm_sec);
> +			fname =3D filename;
> +		}
> =20
>  		if (silent !=3D SILENT_ON)
>  			printf("\nWarning: console output active while logging!");
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kBu1940v5h7cxD9gCuK9Fc6hPt5413DuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIUeicACgkQjTAFq1RaXHOAEwCfbMTxCT/tO+g09dUzCccASE8m
KfQAniseDbXorD+vWGMF52MoIgU8yBZl
=C0Jc
-----END PGP SIGNATURE-----

--kBu1940v5h7cxD9gCuK9Fc6hPt5413DuW--
