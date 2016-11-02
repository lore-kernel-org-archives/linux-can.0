From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Adding new CAN driver
Date: Wed, 2 Nov 2016 14:59:01 +0100
Message-ID: <4a0b5448-c0e9-c4df-a307-fbd57875e1f8@pengutronix.de>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
 <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
 <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="deGca1RDEdhUAmmLSpM4aXsSKeuhCjLmK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49845 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753014AbcKBN7L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 09:59:11 -0400
In-Reply-To: <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--deGca1RDEdhUAmmLSpM4aXsSKeuhCjLmK
Content-Type: multipart/mixed; boundary="5WjWXsEAwxpbpSjMUP92aThbKWfrRp0LG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>,
 Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4a0b5448-c0e9-c4df-a307-fbd57875e1f8@pengutronix.de>
Subject: Re: Adding new CAN driver
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
 <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
 <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>

--5WjWXsEAwxpbpSjMUP92aThbKWfrRp0LG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2016 02:38 PM, Ramesh Shanmugasundaram wrote:
>> I'd like to see a netlink interface for this. Oliver what about adding=
 it
>> to CTRL_MODE?
>=20
> Is it about the CAN bus termination?

Yes.

> Why the driver need to be aware of it?

If the termination is part of the CAN interface, someone has to
configure it, this is typically done by the driver.

> If it needed for some reason shouldn't it be a device tree property
> of that device/bridge node?

No - you want to be able to configure it in the system without needing
to change the DT. The DT is used to descrive the hardware, not configure =
it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5WjWXsEAwxpbpSjMUP92aThbKWfrRp0LG--

--deGca1RDEdhUAmmLSpM4aXsSKeuhCjLmK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJYGfElAAoJED07qiWsqSVqUfEH/0RHOuey+I8QZhQO1FCs+VCF
acrYGM7j3rn6S1hBVUK5nWKpgPIKfaGZYvMLoa1qFS7FFRYjHEbehIPStT2FGFtF
EkAeCzncfxylkJlCFsuLlC/dSVOe1/eYTVl7z7mGxNmfxdGGfWTzsq9Jxdnaq8D+
/w0vG8d1VHgSU3YfIpUd5bvqZxIomObYTgIqgGMHBep6qTqIpiqxpkQI+BCqN1Vz
r6zIn/LHQOO+0tStf54zhCXL7YuWxJ06sBsrHVVbvhM0mysAz++0z9DTkxzqA4A9
1idLolQlmz/rTs2jqhLT5ADBWhGFAmSfT1fNAscf4hj/jlx5G7DIZI7gFKc4ivk=
=dbZ/
-----END PGP SIGNATURE-----

--deGca1RDEdhUAmmLSpM4aXsSKeuhCjLmK--
