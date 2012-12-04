From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 21:22:01 +0100
Message-ID: <50BE5B69.3040801@pengutronix.de>
References: <50BBF73F.9080208@universalnet.at>    <50BC5ECB.9070206@grandegger.com> <50BD0C52.6010606@universalnet.at>    <50BD0858.3020707@grandegger.com> <50BDCD1B.2010306@pengutronix.de> <c003ee227fe9e5a754a78fd8575ce977.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA7FB9408FE1B8BA38838C021"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37829 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2LDUWG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Dec 2012 15:22:06 -0500
In-Reply-To: <c003ee227fe9e5a754a78fd8575ce977.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7FB9408FE1B8BA38838C021
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/04/2012 07:44 PM, "Bernd Krumb=F6ck" wrote:
>> On 12/03/2012 09:15 PM, Wolfgang Grandegger wrote:
>>> On 12/03/2012 09:32 PM, krumboeck@universalnet.at wrote:
>>>> Hi Wolfgang!
>>>>
>>>>>
>>>>> And please also drop the remaining sysfs files for firmware and
>>>>> hardware. I thinks it's enough that the versions are printed when t=
he
>>>>> device is probed.
>>>>
>>>> Systemadministrators often use versions for configuration scripts.
>>>> If you insist I will remove.
>>>
>>> Marc?
>>
>> Are these values exported via lsusb -v (e.g. iSerial)?
>>
>=20
> No, I have not seen yet.
>=20
>=20
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass       255 Vendor Specific Subclass
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0483 SGS Thomson Microelectronics
>   idProduct          0x1234
>   bcdDevice            1.00
>   iManufacturer           1
>   iProduct                2
>   iSerial                 3
    ^^^^^^^^^^^^^^^^^^^^^^^^^

[...]

> dmesg:
> [11708.644014] usb 6-2: new full-speed USB device number 2 using uhci_h=
cd
> [11708.820030] usb 6-2: New USB device found, idVendor=3D0483, idProduc=
t=3D1234
> [11708.820034] usb 6-2: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [11708.820036] usb 6-2: Product: USB2CAN converter
> [11708.820038] usb 6-2: Manufacturer: edevices
> [11708.820041] usb 6-2: SerialNumber: ED000202
                                        ^^^^^^^^

Does these numbers correspond to the hardware and firmware revision?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA7FB9408FE1B8BA38838C021
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC+W2kACgkQjTAFq1RaXHP66gCfcRJE2qC2O5pC6IPAA+LcLc0N
UYMAniAzCQrKCJFpuj99hR771bikvtq8
=9o8i
-----END PGP SIGNATURE-----

--------------enigA7FB9408FE1B8BA38838C021--
