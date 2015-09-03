From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] autotools: fix syntax error
Date: Thu, 3 Sep 2015 14:18:44 +0200
Message-ID: <55E83AA4.7010101@pengutronix.de>
References: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Aa0o4eUMLMaJ5QvRKMegLd8HIJkiF33b9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39219 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbbICMS4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 08:18:56 -0400
In-Reply-To: <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aa0o4eUMLMaJ5QvRKMegLd8HIJkiF33b9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 01:53 PM, Yegor Yefremov wrote:
> On Fri, Aug 7, 2015 at 6:05 PM,  <yegorslists@googlemail.com> wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  configure.ac | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 633ba81..8b50fb7 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -20,7 +20,7 @@ AC_PROG_CC
>>  LT_INIT(win32-dll)
>>
>>  AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
>> -m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
>> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>>
>>  #
>>  # Checks for header files.
>> --
>> 2.1.4
>>
>=20
> Ping?

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

You have write access to the repo, don't you? :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Aa0o4eUMLMaJ5QvRKMegLd8HIJkiF33b9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV6DqmAAoJEP5prqPJtc/HxsIIAJcBaFpsTiOtLEoNL9I6PQnu
oc+qeFCgMsUD2enNzbu/uYbiB//9J6VB7ue0TU4OsEAQfA0dqXV0JHDcBNNwhXlZ
1XbsWZUGTirnGuxmRfyFaLL4Hq/70zbpaRcHqeGcRJymGVHsV/GAVgpKL1lqtXpA
Zn2gGGjwM7uYJF0OFvIGX++NXYm+O/OFQ4jC9RUow/xPVsgUH0B00+8MgwB0/0+4
x7LLHEKxazALaJ5eWUTL435+Wm11OMABbXmXCHsr62Cg6/BK8DFU6WmXdDebP2Qe
BgYTFuTHgWd+8Rt4++V+YnFHdg0cU+NymQ4Dxfh/OKQgLgQ+QB9oAaVvBWR5OA8=
=6Jc5
-----END PGP SIGNATURE-----

--Aa0o4eUMLMaJ5QvRKMegLd8HIJkiF33b9--
