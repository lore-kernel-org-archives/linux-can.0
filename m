From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 20 Sep 2016 11:09:13 +0200
Message-ID: <6d3c3af0-12bb-ba14-c8f9-a8837da82795@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KiuIbRCjmnMirOWi4bDsPl1KKnlN2nEx7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60605 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753808AbcITJJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2016 05:09:26 -0400
In-Reply-To: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KiuIbRCjmnMirOWi4bDsPl1KKnlN2nEx7
Content-Type: multipart/mixed; boundary="FcX3lTVJeVP1EoJMhcAR3Pm0VqSTfvXub";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Message-ID: <6d3c3af0-12bb-ba14-c8f9-a8837da82795@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
In-Reply-To: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>

--FcX3lTVJeVP1EoJMhcAR3Pm0VqSTfvXub
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2016 11:37 PM, Austin Schuh wrote:
>>>> What about putting them into socket depended sockopts with setsockop=
t()?
>>>
>>> Is it a per interface or a per socket setting?
>>
>> At least for iso-tp these kind of settings are transport channel
>> specific. Don't know if this can be applied to j1939 too.
>>
>> This is something Kurt or others can answer better than me.
>=20
> These parameters should be defined by the standard.  For the padding,
> I'm not aware of any messages (besides the RQST message which should
> be 3 bytes long) which are not already 8 bytes.  If you want to
> enforce that, I would think it would be better to refuse to accept the
> packet rather than pad it out to surprise the user less.

So an option is to check if PGN is 0xea00 then length must be 3,
otherwise length must be 8?

> The unused bits should be set to 1, but that's hard to do at the
> driver level when you don't know which bits are used and which are
> unused in a request.

The padding is done in the j1939_send() function. So padding is no
problem here.

> SAE J1939-21 defines all the timing requirements and other constraints
> pretty well.  Is there a reason to make them configurable?

Dunno...Kurt?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FcX3lTVJeVP1EoJMhcAR3Pm0VqSTfvXub--

--KiuIbRCjmnMirOWi4bDsPl1KKnlN2nEx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX4Py5AAoJED07qiWsqSVq1/0IAKQ6bZeHd9ugXiG0/9eHLsYT
0VcEDJNTKgF2haPsnW1Ke5mXRuI6Q5vCtQ10Z6BETVNg4yf22aqFBCvrByH37z7Y
KrNBY3TRgrKtyzsV8cAB4p3rG/RyS5NqucuCAuo64eCopvIcf2H0vX2JDBydQd6Q
3t2dKkDpizPPVTyLqOpvO0SNNHsUW5Ti1LCUQlWwTGAYKGILqX3VnCDk7qbbuUS8
QC2LdAxOEvcpES5jDIb+nIIKwPkCsiyCpJ2AJFtmYlUt4KA5/awcWMD+7FQMkmNY
F3LKurgRTh36+/4Hizk7WEdnYkYho0Yl1A++QYcY7aXXPoxMuBbfnWN0p7BlE4w=
=GY/t
-----END PGP SIGNATURE-----

--KiuIbRCjmnMirOWi4bDsPl1KKnlN2nEx7--
