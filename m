From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
Date: Mon, 20 Jun 2016 10:47:36 +0200
Message-ID: <a359e915-5dcc-5094-eb29-76b6677252e8@pengutronix.de>
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
 <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
 <CACm0Nn320ry07YOuorrMO=u8Q4+JsOd9i3s7eFAwQ-L8AWGm=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WpTp9UfWddmtBXLdfNheSCvKLnCLlHn8w"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45225 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932112AbcFTJIR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 05:08:17 -0400
In-Reply-To: <CACm0Nn320ry07YOuorrMO=u8Q4+JsOd9i3s7eFAwQ-L8AWGm=Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpTp9UfWddmtBXLdfNheSCvKLnCLlHn8w
Content-Type: multipart/mixed; boundary="qx0p0AjgasXQpxoi465eC1fbd6v6e2ve4"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org
Message-ID: <a359e915-5dcc-5094-eb29-76b6677252e8@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
 <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
 <CACm0Nn320ry07YOuorrMO=u8Q4+JsOd9i3s7eFAwQ-L8AWGm=Q@mail.gmail.com>
In-Reply-To: <CACm0Nn320ry07YOuorrMO=u8Q4+JsOd9i3s7eFAwQ-L8AWGm=Q@mail.gmail.com>

--qx0p0AjgasXQpxoi465eC1fbd6v6e2ve4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/17/2016 10:35 PM, Ed Spiridonov wrote:
> 17.06.2016 12:22 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8C "Marc Kleine-Budde" <mkl@pengutronix.de
> <mailto:mkl@pengutronix.de>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB=
:
>=20
>     > @@ -1156,6 +1158,8 @@ static int mcp251x_can_probe(struct
>     spi_device *spi)
>     >
>     >       devm_can_led_init(net);
>     >
>     > +     netdev_info(net, "successfully initialized.\n");
>=20
>     I'll remove this hunk, as we try to make the CAN devices as silent =
as
>     possible in case of no errors.
>=20
>=20
> Why it is so important to be totally silent? IMHO one line per CAN bus
> isn't too much.
> But it could help to debug new configuration, e.g. to find wrong device=

> tree configuration, especially with several CAN buses.
>=20
> I made this patch because a lot of complains on Raspberry PI forum.
> Current module does not produce any message if module initializes
> MCP2510/2515 chip successfully or not. It could be confusing.

ok, can I have your S-o-b [1]?

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L409=


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qx0p0AjgasXQpxoi465eC1fbd6v6e2ve4--

--WpTp9UfWddmtBXLdfNheSCvKLnCLlHn8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXZ62oAAoJED07qiWsqSVqxZoH/1lf3vBZDP+IoKIRPQBMBClG
iulZ45yTf9Fp0OyPILRrvfQ1VNGk+RDJ1HzuzRMFovMLu3497KRskyETto7tV2rO
k0eP+svVdrhHAsu0sc0z/hhicPK+rIC09SGRnHNPhieS0SDpD/VB/SxqWIGKfuar
yeN25IxTR2+1T/FKBhDhokAcQWg0BtxM7nCJPbl+H6Anla26nS+ZIAPPJ5+bef4Y
DyNqw58A0SX4FBuqtA6URYtd4cmvQffsDWx/C9Njdr301wsxCr9wbRqqE4vvHinX
HIbRgN3imlDFS0HZEVK8JdzsPZ80ZEPTc5iAIq2KMdAuyvCDeO1f5oPioOA46v4=
=z2Ne
-----END PGP SIGNATURE-----

--WpTp9UfWddmtBXLdfNheSCvKLnCLlHn8w--
