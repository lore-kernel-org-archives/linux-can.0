From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 10:52:34 +0200
Message-ID: <523180D2.700@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de> <1378968239-sup-1257@pruts.nl> <5231748A.2080009@pengutronix.de> <1378975140-sup-5236@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="f8cqWeWA4Hg9a8QM6usxE9ssBopDr95uj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3ILIwp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Sep 2013 04:52:45 -0400
In-Reply-To: <1378975140-sup-5236@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>, yegorslists@googlemail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8cqWeWA4Hg9a8QM6usxE9ssBopDr95uj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2013 10:47 AM, Ico Doornekamp wrote:
> * On 2013-09-12 10:00:10 +0200, Marc Kleine-Budde wrote:
> =20
>> ...but your CAN frames don't look correct in wireshark. I suggest you
>> bring up the command line tools and use candump to display the raw CAN=

>> frames. Raw CAN frames, as they enter the application, are in host
>> order. To be precise the can_id is in host order, as all other members=

>> are u8. "data" is an array of 8 x u8, which is in fact big endian
>> ordered, if you want to access it with 2x32 or 64 bit.
>>
>>> struct can_frame {
>>>         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>>         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MA=
X_DLEN) */
>>>         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>>> };
>=20
> I just did this. candump shows this:
>=20
>   slcan0  58A   [8]  4B 12 20 04 D6 00 00 00
>=20
> The raw data is shown in wireshark as
>=20
>   8a 05 00 00 08 00 00 00  4b 12 20 04 d6 00 00 00

"8a 05 00 00" in little endian is 0x0000058a, "08 00 00 00" is the dlc
of 8. Looks correct.

> The CAN dissector parses this as identifier 0x0a050000 with the
> 'extended' flag set , which seems to have the wrong endianess.
>=20
> The CANopen dissector also interprets the identifier with wrong endian
> order, and is thus not able to decode the rest of the packet.
>=20
> If I'm not mistaking, both the CAN and CANopen dissector in wireshark
> are thus assuming wrong endianess. I'll check the source and see if I
> can come up with a proper patch for the wireshark team.

They are assuming the wrong endianes for your capture file. Yegor's
capture file, which comes in another format, is interpreted correctly.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--f8cqWeWA4Hg9a8QM6usxE9ssBopDr95uj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIxgNIACgkQjTAFq1RaXHPkYACfZ2cO6R7T9kxfq1ay6vHKYOH7
4d4An2OsvVWLYqkyH8qzgLd9wHJ+UxTJ
=ujiX
-----END PGP SIGNATURE-----

--f8cqWeWA4Hg9a8QM6usxE9ssBopDr95uj--
