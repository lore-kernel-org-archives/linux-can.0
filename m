From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 09:49:47 +0200
Message-ID: <542BB21B.4030200@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1hw0BsixGEikqBjgelk1nolVEJVV1rxw9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52295 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaJAHtw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 03:49:52 -0400
In-Reply-To: <542BACC0.4050707@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1hw0BsixGEikqBjgelk1nolVEJVV1rxw9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/01/2014 09:26 AM, Florian Feldbauer wrote:
> I still have some problems with the socket CAN driver for
> my Raspberry Pi CAN interface.
> I added a printk statement in the read/write register functions to
> see what happens.
>=20
> Looking into the output of `dmesg` after loading the kernel module
> I see in an endless loop appearing the lines
>=20
> [  129.210361] sja1000_raspi: Read register 0: 0x21
> [  129.210394] sja1000_raspi: Write register 4: 0x00
> [  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not yet
> defined
>=20
> Is this an expected behavior?

Do you have network manager or a similar program running that is trying
to handle the CAN interface?

> After setting the bitrate using
> $> ip link set can0 type can bitrate 250000
> The above messages stop.
>=20
> dmesg output at this point:
> [  172.870195] sja1000_raspi: Read register 15: 0xff
> [  172.870231] sja1000_raspi: Read register 14: 0xff
> [  172.872933] sja1000_raspi sja1000_raspi.0 can0: setting BTR0=3D0x01
> BTR1=3D0x1c
> [  172.872971] sja1000_raspi: Write register 6: 0x01
> [  172.872987] sja1000_raspi: Write register 7: 0x1c
> [  173.269190] sja1000_raspi: Read register 0: 0x21
> [  173.269221] sja1000_raspi: Write register 4: 0x00
> [  173.269287] sja1000_raspi: Write register 15: 0x00
> [  173.269303] sja1000_raspi: Write register 14: 0x00
> [  173.269319] sja1000_raspi: Read register 12: 0xff
> [  173.269336] sja1000_raspi: Read register 0: 0x21
> [  173.269348] sja1000_raspi: Write register 0: 0x00
> [  173.269369] sja1000_raspi: Read register 0: 0x20
> [  173.269381] sja1000_raspi: Write register 4: 0x7f
> [  173.269446] sja1000_raspi: Read register 15: 0x0c
> [  173.269462] sja1000_raspi: Read register 14: 0x03
>=20
> The main problem is: If I now try to change the bitrate again
> I get a "Device or resource busy" error.

You'll get this busy error if the device is still "up", so there is
someone who automatically does something similar to "ifconfig can0 up".

> demsg shows in this case simply these to lines:
> [  445.848207] sja1000_raspi: Read register 15: 0x0c
> [  445.848241] sja1000_raspi: Read register 14: 0x03
>=20
> After bringing the interface up and trying to listen on the CANbus
> using candump from the can-utils I get nothing, although a second
> node is sending frames and bitrate settings are correct.

Do you get any interrupts?

> I'm working with the raspberry pi kernel
> (https://github.com/raspberrypi/linux)
> version 3.12.y commit c256eb9968c8997dce47350d2075e42f1b3991d3
>=20
> Source of my own kernel module is also on github
> https://github.com/ffeldbauer/epics_RPi_can/blob/ver3.0.0/CAN_interface=
/driver/sja1000_raspi.c
>=20
>=20
> As written before, I could not find a documentation of socketCAN and
> simply tried
> to "copy" the sja1000_isa.c driver...naybe I did something completely
> wrong or missed
> something?

Yes, making a copy of the driver is probably not the right thing....
BTW: where's are the original copyright notes?

> Any help is very much appreciated!

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1hw0BsixGEikqBjgelk1nolVEJVV1rxw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQrshsACgkQjTAFq1RaXHNpIACeMgLcx4Neg458xzeeHfNXY8Fk
/b0AnArVsBq1zrzd/tTqhHCLdKb/nj5n
=uu42
-----END PGP SIGNATURE-----

--1hw0BsixGEikqBjgelk1nolVEJVV1rxw9--
