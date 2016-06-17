From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.
Date: Fri, 17 Jun 2016 11:55:32 +0200
Message-ID: <910612ea-4a66-9875-57a7-17898b92b4ba@pengutronix.de>
References: <1465591162.2164.2.camel@schneidersoft.net>
 <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jIFsQqK1U6txcmXkSbI72fejcKbGwtEPp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58581 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753211AbcFQJzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:55:40 -0400
In-Reply-To: <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilian Schneider <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jIFsQqK1U6txcmXkSbI72fejcKbGwtEPp
Content-Type: multipart/mixed; boundary="ivIBawbdFQ1m52o9GInEckmkLFGeCc3fE"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maximilian Schneider <max@schneidersoft.net>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <910612ea-4a66-9875-57a7-17898b92b4ba@pengutronix.de>
Subject: Re: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.
References: <1465591162.2164.2.camel@schneidersoft.net>
 <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>
In-Reply-To: <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>

--ivIBawbdFQ1m52o9GInEckmkLFGeCc3fE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/17/2016 11:46 AM, Marc Kleine-Budde wrote:
> On 06/10/2016 10:39 PM, Maximilian Schneider wrote:
>> From a58480fb1c7bb86c11c0d861f3f2997941a84a65 Mon Sep 17 00:00:00 2001=

>> From: Maximilian Schneider <max@schneidersoft.net>
>> Date: Fri, 10 Jun 2016 16:50:16 +0000
>> Subject: [PATCH] Implement ethtool set_phys_id callback to ease locati=
ng
>>  specific physical devices.
>>
>> currently supported on candleLight interfaces.
>=20
> Does the LED blink automatically or do you switch it on and off via a
> USB msg?
>=20
> Please move the coding style enhancements into a separate patch.
>=20
>>
>> Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
>> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>

BTW: Who's the Author of the patch? Hubert Denkmair or Maximilian Schneid=
er?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ivIBawbdFQ1m52o9GInEckmkLFGeCc3fE--

--jIFsQqK1U6txcmXkSbI72fejcKbGwtEPp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY8kUAAoJED07qiWsqSVqHBgIAKV8xA6jf/cWJpDX/pSVIctV
AmnkH+rVFRQK2jtRB9730hlEqc5jKuQW6ZxQ++igiQ/1but9fZIkl7aZr9tm4cWQ
RDlxd2uVj6AGerLQfKmSyjGbKgzz3pvLCgPhTRGTkZjymI7e1GoFWJ5yQts+iCge
L+IwUfn0sg2Q18pC90++96K0vEHs4AienWCWaqklLi+67RyhHUcFoooldP7AJHro
dfH++nEHh/Ha/SDK4LJEeDlG8zIeD9+Ab3qV14Ao0ealr/b6aXQM2Ev1hb9UibcT
R9ykhReY3L8q5fTMV8YAIClxlP0hT6Jc39APW7Ybg0ksBbtIWurd+eVIYMTGyx8=
=dKwp
-----END PGP SIGNATURE-----

--jIFsQqK1U6txcmXkSbI72fejcKbGwtEPp--
