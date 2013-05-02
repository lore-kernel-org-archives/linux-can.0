From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Thu, 02 May 2013 13:32:09 +0200
Message-ID: <51824EB9.7050508@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>   <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox> <5182490F.2080707@pengutronix.de> <51824E42.9080905@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TSSRLUPQPBUQKIJRGPAI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40193 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab3EBLcR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 07:32:17 -0400
In-Reply-To: <51824E42.9080905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>, Sven Geggus <lists@fuchsschwanzdomain.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TSSRLUPQPBUQKIJRGPAI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/02/2013 01:30 PM, Wolfgang Grandegger wrote:
> On 05/02/2013 01:07 PM, Marc Kleine-Budde wrote:
>> On 04/24/2013 11:33 PM, Max S. wrote:
>>> From 8a83080bcddc558cd016e58e408b56ca68bc5bc8 Mon Sep 17 00:00:00 200=
1
>>> From: Maximilian Schneider <max@schneidersoft.net>
>>> Date: Wed, 24 Apr 2013 21:03:31 +0000
>>> Subject: [PATCH] Added ss_usb source.
>>
>> Comments inline.
>>
>>> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
>>> ---
>>>  drivers/net/can/usb/Makefile |    1 +
>>
>> You should add your driver to Kconfig, too.
>>
>>>  drivers/net/can/usb/ss_usb.c |  944 ++++++++++++++++++++++++++++++++=
++++++++++
>>>  2 files changed, 945 insertions(+)
>>>  create mode 100644 drivers/net/can/usb/ss_usb.c
>=20
> What stands "ss" for? I would prefer "ssoft" or "schneidersoft".

Good idea, ad the term is historically biased in Germany.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TSSRLUPQPBUQKIJRGPAI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGCTr0ACgkQjTAFq1RaXHM5qQCghiuUSM4n0oTOnPEw2vnK/S8z
DJEAn0AhHrWiZuEhadRWymfAU8CzCAV5
=hnsO
-----END PGP SIGNATURE-----

------enig2TSSRLUPQPBUQKIJRGPAI--
