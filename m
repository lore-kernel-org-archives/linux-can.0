From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: resolve signedness warnings
Date: Thu, 19 Apr 2012 10:54:25 +0200
Message-ID: <4F8FD2C1.8010903@pengutronix.de>
References: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB7F5DF729634A49198EED9E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33791 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab2DSIyd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 04:54:33 -0400
In-Reply-To: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB7F5DF729634A49198EED9E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/19/2012 09:44 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

nbytes has been tested before if it's < 0, so it's safe to cast it to an
unsigned value.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Oliver do you want to take the patch?

Marc

> ---
>  candump.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/candump.c b/candump.c
> index 5ba9431..ac51192 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -611,7 +611,7 @@ int main(int argc, char **argv)
>  					return 1;
>  				}
> =20
> -				if (nbytes < sizeof(struct can_frame)) {
> +				if ((size_t)nbytes < sizeof(struct can_frame)) {
>  					fprintf(stderr, "read: incomplete CAN frame\n");
>  					return 1;
>  				}
> @@ -627,7 +627,7 @@ int main(int argc, char **argv)
>  					if (nbytes < 0) {
>  						perror("bridge write");
>  						return 1;
> -					} else if (nbytes < sizeof(struct can_frame)) {
> +					} else if ((size_t)nbytes < sizeof(struct can_frame)) {
>  						fprintf(stderr,"bridge write: incomplete CAN frame\n");
>  						return 1;
>  					}


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEB7F5DF729634A49198EED9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+P0sQACgkQjTAFq1RaXHOcGwCfatT9PE8LhBijXWV+pWpFZcwP
tI0An35Dm3Eo3HlRZTfXy4fhadQSA/Wl
=x51B
-----END PGP SIGNATURE-----

--------------enigEB7F5DF729634A49198EED9E--
