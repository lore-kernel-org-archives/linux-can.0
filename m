From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb-can device
Date: Tue, 28 Aug 2012 14:13:19 +0200
Message-ID: <503CB5DF.4030707@pengutronix.de>
References: <1345996339.6610.10.camel@slaptop>  <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <1346071259.3928.33.camel@slaptop> <503CB26E.7010106@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0EBFE1AC5204E6D273ED3965"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2H1MN0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Aug 2012 08:13:26 -0400
In-Reply-To: <503CB26E.7010106@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EBFE1AC5204E6D273ED3965
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Max, please leave the mailinglist on Cc.

On 08/28/2012 01:58 PM, Oliver Hartkopp wrote:
> On 27.08.2012 14:40, Max S. wrote:
>=20
>> On Mon, 2012-08-27 at 08:20 +0200, Oliver Hartkopp wrote:
>=20
>>> The idea is to bring the USB CAN interface as near as possible to the=

>>> SocketCAN network interface:
>>
>> Exactly. The device should know what a struct can_frame is. The device=
 i
>> have is more than powerful enough to do some extra converting, endian
>> etc (its an atmel devboard).
>> I have been reading the Peak CAN-USB driver source, they seem to do th=
e
>> conversion on the host with a simple
>> #ifdef ENDIAN be or le ...=20
>>
>> compiling either the big endian or the little endian code.
>>
>> but a single memcpy would be allot cleaner.
>=20
>=20
> Yes. In general the content from the CAN registers needs to be copied i=
nto the
> URB from the CAN USB CPU anyway. So the idea is to do it in host-byteor=
der.
> This has a very small impact to the CAN CPU complexity and makes it rea=
lly
> easy on the host driver side.
>=20
>>> - send struct can_frames
>>> - receive struct can_frames (for instant CAN data forwarding)
>>> - receive struct can_frames (for instant CAN error messages(!) forwar=
ding)
>>> - send an endian pattern inside the USB URB (*1)
>>> - send skb->sk pointers along with CAN data (*2)
>>> - define a simple interface for open/close/bitrate-setting
>>>
>>> *1:
>>> The idea is to reduce the CAN network driver to make simple memcpy()
>>> operations instead of do any bitshifting or endian conversions. For t=
hat
>>> reason an endian pattern (e.g. 0xAA00AA00) is added to the USB URB at=

>>> send/configuration, so that the CAN USB adapter switches to the host =
endian
>>> mode and replies with the same endian pattern before the CAN data.
>>> This allows to simply memcpy() the received CAN frame into skb->data.=

>>>
>>> *2:
>>> To provide a state-of-the-art echo functionality the sk pointer (skb-=
>sk) is
>>> sent along with the CAN frame. This allows to skb_free() the original=
 tx skb
>>> and create a new one at rx time with the correct sk pointer, when the=
 frame is
>>> echoed after successful transmission. As we are endian safe the sk po=
inter can
>>> be taken from the USB URB as-is. (For security reasons we should prob=
ably not
>>> take the pointer directly but double check with stored echo-skbs)
>>
>> hm. I also don't think it would be wise to accept a pointer from the
>> outside in kernel space. maybe accept an index(that can be checked) in=
to
>> a pointer array?.. I don't know, I'm not at that point yet :P.
>>
>=20
>=20
> I found a very interesting implementation in the Bosch M_CAN specificat=
ion:
>=20
> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/m_can/=
m_can.asp
>=20
> http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/m_can/mcan_=
users_manual.pdf
>=20
> Section 2.4.3 Tx Buffer Element (page 45)
>=20
> ---8<---
>=20
> T1 Bits 31:24 MM[7:0]: Message Marker
>=20
> Written by CPU during Tx Buffer configuration. Copied into Tx Event FIF=
O
> element for identification of Tx message status.
>=20
> ---8<---
>=20
> So you can see in the Tx event FIFO, which marked CAN frame has been se=
nt.
>=20
> This is probably enough to provide just a byte and to create an array o=
f
> skb pointers which is referenced by this Message Marker. Maybe 256 mark=
ers
> are too much ... we could only use 8 markers IMO.

Why not a full u32? Then you're free on the driver side to do what you
want with it.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0EBFE1AC5204E6D273ED3965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlA8teMACgkQjTAFq1RaXHNj1wCgmEUkUMl0ZOF74Yg/H+G+232f
4JcAn2vjXOO+RzDMCCYMgb6tbCxFBIKu
=7Qji
-----END PGP SIGNATURE-----

--------------enig0EBFE1AC5204E6D273ED3965--
