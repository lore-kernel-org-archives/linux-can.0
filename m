From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6/6] can: janz-ican3: add support for one shot mode
Date: Thu, 19 Jul 2012 10:35:42 +0200
Message-ID: <5007C6DE.9020601@pengutronix.de>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu> <1342650798-2991-7-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8048865CF4A013F0A3A335B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54497 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2GSIfo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:35:44 -0400
In-Reply-To: <1342650798-2991-7-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8048865CF4A013F0A3A335B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/19/2012 12:33 AM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The Janz VMOD-ICAN3 hardware has support for one shot packet
> transmission. This means that a packet will be attempted to be sent
> once, with no automatic retries.
>=20
> The SocketCAN core has a controller-wide setting for this mode:
> CAN_CTRLMODE_ONE_SHOT. The Janz VMOD-ICAN3 hardware supports this flag
> on a per-packet level, but the SocketCAN core does not.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

looks good

Marc

> ---
>  drivers/net/can/janz-ican3.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index df3ba07..c271582 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -116,6 +116,7 @@
>  #define ICAN3_BUSERR_QUOTA_MAX	255
> =20
>  /* Janz ICAN3 CAN Frame Conversion */
> +#define ICAN3_SNGL	0x02
>  #define ICAN3_ECHO	0x10
>  #define ICAN3_EFF_RTR	0x40
>  #define ICAN3_SFF_RTR	0x10
> @@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev *m=
od,
>  	desc->data[0] |=3D cf->can_dlc;
>  	desc->data[1] |=3D ICAN3_ECHO;
> =20
> +	/* support single transmission (no retries) mode */
> +	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		desc->data[1] |=3D ICAN3_SNGL;
> +
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		desc->data[0] |=3D ICAN3_EFF_RTR;
> =20
> @@ -1807,7 +1812,8 @@ static int __devinit ican3_probe(struct platform_=
device *pdev)
>  	mod->can.do_set_mode =3D ican3_set_mode;
>  	mod->can.do_get_berr_counter =3D ican3_get_berr_counter;
>  	mod->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES
> -				    | CAN_CTRLMODE_BERR_REPORTING;
> +				    | CAN_CTRLMODE_BERR_REPORTING
> +				    | CAN_CTRLMODE_ONE_SHOT;
> =20
>  	/* find our IRQ number */
>  	mod->irq =3D platform_get_irq(pdev, 0);


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA8048865CF4A013F0A3A335B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHxt4ACgkQjTAFq1RaXHP/swCeNdeq2doZAyTC0DmT3eLPcYC6
LDwAn3XMy4SciQ1yAjeuiLz3FMrrX71O
=cy4t
-----END PGP SIGNATURE-----

--------------enigA8048865CF4A013F0A3A335B--
