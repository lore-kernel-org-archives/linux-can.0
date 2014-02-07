From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] libsocketcan: Initialize stack variables properly
Date: Fri, 07 Feb 2014 10:40:30 +0100
Message-ID: <52F4AA0E.9080704@pengutronix.de>
References: <1391764887-9085-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d65MmACAupeTgd2hMsbdworCLfM8vALbG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35162 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbaBGJkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Feb 2014 04:40:32 -0500
In-Reply-To: <1391764887-9085-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d65MmACAupeTgd2hMsbdworCLfM8vALbG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2014 10:21 AM, Alexander Shiyan wrote:
> Stack variables may have unpredictable data if it not initialized.
> This patch adds the necessary cleanup stack variables.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  src/libsocketcan.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> index 02714ae..4e7842f 100644
> --- a/src/libsocketcan.c
> +++ b/src/libsocketcan.c
> @@ -705,6 +705,7 @@ int can_do_stop(const char *name)
>   */
>  int can_do_restart(const char *name)
>  {
> +	struct req_info req;
>  	int err =3D -1;
>  	int state;
>  	__u32 restart_ms;
> @@ -731,11 +732,10 @@ int can_do_restart(const char *name)
>  		goto err_out;
>  	}
> =20
> -	struct req_info req_info =3D {
> -		.restart =3D 1,
> -	};
> +	memset(&req, 0, sizeof(req));
> +	req.restart =3D 1;

This is equivalent, all other members of req_info are set to 0x0,
guaranteed by C standard. It was added with C99 and support by gcc for a
long time.

If think we can drop the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--d65MmACAupeTgd2hMsbdworCLfM8vALbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL0qg4ACgkQjTAFq1RaXHNm/gCePb2MPUCxNB7TD67fCdlUMEDt
NlcAn1aFJKKcdEnZGG9Je3roBhZT6Lrh
=53Cb
-----END PGP SIGNATURE-----

--d65MmACAupeTgd2hMsbdworCLfM8vALbG--
