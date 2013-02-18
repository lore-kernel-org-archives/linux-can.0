From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-utils: AOSP build improvements
Date: Mon, 18 Feb 2013 10:21:03 +0100
Message-ID: <5121F27F.9020102@pengutronix.de>
References: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com> <5121E30E.1050305@pengutronix.de> <CAGm1_ks1qZkaE0UGMV2F9ooFrziMNb3JAtcqMW1AWX7VSP9Teg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FDJXPHTQJUBHJVTVVJII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45103 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab3BRJVF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Feb 2013 04:21:05 -0500
In-Reply-To: <CAGm1_ks1qZkaE0UGMV2F9ooFrziMNb3JAtcqMW1AWX7VSP9Teg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FDJXPHTQJUBHJVTVVJII
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/18/2013 10:10 AM, Yegor Yefremov wrote:
> On Mon, Feb 18, 2013 at 9:15 AM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 02/18/2013 09:06 AM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> Add local headers and GCC flags for all can-utils targets.
>>
>> Can you create a variable PRIVATE_LOCAL_CFLAGS or whatever to hold the=

>> -O2 -g -W -Wall \
>>> +         -DSO_RXQ_OVFL=3D40 \
>>> +         -DPF_CAN=3D29 \
>>> +         -DAF_CAN=3DPF_CAN
>>
>> and reuse that?
>=20
> Thanks. That makes the code cleaner.
>=20
> Btw what about isotp.h? Is it going to be mainlined?

That's Oliver's cup of tea :)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FDJXPHTQJUBHJVTVVJII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEh8n8ACgkQjTAFq1RaXHNpnACeLp8P68OyaPhP2iPQj1PSFb1c
n7IAoIr+gCxvDil+keVuuLwlOF5R64vW
=WQvj
-----END PGP SIGNATURE-----

------enig2FDJXPHTQJUBHJVTVVJII--
