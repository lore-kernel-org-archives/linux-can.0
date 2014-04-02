From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: mcp251x: Remove unnecessary power disabling
Date: Wed, 02 Apr 2014 09:05:55 +0200
Message-ID: <533BB6D3.401@pengutronix.de>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru> <1396001687-7092-4-git-send-email-shc_work@mail.ru> <533B234B.3030907@pengutronix.de> <1396419467.957204803@f401.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PTOHjv0doQjd62WPTeigktKG6bPkC2enM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34012 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453AbaDBHGD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 03:06:03 -0400
In-Reply-To: <1396419467.957204803@f401.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PTOHjv0doQjd62WPTeigktKG6bPkC2enM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 08:17 AM, Alexander Shiyan wrote:
> Tue, 01 Apr 2014 22:36:27 +0200 =D0=BE=D1=82 Marc Kleine-Budde <mkl@pen=
gutronix.de>:
>> On 03/28/2014 11:14 AM, Alexander Shiyan wrote:
>>> This patch remove unnecessary power disabling on error and on module
>>> exit since this is already done by regulator API.
>>
>> Oh really? Can you point me to the commit in mainline which introduces=

>> this change? As far as I understand devm just callss
>> devm_regulator_release(), which calls regulator_put().
>=20
> It seems that you are right. I thought that the regulator is switched o=
ff when
> the usage count reaches zero, but it is not.
> In this case, please drop the [4/4] patch.

Will do, I'll push the remaining three patches to the can-next as soon
as you give me your okay for the v2 series.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PTOHjv0doQjd62WPTeigktKG6bPkC2enM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7ttMACgkQjTAFq1RaXHOAGACfSE0Ler21CCyYFOrXq/adpeZs
PYoAn3s7iFpboknv6v00wDbWvav4XQPG
=t9Rr
-----END PGP SIGNATURE-----

--PTOHjv0doQjd62WPTeigktKG6bPkC2enM--
