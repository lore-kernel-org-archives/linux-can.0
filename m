From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 00:29:31 +0100
Message-ID: <526DA1DB.9000600@pengutronix.de>
References: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kqj7aTFBm81KBpertlfE70Nb2nNKulNJS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56204 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab3J0XaY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Oct 2013 19:30:24 -0400
In-Reply-To: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kqj7aTFBm81KBpertlfE70Nb2nNKulNJS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2013 10:07 PM, Olivier Sobrie wrote:
> Some devices, like the Kvaser Memorator Professional, have several
> bulk in endpoints. Only the first one found should be used by the
> driver. The same holds for the bulk out endpoint.

Can you give reference where this information comes from? e.g.
documentation or another driver?

> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 3b95465..bdbf5bf 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -1554,13 +1554,14 @@ static void kvaser_usb_get_endpoints(const stru=
ct usb_interface *intf,
> =20
>  	iface_desc =3D &intf->altsetting[0];
> =20
> -	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> +	for (i =3D 0; (i < iface_desc->desc.bNumEndpoints) && (!*in || !*out)=
;
> +	     ++i) {
>  		endpoint =3D &iface_desc->endpoint[i].desc;
> =20
> -		if (usb_endpoint_is_bulk_in(endpoint))
> +		if (!*in && usb_endpoint_is_bulk_in(endpoint))
>  			*in =3D endpoint;
> =20
> -		if (usb_endpoint_is_bulk_out(endpoint))
> +		if (!*out && usb_endpoint_is_bulk_out(endpoint))
>  			*out =3D endpoint;

I personally would add a break or return here, together with a short
comment:

	/* only use first endpoint for in and out */
	if (*in && *out)
		return;

>  	}
>  }
>=20

Thanks for taking care of the driver,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kqj7aTFBm81KBpertlfE70Nb2nNKulNJS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJtodsACgkQjTAFq1RaXHNFeACfYsC6G/K9j4j/+psWoM/4nUM/
pmsAmwUU2F/HGnSLguWT0gPOX8RXhAzJ
=TJG7
-----END PGP SIGNATURE-----

--kqj7aTFBm81KBpertlfE70Nb2nNKulNJS--
