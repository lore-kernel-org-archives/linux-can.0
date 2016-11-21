From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH]: canfdtest typo while waiting for tv_stop time
Date: Mon, 21 Nov 2016 11:36:24 +0100
Message-ID: <41e64253-6e55-9500-602e-8e4038bbceac@pengutronix.de>
References: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UATEA4bvQGBDlFdanNAid0w69hGi0NBGB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48589 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754058AbcKUKgi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Nov 2016 05:36:38 -0500
In-Reply-To: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UATEA4bvQGBDlFdanNAid0w69hGi0NBGB
Content-Type: multipart/mixed; boundary="bRMQqMms7IMBTXBQM9PAJTChRwKLU00jF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <41e64253-6e55-9500-602e-8e4038bbceac@pengutronix.de>
Subject: Re: [PATCH]: canfdtest typo while waiting for tv_stop time
References: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
In-Reply-To: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>

--bRMQqMms7IMBTXBQM9PAJTChRwKLU00jF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2016 11:46 AM, Stephane Grosjean wrote:
> After a few complaint about 100% CPU usage of canfdtest over our PCI=20
> -like boards, I have had a look to the source file, and think I have=20
> found the issue in:
>=20
> diff --git a/canfdtest.c b/canfdtest.c
> index 2407027..d7ba740 100644
> --- a/canfdtest.c
> +++ b/canfdtest.c
> @@ -239,7 +239,7 @@ static int can_echo_dut(void)
>                                  }
>                                  gettimeofday(&tvn, NULL);
>                                  while ((tv_stop.tv_sec > tvn.tv_sec) |=
|
> -                                      ((tv_stop.tv_sec =3D tvn.tv_sec)=
 &&
> +                                      ((tv_stop.tv_sec =3D=3D tvn.tv_s=
ec) &&
>                                          (tv_stop.tv_usec >=3D tvn.tv_u=
sec)))
>                                          gettimeofday(&tvn, NULL);
>                          }
>=20
> Am I right?

Yes. But it still does a busywait. I've reviewed Ramesh's changes, that
will fix the busywait.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bRMQqMms7IMBTXBQM9PAJTChRwKLU00jF--

--UATEA4bvQGBDlFdanNAid0w69hGi0NBGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlgyzigACgkQPTuqJayp
JWq1Rgf+Jp6v2c7osouTg8oRatMTYS9G6nDmg+QGnoqnb4UBtrBoJAZ+1ht8axtE
prLb8SIkrgpqTq5kfQTCjQCZtLvmTQNZzGnGewKFGQI69g+lowbxWtBErQ+Thczs
ec6UxYqpnTSHo8vZhkM9YL4P60TgUFwYH6zp3GE2EVah1A4HZmInP1U+5+969NWg
+sETzlJbYBmP4q9W5jWfNwYFARRu22/T9Jr3xc/zt+fHu6OjZFDL3pqYzociDhRg
iRouYmNJNHBkjg5ibs5N8133Ok6wTCcGchB5E1MjdlzizCrZesjk8Har4T8jKm3e
WPR+EPAslCUmL8H+ySZ72Xaff4axGQ==
=bJud
-----END PGP SIGNATURE-----

--UATEA4bvQGBDlFdanNAid0w69hGi0NBGB--
