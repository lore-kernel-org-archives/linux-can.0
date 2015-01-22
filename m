From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 16:41:52 +0100
Message-ID: <54C11A40.5000308@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com> <54C11839.7060802@pengutronix.de> <54C119F9.7030006@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PvQLuebLoXjE07emu7uSraedhM6pkarph"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54507 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbAVPly (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:41:54 -0500
In-Reply-To: <54C119F9.7030006@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PvQLuebLoXjE07emu7uSraedhM6pkarph
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:40 PM, Stephane Grosjean wrote:
>=20
> Le 22/01/2015 16:33, Marc Kleine-Budde a =C3=A9crit :
>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>> Add support for the following new PEAK-System technik CANFD USB adapt=
ers:
>>>
>>> PCAN-USB FD             single CANFD channel USB adapter
>>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>>
>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>   drivers/net/can/usb/Kconfig                  |   14 +-
>>>   drivers/net/can/usb/peak_usb/Makefile        |    2 +-
>>>   drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++
>> Please merge ucan.h into pcan_usb_fd.c, which is the one and only user=

>> of it.
>>
>> Marc
>>
>=20
> Well, we already have discussed about that, remember: uCAN interface is=
=20
> to be also used with some other new CANFD equipments...

Thanks for reminding me :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PvQLuebLoXjE07emu7uSraedhM6pkarph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRpAAAoJECte4hHFiupUSjwQAJbDxkVLgEsvfcXr2RAXMLzv
zu+OzhgzgQW1yvUXZnJEQ2g2b5i7I+mL7k6q2i3PwVKgCk6AvkBzR3YoH7Miln85
OdTS+KdgZBgR9mUE3klIZe0Tv6J1/2kh8azfmxziN4Ihda3t44mYVa+g5qfpM4dD
pkdSHpNA7N4KGbvHVkqtJ5ftC2J33RFnjALBHmxauYQbhXDDwsSQli3PJ5ZBWIkQ
GxDMlHoishk5kuQfC+t2IPhqECuJH//yzdIW4SgutPvi9nHL7ZCR3JI1TCtGdDAC
3gNW43VhWCpgeUGH1XL/6TES5phbrmHWEB8T4twbQp1cnmznB06KtWA4CEAr5T/7
O81+khdGgA4PA6bc1JqUvCWTBBGlGzIVpQTg67dcE5Rb4QyV0HOLZdyPFVrKrLre
lC2ZKrMx5Wh6qmn+bgrsJ0o7Toq1uNJYIbGJEjNu/4isTo6o6svhCwv2anVpwaFL
jM3v5a8BE9wHyT6Jd8K1acU2i4dwIqf9dksWOQPS0IEkvDJTyF0fput7oGa36gWc
1e5+ktCk8+qgqkh1Ifay4Vjv4eVwy9YanB8OML7HTjRDdXL7AvL0OVUwiySkeLBE
NMKlEvCp+v0jYM7odDkZ0ltarWHpUQSL3fijLXEyqSMmnVNmbyOCMtOxaWGK+H4Y
V62o4M0++f+LZYaiod5C
=+Yaw
-----END PGP SIGNATURE-----

--PvQLuebLoXjE07emu7uSraedhM6pkarph--
