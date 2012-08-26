From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb-can device
Date: Sun, 26 Aug 2012 18:28:11 +0200
Message-ID: <503A4E9B.9060308@pengutronix.de>
References: <1345996339.6610.10.camel@slaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig68A37D29F303BCCF1937ECCD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45577 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2HZQ2S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Aug 2012 12:28:18 -0400
In-Reply-To: <1345996339.6610.10.camel@slaptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68A37D29F303BCCF1937ECCD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Max,

On 08/26/2012 05:52 PM, Max S. wrote:
> I am developing a usb to can adapter.
>=20
> Does there exist a standard usb-can interface on the linux side? Or wil=
l
> I have to create my own device driver?

There is no standard driver, however I was thinking last week that
someone should write a CDC CAN driver. CDC Ethernet is a standard to
send ethernet frames over USB.

> In the linux kernel source I see drivers/net/can/ems_usb.c which seems
> to provide a way to add support for multiple devices through the
> ems_usb_table. What would it take to get my vendor id and product id
> into this list (assuming that the device is working with this driver).
>=20
> I haven't studied the driver in great detail, so i don't know if it is
> appropriate for what I am trying to do...

I don't know what the legal department of ems will do, if you "clone"
their hardware, or build something that is compatible to their hardware
on the driver level.

> What are my options for getting a usb device, that exposes two can
> nodes, supported under linux? I have complete access to the usb device,=

> so it would not be a problem for me to build a firmware that behaves a
> certain standard way.

The kvaser driver basically just sends and receives binary messages.
They have a common header (len+type of message+CAN interface) and the
message itself. There are messages to send and receive a CAN frame,
TX-complete, for error handling, and for configuration. If you want to
make your device's firmware update able, implement dfu (device firmware
update). Optional stuff is abort tx of CAN frames, timestamps for rx and =
tx.

Oliver, do you remember the talk about the CAN in FPGA we heart at the
CAN CIA conference, do you have a link to the presentation. It was FPGA
based, but all concept mentioned there also apply to USB based devices.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig68A37D29F303BCCF1937ECCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlA6Tp4ACgkQjTAFq1RaXHO1FwCfYxVghwW3bmzLfD39+W7+6lyv
40YAn0oqUfxLTrtzxz4Ri0JM6u1Fw7G2
=AnTZ
-----END PGP SIGNATURE-----

--------------enig68A37D29F303BCCF1937ECCD--
