From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] slcand: add option -p<file> to write pid to a file.
Date: Mon, 8 Jun 2015 15:00:21 +0200
Message-ID: <557591E5.2080706@pengutronix.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
 <1433764540-24917-2-git-send-email-armin@uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DEUqH22Afbpnhau7fht1ufQFksK1oBlN6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbFHNA3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 09:00:29 -0400
In-Reply-To: <1433764540-24917-2-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DEUqH22Afbpnhau7fht1ufQFksK1oBlN6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2015 01:55 PM, Armin Burchardt wrote:
> Useful in combination with start-stop-daemon.
>=20
> Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
> ---
>  slcand.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/slcand.c b/slcand.c
> index af7ca98..8fd1418 100644
> --- a/slcand.c
> +++ b/slcand.c
> @@ -64,11 +64,13 @@ void print_usage(char *prg)
>  	fprintf(stderr, "         -t <type>  (set UART flow control type 'hw'=
 or 'sw')\n");
>  	fprintf(stderr, "         -b <btr>   (set bit time register value)\n"=
);
>  	fprintf(stderr, "         -F         (stay in foreground; no daemoniz=
e)\n");
> +	fprintf(stderr, "         -p <file>  (write PID of daemon to file)\n"=
);
>  	fprintf(stderr, "         -h         (show this help page)\n");
>  	fprintf(stderr, "\nExamples:\n");
>  	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0\n");
>  	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0 can0\n");
>  	fprintf(stderr, "slcand -o -c -f -s6 /dev/ttyUSB0\n");
> +	fprintf(stderr, "slcand -o -c -f -s6 -p/var/run/slcand-can0.pid /dev/=
ttyUSB0\n");

I think "/run/slcand/<IFACE>" would fit better into modern file system
layout. What about having a default for the pid file path?

>  	fprintf(stderr, "\n");
>  	exit(EXIT_FAILURE);
>  }
> @@ -178,12 +180,13 @@ int main(int argc, char *argv[])
>  	char *btr =3D NULL;
>  	int run_as_daemon =3D 1;
>  	char *pch;
> +	char *pidfile =3D NULL;
>  	int ldisc =3D N_SLCAN;
>  	int fd;
> =20
>  	ttypath[0] =3D '\0';
> =20
> -	while ((opt =3D getopt(argc, argv, "ocfs:S:t:b:?hF")) !=3D -1) {
> +	while ((opt =3D getopt(argc, argv, "ocfs:S:t:b:p:?hF")) !=3D -1) {
>  		switch (opt) {
>  		case 'o':
>  			send_open =3D 1;
> @@ -228,6 +231,9 @@ int main(int argc, char *argv[])
>  		case 'F':
>  			run_as_daemon =3D 0;
>  			break;
> +		case 'p':
> +			pidfile =3D optarg;
> +			break;
>  		case 'h':
>  		case '?':
>  		default:
> @@ -363,6 +369,27 @@ int main(int argc, char *argv[])
>  		signal(SIGTERM, child_handler);
>  	}
> =20
> +	/* write pidfile */
> +	if (pidfile) {
> +		FILE *pidfd;
> +		pidfd =3D fopen(pidfile, "w");
> +		if (pidfd =3D=3D NULL) {

if (!pidfd)

Does it make sense to open in exclusive mode?

Technically speaking, it's not a file descriptor "fd" :)

> +			syslog(LOG_ERR, "could not open pidfile");
> +			perror(pidfile);
> +			exit(EXIT_FAILURE);
> +		}
> +		if (fprintf(pidfd, "%i\n", getpid()) < 0) {
> +			syslog(LOG_ERR, "could not write to pidfile");
> +			perror(pidfile);
> +			exit(EXIT_FAILURE);
> +		}
> +		if (fclose(pidfd) !=3D 0) {
> +			syslog(LOG_ERR, "could not close pidfile");
> +			perror(pidfile);
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
>  	/* */
>  	slcand_running =3D 1;
> =20
> @@ -391,6 +418,13 @@ int main(int argc, char *argv[])
>  	if (tcsetattr(fd, TCSADRAIN, &tios) < 0)
>  		syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n",=
 ttypath, strerror(errno));
> =20
> +	/* Remove pidfile */
> +	if (pidfile) {
> +		if (unlink(pidfile) < 0) {
> +			syslog(LOG_ERR, "Can not remove pidfile '%s': %s", pidfile, strerro=
r(errno));
> +		}
> +	}
> +
>  	/* Finish up */
>  	syslog(LOG_NOTICE, "terminated on %s", ttypath);
>  	closelog();
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DEUqH22Afbpnhau7fht1ufQFksK1oBlN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVdZHlAAoJEP5prqPJtc/HQ04H/1Wxg8Qb3u6ivkNm2aHZz18m
ZuRFCwPSlE1j71firK5j0NU3BF6KYQVKZJgDpiJ/hmvnVakCFvix2SIDkRdSLIJh
EdRRpn5fKEH4CMQb17ZxE2tRjxIfe8Le/do/iWFk9UYASJCBSCHd6w03MOt3F1rY
2/2WUav5lm6ohQuLFdCfsltk2AnnrGBK1Tj9m8p5hD1TXR/YE25R6Ikh5Dt1ikM7
ED/sMbYR6kn8UZ5TWmk+esjb0Yd2VG4gH3opCgYfkJ3apa37mE0HfOP8hG2r3DNk
zkJs4Ys2kXiR3VDNS1O76ZdeuWewdW3aGE0YisXzlymDS28Qii/WgsubGJGPssE=
=RdLh
-----END PGP SIGNATURE-----

--DEUqH22Afbpnhau7fht1ufQFksK1oBlN6--
