From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 4/5] can: bcm: add support for CAN FD frames
Date: Fri, 17 Jun 2016 12:41:09 +0200
Message-ID: <d6d31b17-9ec2-6682-f54b-28fec6358154@pengutronix.de>
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
 <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
 <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
 <5763D2F1.5040408@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WVv1t3h4kQmqsLfPMNb8FisCnJiirBVH7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37832 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751711AbcFQKlR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:41:17 -0400
In-Reply-To: <5763D2F1.5040408@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WVv1t3h4kQmqsLfPMNb8FisCnJiirBVH7
Content-Type: multipart/mixed; boundary="93kGkUQKwOdBLQ7Gu359sBLMSFMKTbTmw"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <d6d31b17-9ec2-6682-f54b-28fec6358154@pengutronix.de>
Subject: Re: [PATCH v4 4/5] can: bcm: add support for CAN FD frames
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
 <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
 <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
 <5763D2F1.5040408@hartkopp.net>
In-Reply-To: <5763D2F1.5040408@hartkopp.net>

--93kGkUQKwOdBLQ7Gu359sBLMSFMKTbTmw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/17/2016 12:37 PM, Oliver Hartkopp wrote:
> On 06/17/2016 12:23 PM, Marc Kleine-Budde wrote:
>> On 06/04/2016 09:26 PM, Oliver Hartkopp wrote:
>=20
>>> -/* easy access to CAN frame payload */
>>> -static inline u64 GET_U64(const struct can_frame *cp)
>>> +/* easy access to the first 64 bit of can(fd)_frame payload */
>>> +static inline u64 GET_U64(const struct canfd_frame *cp, int offset)
>>>   {
>>> -	return *(u64 *)cp->data;
>>> +	return *(u64 *)(cp->data + offset);
>>
>> Can you ensure that offset is always a multiple of 8?
>=20
> I would like to put that into a comment, as a check for this helper at =

> runtime is too expensive - and the caller is only in this C-file at two=
=20
> places.

No need to check during runtime, if you know your code and can ensure
that offset is always a multiple of 8 :D

>> Unaligned pointer
>> access will be quite slow on some platforms.
>=20
> cp->data is well aligned.

"cp->data + offset" must be aligned properly, this is why offset must be
a multiple of 8.

>> Can you please make this
>> function lower-case (as it's a function not a macro).
>=20
> will do.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--93kGkUQKwOdBLQ7Gu359sBLMSFMKTbTmw--

--WVv1t3h4kQmqsLfPMNb8FisCnJiirBVH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY9PFAAoJED07qiWsqSVqTGIH/iKNAJDAcXSVkZMrmeIJoik6
0hFJpJ6aYNpL7ggbvFxqX46c0o2XI0i/fJ/tV8aw0U7Sm7SGTSZUTczM+XlDknmp
r0pfBDLlQsZIupgaDriZH/5FqGo0UvjXgTZNJN4vEoWcQjybup2fQl6XCt4EvVl8
xg763hzWiLttsCIfJNZqOKqxOkTuRnfZK85yN4r0OPH0r0wJtdULRvj//isQ0Shd
5A/5FKQpPqdRIhYLa5gQqOtjJ0m7svLYPykjHdUvMzgZHpxzg7y1rDqEwF1d5DhY
4/HMLPI0vASV9guNhP6JwldAa9VMwPNdhZid3jo+juehKzt9onX6iOXNrtep1F0=
=RlLI
-----END PGP SIGNATURE-----

--WVv1t3h4kQmqsLfPMNb8FisCnJiirBVH7--
