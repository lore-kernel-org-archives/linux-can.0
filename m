From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V4 1/4] net: can: ifi: Fix clock generator configuration
Date: Thu, 3 Mar 2016 22:02:20 +0100
Message-ID: <56D8A65C.7060803@pengutronix.de>
References: <1457034358-5515-1-git-send-email-marex@denx.de>
 <1457034358-5515-2-git-send-email-marex@denx.de>
 <56D89C1F.9060504@hartkopp.net> <56D8A41B.80508@denx.de>
 <56D8A573.4010208@hartkopp.net> <56D8A621.3040404@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tWLh3N6MDrpAaAQm0CGImvcIFOaoiveMj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54009 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308AbcCCVCa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Mar 2016 16:02:30 -0500
In-Reply-To: <56D8A621.3040404@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tWLh3N6MDrpAaAQm0CGImvcIFOaoiveMj
Content-Type: multipart/mixed; boundary="CriL3GAW3BGbNtwEmfchUacnJ6vhtchff"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>,
 linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <56D8A65C.7060803@pengutronix.de>
Subject: Re: [PATCH V4 1/4] net: can: ifi: Fix clock generator configuration
References: <1457034358-5515-1-git-send-email-marex@denx.de>
 <1457034358-5515-2-git-send-email-marex@denx.de>
 <56D89C1F.9060504@hartkopp.net> <56D8A41B.80508@denx.de>
 <56D8A573.4010208@hartkopp.net> <56D8A621.3040404@pengutronix.de>
In-Reply-To: <56D8A621.3040404@pengutronix.de>

--CriL3GAW3BGbNtwEmfchUacnJ6vhtchff
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2016 10:01 PM, Marc Kleine-Budde wrote:
> On 03/03/2016 09:58 PM, Oliver Hartkopp wrote:
>> Hi Marek,
>>
>> On 03/03/2016 09:52 PM, Marek Vasut wrote:
>>
>>>
>>> See above, I think the code is correct as is.
>>>
>>> btw can you pick the remaining patches (2,3,4) if they're fine with y=
ou,
>>> so I don't have to repost the whole series ?
>>>
>>
>> As my remark was obsolete, Marc might apply the whole V4 patch series =
to the
>> can-next git tree without any changes.
>>
>> So let's wait for him then :-)
>=20
> Ok. :)

Do you want some Acked-by or Reviewed-by?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CriL3GAW3BGbNtwEmfchUacnJ6vhtchff--

--tWLh3N6MDrpAaAQm0CGImvcIFOaoiveMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW2KZcAAoJED07qiWsqSVqbdMH/A5tDQoRnxUcaAic60KWCc+S
j9LxczkUJ4AW1Dz1vGWAIK+aPd1MVu6PaG5HH9uyBs6sx9iTdeYxrK8TQVCWqjK6
wiNIh6wewOlMrATTRnnBvHDjGb/ZcK7JkJnvKDnxcsrcuGcis4cMeGylVJ2p9leV
PT4TlARiG8uZBKz0rnclul02mvmpIS2eBEOkuwztuMxHRZoi6NYjmSoncqjJ8KcR
sD5LcHXZPZZagbDJinYkV81KkSe4RuUe19coXfhZLlq0w/OZ4+HX2LOz7eTO7w2e
y13pFKn1izolkZPdfPXTVENj4ydT0KuFQA8WP48DbCUUY84O/1sPhSeM1L06PQU=
=KzGR
-----END PGP SIGNATURE-----

--tWLh3N6MDrpAaAQm0CGImvcIFOaoiveMj--
