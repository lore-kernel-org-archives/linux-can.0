From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Mon, 15 Jan 2018 11:02:36 +0100
Message-ID: <1adef5d5-8607-7c50-38e6-80135094c778@pengutronix.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
 <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nPBjfnNrbAuR50O1pqlkYlLh8Qv2UI1Oj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeAOKUf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 05:20:35 -0500
In-Reply-To: <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nPBjfnNrbAuR50O1pqlkYlLh8Qv2UI1Oj
Content-Type: multipart/mixed; boundary="qR4DYxu3CuLygpbTJY7vkHeCu8CkIQQA9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com,
 wg@grandegger.com
Message-ID: <1adef5d5-8607-7c50-38e6-80135094c778@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
 <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>
In-Reply-To: <baddf3da-d44b-d326-1289-7cd6d0f387a4@gmx.de>

--qR4DYxu3CuLygpbTJY7vkHeCu8CkIQQA9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/13/2018 04:54 PM, Andr=C3=A9 Hartmann wrote:
> Hi all,
>=20
> and a (late) Happy New Year!
>=20
> I finally managed to finish my patch over christmas, which is now=20
> included in QtSerialBus [1]. Thanks for all your help on this topic!
>=20
> To summarize, I was able to get the CAN adapter description and the CAN=
=20
> channel by parsing the SysFS.

Why not use libudev?

> It would have been nice to extract the adapters serial number and/or an=
=20
> user-programmable device ID too (I know that Peak and SYS-TEC have such=
=20
> features), but I did not find such a property in the SysFS tree.
>=20
> So if you have one more hot tip for me ... I'd appreciate it.

At least with my candelight and udev I can read the serial number and
other information. I suppose it's accessible via libudev somehow.

> udevadm info --path=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2/=20
> P: /devices/pci0000:00/0000:00:14.0/usb1/1-2
> N: bus/usb/001/095
> E: BUSNUM=3D001
> E: DEVNAME=3D/dev/bus/usb/001/095
> E: DEVNUM=3D095
> E: DEVPATH=3D/devices/pci0000:00/0000:00:14.0/usb1/1-2
> E: DEVTYPE=3Dusb_device
> E: DRIVER=3Dusb
> E: ID_BUS=3Dusb
> E: ID_MODEL=3DcandleLight_USB_to_CAN_adapter
> E: ID_MODEL_ENC=3DcandleLight\x20USB\x20to\x20CAN\x20adapter
> E: ID_MODEL_ID=3D606f
> E: ID_REVISION=3D0000
> E: ID_SERIAL=3Dbytewerk_candleLight_USB_to_CAN_adapter_000000000002
> E: ID_SERIAL_SHORT=3D000000000002
> E: ID_USB_INTERFACES=3D:ffffff:fe0101:
> E: ID_VENDOR=3Dbytewerk
> E: ID_VENDOR_ENC=3Dbytewerk
> E: ID_VENDOR_FROM_DATABASE=3DOpenMoko, Inc.
> E: ID_VENDOR_ID=3D1d50
> E: MAJOR=3D189
> E: MINOR=3D94
> E: PRODUCT=3D1d50/606f/0
> E: SUBSYSTEM=3Dusb
> E: TYPE=3D0/0/0
> E: USEC_INITIALIZED=3D288243366799

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qR4DYxu3CuLygpbTJY7vkHeCu8CkIQQA9--

--nPBjfnNrbAuR50O1pqlkYlLh8Qv2UI1Oj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcfD4ACgkQHv7KIOw4
HPaOfggA2FIJUusYotmc+u5KC+3AtutHzpZsGLu0+9MCFVacKLGS/Nn5FmdPQniB
34Z09DBjUbZwraaOoDPhZUdoIIeeYXE1labok+j9HB3Eh2oBLQFWsfbfZF4SZVt8
GP0H29bm3Hqgba5HSme6kJzuJw6hjGE3t+2LKNINqZFEsFuq1CufHjYeJCxUiicu
2duoc75udFGzpELd4Q6RIxeEJMd0EYmOcmi097FXRDncF6AGPwrBo5h5pKJYiWm6
TMl3VyFL+Rz9OnPLsjc0bJn3z0EXDYw03XrjiMZB3IMUP4ANmiMRr5lX80y8DxNG
bGHo7p3tyJTjK5KdE7Oycqnsj0kySg==
=c3oE
-----END PGP SIGNATURE-----

--nPBjfnNrbAuR50O1pqlkYlLh8Qv2UI1Oj--
