From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Any chance to get the Softing CAN-AC PCI card to run with socketcan?
Date: Thu, 09 Aug 2012 20:09:24 +0200
Message-ID: <5023FCD4.7080601@pengutronix.de>
References: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig313BD7D1D48977C97AC489DA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38380 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745Ab2HISJf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 14:09:35 -0400
In-Reply-To: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernhard Thiele <bernhard-thiele@web.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig313BD7D1D48977C97AC489DA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On 08/09/2012 04:40 PM, Bernhard Thiele wrote:
> I wonder if anyone could give me an answer whether there is way to
> get the Softing-AC PCI card running with the current code base.
>=20
> The card has an SJA1000 chip that seems to be supported by linux-can
> for some devices. However, for Softing devices I've only found
> support for the Softing PCMCIA cards in the source tree.

Have you tried to load the generic plx_pci driver?

> Is there are a way to get a Softing-AC PCI card running with linux-can?=


If softing has attached the sja1000 with a plx pci bridge, it's probably
not to complicated to add support to the existing plx_pci driver. A
non-socketcan softing driver may be of help here.

> P.S.: I hope this post is not off-topic for this list that seems
> mainly to be used by developers. If there is an active forum or
> mailing list for users, I'll gladly take any pointers to that address
> and repost there.

This is the correct mailing list.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig313BD7D1D48977C97AC489DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAj/NsACgkQjTAFq1RaXHPJLQCgg0zD0oQ5YhZ2nqPwwuLiNsZz
+70AnRfQ6Wcr9HVdpB0EO0T3sIgHqvSA
=OD5O
-----END PGP SIGNATURE-----

--------------enig313BD7D1D48977C97AC489DA--
