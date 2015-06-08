From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] slcand: daemonize _after_ interface is created,
 renamed and up.
Date: Mon, 8 Jun 2015 14:51:26 +0200
Message-ID: <55758FCE.4050109@pengutronix.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MQsmVGWWuwMxLA3swCx50rm5uj3tfETiG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46125 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbFHMvf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 08:51:35 -0400
In-Reply-To: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MQsmVGWWuwMxLA3swCx50rm5uj3tfETiG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2015 01:55 PM, Armin Burchardt wrote:
> Create interface, then daemonize to avoid race-conditions,
> ie. in init.d-scripts.
>=20
> Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
> ---
>  slcand.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/slcand.c b/slcand.c
> index e5e4752..af7ca98 100644
> --- a/slcand.c
> +++ b/slcand.c
> @@ -255,23 +255,7 @@ int main(int argc, char *argv[])
> =20
>  	syslog(LOG_INFO, "starting on TTY device %s", ttypath);
> =20
> -	/* Daemonize */
> -	if (run_as_daemon) {
> -		if (daemon(0, 0)) {
> -			syslog(LOG_ERR, "failed to daemonize");
> -			exit(EXIT_FAILURE);
> -		}
> -	}
> -	else {
> -		/* Trap signals that we expect to receive */
> -		signal(SIGINT, child_handler);
> -		signal(SIGTERM, child_handler);
> -	}
> -
> -	/* */
> -	slcand_running =3D 1;
> -
> -	/* Now we are a daemon -- do the work for which we were paid */
> +	/* Create file handle for tty device. */
>  	fd =3D open(ttypath, O_RDWR | O_NONBLOCK | O_NOCTTY);
>  	if (fd < 0) {
>  		syslog(LOG_NOTICE, "failed to open TTY device %s\n", ttypath);
> @@ -365,6 +349,23 @@ int main(int argc, char *argv[])
>  		}=09
>  	}
> =20
> +	/* Daemonize (_after_ interface is up to avoid race-conditions,
> +	 * ie. between init.d-scripts). */
> +	if (run_as_daemon) {
> +		if (daemon(0, 0)) {
> +			syslog(LOG_ERR, "failed to daemonize");
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +	else {

Please change to

} else {

> +		/* Trap signals that we expect to receive */
> +		signal(SIGINT, child_handler);
> +		signal(SIGTERM, child_handler);
> +	}
> +
> +	/* */

Empty comment? I know you just moved the code around :)

> +	slcand_running =3D 1;
> +
>  	/* The Big Loop */
>  	while (slcand_running)
>  		sleep(1); /* wait 1 second */
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MQsmVGWWuwMxLA3swCx50rm5uj3tfETiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVdY/PAAoJEP5prqPJtc/HIvQH/2/H8Qm8MXFF+TuXp3ELqZc2
olLGpYtSZGOaNHPKObcZjdCCbK5u4d8Y8XApH68cHzoLq8yRGzpVopc8E+V89SPn
JBRkG4S9N7aI1yC8DEXRmuJUt1c6j4Z+w9icpQ+1ePFp4h61vvNLFjLgIDHPgLWv
IUEeop2NBmMVLs/SCgT+gxNzB3m79GF7yqutlpRJV2MquKQT5J57d0q/h2fk9ZHF
wqFujlLZW9//XO1CG5ejJXpRILJQH7BrbtyIP2MQs5xuURbB2oczF5Q6H1HdFEmf
9lOsXvH5XAn9CrR2igm7X23UU0zdIntUzeKExsSnatD8I9uUc0CBSWtg45Lf23Q=
=BCs3
-----END PGP SIGNATURE-----

--MQsmVGWWuwMxLA3swCx50rm5uj3tfETiG--
