From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 22:32:25 +0100
Message-ID: <50BFBD69.40009@pengutronix.de>
References: <50BE7C7E.8080406@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8920092696B643D6DDA425EF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BE7C7E.8080406-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8920092696B643D6DDA425EF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12/04/2012 11:43 PM, Bernd Krumboeck wrote:
> Add device driver for USB2CAN interface from "8 devices"
> (http://www.8devices.com).

[...]

> +/* Send data to device */
> +static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
> +                      struct net_device *netdev)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);

I just noticed, it's unusual to name you private data pointer "dev", I
suggest to name it priv. Maybe you can rename your private data struct
to: "struct usb_8dev_priv".

> +    struct net_device_stats *stats =3D &netdev->stats;
> +    struct can_frame *cf =3D (struct can_frame *) skb->data;
> +    struct usb_8dev_tx_msg *msg;
> +    struct urb *urb;
> +    struct usb_8dev_tx_urb_context *context =3D NULL;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8920092696B643D6DDA425EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC/vW0ACgkQjTAFq1RaXHNCJQCfUG452EQr8xIOlbWq22ZBu2iv
mJQAn0StVmKQXSIrfPLPejehjp2HeN77
=ruf0
-----END PGP SIGNATURE-----

--------------enig8920092696B643D6DDA425EF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
