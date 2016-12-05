From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: canfdtest and CPU load average
Date: Mon, 5 Dec 2016 10:59:09 +0100
Message-ID: <cf73c31f-30cb-c774-d6a7-6c27c41c2df3@pengutronix.de>
References: <1579A5A5423CC14B827884B535F8E9513494220F@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ITIN9WgiCVwC7MWpV4axBVbOgmiE3jCja"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55827 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751802AbcLEJ7P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Dec 2016 04:59:15 -0500
In-Reply-To: <1579A5A5423CC14B827884B535F8E9513494220F@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITIN9WgiCVwC7MWpV4axBVbOgmiE3jCja
Content-Type: multipart/mixed; boundary="SMxnRBn1MwhxVXeFrmmi4kNfkCbRaapAL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <cf73c31f-30cb-c774-d6a7-6c27c41c2df3@pengutronix.de>
Subject: Re: canfdtest and CPU load average
References: <1579A5A5423CC14B827884B535F8E9513494220F@SSCOXCHG2.spray.com>
In-Reply-To: <1579A5A5423CC14B827884B535F8E9513494220F@SSCOXCHG2.spray.com>

--SMxnRBn1MwhxVXeFrmmi4kNfkCbRaapAL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2016 09:10 PM, Grim, Dennis wrote:
> The recent update of canfdtest (can-utils) significantly reduces the CP=
U load average that I see when testing.
>=20
> It seems likely that using gettimeofday in a tight loop in can_echo_dut=
 was the issue.

Yes, it was basically a busy-loop.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SMxnRBn1MwhxVXeFrmmi4kNfkCbRaapAL--

--ITIN9WgiCVwC7MWpV4axBVbOgmiE3jCja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhFOm0ACgkQPTuqJayp
JWrCnwgAmvLvY4ZxfKokyU0j5PMM2jkJQFSXs4p4Jg7bTByrnXMT3jkG5sLOONTx
/mgrgaIX1+Bo9dWVRXzmXgZMIUD+VHJso4e6aonfHpSJzK4ouK6WHdKWUQSMbJ+x
XhAVMCtgswioY1xA9chDEPGI4t6K50/H0Df6bj6SwiPEMPuN4p66FF4d7L14Zj49
RGR2lZsz5lEW++dcs2voImYzxaB1lJX1dAEvIWNWWTKxscyI2nc0aJyAZdNrF7Ob
HWadjk1VrbgqIOQvXbhtkws8ywUW/mk+hQNFcRN15mvkZWGsaIcv9WwtvuN5ofAy
60oJWTKq2LlftxBgQJaWvt2KV0yG4Q==
=LQrd
-----END PGP SIGNATURE-----

--ITIN9WgiCVwC7MWpV4axBVbOgmiE3jCja--
