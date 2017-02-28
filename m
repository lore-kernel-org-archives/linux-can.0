From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] gs_usb driver was performing USB transfers using buffers
 allocated on the stack
Date: Tue, 28 Feb 2017 09:28:34 +0100
Message-ID: <4b7aec09-87c8-2141-a452-9479a7c8743d@pengutronix.de>
References: <20170224162736.14688-1-e@ethanzonca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gvxw72qF7tBtVbPPAgUPGwaeniSORPxOA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49355 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751677AbdB1Jr4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Feb 2017 04:47:56 -0500
In-Reply-To: <20170224162736.14688-1-e@ethanzonca.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ethan Zonca <e@ethanzonca.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gvxw72qF7tBtVbPPAgUPGwaeniSORPxOA
Content-Type: multipart/mixed; boundary="aBEIrhIfkgGX7FiGdGuCDhKWRJOcW9lrD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ethan Zonca <e@ethanzonca.com>, linux-can@vger.kernel.org
Message-ID: <4b7aec09-87c8-2141-a452-9479a7c8743d@pengutronix.de>
Subject: Re: [PATCH] gs_usb driver was performing USB transfers using buffers
 allocated on the stack
References: <20170224162736.14688-1-e@ethanzonca.com>
In-Reply-To: <20170224162736.14688-1-e@ethanzonca.com>

--aBEIrhIfkgGX7FiGdGuCDhKWRJOcW9lrD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 05:27 PM, Ethan Zonca wrote:
> This causes the driver to not function with vmapped stacks. Instead, al=
locate memory for the transfer buffers.
>=20
> Signed-off-by: Ethan Zonca <e@ethanzonca.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
> index 77e3cc06a30c..3f064f5a8633 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -908,10 +908,13 @@ static int gs_usb_probe(struct usb_interface *int=
f,
>  	struct gs_usb *dev;
>  	int rc =3D -ENOMEM;
>  	unsigned int icount, i;
> -	struct gs_host_config hconf =3D {
> -		.byte_order =3D 0x0000beef,
> -	};
> -	struct gs_device_config dconf;
> +	struct gs_host_config *hconf;
> +	struct gs_device_config *dconf;
> +
> +	hconf =3D kmalloc(sizeof(*hconf), GFP_KERNEL);
> +	hconf->byte_order =3D 0x0000beef;
> +
> +	dconf =3D kmalloc(sizeof(*dconf), GFP_KERNEL);

I've added error checking here. Otherwise OK. Applied to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aBEIrhIfkgGX7FiGdGuCDhKWRJOcW9lrD--

--gvxw72qF7tBtVbPPAgUPGwaeniSORPxOA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli1NLIACgkQHv7KIOw4
HPawMQf+MGYr9hB3L34qqTdVGmzzzQD0FL7Ca3gqKx2NfmW9TiwFJ+Xwcu8FEemm
0Yvs/2f2PYVqdoiqShSxX/jHhlUY6baL2V4yIcVlRXLwSrY2NXA2Tn1zGcC+fU4/
7yIQyYJHdn9ujm4C+iow+f1VwX6ZDvkGnc1oNBK6Ev4FkWtxU+oXY6vLhfbo8Uca
uftqYT3qLLakEFbW9fIXykaAFOKeoSCngZqVxVJfI1qZxcMGmbw8NJAF43Y8Mg5R
KKYDLthtG1z78ZZKN5qrAAMD3mvdGbyR9fa12LJirw7veYEV3T5YXkfaUW92FQNC
lOiAuEDAYnqBaytWKb3DU8rS0LAMIQ==
=wOJe
-----END PGP SIGNATURE-----

--gvxw72qF7tBtVbPPAgUPGwaeniSORPxOA--
