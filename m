From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] socketcan in barebox bootloader
Date: Fri, 10 Feb 2012 11:58:33 +0100
Message-ID: <4F34F859.6050905@pengutronix.de>
References: <OF32B6D01B.4E8430B8-ONC125799E.0055E20B-C125799E.00563FFD@o0802.rafi.inhouse> <1328824647.5414.10.camel@slaptop> <4F34DB82.2050603@pengutronix.de> <4F34E475.1090408@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D199C6073C08F79CC33238A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55559 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758719Ab2BJK6f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 05:58:35 -0500
In-Reply-To: <4F34E475.1090408@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Max S." <king@greatfreeworld.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D199C6073C08F79CC33238A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2012 10:33 AM, Oliver Hartkopp wrote:
>> On 02/09/2012 10:57 PM, Max S. wrote:
>>> CAN is meant for control messages, not for media, or data transfer.
>>
>> In the automotive world it's quite common to do firmware updates over =
CAN.

> indeed e.g. the ISO 15765-2 protocol is used to segment PDUs up to 4095=
 byte
> into the 8 byte payload of CAN frames.
>=20
> If you want to play with ISO TP on SocketCAN - it's located here:
>=20
> https://gitorious.org/linux-can/can-modules/blobs/master/net/can/isotp.=
c
>=20
> But then you would need to implement ISO-TP inside the bootloader too.

That's why I argued to boot into an update linux from the bootloader and
use the existing CAN stack and protocols.

>>> That aside, I do use CAN to flash AVR microchips. It can take a few
>>> minutes though.
>>
>> What throughput do you usually get when updating over CAN?
>=20
>=20
> I implemented a IP-over-ISOTP tunnel for fun:
>=20
> https://gitorious.org/linux-can/can-utils/blobs/master/isotptun.c
>=20
> and taking into account that ISO-TP uses the first byte inside the CAN =
frame
> payload for protocol purposes (1/8 =3D 12.5% overhead) and the TCP/IP-h=
eader of
> 40 byte within the IP communication i got ~26 kByte/s on a 500kbit/s CA=
N as
> throughput.

There are people that haver narrower DSL lines :)

> Probably that helps to get an impression ;-)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7D199C6073C08F79CC33238A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk80+FkACgkQjTAFq1RaXHMETgCfWGNW6hzgcs7+TIE/LwA5huDC
lBQAn02Z96peK/xIgr5rfQ2waNMCaM5Z
=VCMN
-----END PGP SIGNATURE-----

--------------enig7D199C6073C08F79CC33238A--
