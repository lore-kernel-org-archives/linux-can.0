From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: dev: add CAN interface termination API
Date: Wed, 18 Jan 2017 14:43:11 +0100
Message-ID: <3f4094fb-7643-2096-3309-e1a4b9d493bb@pengutronix.de>
References: <20170113113457.21775-1-mkl@pengutronix.de>
 <CAKT-o-e-NyQt7TDeBRXsJ8f3KQ2penkk+JdeTZ1BBWS=vPivig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Nmfmo9tp9q0FhWefIotmBBWpqiXIRt7bL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56251 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751384AbdARNnT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 08:43:19 -0500
In-Reply-To: <CAKT-o-e-NyQt7TDeBRXsJ8f3KQ2penkk+JdeTZ1BBWS=vPivig@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nmfmo9tp9q0FhWefIotmBBWpqiXIRt7bL
Content-Type: multipart/mixed; boundary="iwghkpTUP4bPVBul9ec5xdX71AQFucqEk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <3f4094fb-7643-2096-3309-e1a4b9d493bb@pengutronix.de>
Subject: Re: [PATCH v5] can: dev: add CAN interface termination API
References: <20170113113457.21775-1-mkl@pengutronix.de>
 <CAKT-o-e-NyQt7TDeBRXsJ8f3KQ2penkk+JdeTZ1BBWS=vPivig@mail.gmail.com>
In-Reply-To: <CAKT-o-e-NyQt7TDeBRXsJ8f3KQ2penkk+JdeTZ1BBWS=vPivig@mail.gmail.com>

--iwghkpTUP4bPVBul9ec5xdX71AQFucqEk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:55 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 5f5270941ba0..94c5037881f3 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -38,6 +38,9 @@ struct can_priv {
>>         struct can_bittiming bittiming, data_bittiming;
>>         const struct can_bittiming_const *bittiming_const,
>>                 *data_bittiming_const;
>> +       const u16 *termination_const;
>> +       const unsigned int termination_const_cnt;
>=20
> 1. Is const intentional here? It makes setting value in a driver hard..=
=2E

No. Will fix.

> 2. nitpick - as the value is intended to be initialized with
> ARRAY_SIZE maybe we should change it to size_t? If so we should also
> change "const unsigned int num_term" above.

I think on 32 bit archs size_t is 64 wide, we don't need this many bits.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iwghkpTUP4bPVBul9ec5xdX71AQFucqEk--

--Nmfmo9tp9q0FhWefIotmBBWpqiXIRt7bL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh/cO8ACgkQPTuqJayp
JWrNhggAtve7BYkppVsJDAD4q1AKsz4yd9kAblTFQ55HJCAhbUkVtg5v73RPYvRy
j6lkwkcQY1erGoxXS+nmNazJlCiOE1zC9x90Nf8fnJ/WVvPYgeDyaPDUkWV6sR/h
HnuiXBdQjqjQDKgGqR1VSVkQnAvcQjoD7N27KpQrv/8u/7+K3cbDXIbAy2xrISTX
H238gXS33kdcvfbgQ0F47NnhLTZtqC2sC+RB67OwFWA8OwJn4JT/2IPAj4PEl4Bc
OeST0NzEXYYphAb2xos4zFpMHSL/JI9mYxrstG0d6dt3R4QVKn83WoFpYleifwwW
Td/+d+FJ+2Fj5bLlnW589KHds6FfMA==
=H7eb
-----END PGP SIGNATURE-----

--Nmfmo9tp9q0FhWefIotmBBWpqiXIRt7bL--
