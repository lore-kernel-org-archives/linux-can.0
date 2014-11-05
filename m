From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Wed, 05 Nov 2014 14:15:54 +0100
Message-ID: <545A230A.4020107@pengutronix.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-3-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CGlNo2eDKxheCJXNXSEFN2bHFJvpeWDFX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbaKENQK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Nov 2014 08:16:10 -0500
In-Reply-To: <1406565510-10783-3-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CGlNo2eDKxheCJXNXSEFN2bHFJvpeWDFX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2014 06:38 PM, Stefano Babic wrote:
> This driver implements a simple protocol
> to transfer CAN messages to and from an external
> microcontroller via SPI interface.
> Multiple busses can be tranfered on the same SPI channel.
>=20
> It was tested on a i.MX35 connected to a Freescale's
> HCS12 16-bit controller with 5 CAN busses.
>=20
> Signed-off-by: Stefano Babic <sbabic@denx.de>

No line by line review, but some fundamental comments and questions:

Can you please use a consistent indention scheme for struct and enums, I
favour a single space against aligning with tab, as it ony fits 95% of
the time and breaks during upgrades.

Please only use u16, u32 and friends where the size of the register is
important, use plain int, unsinged int otherwise.

I'm not sure of fiddling with the GPIO which you requested as an
interrupt is a good idea. This is probably not available on all platforms=
=2E

Why do you have two functions calculating the checksum? Have you checked
if the kernel offers you a library for this?

Can you explain me the endianess, I don't get why you need
format_frame_output() and format_frame_input() and while your structs
that go over the wire have no specific endianess (i.e. no __be32 in the
struct msg_*).

Have you thought about using threaded interrupts? Or even better make
use of the asynchronous SPI framework?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CGlNo2eDKxheCJXNXSEFN2bHFJvpeWDFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWiMKAAoJECte4hHFiupUvmAP/35/nJgDHADg4/iMTlBNMGJZ
dj3gzG+ojmlAw4ZSPkLQ4gzkOZTAPCE3Or8rWD+1NEGhQMBhLk2qoubVzzyK+gy+
Cm1KtzZbD+g8vRMu081WLqec3ndJai5NXfL7qLADodeS7dkGteIqAt/o5qiXH0Y0
8A8Okh74ugYBDXHSHeDs4da9ig44rsi7YnzGNnZh9zcvorAmNQXGGBUprq1FFaZo
EzLC6H2FGM0GcfaTEaDOVuTauvrw0QTJqT7p9eXpuqGyPYKZoe12B4LuMXriVr27
UPuQge1ygSnmTeS4V2TSaXrQiMyZ7Unm6O6wqDlY/qUDLAp+2hxzajToWghjPJI2
IK7OXEjq9l4mUURnriO75I2nWEeeGNazfXXOyJaxRx7YZRk+vOSwDVSe8Ae5V0g1
fppIUJ7LtfKvSqNuU6dm/mUw80Ln+foRfwbMcrho3Gyr3B3KBoWHOubbffROZHIU
Tbvm0eZpzNh7ZKtJX/oY5ahDWQoWnHXKCx9riRH2DBH/SVi9pcWlAsHRm4wVUdbI
hH/R/83E68nyWgN0lqMow8KiKFT9OqZ3V9T+cCFLAYwLVxy/X1BPemHqXhXQLMIr
6UnKYqyvhYu0jkYDlTYTkMybxX1C8uYMfoYmQJyBZU92vu0b9pHMEm9n2hMLMlZB
U99kFoFrCdj8XBqkximo
=KvB1
-----END PGP SIGNATURE-----

--CGlNo2eDKxheCJXNXSEFN2bHFJvpeWDFX--
