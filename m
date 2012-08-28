From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb-can device
Date: Tue, 28 Aug 2012 14:20:06 +0200
Message-ID: <503CB776.8030303@pengutronix.de>
References: <1345996339.6610.10.camel@slaptop>  <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <1346071259.3928.33.camel@slaptop> <503CB26E.7010106@hartkopp.net> <503CB5DF.4030707@pengutronix.de> <503CB70A.8040506@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1629B1F13303697F23459FC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2H1MUN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Aug 2012 08:20:13 -0400
In-Reply-To: <503CB70A.8040506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1629B1F13303697F23459FC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2012 02:18 PM, Oliver Hartkopp wrote:

[...]

>>> I found a very interesting implementation in the Bosch M_CAN specific=
ation:
>>>
>>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/m_ca=
n/m_can.asp
>>>
>>> http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/m_can/mca=
n_users_manual.pdf
>>>
>>> Section 2.4.3 Tx Buffer Element (page 45)
>>>
>>> ---8<---
>>>
>>> T1 Bits 31:24 MM[7:0]: Message Marker
>>>
>>> Written by CPU during Tx Buffer configuration. Copied into Tx Event F=
IFO
>>> element for identification of Tx message status.
>>>
>>> ---8<---
>>>
>>> So you can see in the Tx event FIFO, which marked CAN frame has been =
sent.
>>>
>>> This is probably enough to provide just a byte and to create an array=
 of
>>> skb pointers which is referenced by this Message Marker. Maybe 256 ma=
rkers
>>> are too much ... we could only use 8 markers IMO.
>>
>> Why not a full u32? Then you're free on the driver side to do what you=

>> want with it.
>=20
>=20
> Yes. You're right. It's a marker - and if i personally only want to han=
dle an
> index into an array with 8 elements with my driver it's my choice.
ACK :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA1629B1F13303697F23459FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlA8t3kACgkQjTAFq1RaXHNsTACbBSKim1ZjuKs6RxYaGMtrZ0j+
4D0AniZDPhzI3kQzuDdHq1ZzeauJc/rv
=rZe5
-----END PGP SIGNATURE-----

--------------enigA1629B1F13303697F23459FC--
