From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: candump error flags
Date: Fri, 07 Nov 2014 15:30:13 +0100
Message-ID: <545CD775.1030200@pengutronix.de>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4TmqkAdnOiBfVIGPS0Dpjj0GBPO8WTeJQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34822 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbaKGOaZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Nov 2014 09:30:25 -0500
In-Reply-To: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4TmqkAdnOiBfVIGPS0Dpjj0GBPO8WTeJQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2014 02:57 PM, Paul Lever wrote:
> I'm trying to use the candump -e and -d options to catch errors. I
> know that frames are being dropped, as I can see missing packets in
> known sequences, yet I never see anything printed from candump
> indicating any errors or dropped packets. Is there additional steps
> needed to get output from -e/-d options? This is on a Beaglebone Black
> platform.
> My cmd line is:
> candump -t a -e -d -r 16000 can0 > /media/testdata.raw&

Make sure you're running a recent new kernel (v3.15 or better) as a lot
of fixes went into the driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4TmqkAdnOiBfVIGPS0Dpjj0GBPO8WTeJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXNd1AAoJECte4hHFiupUgaIQAKIvT2rDiEORcKqSO8TK5Xn5
1Vtfi93H2oNnPjOR9ABwOAO8dzRm0aWndfVp7JKGcvYaoY3A3xr4aEn6XKt0vpRt
8VxZGkbpDvJoubEnwQ+Iry7un3RTAp/LoM8uVAXem2Sgg55jAZ2tkp22gkGdbbQS
Xi9JkXJW09plCVB4j6TInpcx/mNFqUCqx37Hy/hby4JuZdLJJYbVycwnf4BM1ZMk
RvDan48TmbdSXuIaRZ6FXqH+aI8lBeYNPF9GMuv9VVOEw354l3KNEpW6bZ5Ulujz
HM7lq91M18QEshi3Tv3wzX8Wa4AHgQmrYLNbWBwbS0d6Wn5wWgonQ5Sqn7zruUQW
7psRuUFb2PNegIPMv4wCMybS7oolTGmcHW3GI92Almh4JF5RTkcXglntAljcThyx
zkgJvDpx6KXJDttmsYxVWxQpnYAGlOpt7pUsUcKMBu2FtZj6fVa277159c0gLsAt
QLsW5FfVRThMaupjgzNGdAuBBiEuedoSwPTqAXSyfIUNBte2i9X1Jd83ZgfcU7mf
pYi4AShpCW9ZKStYAJMKCOsB7HJf0F+VcuJ24WqB6yJ9tiwLSX3cJLwN4r+s28k8
/3waBIqTXCHahw8V3F7qo6ogVoxNdqYUesMl6vwvGre9lc5D6iKRhFZBmezMh6R5
lmOH3kkbERxux3tiRnGV
=ucC8
-----END PGP SIGNATURE-----

--4TmqkAdnOiBfVIGPS0Dpjj0GBPO8WTeJQ--
