From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sun4i: fix overrun
Date: Mon, 6 Nov 2017 16:03:18 +0100
Message-ID: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
References: <5511583c-37ac-c6b7-f88d-1fd740fae3f5 () pengutronix ! de>
 <1509108411-9614-1-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RTrHG0Fx0L9CHAdSmbMmH5uQSgvnnFV5s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59265 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932489AbdKFPDX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2017 10:03:23 -0500
In-Reply-To: <1509108411-9614-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RTrHG0Fx0L9CHAdSmbMmH5uQSgvnnFV5s
Content-Type: multipart/mixed; boundary="uDuinMJdElax6oIGdkKmmhdXVIvI1WJFM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org
Message-ID: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
Subject: Re: [PATCH v2] can: sun4i: fix overrun
References: <5511583c-37ac-c6b7-f88d-1fd740fae3f5 () pengutronix ! de>
 <1509108411-9614-1-git-send-email-info@gerhard-bertelsmann.de>
In-Reply-To: <1509108411-9614-1-git-send-email-info@gerhard-bertelsmann.de>

--uDuinMJdElax6oIGdkKmmhdXVIvI1WJFM
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 02:46 PM, GBert wrote:
> From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
>=20
> SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drai=
ned
> fast enough (overrun) it's getting mangled. Already received frames are=

> dropped - the data can't be restored.
>=20
> V2: no duplicate error reporting

Please don't forget your S-o-b.

> ---
>  drivers/net/can/sun4i_can.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index 68ef0a4..bcec511 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -539,6 +539,11 @@ static int sun4i_can_err(struct net_device *dev, u=
8 isrc, u8 status)
>  		}
>  		stats->rx_over_errors++;
>  		stats->rx_errors++;
> +
> +		/* reset the CAN IP by entering reset mode */
> +		err =3D set_reset_mode(dev);
> +		err =3D set_normal_mode(dev);

Please add the missing error handling here.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uDuinMJdElax6oIGdkKmmhdXVIvI1WJFM--

--RTrHG0Fx0L9CHAdSmbMmH5uQSgvnnFV5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloAebYACgkQHv7KIOw4
HPbPUAf+M+QNdiuWIWRZ4YG2bLjBLkXogvlpYoONUamgdnOFLSE+vGdeTzDU52Xi
CNapcB1wHTpLMeUYUCFwegg+PjA6OZ0YtwMSoze7YiiVWP0POOtxzRwnpRjyXtEq
cEN99/nDGs1B667M1+XYu8fcixV9MWnowGwjbbtNK98k2qosrV0LRwgPqTScnMCX
tLfpxCfp0FMVndNYXk57bSB0gcHL3uNh0zwicTbCTyv44TGO8zeIox6HBDeKzcoy
t9b9dS0fQ05wQwSUKSCOH8HUfwvfNVyK5clGG96CnAsGezLKMgs56LKGSIp+zezp
qO7YoCd/4brSfB6WbE6bNw2rAXyDFw==
=Exz7
-----END PGP SIGNATURE-----

--RTrHG0Fx0L9CHAdSmbMmH5uQSgvnnFV5s--
