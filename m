From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Thu, 11 Oct 2012 13:28:37 +0200
Message-ID: <5076AD65.6080909@pengutronix.de>
References: <1349188730-11434-1-git-send-email-andreas@gaisler.com> <506D5AA4.5080704@pengutronix.de> <5076999F.6070302@pengutronix.de> <5076AC0C.6090306@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig063952DB4A3CEBD074FF2666"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab2JKL2q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 07:28:46 -0400
In-Reply-To: <5076AC0C.6090306@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig063952DB4A3CEBD074FF2666
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/11/2012 01:22 PM, Andreas Larsson wrote:
> On 2012-10-11 12:04, Marc Kleine-Budde wrote:
>> On 10/04/2012 11:45 AM, Marc Kleine-Budde wrote:
>>> Hello,
>>>
>>> On 10/02/2012 04:38 PM, Andreas Larsson wrote:
>>>> This driver supports GRCAN and CRHCAN CAN controllers available in
>>>> the GRLIB
>>>> VHDL IP core library.
>>>>
>>>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>>>> ---
>>>>   drivers/net/can/Kconfig  |    6 +
>>>>   drivers/net/can/Makefile |    1 +
>>>>   drivers/net/can/grcan.c  | 1283
>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   drivers/net/can/grcan.h  |  273 ++++++++++
>>>>   4 files changed, 1563 insertions(+), 0 deletions(-)
>>>>   create mode 100644 drivers/net/can/grcan.c
>>>>   create mode 100644 drivers/net/can/grcan.h
>>>
>>> Some general remarks while scrolling though the driver:
>>> - please provide a device tree binding documentation
>>>    Documentation/devicetree/bindings/net/can/grcan.txt
>>>    and add devicetree-discuss@lists.ozlabs.org on Cc
>>> - please provide a documentation for the sysfs entries:
>>>    Documentation/ABI/testing/sys-XXX-grcan.txt
>>> - please implement a NAPI
>>> - please include the .h file into the C code,
>>>    as the C code is the one and only user of the .h file
>>> - please give every macro a GRCAN_ prefix
>>
>> Your driver should work on little as well as on big endian systems. Yo=
u
>> need probably two implementations of the grcan_{read,write}_reg
>> functions, you can take the flexcan driver [1] as an example.
>=20
> Adding that is easy of course, but that gives the impression of support=

> for little endian systems. If the core would be instantiated in a littl=
e
> endian fashion in a little endian environment, the DMA accessing parts
> of the hardware would still not work in a little endian system without
> modifications to the hardware design.

Can you add this to the Kconfig help text.

> From the driver point of view either way works for me, but I am not sur=
e
> what is best.

In this case you should limit the driver to big endian systems via kconfi=
g.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig063952DB4A3CEBD074FF2666
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB2rWUACgkQjTAFq1RaXHMOzwCglYaJrGy6UICZrW8y8fAHM7nn
jCcAn3+8ffRpAAKB9eJRKFiaxdln+Uhz
=lOtv
-----END PGP SIGNATURE-----

--------------enig063952DB4A3CEBD074FF2666--
