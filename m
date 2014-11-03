From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Request for advice on CAN driver writing
Date: Mon, 03 Nov 2014 13:32:44 +0100
Message-ID: <545775EC.7030800@pengutronix.de>
References: <54F29680670EE04E9BB46A703116517492D781@dtxvm2010.dtxinc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iIeVtf1dOrSTtuihFsOcx7MsIv8I81Nd3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51079 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbaKCMcx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:32:53 -0500
In-Reply-To: <54F29680670EE04E9BB46A703116517492D781@dtxvm2010.dtxinc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Naughton <Dan.Naughton@dtx.com>, "'wg@grandegger.com'" <wg@grandegger.com>, "'linux-can@vger.kernel.org'" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIeVtf1dOrSTtuihFsOcx7MsIv8I81Nd3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On 10/31/2014 06:40 PM, Dan Naughton wrote:
> I found your names on the kernel maintainers list for CAN driver and I
> was hoping you could help with some advice.  I have two companies that
> are writing drivers for their CAN cards for me (http://goo.gl/mca7Ao an=
d
> http://goo.gl/S00PDT ), but I am not a driver developer.     I would
> like them to submit their drivers to kernel.org =E2=80=93 but I would l=
ike to
> make sure that the drivers are not garbage.  So I was looking for advic=
e:

that depends on your agreement with these companies ;)

> My list of requirements:
>=20
> =C2=B7         libsocketcan.h  API compatible.

If you add "upstream CAN driver to official linux tree at kernel.org" to
your requirements there the drivers will sooner or later end up here.
And eventually they're being reviewed.

There also is the possibility to book commercial CAN driver
reviewing/mainlining/writing support, e.g. by you (your company) or the
hardware manufacturer. Contact me directly for more information.

> =C2=B7         ???  I=E2=80=99m stuck =E2=80=93 is there one of the dri=
vers here that we
> should model it after
> (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/net/can)

Regarding the hardware:

- MPE-CAN+CAN-C
The documentation situation is quite shallow :) But it says a
PIC32MX795F512L (MIPS based) processor is used. As far as I can see the
processor has a USB, but no PCI controller. So the card uses probably
the USB within the PCIe connector. So the drivers in
"drivers/net/can/usb" are worth to look at. The "usb_8dev.c" supports an
ARM based chip, where the hardware and firmware is open source. The
"gs_usb.c" serves a device, which firmware is modelled to fit the
linux-can quite easily.

But as the MPE-CAN+CAN-C hardware is already available, I assume the
firmware is already finished and a new Linux driver has to be written.

- MPX-2515
Hearing the numbers "2515" next to CAN, gives me shivers :) There is the
MCP2515 SPI CAN controller, which is the second worst CAN chip I know
(the MCP2510 is the worst one). And indeed:

> CYPRESS CY8C24794-24LTXI PSoC
> Microchip MCP-2515 CAN Controller
> Microchip MCP-2551 High-Speed CAN Transceiver

They probably have attached the MCP2515 to the SPI bus of the CYPRESS
processor, which has a USB Interface. So this hardware is only using the
USB part of the PCIe connector. BTW: the USB is only working in 12
Mbit/s (instead of the full 480 Mbit/s of USB-2.0). From the used chips,
this hardware must/should significantly cheaper than the MPE-CAN+CAN-C :)=


As this is a USB hardware, the same comments about existing CAN-USB
driver apply.

> Thanks for your assistance.  We would like to contribute the CAN driver=

> support =E2=80=93 I would like to avoid contributing garbage

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iIeVtf1dOrSTtuihFsOcx7MsIv8I81Nd3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV3XsAAoJECte4hHFiupUgecQAIRScmUQ8jxIO6RAQ/vRH2di
YBqLBWxEHAx6cbGIiz1pM9pzrXJJb8jvgmaAqJPB2K1OCxkWFRSYOMCexdtvF/7I
sHbVg3WU/amwNx6uaW44iOK39fZbJ0FEc37MZ0x19eANttOv+uEkghB0BYHeEK1U
VGklaey58eqpQqxSnzSz4ZYCm79bGctbe+9sZR+bpNGDGrLyXtH5NY3J/zUQjpzW
8DVVIOXUepAElNPI1YJEDPqUcIf2ZPP9EHU7HXPD6UBTIIkFfPjd+NDKtrA0QJng
DCezU0Vky8cWUE8jBK2COzpBIyGO1KXcTYeS0V03N6HEyr6hFYRcR8eTvG44d6dz
R58GzgD4uV9pmKgNF8HLHGa7e25dNjT/9Ruc6J0K2l8WFjEHyqjeZkQ/q98TPar2
iRm+mvVILcGdZ4Ayp+OmIxAax0M07QxJCEcdaF1XDDrCBkasbBnTWZ1HgcfHlFAE
p4q1QuwX1JK53iXi84YNwdLmTgK34OlZ2B2AQJ6nV/o4a2OJ5iqOuEthzaFGANtM
FftuJImPS02tZ6iPASkx5ygKvfSIqbjPZbbCeUdiVi5/4O0SgTtXH28tTwFQZQia
lMTDjaBUrN2/gDu+zWoM4fCYXlMiIKcaof0hP9tMII73dA7WEDR3Ey07Ljf5w4Ta
UXGNhy8dYrxTh6bjC0ax
=+ZQU
-----END PGP SIGNATURE-----

--iIeVtf1dOrSTtuihFsOcx7MsIv8I81Nd3--
