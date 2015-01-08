From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Thu, 08 Jan 2015 10:09:19 +0100
Message-ID: <54AE493F.9010303@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54AD6ED8.2020808@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5XAJWo6B7OaIq5SKIXaooas52TG8lpOUK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50108 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbbAHJJW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Jan 2015 04:09:22 -0500
In-Reply-To: <54AD6ED8.2020808@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5XAJWo6B7OaIq5SKIXaooas52TG8lpOUK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/07/2015 06:37 PM, Oliver Hartkopp wrote:
> On 07.01.2015 18:03, Marc Kleine-Budde wrote:
>> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>>> Add support for the following new PEAK-System technik CANFD USB
>>> adapters:
>>>
>>> PCAN-USB FD             single CANFD channel USB adapter
>>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>
>> Can you please work out the correct ISO/non-ISO for CAN-fd with Oliver=
=2E
>> If you need CAN_CTRLMODE_FD_NON_ISO make your patch based on
>>
>>      https://gitorious.org/linux-can/linux-can.git testing
>>
>=20
> Good idea.
>=20
> @Stephane: Do you already have the latest UCAN IP core from Philipp
> which supports the ISO/non-ISO switching? (I don't have it)
>=20
> The question is if it makes sense to provide a driver for the current
> UCAN IP core and later provide a separate patch when the new
> (switchable) UCAN IP core is available.
>=20
> But in this case we need to check for the UCAN revision whether it is
> fixed to non-ISO or if it is switchable.
>=20
> Maybe it makes sense to support ONLY the latest (=3D=3D switchable) UCA=
N
> revision for the mainline driver. The update to the latest UCAN revisio=
n
> is mandatory anyway.

I think supporting both variants is the way to go. As there are some
devices with the old firmware in the wild, you have to check the
firmware revision anyways.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5XAJWo6B7OaIq5SKIXaooas52TG8lpOUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrkk/AAoJECte4hHFiupUxBEP/RG3mgpg6yyTVncZQJUdVVVM
5jggtGW+lqt0aFwfY7jhlEFC6SLY7Xxnn3GiSx0/4hWpaP11n7CWQY0WrwAOmm5z
e1maLtsJCc+c7/ve8nfU5k73PWMttiF3MZIvwdFZ0/HtoI5cKyim/cqHINwQHjzg
62nEq0v9jqLOUGBXBJyvLpDq04nPsykG1FY+A07TcEjzgfpz9n5DCMVIf2sHaJv7
7IN/vVxEWWq+Uz5ln7lVv3Cr3IQOUiwHdDci5hl1d+kM/Aysv5Ii62EpbYwWND/H
HJrjVX2KaUHi5Xx2jhRW5PqoHna6bAINFjYrJhpsimvKUB9JjzcIvb3aqElQY/4F
5mYC3Mj2s+pWTYCaLMOIqmz3sXBqAAb/JCJsHQnrDK6rakSmXdeaBoCDm4+ngtN0
g33neHQp9XnnX5pZqkkdTMzkOXqX/lpfBJsOo7oibdjTzrE54DP6Eax22N9ScIM6
s+K8k8MLFlCZm+SBVPAS0SOWnxw0CKbZjDXG8H2WWTL/qcrYGJeDARGbkHZDS3vP
OKF+rZIdRRHIZ3//XucfpUIti8R5er3NDFHHxIsUiKm63H5Wrm3l84/W5eaogw/g
d2KkMXHZ8/uN0GBZGqSLaXA9c2cA1y1IghmzGbP89ilAN/l2vfX0EdFuOIN0wf+r
NE5yDrih4PQ4nhn5gDdu
=o5Y+
-----END PGP SIGNATURE-----

--5XAJWo6B7OaIq5SKIXaooas52TG8lpOUK--
