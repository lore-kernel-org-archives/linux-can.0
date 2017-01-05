From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
Date: Thu, 5 Jan 2017 14:44:17 +0100
Message-ID: <0598cd15-e605-c5c2-a4ad-9cee6c557b2e@pengutronix.de>
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <dde2aebd-904a-234c-1437-116973201211@pengutronix.de>
 <e7f1511b-02ae-f5c1-4986-0e540df3d9fd@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vV7LMKWRvDddHIseUS3swRppDx3PwSDKA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52523 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936960AbdAENqH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 08:46:07 -0500
In-Reply-To: <e7f1511b-02ae-f5c1-4986-0e540df3d9fd@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Remigiusz Kollataj <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vV7LMKWRvDddHIseUS3swRppDx3PwSDKA
Content-Type: multipart/mixed; boundary="SLWlwndcN4g7gG6N7qTGVJ4bkrg2mrMNV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Remigiusz Kollataj <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org
Message-ID: <0598cd15-e605-c5c2-a4ad-9cee6c557b2e@pengutronix.de>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <dde2aebd-904a-234c-1437-116973201211@pengutronix.de>
 <e7f1511b-02ae-f5c1-4986-0e540df3d9fd@hartkopp.net>
In-Reply-To: <e7f1511b-02ae-f5c1-4986-0e540df3d9fd@hartkopp.net>

--SLWlwndcN4g7gG6N7qTGVJ4bkrg2mrMNV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 02:36 PM, Oliver Hartkopp wrote:
> On 01/05/2017 12:55 PM, Marc Kleine-Budde wrote:
>> On 11/04/2016 09:03 AM, Remigiusz Kollataj wrote:
>=20
>>> +	if (MCBA_RX_IS_RTR(msg))
>>> +		cf->can_id |=3D MCBA_CAN_RTR_MASK;
>>> +
>>> +	cf->can_dlc =3D msg->dlc & MCBA_DLC_MASK;
>>
>> Please check, that the dlc stays <=3D 8 bytes. As this is a USB device=
,
>> this value cannot be trusted.
>=20
> Yes.
>=20
> Please use the existing helper function:
>=20
> 	cf->can_dlc =3D get_can_dlc(msg->dlc & MCBA_DLC_MASK);

ACK.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SLWlwndcN4g7gG6N7qTGVJ4bkrg2mrMNV--

--vV7LMKWRvDddHIseUS3swRppDx3PwSDKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhuTbEACgkQPTuqJayp
JWr82gf/e/eV8L99PD5vd7hvX8BBZ+peTnWtTLPVCtajozGx042+MRQ9arBRKAYZ
AtHDM3OAJ01CfIiVdMmm0/GRC4FO9rce7UmZCGB3p31DWrGmIFnKz2tdoKA2Q/+1
22jE5fdlsXAbTFn5oK7bBI6obSEhDk5eZHfNYMhthS7mv3rlIrHb30rPZoon1B4S
Gkdq191yJ5uUhDdv6VZ7SS2dbfP1JuW5ywGFZP5hME7kHfSdHOFFKs5NR0opLkhw
OS0ElBOy1UV8VohsiWmIggC93ORUQnSs9StRB0TKpntZh8k9LSEjdXFk/9ZX57g7
p3dj5cC17sqNfMuF2c9iFqegpCTAkg==
=gFUg
-----END PGP SIGNATURE-----

--vV7LMKWRvDddHIseUS3swRppDx3PwSDKA--
