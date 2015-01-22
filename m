From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 16:33:13 +0100
Message-ID: <54C11839.7060802@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RidcL3Isw7gmcM8vov8NROUlehddDPBRG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56978 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbbAVPdQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:33:16 -0500
In-Reply-To: <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RidcL3Isw7gmcM8vov8NROUlehddDPBRG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
> Add support for the following new PEAK-System technik CANFD USB adapter=
s:
>=20
> PCAN-USB FD             single CANFD channel USB adapter
> PCAN-USB Pro FD         dual CANFD channels USB adapter
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/Kconfig                  |   14 +-
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +-
>  drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++

Please merge ucan.h into pcan_usb_fd.c, which is the one and only user
of it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RidcL3Isw7gmcM8vov8NROUlehddDPBRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRg5AAoJECte4hHFiupUpPIP/0x6UxXyXjRNvfc5Puu1u7Gn
44lJk64ATG+CEhTJ7swrmbbcLah7VTuhsPSuBTP3+vz1si1JgkUSRKtuGnFnH5YK
4ryqm1u6iU6mhrHE3sFk9JU8kCr9tpK6mRrVFbbHe08DskH/lEz4lgZ+raEA0fhg
pMl3hAc9p8XvEe2rd7FjOrtYO/n4CGiNtxgv57hAbntJcSzlr4fX54w+7mciIzsP
qZpLI7C/vqwWKzdFAJcpXv5+2vbfqp8QGwb5CLJup8rqPUTglFLQq0qrRYE9cCl3
KfKlEa0+4MdTBjU/Put1qqRwZk7GHaBPNfI82HWKCD649T/wxcjH1oXXg20l5x5w
ODhxHUGNlwHGaeIDhmO/y2+FhOr5j8YXn0txvTQE2do5boJ1BFc9a0nrAVrR96jo
XqdqNDq0pH6AG7WFf60BTy5R5ow2otWajqNC4gCLbQ3X/LWVf0mAYdK8bUcJ/Rg7
tubG3zpX8r8Ddy1knZ3pDWCd2lbNM8kBJY5yGWqvEornCorNoc+1wU7iiXWQ0lE+
smUOFvDoQYRppSPH9YoQp4dSbl6f29W+dUqUD/0Q6KLnbvwPyJTYIsj3bx0of+b2
udSfAssP/rv/4ioBJiNhpUraZkHA2CYc1dLU+eLcQa5T26IHuWfSlReiFIIxwNB3
JG0LTn3UwvdynCxfMi12
=rcJb
-----END PGP SIGNATURE-----

--RidcL3Isw7gmcM8vov8NROUlehddDPBRG--
