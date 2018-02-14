From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Wed, 14 Feb 2018 22:23:53 +0100
Message-ID: <c4302b64-8136-076b-5e41-4906a7f4492d@pengutronix.de>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
 <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iKMzAJiwUq2gKhXrHfzfpzNJyfjGr00ud"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVYl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 16:24:41 -0500
In-Reply-To: <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iKMzAJiwUq2gKhXrHfzfpzNJyfjGr00ud
Content-Type: multipart/mixed; boundary="tnHSVYIVMe25qzjSBGesEQrzMXm1peDql";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
 o.rempel@pengutronix.de
Message-ID: <c4302b64-8136-076b-5e41-4906a7f4492d@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
 <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>
In-Reply-To: <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>

--tnHSVYIVMe25qzjSBGesEQrzMXm1peDql
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/14/2018 10:20 PM, Marc Kleine-Budde wrote:
> On 02/14/2018 10:20 PM, Elenita Hinds wrote:
>> Thanks, Kurt and Oliver, for the feedback. The newest bcm changes look=
 better.
>>
>> Marc:  I'm sorry ... forgot to sign the patch. Hope re-attaching below=
 is ok:
>=20
> Sure.
>=20
>> Signed-off-by: Elenita Hinds <ecathinds@gmail.com>

Added to the j1939 and j1939-v4.15-rc9 branches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tnHSVYIVMe25qzjSBGesEQrzMXm1peDql--

--iKMzAJiwUq2gKhXrHfzfpzNJyfjGr00ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqEqOkACgkQk9IU1zQo
ZfHW+ggAn4a9iZfKHz0N5SRIWL3+VCYW5zPr1x5JR+pBeC/Kz4i7lrdAXXXWuu1N
nvGiOHWFGS2+lRach8bnbEWPgfLqUjkA4pLw/ekNncA3gws54iF3FfDb4n7dwyPA
YOqSgYkvk4eRDyWpn7EIsM9kOq4fXl8NUQB7OPTlavhSUyY+KEkPpfZQ8hjImsS5
I6pIetvm19MLQxGbH53QYSp8xei4DwN0POR3q0NYt5eAzcDepe6DJlZ9EI5TM6em
cjimaZNp5UQETb/Khnc/3/fEAXQwM30kPOX6JQtYPRebXELaUPoVTcIzzHc/J+lj
p7e78UWNkOO6frD5vp2RaBVa0zM3YQ==
=Uq65
-----END PGP SIGNATURE-----

--iKMzAJiwUq2gKhXrHfzfpzNJyfjGr00ud--
