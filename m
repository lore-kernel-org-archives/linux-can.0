From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] can: add missing initialization of CAN
 statistics
Date: Wed, 6 Jul 2016 09:36:32 +0200
Message-ID: <7d5a57a6-bad3-c61f-bc51-50a0615be0f0@pengutronix.de>
References: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
 <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
 <8cdd1516-508e-6fc5-ff58-b61181376479@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4rn2ssHWPfJhuqU54BNV4g5KtchHvcRWj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53955 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752475AbcGFHgj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Jul 2016 03:36:39 -0400
In-Reply-To: <8cdd1516-508e-6fc5-ff58-b61181376479@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4rn2ssHWPfJhuqU54BNV4g5KtchHvcRWj
Content-Type: multipart/mixed; boundary="Fqw3ddJInRLt7sbnEMdX5livI525WEKUo"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <7d5a57a6-bad3-c61f-bc51-50a0615be0f0@pengutronix.de>
Subject: Re: [PATCH can-next] can: add missing initialization of CAN
 statistics
References: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
 <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
 <8cdd1516-508e-6fc5-ff58-b61181376479@hartkopp.net>
In-Reply-To: <8cdd1516-508e-6fc5-ff58-b61181376479@hartkopp.net>

--Fqw3ddJInRLt7sbnEMdX5livI525WEKUo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2016 09:27 AM, Oliver Hartkopp wrote:
>=20
>=20
> On 07/06/2016 09:24 AM, Marc Kleine-Budde wrote:
>> On 07/06/2016 09:19 AM, Oliver Hartkopp wrote:
>=20
>=20
>>> +void can_init_stats(void)
>>> +{
>>> +	memset(&can_pstats, 0, sizeof(can_pstats));
>>> +	memset(&can_stats, 0, sizeof(can_stats));
>>
>> I think this is not needed, as both are global variables, right?
>=20
> Yes they are.
>=20
> Is it assured that global variables are initialized with zero like=20
> static variables?

Yes.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Fqw3ddJInRLt7sbnEMdX5livI525WEKUo--

--4rn2ssHWPfJhuqU54BNV4g5KtchHvcRWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXfLUAAAoJED07qiWsqSVq9wcH/Arr3tN74VCbT0TYkRd2bF8g
ScyYpdtQMQC79C9xv59sZX5g9eaPpeiFLDB45Xpdc15fXbd0le5CitQNPxj+njyi
eIkEfT/oMbDaOwb4k0RvGfSUJbt18KoyI8YYlxycfWc8aIDm4lI5FE6jrt5M7KiU
9G5nqN5ZGFBck9nViNiWUp3+zkplJAX9mHqezSKGsd4ozDOv/lNiNm8K8yfJyyhC
SfRil6RApypGTEJhmz9Ow7sQT1o6ZKJUyw/Z2XYxITEX++0Q2s0Hp/Qf8izZfMxh
/0wYwL2Md2lxr6Knc2iCQODyYXW+EreCsXqc4zT6eQ6dfrop3zNWChif8uppqoQ=
=TD+E
-----END PGP SIGNATURE-----

--4rn2ssHWPfJhuqU54BNV4g5KtchHvcRWj--
