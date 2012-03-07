From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 15:07:35 +0100
Message-ID: <4F576BA7.6080406@pengutronix.de>
References: <20120306112108.GA4362@elgon.mountain> <20120307122112.GC674@mwanda> <4F57549F.3050309@pengutronix.de> <20120307131741.GD674@mwanda> <4F5761F2.5010301@pengutronix.de> <4F576B3C.7000607@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7356F3E033F5E8F024C40473"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44891 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2CGOHq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 09:07:46 -0500
In-Reply-To: <4F576B3C.7000607@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7356F3E033F5E8F024C40473
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2012 03:05 PM, Stephane Grosjean wrote:
>>> That's my guess too.
>>>         __le32 tmp32 =3D cpu_to_le32((cf->can_id&  CAN_ERR_MASK)<<  3=
);
>> St=E9phane, do you want to make that patch?
>> Add my Acked-by and a
>> "Reported-by: Dan Carpenter<dan.carpenter@oracle.com>"
>=20
> Ok I'll do it as soon as I did small tests to check.

Have you got a big endian machine (powerpc or an ARM IXP in Big Endian
Mode) somewhere?

> FYI, the patch will also contain the same fix but for the tmp16 local,
> declared into the "else" block:
>=20
>     __le16 tmp16 =3D cpu_to_le16((cf->can_id & CAN_ERR_MASK) << 5);

good point,

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7356F3E033F5E8F024C40473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Xa6oACgkQjTAFq1RaXHMvgQCfSSPipPiff31pD3EawXK7SOlQ
rfQAn0DA4rw1mkj6dhR+gwAO8dmw/tiJ
=uIwF
-----END PGP SIGNATURE-----

--------------enig7356F3E033F5E8F024C40473--
