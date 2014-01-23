From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] slcand: accept both tty* and /dev/tty* device names
Date: Thu, 23 Jan 2014 13:47:19 +0100
Message-ID: <52E10F57.5020000@pengutronix.de>
References: <1390466963-9519-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ox3iM0H3aAJqBpN36CWBmlXnprfRmdvOX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41360 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaAWMrZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 07:47:25 -0500
In-Reply-To: <1390466963-9519-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ox3iM0H3aAJqBpN36CWBmlXnprfRmdvOX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2014 09:49 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  slcand.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/slcand.c b/slcand.c
> index 69d30f7..f682645 100644
> --- a/slcand.c
> +++ b/slcand.c
> @@ -251,10 +251,12 @@ int main(int argc, char *argv[])
> =20
>  	/* Prepare the tty device name string */
>  	pch =3D strstr(tty, devprefix);
> -	if (pch =3D=3D tty)
> -		print_usage(argv[0]);
> +	if (pch !=3D tty) {
> +		snprintf(ttypath, TTYPATH_LENGTH, "%s%s", devprefix, tty);
> +	} else {
> +		snprintf(ttypath, TTYPATH_LENGTH, "%s", tty);
> +	}

I've remove the { } after if and else, as there is only a single line.
Applied to master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ox3iM0H3aAJqBpN36CWBmlXnprfRmdvOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLhD1cACgkQjTAFq1RaXHMhGACffdxZrCOQcMcyIiobI+Pto22o
UR4AnRi8rHmt4cAmzpuB5eEuP0LTiBhV
=zz4k
-----END PGP SIGNATURE-----

--Ox3iM0H3aAJqBpN36CWBmlXnprfRmdvOX--
