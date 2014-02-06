From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Driver for CAN in at91
Date: Thu, 06 Feb 2014 15:29:09 +0100
Message-ID: <52F39C35.8040601@pengutronix.de>
References: <CACwGGRJ2WX2fJJVfvwAk27mp2JhRfLMT8ZeNwfw0w1kPPCAvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rtpVsnjghGVKsmgr2i7MlFR57Mgk689N7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaBFO3O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 09:29:14 -0500
In-Reply-To: <CACwGGRJ2WX2fJJVfvwAk27mp2JhRfLMT8ZeNwfw0w1kPPCAvoA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yoann DI RUZZA <ydiruzza@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rtpVsnjghGVKsmgr2i7MlFR57Mgk689N7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2014 03:13 PM, Yoann DI RUZZA wrote:
> I'll send you a patch to add the listen only mode in AT91 CAN driver.
> I don't know if it is the good way to send a patch.

Thanks for your contribution, please add the linux-can mailinglist on
Cc, too.

> I'm working and testing this patch with the 3.6.9 kernel version on a
> at91sam9x35-ek.
> cordially,
>=20
> Yoann DI RUZZA

Can you add your Signed-off-by to the next patch. See
http://elinux.org/Developer_Certificate_Of_Origin for more information.

>=20
> can_listenonly.patch
>=20
>=20
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 1cf6104..d4c3213 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -422,7 +422,11 @@ static void at91_chip_start(struct net_device *dev=
)
>  	at91_transceiver_switch(priv, 1);
> =20
>  	/* enable chip */
> -	at91_write(priv, AT91_MR, AT91_MR_CANEN);
> +	if(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		reg_mr =3D reg_mr | AT91_MR_CANEN | AT91_MR_ABM;
> +	else
> +		reg_mr =3D reg_mr | AT91_MR_CANEN;

The documentation says it's "autobaud/liste mode". Is this another name
for listen only?

Your patch does change what's written to the CAN core, the original code
writes only AT91_MR_CANEN, you preserve the original contents. Who will
clear AT91_MR_ABM if you switch from listen only to normal mode?

> +	at91_write(priv, AT91_MR, reg_mr);
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> =20
> @@ -1345,7 +1349,7 @@ static int __devinit at91_can_probe(struct platfo=
rm_device *pdev)
>  	priv->can.bittiming_const =3D &at91_bittiming_const;
>  	priv->can.do_set_mode =3D at91_set_mode;
>  	priv->can.do_get_berr_counter =3D at91_get_berr_counter;
> -	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMOD=
E_LISTENONLY;
>  	priv->dev =3D dev;
>  	priv->reg_base =3D addr;
>  	priv->devtype_data =3D *devtype_data;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rtpVsnjghGVKsmgr2i7MlFR57Mgk689N7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLznDUACgkQjTAFq1RaXHMPVACeOCtJb+zEV1V4TUTsUFU8Y+M2
WjAAnRTPQ1TpKQh4RNjMt5FDAdvm21/N
=gwhT
-----END PGP SIGNATURE-----

--rtpVsnjghGVKsmgr2i7MlFR57Mgk689N7--
