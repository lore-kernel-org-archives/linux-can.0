From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 20:22:01 +0200
Message-ID: <5230B4C9.4070904@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G0aXgHSTpqvqS55HC6xBo5M8WRSucCnAe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58622 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab3IKSWI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 14:22:08 -0400
In-Reply-To: <1378920814-sup-4559@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0aXgHSTpqvqS55HC6xBo5M8WRSucCnAe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On 09/11/2013 07:42 PM, Ico wrote:
> Recently I tried the CANopen module in wireshark to sniff on my slcan
> interface, but the dissector seemed to mix up the endianess of the

When opening your attached files I don't see any CANopen related
dissecting happening in my wireshark (Version 1.10.1 (SVN Rev 50926 from
/trunk-1.10), from current Debian testing/jessie). Just normal raw CAN
frames are displayed.

> capture. The source of the dissector seems to assume the CANopen data i=
s
> encoded in big endian, altough afaik CANopen uses little endian for its=

> data.

Maybe you are mixing CANopen and plain raw CAN frames.

> I contacted Yegor Yefremov, the contributor of the CANopen dissector,
> who is now just confused as I am: he made some captures on his own
> setup, on which the endianess is indeed different then from mine.
>=20
> We both run on x86, so host endianess does not seem to be part of the
> problem.

But you're using a 64 bit system while Yegor uses a 32 bit one
(according to your notes below).

> Hereby I attach two capture files, one made on my setup, and one made b=
y
> Yegor. Can oneone check which one has the proper endianess, and maybe
> take a look at the current CANopen dissector in wireshark to see if the=

> implementation is ok?

Your dump doesn't look correct in my wireshark, it has alternating
extended and standard frames and the standard frames have identifiers of
0x060000 which is not valid.

Does the command line tool candump show proper frames?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G0aXgHSTpqvqS55HC6xBo5M8WRSucCnAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIwtMkACgkQjTAFq1RaXHNQGQCdEyczALaQQfTYUJLdx21WrUJi
x9QAnAyxyZxJWUGTLGzc9R67rX/s2tWu
=NFfh
-----END PGP SIGNATURE-----

--G0aXgHSTpqvqS55HC6xBo5M8WRSucCnAe--
