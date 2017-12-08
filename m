From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] slip: sl_alloc(): remove unused parameter "dev_t line"
Date: Fri, 8 Dec 2017 12:22:55 +0100
Message-ID: <39d83463-b20d-3739-7e84-f1f51919e9e5@pengutronix.de>
References: <20171208111859.6090-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lAUhpgCv4ewKbt1HGmKRucgfKHNOtqXL9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37961 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753330AbdLHLXB (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 8 Dec 2017 06:23:01 -0500
In-Reply-To: <20171208111859.6090-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lAUhpgCv4ewKbt1HGmKRucgfKHNOtqXL9
Content-Type: multipart/mixed; boundary="IjKN1Xk4p4D5jMOhqsBPvnfQE8j5HhVwB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de, linux-can <linux-can@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <39d83463-b20d-3739-7e84-f1f51919e9e5@pengutronix.de>
Subject: Re: [PATCH] slip: sl_alloc(): remove unused parameter "dev_t line"
References: <20171208111859.6090-1-mkl@pengutronix.de>
In-Reply-To: <20171208111859.6090-1-mkl@pengutronix.de>

--IjKN1Xk4p4D5jMOhqsBPvnfQE8j5HhVwB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

I've the corresponding slcan patch already in my queue.

Marc

On 12/08/2017 12:18 PM, Marc Kleine-Budde wrote:
> The first and only parameter of sl_alloc() is unused, so remove it.
>=20
> Fixes: 5342b77c4123 slip: ("Clean up create and destroy")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/slip/slip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
> index cc63102ca96e..8940417c30e5 100644
> --- a/drivers/net/slip/slip.c
> +++ b/drivers/net/slip/slip.c
> @@ -731,7 +731,7 @@ static void sl_sync(void)
> =20
> =20
>  /* Find a free SLIP channel, and link in this `tty' line. */
> -static struct slip *sl_alloc(dev_t line)
> +static struct slip *sl_alloc(void)
>  {
>  	int i;
>  	char name[IFNAMSIZ];
> @@ -809,7 +809,7 @@ static int slip_open(struct tty_struct *tty)
> =20
>  	/* OK.  Find a free SLIP channel to use. */
>  	err =3D -ENFILE;
> -	sl =3D sl_alloc(tty_devnum(tty));
> +	sl =3D sl_alloc();
>  	if (sl =3D=3D NULL)
>  		goto err_exit;
> =20
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IjKN1Xk4p4D5jMOhqsBPvnfQE8j5HhVwB--

--lAUhpgCv4ewKbt1HGmKRucgfKHNOtqXL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloqdg8ACgkQHv7KIOw4
HPbjPAf7BLAe4SAYmtBqqTK4JuKwmBDlb63uTTMSVKSsN1Gl6G/NN1ZT694RBJAq
HLTNZuN8VfiNWPUEU/kkT1yycQ7kaFSb0F75JJX+PhIQtJ+djoQNyya+d3R19skJ
RBm/46NE2jeWIRm54h8fmuknnjl9dR9BzgLpJy/ZsGw2Ig8xTBjqlH+TEG4AWBAF
ss4DWtXqVXRqGVUz6n/0poUq6l4Z6YToY3gnxawIH7OyJcYsccJSHzW+0znXtkKV
EdWalDSvBLniSpjREPfTB9h77vV65Fb4f5JpqBmnG4p3n+zdXPMvz/TFCbmGw18V
uiZS4UoowP/3zQHHsHTkXXZMHWF10Q==
=efPK
-----END PGP SIGNATURE-----

--lAUhpgCv4ewKbt1HGmKRucgfKHNOtqXL9--
