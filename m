From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: WIP: fix out-of-order problem - CANMIN
 Version
Date: Wed, 07 Nov 2012 15:16:56 +0100
Message-ID: <509A6D58.4060104@pengutronix.de>
References: <a> <1352145232-16403-1-git-send-email-mkl@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA664B7@DBDE01.ent.ti.com> <509A53A2.8020902@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA665AB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7C017BA869CC19C5948E72A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54819 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2KGORH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 09:17:07 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA665AB@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7C017BA869CC19C5948E72A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/07/2012 02:56 PM, AnilKumar, Chimata wrote:
[...]

>>> 3. @1MBPS I have seen the wrong sequence message.
>>
>> Can you give the the exact error messages. There is a difference betwe=
en
>> "lost" messages and out-of-order messages. Lost messages simply print =
a
>> single wrong sequence number detected message. An out-of-order recepti=
on
>> prints a characteristic 3 line error message.
>=20
> These are the message I am seeing at 1MBPS
>=20
> [root@arago /]# cansequence -r -v | grep wron
> received wrong sequence count. expected: 191, got: 192
> received wrong sequence count. expected: 193, got: 194
> received wrong sequence count. expected: 195, got: 196
> received wrong sequence count. expected: 197, got: 198

These are lost frames, they are not out-of-order. Would be interesting
to know if they are list in the socket or in the hardware. I've hacked
the driver to do the cansequence analysis in the driver, I'll port the
patches and post them here.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC7C017BA869CC19C5948E72A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCabVwACgkQjTAFq1RaXHOgZwCeJsGycy9syFp6ql1qh23uKikA
0ZkAnAqX3uv88Z6DIfGs60CctAFuTAnT
=2Vse
-----END PGP SIGNATURE-----

--------------enigC7C017BA869CC19C5948E72A--
