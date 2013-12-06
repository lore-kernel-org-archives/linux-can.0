From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: arbitration lost error reporting
Date: Fri, 06 Dec 2013 14:23:39 +0100
Message-ID: <52A1CFDB.80809@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net> <52A1C02F.6050106@pengutronix.de> <loom.20131206T140921-289@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mh30nAri8pmajMUfeSqXEi7uqU2daMktV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50201 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161857Ab3LFNXm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 08:23:42 -0500
In-Reply-To: <loom.20131206T140921-289@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mh30nAri8pmajMUfeSqXEi7uqU2daMktV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2013 02:21 PM, Richard Andrysek wrote:
> Marc Kleine-Budde <mkl <at> pengutronix.de> writes:
>=20
>=20
>>> If you thing about a define, what about:
>>>
>>> [ ] CAN_CTRLMODE_ARB_LOST_REPORTING
>>> [x] CAN_CTRLMODE_ARBITRATION_LOST_REPORTING
>>
>> Marc
>>
>=20
> To be more compatible with compilers and standards the option 1 is pref=
ferd.
> This one si only 32 characters long.

Okay, option 1 is verbose enough.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mh30nAri8pmajMUfeSqXEi7uqU2daMktV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKhz9sACgkQjTAFq1RaXHP1qwCdGMSyuNuJJJK7kgPJDGK0Q1vv
Dv8An0ooiYsbBNm1DQXcuIWRk7E5Evis
=UFXP
-----END PGP SIGNATURE-----

--mh30nAri8pmajMUfeSqXEi7uqU2daMktV--
