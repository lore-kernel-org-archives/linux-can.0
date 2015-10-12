From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Mon, 12 Oct 2015 10:54:46 +0200
Message-ID: <561B7556.3050206@pengutronix.de>
References: <55E6CCC8.7010908@picquet.fr> <55E80C74.8060600@pengutronix.de>
 <561B69B2.9010804@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xx6vcJunkmRfU97KBiIsaMTLOJjcd8sXE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48306 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbJLIzA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 04:55:00 -0400
In-Reply-To: <561B69B2.9010804@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xx6vcJunkmRfU97KBiIsaMTLOJjcd8sXE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2015 10:05 AM, Guillaume Picquet wrote:
> I've received a patched firmware from my provider, tested it and so far=
=20
> so good.

Good to hear that. Can you send the patches or at91_can.c to the list?

> I've connected 2 devices (AT91 based) at 1Mb/s.
> So far more than 470000000 frames received so far.
>  From the user-space point of view it's much better.
> Now the only way to know if rx overflow occur is to set SO_RXQ_OVFL=20
> flag, use recvmsg and check ancillary data.

No, that's not correct. With SO_RXQ_OVFL you'll detect overflows of the
socket. When there are overflows in the hardware the rx overrun in per
device statistics will be increased (see ifconfig) output.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xx6vcJunkmRfU97KBiIsaMTLOJjcd8sXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWG3VYAAoJEP5prqPJtc/H524IAI+zDu60MV3UAF+mtxbXcj+e
Az/w1Lct8B4br2wA8kKYihGUeAGsWADD7C08Bq+eu67UuPw6ILWJdR6nJ6vXK/hx
nc/kEh1JcI8Zme8WnVTIA8uqKbS5xapnzQnGtpoOvm/OHmutCe9z9bdSY4hjkVl4
KkVEFzjvjZORLGutZRPJ7urFQxi7qjfSqSXbt2BWqKmdtnjZBMQMIMv/A2N7Nmhs
pnnlzkZH+Zf5SlmecIb4FtgwMQDVqBZBAKtysl14H8p1ga+oOxhEtH4FqfXbRraE
2Ywc6LTFF9H7f0f1/azkipa1x+AOab6Souo/qfgFEW5X2HGQHKqekfhydR04BHs=
=IXhZ
-----END PGP SIGNATURE-----

--xx6vcJunkmRfU97KBiIsaMTLOJjcd8sXE--
