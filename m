From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939 ACL
Date: Mon, 22 Jan 2018 10:12:37 +0100
Message-ID: <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
 <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="I20UOdR0WdRhfHyLDVfMXjPKontXEw5Ml"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeAVJNE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jan 2018 04:13:04 -0500
In-Reply-To: <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I20UOdR0WdRhfHyLDVfMXjPKontXEw5Ml
Content-Type: multipart/mixed; boundary="ckfqSENpZbZirYZEHC6ZwXst33zyHjsZE";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>,
 Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
Subject: Re: j1939 ACL
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
 <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
In-Reply-To: <20180120212809.GB3515@airbook.vandijck-laurijssen.be>

--ckfqSENpZbZirYZEHC6ZwXst33zyHjsZE
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/20/2018 10:28 PM, Kurt Van Dijck wrote:
>> after playing with jacd i have a bit more questions:
>> - do any one already using kernel j1939? any suggestions or request fo=
r
>> changes?
>=20
> A linux 3.10 version runs in production. Since then, a few changes were=

> requested and implemented.
> Recently, the stack had some serious retesting, you will find the
> latest state in my github (only a few minor commits from Marc's
> version).

Oleksij and Basti are now working on the j1939 kernel and userspace. I'd
like to have top of development on the linux-can-next/j1939 branch.
Which branch in your linux repo is the newest one?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ckfqSENpZbZirYZEHC6ZwXst33zyHjsZE--

--I20UOdR0WdRhfHyLDVfMXjPKontXEw5Ml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlplqwUACgkQHv7KIOw4
HPZUZQgAyAVGR+MIG+opX6KWo1twaLCQAgY30Z8C825QN4Oiar4akCXEzvV8qfqS
q4b8w8OEWGGWSu5KnJ0q1jmEJnNI0E6OWE7Eik2mcwfeCCrLirDoj7bJ537Xjrh8
5ENJ+0iXxwl9Z9fI0T125PjOM5At00gxQRJyTbr8VEXo/1asNXZIrXi33aUhqT24
pew2kTCL8xWlbdcx88enLQ//rg9w92xqWm7Jc62Zjftdln4S5B7GTUcc4yPzh7DW
YsiA8NnO4dXTBNCelXlKbb3DWjvrlAjYCw/c3jDD/1IFD5fNWDcck21PH70NTzp2
cFRtXSdbwJOpuq3xRhAYnCPSAXFIvQ==
=iHlG
-----END PGP SIGNATURE-----

--I20UOdR0WdRhfHyLDVfMXjPKontXEw5Ml--
