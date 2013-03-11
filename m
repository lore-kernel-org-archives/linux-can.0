From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: at91_can: add dt support
Date: Mon, 11 Mar 2013 16:12:46 +0100
Message-ID: <513DF46E.7000903@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com> <1362763842-14924-2-git-send-email-ludovic.desroches@atmel.com> <513A2365.5050803@pengutronix.de> <20130311091722.GA2572@ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BOULXQOQIPOSOSAFHOGV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59181 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3CKPM6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 11:12:58 -0400
In-Reply-To: <20130311091722.GA2572@ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BOULXQOQIPOSOSAFHOGV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/11/2013 10:17 AM, Ludovic Desroches wrote:
> On Fri, Mar 08, 2013 at 06:44:05PM +0100, Marc Kleine-Budde wrote:
>> On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> Add device tree support.
>>>
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>> ---
>>>  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
>>>  drivers/net/can/at91_can.c                         | 75 ++++++++++++=
++++------
>>>  2 files changed, 70 insertions(+), 19 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-c=
an.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt =
b/Documentation/devicetree/bindings/net/can/atmel-can.txt
>>> new file mode 100644
>>> index 0000000..69381db
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
>>> @@ -0,0 +1,14 @@
>>> +* AT91 CAN *
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9=
x5-can"
>>
>> On imx we use the oldest SoC with that IP available. Which strategy ar=
e
>> you following on at91?
>>
>=20
> We are using the same strategy.

But "atmel,at91sam9x5-can" isn't a specific SoC, probably a SoC family.
Or are you using "atmel,at91sam9x5-can" for the other devices in the DT,
too.

I picked at91sam9x5-can for the non devicetree driver out of the blue,
as there was no scheme established, yet. I'm not hanging on that name,
I'd rather appreciate to follow the common at91 DT rules.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BOULXQOQIPOSOSAFHOGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE99G4ACgkQjTAFq1RaXHPaHwCdGhiIsbJJmfUQ2yIZUzuXMgCr
ZL8AoJQgsNaW2xX4hv3RhWYQ2a7JinEW
=sHTp
-----END PGP SIGNATURE-----

------enig2BOULXQOQIPOSOSAFHOGV--
