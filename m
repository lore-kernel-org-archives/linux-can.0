From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: at91: move at91_can_data to at91_can.c
Date: Thu, 13 Aug 2015 12:11:18 +0200
Message-ID: <55CC6D46.8020202@pengutronix.de>
References: <1439217894-15230-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iUhPcOCab7L0QKPO9FtTjxQAaVTOIojWN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34536 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbHMKLa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Aug 2015 06:11:30 -0400
In-Reply-To: <1439217894-15230-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iUhPcOCab7L0QKPO9FtTjxQAaVTOIojWN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2015 04:44 PM, Alexandre Belloni wrote:
> struct at91_can_data is now only used inside the driver, move it to
> its c file.

It was supposed to be the interface between the board and the CAN
driver. In commit 4403ac46edcdb51e92d36ad9f00ea3bbb766342e the
at91sam9263 board was removed. As the driver has no support for DT
transceiver switch, this functionality was lost. We should either remove
the transceiver support or add a DT regulator for this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iUhPcOCab7L0QKPO9FtTjxQAaVTOIojWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVzG1GAAoJEP5prqPJtc/HFXwH/1zXiT4iMVD99GbQvNy/hMZ7
Twyvkdon5SCtHFYXQQO9LeOz0LpXBopjn1OjvWib2dP/ygcihBAvhwQ5UWgUe0+Q
yQT3+SeKWlQ5wsiV+Z9vHeB4kqT34hOvD54YpnBAZW+/uN7KoIETx+WqcDPjjzVH
DBVnRnAurABPhsBio39yjlsqNvqE1u94C7T8PcoMV3MG4Gmas+Mew8U4v+P8WReb
f5TUSko0JRtcvJg6s17X4/knWW6wlpR9M3RgeH357a/4IBuO4/FskiRIJohyrVyQ
6R906D/yF1ofM90tBHqaOPJuS3xhuaRdoZIDcoTODdXNhSkS5FihH3mEN/SXgRM=
=OXC7
-----END PGP SIGNATURE-----

--iUhPcOCab7L0QKPO9FtTjxQAaVTOIojWN--
