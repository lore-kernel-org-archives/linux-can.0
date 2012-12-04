From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 11:07:06 +0100
Message-ID: <50BDCB4A.5040709@pengutronix.de>
References: <50BBF73F.9080208@universalnet.at> <50BCB1E8.2070705@pengutronix.de> <50BD0E9F.2060302@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig009AA2D87DCACC0C6AA59DF8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BD0E9F.2060302-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org" <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig009AA2D87DCACC0C6AA59DF8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12/03/2012 09:42 PM, krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org wrote:
> Hi Marc!
>=20
>=20
>>> +/* Send open command to device */
>>> +static int usb_8dev_cmd_open(struct usb_8dev *dev)
>>> +{
>>> +    struct can_bittiming *bt =3D &dev->can.bittiming;
>>> +    struct usb_8dev_cmd_msg outmsg;
>>> +    struct usb_8dev_cmd_msg inmsg;
>>> +    u32 flags =3D 0;
>>> +    u32 beflags;
>>> +    u16 bebrp;
>>> +    u32 ctrlmode =3D dev->can.ctrlmode;
>>> +
>>> +    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
>>> +        flags |=3D USB_8DEV_LOOPBACK;
>>> +    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
>>> +        flags |=3D USB_8DEV_SILENT;
>>> +    if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>>> +        flags |=3D USB_8DEV_DISABLE_AUTO_RESTRANS;
>>> +
>>> +    flags |=3D USB_8DEV_STATUS_FRAME;
>>> +
>>> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));
>>> +    outmsg.command =3D USB_8DEV_OPEN;
>>> +    outmsg.opt1 =3D USB_8DEV_BAUD_MANUAL;
>>> +    outmsg.data[0] =3D (bt->prop_seg + bt->phase_seg1);
>>> +    outmsg.data[1] =3D bt->phase_seg2;
>>> +    outmsg.data[2] =3D bt->sjw;
>>
>> But you should not use usb_bulk_msg() to send data which is on the
>> stack, please use you already allocated memory in priv or kmalloc
>> something here.
>=20
> The function usb_8dev_send_cmd copies the data to dev->cmd_msg_buffer
> (allocated with kzalloc, GFP_KERNEL).

Okay, then you might want to set outmsg via C99 initializers.

>>> +
>>> +    /* BRP */
>>> +    bebrp =3D cpu_to_be16((u16) bt->brp);
>>> +    memcpy(&outmsg.data[3], &bebrp, sizeof(bebrp));
>>
>> Are you sure about the endianess? Some data types are BE some are LE?
>=20
> Where is LE used?

Opps, yeah right. only BE.


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig009AA2D87DCACC0C6AA59DF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9y0oACgkQjTAFq1RaXHMKogCfbZ2ZfnNLneY9Qhrd/UgvOC8U
QXAAnRrYwofw+YCYOxV6SDsTseSYSHz6
=8sc6
-----END PGP SIGNATURE-----

--------------enig009AA2D87DCACC0C6AA59DF8--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
