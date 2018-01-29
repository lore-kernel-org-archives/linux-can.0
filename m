From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/5] can: xilinx_can: only report warning and passive
 states on state changes
Date: Mon, 29 Jan 2018 09:35:38 +0100
Message-ID: <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-5-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WWVRaHqTKyG9JhLBUhZx4GyORhdM3Ajaj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48117 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeA2IgQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jan 2018 03:36:16 -0500
In-Reply-To: <20180126142723.3212-5-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WWVRaHqTKyG9JhLBUhZx4GyORhdM3Ajaj
Content-Type: multipart/mixed; boundary="86Adf77j4MvS2mYfTiemmHyWnZkR4n94G";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>
Message-ID: <87c7662b-0a49-cf90-10cc-b7aaee44a543@pengutronix.de>
Subject: Re: [PATCH 4/5] can: xilinx_can: only report warning and passive
 states on state changes
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-5-anssi.hannula@bitwise.fi>
In-Reply-To: <20180126142723.3212-5-anssi.hannula@bitwise.fi>

--86Adf77j4MvS2mYfTiemmHyWnZkR4n94G
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 03:27 PM, Anssi Hannula wrote:
> The xilinx_can driver currently increments error-warning and
> error-passive statistics on every error interrupt regardless of whether=

> the interface was already in the same state. Similarly, the error frame=

> sent on error interrupts is always sent with
> CAN_ERR_CRTL_(RX|TX)_(PASSIVE|WARNING) bit set.
>=20
> To make the error-warning and error-passive statistics more useful, add=

> a check to only set the error state when the state has actually been
> changed.
>=20
> Tested with the integrated CAN on Zynq-7000 SoC.
>=20
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>  drivers/net/can/xilinx_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index 763408a..862c12bb 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -680,7 +680,8 @@ static void xcan_err_interrupt(struct net_device *n=
dev, u32 isr)
>  	} else {
>  		enum can_state new_state =3D xcan_current_error_state(ndev);
> =20
> -		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
> +		if (new_state !=3D priv->can.state)
> +			xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
>  	}

Are you changing a piece of code, that you've introduced in patch 3? If
so, I'm going to squash these two patches together.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--86Adf77j4MvS2mYfTiemmHyWnZkR4n94G--

--WWVRaHqTKyG9JhLBUhZx4GyORhdM3Ajaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlpu3N0ACgkQk9IU1zQo
ZfF55QgAkNw/VhA8hFQVBMZMYCW7QfpKm5xb79e/r7x3VuQDcK4SM1uOeybzcF2H
50vIUtaI1HXBmrGJ92DiuhPpSvgfxKHi4JVtwHUvMBZbTi03lYcCDSnnaIha8s3h
0d3BRQsDLqKLIG4eMmpLL/uF8nWP2T2+8K6kQkwpBLBLuDJrydOUMktrkz5OcMzW
xjKUr/VzWWGpDINsS+bR7U1x/PhjP4FHTAZXbBd5RUen30YpGKgY6O6H9itNGto4
I2WPSro//kPD9ScdiNQURGQSkDBSetzCUOr6x9XxlLCwa+wOjQxk1/2N5bvkisst
t2f5XRcGjIPuwdNs3kSGLIet1X9J6A==
=yoe3
-----END PGP SIGNATURE-----

--WWVRaHqTKyG9JhLBUhZx4GyORhdM3Ajaj--
