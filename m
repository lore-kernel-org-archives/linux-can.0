From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP251x bit rate calculations wrong
Date: Mon, 28 Oct 2013 09:33:14 +0100
Message-ID: <526E214A.9090108@pengutronix.de>
References: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com> <CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OCbNGlRMFR9TxrQpgvPiLpbQBAXAQnbFP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46081 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab3J1IdS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 04:33:18 -0400
In-Reply-To: <CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brennan Ashton <bashton@brennanashton.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OCbNGlRMFR9TxrQpgvPiLpbQBAXAQnbFP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/26/2013 07:26 PM, Brennan Ashton wrote:
> I did not see this line:
> 1024 >---priv->can.clock.freq =3D pdata->oscillator_frequency / 2;$
>=20
> So the kernel driver should be fine but in can utils this should still
> be fixed for the -1

Can I add your Signed-off-by to the patch?

Marc

>=20
> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> index ecf5cb6..242e1ef 100644
> --- a/can-calc-bit-timing.c
> +++ b/can-calc-bit-timing.c
> @@ -192,7 +192,7 @@ static void printf_btr_mcp251x(struct
> can_bittiming *bt, int hd
>         if (hdr) {
>                 printf("CNF1 CNF2 CNF3");
>         } else {
> -               cnf1 =3D ((bt->sjw - 1) << 6) | bt->brp;
> +               cnf1 =3D ((bt->sjw - 1) << 6) | (bt->brp-1);
>                 cnf2 =3D 0x80 | ((bt->phase_seg1 - 1) << 3) | (bt->prop=
_seg - 1);
>                 cnf3 =3D bt->phase_seg2 - 1;
>                 printf("0x%02x 0x%02x 0x%02x", cnf1, cnf2, cnf3);

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OCbNGlRMFR9TxrQpgvPiLpbQBAXAQnbFP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJuIUoACgkQjTAFq1RaXHN6LQCffcp40E2hDFtvW/3CymaZXw//
L3MAoIbxoIGIaINHpbARgmdHALBJI94/
=T92o
-----END PGP SIGNATURE-----

--OCbNGlRMFR9TxrQpgvPiLpbQBAXAQnbFP--
