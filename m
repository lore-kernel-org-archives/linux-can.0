From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan: use hardware timestamp
Date: Mon, 29 Apr 2013 20:00:17 +0200
Message-ID: <517EB531.20803@pengutronix.de>
References: <517ECB130200000100098502@mail.schleissheimer.de> <517EB4D1.8020205@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LGHSHVLHEEJNKMOGKMMC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49697 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab3D2SAT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 14:00:19 -0400
In-Reply-To: <517EB4D1.8020205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LGHSHVLHEEJNKMOGKMMC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/29/2013 07:58 PM, Marc Kleine-Budde wrote:
> On 04/29/2013 07:33 PM, Sven Schuchmann wrote:
>> Hello,
>> I was wondering if the flexcan driver uses the hardware timestamp
>> and by looking at the code under drivers/net/can/flexcan.c and did
>> not find any access to those registers.
>> =20
>> is there a special reason for this?
>=20
> Yes, no one has implemented it yet :)
>=20
>> If not, I would try implementing to use skb_shared_hwtstamps...

I mean, go ahead implement hardware timestamps, but I haven't checked if
skb_shared_hwtstamps is the correct interface.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2LGHSHVLHEEJNKMOGKMMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF+tTEACgkQjTAFq1RaXHO88gCeI6JOvQLoRM2zTx3Kt0YrEoyj
zzUAniJFPYJj2fhSWlauOCbq620IwP5d
=Zl5+
-----END PGP SIGNATURE-----

------enig2LGHSHVLHEEJNKMOGKMMC--
