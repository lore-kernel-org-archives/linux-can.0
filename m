From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: mcp251x: various improvements
Date: Wed, 02 Apr 2014 09:12:59 +0200
Message-ID: <533BB87B.9010007@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de> <533B299F.4090208@pengutronix.de> <1396422698.779925882@f178.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VPUImKXJ2qXSncP1RbDD8LVsNpxWwcCw5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60510 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbaDBHNC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 03:13:02 -0400
In-Reply-To: <1396422698.779925882@f178.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VPUImKXJ2qXSncP1RbDD8LVsNpxWwcCw5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 09:11 AM, Alexander Shiyan wrote:
> Tue, 01 Apr 2014 23:03:27 +0200 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pen=
gutronix.de>:
>> On 04/01/2014 11:02 PM, Marc Kleine-Budde wrote:
>>> I've picked up Alexander Shiyan's work.
>>>
>>> Changes since v1:
>>> - 1/4: mcp251x_can_probe(): do cleanup in case of spi_setup() fails
>>> - 2/4: mcp251x_hw_reset(): convert ternary-? to if (err) return
>>> - 3/4: mcp251x_hw_probe(): convert ternary-? to if (err) return
>>
>> Alexander, can you please test this series?
>=20
> Tested-by: Alexander Shiyan <shc_work@mail.ru>

Thanks

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VPUImKXJ2qXSncP1RbDD8LVsNpxWwcCw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7uHsACgkQjTAFq1RaXHNlvACeKakmnyByK3vNQQJFy6xMzoU6
ADcAnRD+53K6iSDs9FVmA+Yk29vCPWZo
=sk7T
-----END PGP SIGNATURE-----

--VPUImKXJ2qXSncP1RbDD8LVsNpxWwcCw5--
