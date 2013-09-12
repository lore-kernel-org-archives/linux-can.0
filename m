From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 11:13:40 +0200
Message-ID: <523185C4.1020208@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de> <1378968239-sup-1257@pruts.nl> <5231748A.2080009@pengutronix.de> <1378975140-sup-5236@pruts.nl> <523180D2.700@pengutronix.de> <1378976796-sup-1310@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gMIhqDqH6dLscmMaUIsTnOon5IQ2RVbXW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59536 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3ILJNs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Sep 2013 05:13:48 -0400
In-Reply-To: <1378976796-sup-1310@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>, yegorslists <yegorslists@googlemail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gMIhqDqH6dLscmMaUIsTnOon5IQ2RVbXW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2013 11:09 AM, Ico Doornekamp wrote:

>> They are assuming the wrong endianes for your capture file. Yegor's
>> capture file, which comes in another format, is interpreted correctly.=

>=20
> Sorry, I was not completely clear on this: I did the capturing on the
> slcan0 interface from wireshark, so I did not make a capture file first=
=2E

In your original mail you've captured with wireshark, too, but written
into a file. Now you are capturing with wireshark directly. I assume the
same capturing engine (that one in wireshark) is involved in both
workflows and the same error is triggered in the
interpretation/dissection process.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gMIhqDqH6dLscmMaUIsTnOon5IQ2RVbXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIxhcQACgkQjTAFq1RaXHOArwCggG3r7PtJY5ivCd/0ISx4oVeI
hs0An3OuoRAPGH0p8Exi1QmwxJwycM1l
=YZLX
-----END PGP SIGNATURE-----

--gMIhqDqH6dLscmMaUIsTnOon5IQ2RVbXW--
