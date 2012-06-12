From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: serial can or socket can ?
Date: Tue, 12 Jun 2012 15:53:47 +0200
Message-ID: <4FD749EB.5070201@pengutronix.de>
References: <CAHvj1qaxr-Zo4oteEhvrMXG00if3CBrPSL8+QYrQyJu=NUfnzg@mail.gmail.com> <4FD747AB.70406@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5AF676E3E7A03876F8073DB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab2FLNyL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 09:54:11 -0400
In-Reply-To: <4FD747AB.70406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: bruce bushby <bruce.bushby@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5AF676E3E7A03876F8073DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/12/2012 03:44 PM, Oliver Hartkopp wrote:
> On 12.06.2012 14:55, bruce bushby wrote:
>=20
>> Hi
>>
>> I wanted to confirm my understanding of "socketcan" in terms "slcan0" =
and "can0"
>>
>=20
>=20
> Ok, let's go ...
>=20
>> I've been playing with a Beaglebone board the a usb-can adaptor from
>> mictronics.de:
>> http://www.mictronics.de/projects/usb-can-bus/
>> Purchased from:
>> http://shop.greenstage.co.nz/product/usb-can-bus-interface
>>
>> 1. Is my understanding correct that "slcan" will ALWAYS be used when
>> connecting a USB based CANBUS adapter?
>=20
>=20
> No.
>=20
> The slcan driver provides a CAN network device for CAN interfaces that =
are
> controlled by the ASCII protocol first brought up by LAWICEL (www.can23=
2.com,
> www.canusb.com). The slcan driver converts the ASCII frames to struct
> can_frame which is used in the Linux CAN subsystem (aka SocketCAN).
>=20
> You may have a CAN device supporting the SLCAN protocol on RS232, USB-s=
erial
> adapters, whatever.
>=20
> See
>=20
> http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/Kconfig#L13
>=20
> and
>=20
> http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/slcan.c#L99
>=20
> There are CAN USB drivers in the tree, that do not use the SLCAN protoc=
ol:
>=20
> http://lxr.linux.no/#linux+v3.4.2/drivers/net/can/usb/Kconfig
>=20
>=20
>>
>> I am able to bringup slcan0 using the following commands:
>=20
>=20
> Use this
>=20
>> # slcan_attach -o -s6 /dev/ttyUSB0
>> attached tty /dev/ttyUSB0 to netdevice slcan0
>=20
>=20
> OR this
>=20
>> # slcand ttyUSB0
>=20
>=20
> !
>=20
> Running slcand and slcan_attach together doesn't make sense.
>=20
>=20
>> # ifconfig slcan0 up
>> # ifconfig slcan0
>> slcan0    Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:10
>>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>
>> #
>>
>>
>> 2. AM335x has an internal D_CAN, but the Beaglebone is missing any CAN=

>> transceiver...would the lack of the transceiver prevent the kernel
>> from creating the "can0" device?

As Oliver said, you need a platform device definition in your board file
and a kernel that supports the d_can hardware. You can use David
Miller's net-next/master tree.

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF5AF676E3E7A03876F8073DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/XSe8ACgkQjTAFq1RaXHNFyACfY0+zGHtPZk15ZCgOGHhJ3Hm1
wMcAn3xtqhM4q+T/EP+WrqnKBFOoLveB
=fahQ
-----END PGP SIGNATURE-----

--------------enigF5AF676E3E7A03876F8073DB--
