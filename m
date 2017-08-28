From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 03/14] can: af_can: give struct holding the CAN per device
 receive lists a sensible name
Date: Mon, 28 Aug 2017 12:58:54 +0200
Message-ID: <0fdf4bcb-c5e4-7977-33a5-7cf6e5bd6739@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-4-mkl@pengutronix.de>
 <37090b41-cbea-5272-a020-cba897e86134@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ph9kVWJRbI6l8wWAhXDBkfLnIJ8Uss5SJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44289 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751157AbdH1K7A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 06:59:00 -0400
In-Reply-To: <37090b41-cbea-5272-a020-cba897e86134@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ph9kVWJRbI6l8wWAhXDBkfLnIJ8Uss5SJ
Content-Type: multipart/mixed; boundary="Gap0NjsdC3WkLNae3VGKTHj24VJedbOq3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <0fdf4bcb-c5e4-7977-33a5-7cf6e5bd6739@pengutronix.de>
Subject: Re: [PATCH 03/14] can: af_can: give struct holding the CAN per device
 receive lists a sensible name
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-4-mkl@pengutronix.de>
 <37090b41-cbea-5272-a020-cba897e86134@hartkopp.net>
In-Reply-To: <37090b41-cbea-5272-a020-cba897e86134@hartkopp.net>

--Gap0NjsdC3WkLNae3VGKTHj24VJedbOq3
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 02:59 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch adds a "can_" prefix to the "struct dev_rcv_lists" to bette=
r
>> reflect the meaning and improbe code readability.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Gap0NjsdC3WkLNae3VGKTHj24VJedbOq3--

--ph9kVWJRbI6l8wWAhXDBkfLnIJ8Uss5SJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmj924ACgkQHv7KIOw4
HPb6hAf+KKDQd6Y7JmfqjUggERshKVvm/IRDfPt3khw9jrqkcwmeknc/ii7xFgQB
wmGPJ+oHikn77JQV1okD+mL7W97sBPlW33r52HLcf6Z1y9/WhI7zdD8ngwuxtFKi
GgEFYBxMnFxaEyMgk7K2AvQoU3XcAdhxuCss73u+4uLoNDK8Hvo7k1GxM8hlqD1p
9mRTq+cC1BsfkCCWPX0qdkbEfaNjGRsymGM2hLimLN68hXXRikVlYvGo2OVLofVV
spBUlQzG4/PW/CXOyr1juAAIf1CW1H+PETkPtDpSPJR97mxpe0A/tZAgMemakrpb
qtOeolxorClbiD32ig4PtW7c2MS/pQ==
=sOnP
-----END PGP SIGNATURE-----

--ph9kVWJRbI6l8wWAhXDBkfLnIJ8Uss5SJ--
