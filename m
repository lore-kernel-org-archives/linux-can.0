From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 22:40:48 +0100
Message-ID: <50BFBF60.2090106@pengutronix.de>
References: <50BE6092.9050602@universalnet.at> <50BE6F0E.80308@pengutronix.de> <50BF8602.1070909@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig417D0ABDDA0F1DF2D8140375"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF8602.1070909-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417D0ABDDA0F1DF2D8140375
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2012 06:36 PM, Bernd Krumboeck wrote:
> Hi Marc!
>=20
>=20
>>> +    default:
>>> +        netdev_info(netdev, "Rx URB aborted (%d)\n",
>>> +             urb->status);
>>> +        goto resubmit_urb;
>>> +    }
>>> +
>>> +    while (pos < urb->actual_length) {
>>> +        struct usb_8dev_rx_msg *msg;
>>> +
>>> +        if (pos + sizeof(struct usb_8dev_rx_msg) >
>>> urb->actual_length) {
>>> +            netdev_err(dev->netdev, "format error\n");
>>> +            break;
>>
>> is resubmitting the urb the correct way to handle this problem?
>=20
> Suggestions? (maybe CAN_ERR_CRTL_UNSPEC ??)

It's not an error on the CAN protocol level, but the USB communication
is broken. I just had a look at the kvaser usb driver, it's doing a
resubmit, too. So it seems to be okay.

>=20
>>> +
>>> +            stats->tx_dropped++;
>>> +        }
>>> +    } else {
>>> +        /* Slow down tx path */
>>> +        if (atomic_read(&dev->active_tx_urbs) >=3D MAX_TX_URBS ||
>>> +            dev->free_slots < 5) {
>>
>> where's the 5 coming from?
>>
>=20
> From ems_usb driver.

Hmmmm, is the variable free_slots used?

>=20
>>> +            netif_stop_queue(netdev);
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * Release our reference to this URB, the USB core will eventual=
ly
>>> free
>>> +     * it entirely.
>>> +     */
>>> +    usb_free_urb(urb);
>>> +
>>> +    return NETDEV_TX_OK;
>>> +
>>> +nomem:
>>> +    dev_kfree_skb(skb);
>>> +    stats->tx_dropped++;
>>> +
>>> +    return NETDEV_TX_OK;
>>> +}
>>> +
>>> +static int usb_8dev_get_berr_counter(const struct net_device *netdev=
,
>>> +                     struct can_berr_counter *bec)
>>> +{
>>> +    struct usb_8dev *dev =3D netdev_priv(netdev);
>>> +
>>> +    bec->txerr =3D dev->bec.txerr;
>>> +    bec->rxerr =3D dev->bec.rxerr;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/* Start USB device */
>>> +static int usb_8dev_start(struct usb_8dev *dev)
>>> +{
>>> +    struct net_device *netdev =3D dev->netdev;
>>> +    int err, i;
>>> +
>>> +    dev->free_slots =3D 15; /* initial size */
>>
>> there does the 15 come from?
>=20
> ditto

dito :)

>=20
>>> + * Check device and firmware.
>>> + * Set supported modes and bittiming constants.
>>> + * Allocate some memory.
>>> + */
>>> +static int usb_8dev_probe(struct usb_interface *intf,
>>> +             const struct usb_device_id *id)
>>> +{
>>> +    struct net_device *netdev;
>>> +    struct usb_8dev *dev;
>>> +    int i, err =3D -ENOMEM;
>>> +    u32 version;
>>> +    char buf[18];
>>
>> where does this 18 come from?
>=20
> String "USB2CAN converter" + trailing 0.

okay

>=20
>>
>>> +    struct usb_device *usbdev =3D interface_to_usbdev(intf);
>>> +
>>> +    /* product id looks strange, better we also check iProdukt
>>> string */
>>
>> iProduct?

I mean typo iProdukt vs iProduct.

>=20
> Check if usbdev->descriptor.iProduct =3D=3D "USB2CAN converter".
>=20
>>> +    if (usb_string(usbdev, usbdev->descriptor.iProduct, buf,
>>> +               sizeof(buf)) > 0 && strcmp(buf, "USB2CAN converter"))=
 {
>>> +        dev_info(&usbdev->dev, "ignoring: not an USB2CAN converter\n=
");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    netdev =3D alloc_candev(sizeof(struct usb_8dev), MAX_TX_URBS);
>>> +    if (!netdev) {
>>> +        dev_err(&intf->dev, "Couldn't alloc candev\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    dev =3D netdev_priv(netdev);
>>> +
>>> +    dev->udev =3D usbdev;
>>> +    dev->netdev =3D netdev;
>>> +
>>> +    dev->can.state =3D CAN_STATE_STOPPED;
>>> +    dev->can.clock.freq =3D USB_8DEV_ABP_CLOCK;
>>> +    dev->can.bittiming_const =3D &usb_8dev_bittiming_const;
>>> +    dev->can.do_set_mode =3D usb_8dev_set_mode;
>>> +    dev->can.do_get_berr_counter =3D usb_8dev_get_berr_counter;
>>> +    dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>>> +                      CAN_CTRLMODE_LISTENONLY |
>>> +                      CAN_CTRLMODE_ONE_SHOT;
>>
>> Have you actually tested one shot? What happens if a can frame cannot =
be
>> transmitted?
>>
>=20
> Not really. Can someone explain what one-shot exactly means and what is=

> the correct behavior.
> I've only tested without any other device connected. I got the same
> errors like in normal mode.

Can has a built in collision avoidance protocol. If a collision is about
to happen the sender with the higher CAN id will back of and try again
later. In one shot mode it will not try again. The question is, how
behaves the dongle firmware, as you have to free your tx message somehow.=


To test, simply send with one station with canid 1, the other one in
one-shot-mode with canid 0x7ff.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig417D0ABDDA0F1DF2D8140375
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC/v2MACgkQjTAFq1RaXHOwigCfR9vYm7U8FHyVzA/NWHNQJji1
eagAn0NgCnE4in2OfTAWKj/YTnzRFRBu
=NrCx
-----END PGP SIGNATURE-----

--------------enig417D0ABDDA0F1DF2D8140375--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
