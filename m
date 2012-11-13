From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Use strlen instead of sizeof on char* string
Date: Tue, 13 Nov 2012 21:26:50 +0100
Message-ID: <50A2AD0A.6040005@pengutronix.de>
References: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDAE1B5A1A076C80D2B0EB9E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53554 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab2KMU05 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Nov 2012 15:26:57 -0500
In-Reply-To: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDAE1B5A1A076C80D2B0EB9E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/13/2012 04:47 PM, Alexander Stein wrote:
> This bug was detected by the clang warning:
> libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' call
> is the same expression as the source; did you mean to provide an
> explicit length? [-Wsizeof-pointer-memaccess]
> sizeof(name)) !=3D 0)
> ~~~~~~~^~~~~~
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  src/libsocketcan.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> index fedcbdc..3ad2a6c 100644
> --- a/src/libsocketcan.c
> +++ b/src/libsocketcan.c
> @@ -364,6 +364,7 @@ static int do_get_nl_link(int fd, __u8 acquire, con=
st char *name, void *res)
>  		     nl_msg =3D NLMSG_NEXT(nl_msg, u_msglen)) {
>  			int type =3D nl_msg->nlmsg_type;
>  			int len;
> +			int namelen =3D strlen(name);
> =20
>  			if (type =3D=3D NLMSG_DONE) {
>  				done++;
> @@ -381,7 +382,7 @@ static int do_get_nl_link(int fd, __u8 acquire, con=
st char *name, void *res)
> =20
>  			if (strncmp
>  			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
> -			     sizeof(name)) !=3D 0)
> +			     namelen) !=3D 0)

What about using strcmp() instead. AFAIK it will compare until it finds
the end of the string in one of the strings, so it should be no
difference here?

>  				continue;
> =20
>  			if (tb[IFLA_LINKINFO])
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDDAE1B5A1A076C80D2B0EB9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCirQ4ACgkQjTAFq1RaXHM4hgCeKjqugyyfnsQSwpLnL3OS2frX
mv8AniB2NI3DiNo5okndW0HHXyBtMjA7
=7ZzR
-----END PGP SIGNATURE-----

--------------enigDDAE1B5A1A076C80D2B0EB9E--
