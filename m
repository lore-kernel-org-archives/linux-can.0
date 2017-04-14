From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
Date: Fri, 14 Apr 2017 16:34:03 +0200
Message-ID: <209acfa8-59d4-6d5a-eb4c-019d191cad7c@pengutronix.de>
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de>
 <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
 <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
 <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="T2anHHflPEmssscik8vJt5c00jk7cQs0r"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33651 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751960AbdDNOeO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 10:34:14 -0400
In-Reply-To: <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T2anHHflPEmssscik8vJt5c00jk7cQs0r
Content-Type: multipart/mixed; boundary="4P0q3ptrNVk31JKlvlbi4Dow9dXelIeCM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org
Message-ID: <209acfa8-59d4-6d5a-eb4c-019d191cad7c@pengutronix.de>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de>
 <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
 <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
 <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>
In-Reply-To: <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>

--4P0q3ptrNVk31JKlvlbi4Dow9dXelIeCM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2017 03:19 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:>>> In M=
BCA leds are
controlled by device itself - CAN status leds are
>>> connected directly CANTX and CANRX pins of PIC controller and CAN
>>> Error led is driven by firmware.
>>
>> With LED support in the driver, you can use CAN RX and/or TX events to=

>> drive generic LEDs.
>=20
> I am ok with adding it to the driver however I don't know if I
> understand the idea. Will addition of generic LEDs expose device TX
> and RX status via SYSFS?

No. If your System has a generic LED, you can use the CAN RX/TX trigger
to blink the LED - in a total generic way, see:

https://fabiobaltieri.com/2011/09/21/linux-led-subsystem/

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4P0q3ptrNVk31JKlvlbi4Dow9dXelIeCM--

--T2anHHflPEmssscik8vJt5c00jk7cQs0r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljw3dsACgkQHv7KIOw4
HPYz7gf9FHSrNnDBWJchy/9nxIkx7hGsbP9wQuQB6PLMqv0EW8PeYcpfkYeHYQCa
VZKFktnn06+de49U2E6t31yhEffa2iaI1jgwgVQb1fLCZUPn5PAkArDE/MCtzIA7
1neL79rlSQL4+Qeea2lAGzWJuFlF+f2jW2GQli8e8b9F5A6+q2mF5RAzxPM+7vVt
4Lrj9QiGTnqwBrJFl2QkLPLMFg3iI2e4/AV/52BnEkc6t+cUWX57jsA9jaoRkm2O
IF5106q18uTbcg/BzdMBIfEKwA1gOQs803Fj7b7snpDvfkmuNUdzMIy733W74uRm
Db198aRxgI+AvaOJWRI6PPaLb+fjIw==
=eO7i
-----END PGP SIGNATURE-----

--T2anHHflPEmssscik8vJt5c00jk7cQs0r--
