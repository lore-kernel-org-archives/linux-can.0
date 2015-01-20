From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3.19-rc3] c_can: end transmission on network stop
Date: Tue, 20 Jan 2015 15:39:02 +0100
Message-ID: <54BE6886.5040203@pengutronix.de>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login> <alpine.DEB.2.02.1501181931400.32136@login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2imwo4lWpH8gPGcT01ib01IeQ4E7Nd2RP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60398 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbATOjU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:39:20 -0500
In-Reply-To: <alpine.DEB.2.02.1501181931400.32136@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>, linux-can@vger.kernel.org
Cc: Andri Yngvason <andri.yngvason@marel.com>, Tom Evans <tom_usenet@optusnet.com.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2imwo4lWpH8gPGcT01ib01IeQ4E7Nd2RP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2015 08:01 PM, Viktor Babrian wrote:
>=20
> Controller put into init mode in betwork stop to end pending=20
> transmission. The issue is observed in cases when transmitted frame is =
not=20
> acked.
>=20
> Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>
> ---
> --- linux-3.19-rc3/drivers/net/can/c_can/c_can.c	2015-01-06=20
> 02:05:20.000000000 +0100
> +++ linux/drivers/net/can/c_can/c_can.c	2015-01-18 18:07:09.000000000=20
> +0100
> @@ -615,6 +615,9 @@ static void c_can_stop(struct net_device
>=20
>   	c_can_irq_control(priv, false);
>=20
> +	/* put ctrl to init on stop to end ongoing transmission */
> +	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_INIT);
> +
>   	/* deactivate pins */
>   	pinctrl_pm_select_sleep_state(dev->dev.parent);
>   	priv->can.state =3D CAN_STATE_STOPPED;

Your mailer has word-wrapped the patch. I've applied it by hand to
can/master. Please consider using git send-email in the future.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2imwo4lWpH8gPGcT01ib01IeQ4E7Nd2RP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmiMAAoJECte4hHFiupU+p8P/RRXqR8HFipaQ2nsL4qji/4u
aEsBeO6XbI7gRrZPcXWQj17aCTA5tAtkreHPhzDC5Me6SK58XqxWJzEjlzvwraqt
ByalVqFmlprd1AvucBRKBG/IzgPkfHTyocXj5EiW8c8Q0pt1QjOMbH9bi5BE0EOo
f6U6ujmDkywsEF9qpiL7hhEgjyW/oYbsBhuVhAyLmfQlYh5+2mu5F7a3V3/xKkHB
cLPZNUApL6C7+n9Qi+7yRLE7Xmi4Ekte4MtZd6DAjemDz3aXBeGIsQgRk79R2OWe
zDLWixuWyyCdYw635H6B/OvO4/sX9Gx8MbXxUR5jVXI65MjlCdgeaqr1Hh6XAfKf
ATqUlw1z7jfkesW1XwjJ557MpJoUf7g7lFOQ0cWBttHoQDpfOf+cOJsj1hBQDKzT
YnH9Feuoj0UFJGP1rKycEPnJEOSzQr0uKlAFvrB3VwJQAkCU11C58Um2LPCwzad/
cknrh+CmMySvDpD6MI7rjQVtw9dtbcYxP8TNlBBg+gbvcuInGzNH+EyTsXWnHlwx
j/vdaTiJeNQKP0MPA0aDyoLJDAcYes46UdOnY/NilUXrVSwR4P63GJX2RbsHZURs
m4Q1tdRPCjd6y5M3BYdUBDBdbOPxHC9xAzu8UR6RSbFDWJwxNsKPZg1HdpQJaGnR
jzNzQzP7j/liPp2tPEST
=S81d
-----END PGP SIGNATURE-----

--2imwo4lWpH8gPGcT01ib01IeQ4E7Nd2RP--
