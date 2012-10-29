From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: usb: esd_usb2: Add support for CAN-USB/Micro
Date: Mon, 29 Oct 2012 11:27:55 +0100
Message-ID: <508E5A2B.1010405@pengutronix.de>
References: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu> <1351504488-7060-3-git-send-email-matthias.fuchs@esd.eu> <508E59E1.4010901@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E7E7C39778D4EA78E62DD92"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55440 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab2J2K15 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 06:27:57 -0400
In-Reply-To: <508E59E1.4010901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: matthias.fuchs@esd.eu
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E7E7C39778D4EA78E62DD92
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/29/2012 11:26 AM, Marc Kleine-Budde wrote:
> On 10/29/2012 10:54 AM, matthias.fuchs@esd.eu wrote:
>> From: Matthias Fuchs <matthias.fuchs@esd.eu>
>>
>> This patch extends the esd_usb2 driver to support the
>> tiny CAN-USB/Micro CAN/USB interface.

> But I think your solution is easier. If you add more device a conversio=
n
> might become handy.

This means, I take your patch as is to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8E7E7C39778D4EA78E62DD92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCOWisACgkQjTAFq1RaXHOo6gCdHIVVIlCS5YWqhPTTP541Z1XD
OQ8An1TueQ5eFuxTXp20xOloxQu/XQZO
=j4Rs
-----END PGP SIGNATURE-----

--------------enig8E7E7C39778D4EA78E62DD92--
