From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH]: canfdtest typo while waiting for tv_stop time
Date: Mon, 21 Nov 2016 11:37:50 +0100
Message-ID: <a894b911-d037-c58e-635f-c415d01d4c30@pengutronix.de>
References: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
 <SG2PR06MB10387876750D66073C215FF4C3B10@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7uacMt8aghOcjUwOIacat9Ja7PQDb8iVC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54569 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754020AbcKUKiA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2016 05:38:00 -0500
In-Reply-To: <SG2PR06MB10387876750D66073C215FF4C3B10@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7uacMt8aghOcjUwOIacat9Ja7PQDb8iVC
Content-Type: multipart/mixed; boundary="E3buwoJgQtIPSmJIW0DQ0bnPRvl90uH86";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Stephane Grosjean <s.grosjean@peak-system.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <a894b911-d037-c58e-635f-c415d01d4c30@pengutronix.de>
Subject: Re: [PATCH]: canfdtest typo while waiting for tv_stop time
References: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
 <SG2PR06MB10387876750D66073C215FF4C3B10@SG2PR06MB1038.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB10387876750D66073C215FF4C3B10@SG2PR06MB1038.apcprd06.prod.outlook.com>

--E3buwoJgQtIPSmJIW0DQ0bnPRvl90uH86
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2016 09:09 AM, Ramesh Shanmugasundaram wrote:
>> Subject: [PATCH]: canfdtest typo while waiting for tv_stop time
>>
>> Hello Mark,
>>
>> After a few complaint about 100% CPU usage of canfdtest over our PCI -=
like
>> boards, I have had a look to the source file, and think I have found t=
he
>> issue in:
>>
>> diff --git a/canfdtest.c b/canfdtest.c
>> index 2407027..d7ba740 100644
>> --- a/canfdtest.c
>> +++ b/canfdtest.c
>> @@ -239,7 +239,7 @@ static int can_echo_dut(void)
>>                                  }
>>                                  gettimeofday(&tvn, NULL);
>>                                  while ((tv_stop.tv_sec > tvn.tv_sec) =
||
>> -                                      ((tv_stop.tv_sec =3D tvn.tv_sec=
) &&
>> +                                      ((tv_stop.tv_sec =3D=3D tvn.tv_=
sec)
>> + &&
>>                                          (tv_stop.tv_usec >=3D
>> tvn.tv_usec)))
>>                                          gettimeofday(&tvn, NULL);
>>                          }
>>
>> Am I right?
>=20
> There is one more bug on that piece of code. I submitted a bug & a pull=
 request fixing it
>=20
> https://github.com/linux-can/can-utils/pull/15

See github for the review.

Thanks,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--E3buwoJgQtIPSmJIW0DQ0bnPRvl90uH86--

--7uacMt8aghOcjUwOIacat9Ja7PQDb8iVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlgyzn4ACgkQPTuqJayp
JWoRZQf/dKex+OGjUAsOJV6yWY7n3wonrIqoOBTRtnjQGR3E5Q5tVV3WLfC3LrTJ
WvYSlppEt2k+eKVrinLi+OvKESTCJqv69B/dmTwucBFe7DfwL2i9RaQnS7zq4Ih3
n9iSsmF5iVBcdEpI3UXOS/ngp4n/OGoyjPhgUNDtsiyP/oy0KqpqvlXiK8t0UJ0/
w6Ze2FzbQnlgrPz0SpVqtQgZBa12brT4EjkRzn60SyOwlyV7HRhvWZu+6A6Kpc80
sd2M6DGXbCW6+Rjwm6vVD03wqJ/BomQdebk3U8hne2LYrxP0sMrkV6qspNcsgbEV
U938MvRn9UsKQzIj/nruhQKVk4yscQ==
=1do7
-----END PGP SIGNATURE-----

--7uacMt8aghOcjUwOIacat9Ja7PQDb8iVC--
