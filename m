From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Driver for CAN in at91
Date: Tue, 11 Feb 2014 09:53:56 +0100
Message-ID: <52F9E524.9050403@pengutronix.de>
References: <CACwGGRJ2WX2fJJVfvwAk27mp2JhRfLMT8ZeNwfw0w1kPPCAvoA@mail.gmail.com> <52F39C35.8040601@pengutronix.de> <CACwGGR+nqwjL6M08SYMQDwWM=Eib6Y0OcZDQ7mxZdenGk1x3qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iBbR6542Wrd8kjqTWx3CwpUuCAMh3lGrE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57507 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaBKIyG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 03:54:06 -0500
In-Reply-To: <CACwGGR+nqwjL6M08SYMQDwWM=Eib6Y0OcZDQ7mxZdenGk1x3qg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yoann DI RUZZA <ydiruzza@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iBbR6542Wrd8kjqTWx3CwpUuCAMh3lGrE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/11/2014 09:46 AM, Yoann DI RUZZA wrote:
>     > diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_ca=
n.c
>     > index 1cf6104..d4c3213 100644
>     > --- a/drivers/net/can/at91_can.c
>     > +++ b/drivers/net/can/at91_can.c
>     > @@ -422,7 +422,11 @@ static void at91_chip_start(struct net_devic=
e
>     *dev)
>     >       at91_transceiver_switch(priv, 1);
>     >
>     >       /* enable chip */
>     > -     at91_write(priv, AT91_MR, AT91_MR_CANEN);
>     > +     if(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>     > +             reg_mr =3D reg_mr | AT91_MR_CANEN | AT91_MR_ABM;
>     > +     else
>     > +             reg_mr =3D reg_mr | AT91_MR_CANEN;
>=20
>     The documentation says it's "autobaud/liste mode". Is this another =
name
>     for listen only?
>=20
> Yes, in this mode you can make autobauding because you don't have bus
> error even if you don't have the right baudrate. =20
> LISTEN_ONLY is the word used on the other net can driver (mcp251x for
> example).

Thanks for clarifying this.

>=20
>     Your patch does change what's written to the CAN core, the original=
 code
>     writes only AT91_MR_CANEN, you preserve the original contents. Who =
will
>     clear AT91_MR_ABM if you switch from listen only to normal mode?
>=20
> =20
> I modify the patch to correct this.
> thanks

Thanks for the patch, please send it via "git send-email" next time, as
you mailer has converted tabs into spaces. I've applied the patch manuall=
y.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iBbR6542Wrd8kjqTWx3CwpUuCAMh3lGrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL55SQACgkQjTAFq1RaXHOb6QCfY02QVJtqIb8oVpff7ZSS/k4K
VKIAn2X8n4un4S2Dptl7frCWqWiO/uNM
=9cpo
-----END PGP SIGNATURE-----

--iBbR6542Wrd8kjqTWx3CwpUuCAMh3lGrE--
