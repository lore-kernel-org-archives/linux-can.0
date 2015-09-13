From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [linux-sunxi] [PATCH v5 0/2] can: Allwinner A10/A20 CAN
 Controller support - summary
Date: Sun, 13 Sep 2015 14:57:24 +0200
Message-ID: <55F572B4.10107@pengutronix.de>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <20150913122227.GQ9885@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2hFMifC8nuiLNeRL36r4QnXT2Ghu5bJI7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40145 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbIMM5d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 13 Sep 2015 08:57:33 -0400
In-Reply-To: <20150913122227.GQ9885@lukather>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: linux-can@vger.kernel.org, linux-sunxi@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2hFMifC8nuiLNeRL36r4QnXT2Ghu5bJI7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2015 02:22 PM, Maxime Ripard wrote:
>> History:
>>     V5: fix license
>>         modify prefix to mode select defines
>>         enable and disable clock in sunxican_get_berr_counter
>> 	delete set_normal_mode at the end of sunxi_can_start
>> 	removed sunxican_id_table
>> 	use devm_clk_get instead of clk_get
>> 	use devm_ioremap_resource to simplify probe and remove
>> 	make set-normal-mode and set-reset-mode more readable
>>        =20
>>     v4: defines prefixed with SUNXI_
>>         sunxi_can_write_cmdreg tweaked
>> 	loops in set_xxx_mode reworked
>> 	add return value to set_xxx_mode
>> 	sunxican_start_xmit reworked
>> 	struct platform_driver stripped
>> 	moved set_bittiming into open
>> 	moved clock start into open
>> 	add clock stop to close
>>         suspend reworked
>>         resume reworked
>>         fixed double counting bug
>>
>>     v3: changed error state change handling (thx Andri for the hint)
>>         use bittiming function correct (no need to call it)
>>         strip down priv (suggested by Marc)
>>         scripts/checkpatch.pl-> no matches anymore
>>         sparse -> no errors or warnings anymore
>>     v2: cleaning
>>     v1: initial
>=20
> Where were those versions posted ?

On the linux-can mailinglist.

> Make sure to run get_maintainer before sending your patches to mail
> them to the right recipients.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2hFMifC8nuiLNeRL36r4QnXT2Ghu5bJI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV9XK0AAoJEP5prqPJtc/HB0AIALsRoFZJghUO3gJ75sRw3jnM
vLcmNKvauHx/2QeYy1Wqre1po51WLOjjE3i78fMby+FoWI/d0vTAXVXF5oczeegk
CB0ZLwLZqDjRyBa+u0Fi+G5tHamOBJ+V4vWqcr1e0ZKVIRLwuvlZ/aoQljrEFvn7
m5a1BlGUctZjrK5JIUWd7aCGIEXAiseGixpm4nuEf2rtYgG55G/fBZitNrKX8Ik6
AgISEaJoD0RRhANaUhfRC31+Ixwp9BbvnrcBp78BU4vst3zeiXD2AEMlwSIh1382
+7RyKAF452KoZ/VoI7KmUbcZwosWN+iBzqhV+ugWk/v0CFQ/peMR8ZvcMbgFPhI=
=Kpu1
-----END PGP SIGNATURE-----

--2hFMifC8nuiLNeRL36r4QnXT2Ghu5bJI7--
