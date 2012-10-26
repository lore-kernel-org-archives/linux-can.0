From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: add option to ignore ENOBUFS
Date: Fri, 26 Oct 2012 11:46:45 +0200
Message-ID: <508A5C05.6050803@pengutronix.de>
References: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB62B95B55DA5E161301C0FD7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37323 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab2JZJqy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Oct 2012 05:46:54 -0400
In-Reply-To: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB62B95B55DA5E161301C0FD7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/26/2012 11:42 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> -f option replicated -i option from cangen and allows to
> ignore ENOBUFS error in bridge mode

Better not ignore, but handle the error. If socket would support, wait
with select/poll that the socket get writable and try again. For now
sleep and try again. (or fix the poll/select bug in the kernel).

Marc

> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  candump.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/candump.c b/candump.c
> index ac51192..3a6be62 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -53,6 +53,7 @@
>  #include <ctype.h>
>  #include <libgen.h>
>  #include <time.h>
> +#include <errno.h>
> =20
>  #include <sys/time.h>
>  #include <sys/types.h>
> @@ -122,6 +123,7 @@ void print_usage(char *prg)
>  	fprintf(stderr, "         -r <size>   (set socket receive buffer to <=
size>)\n");
>  	fprintf(stderr, "         -d          (monitor dropped CAN frames)\n"=
);
>  	fprintf(stderr, "         -e          (dump CAN error frames in human=
-readable format)\n");
> +	fprintf(stderr, "         -f          (ignore -ENOBUFS return values =
on write() syscalls)\n");
>  	fprintf(stderr, "\n");
>  	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets ca=
n be specified\n", MAXSOCK);
>  	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n=
");
> @@ -211,6 +213,7 @@ int main(int argc, char **argv)
>  	unsigned char view =3D 0;
>  	unsigned char log =3D 0;
>  	unsigned char logfrmt =3D 0;
> +	unsigned char ignore_enobufs =3D 0;
>  	int count =3D 0;
>  	int rcvbuf_size =3D 0;
>  	int opt, ret;
> @@ -236,7 +239,7 @@ int main(int argc, char **argv)
>  	last_tv.tv_sec  =3D 0;
>  	last_tv.tv_usec =3D 0;
> =20
> -	while ((opt =3D getopt(argc, argv, "t:ciaSs:b:B:u:ldLn:r:he?")) !=3D =
-1) {
> +	while ((opt =3D getopt(argc, argv, "ft:ciaSs:b:B:u:ldLn:r:he?")) !=3D=
 -1) {
>  		switch (opt) {
>  		case 't':
>  			timestamp =3D optarg[0];
> @@ -347,6 +350,10 @@ int main(int argc, char **argv)
>  			}
>  			break;
> =20
> +		case 'f':
> +			ignore_enobufs =3D 1;
> +			break;
> +
>  		default:
>  			print_usage(basename(argv[0]));
>  			exit(1);
> @@ -625,8 +632,14 @@ int main(int argc, char **argv)
> =20
>  					nbytes =3D write(bridge, &frame, sizeof(struct can_frame));
>  					if (nbytes < 0) {
> -						perror("bridge write");
> -						return 1;
> +						if (errno !=3D ENOBUFS) {
> +							perror("bridge write");
> +							return 1;
> +						}
> +						if (!ignore_enobufs) {
> +							perror("bridge write");
> +							return 1;
> +						}
>  					} else if ((size_t)nbytes < sizeof(struct can_frame)) {
>  						fprintf(stderr,"bridge write: incomplete CAN frame\n");
>  						return 1;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB62B95B55DA5E161301C0FD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCKXAsACgkQjTAFq1RaXHMu4wCfYWUs7WdXTS+ZkSHys/W/H5jL
UKsAoITdri5Bg9idhxqdW82D1k646qmL
=y+bQ
-----END PGP SIGNATURE-----

--------------enigB62B95B55DA5E161301C0FD7--
