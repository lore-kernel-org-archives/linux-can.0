From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-bcm: initialize ifindex for timeouts without previous
 frame reception
Date: Mon, 26 Nov 2012 22:42:24 +0100
Message-ID: <50B3E240.1090709@pengutronix.de>
References: <50B3DE07.7080506@hartkopp.net> <50B3E11B.8040606@pengutronix.de> <50B3E1A8.7030900@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B0544FD7885CD05677160BA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36504 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab2KZVm1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 16:42:27 -0500
In-Reply-To: <50B3E1A8.7030900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andre Naujoks <nautsch2@googlemail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B0544FD7885CD05677160BA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 10:39 PM, Oliver Hartkopp wrote:
> On 26.11.2012 22:37, Marc Kleine-Budde wrote:
>=20
>> On 11/26/2012 10:24 PM, Oliver Hartkopp wrote:
>>> Set in the rx_ifindex to pass the correct interface index in the case=
 of a
>>> message timeout detection. Usually the rx_ifindex value is set at rec=
eive
>>> time. But when no CAN frame has been received the RX_TIMEOUT notifica=
tion
>>> did not contain a valid value.
>>>
>>> Reported-by: Andre Naujoks <nautsch2@googlemail.com>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Tnx, I'll send a pull request to David, let's hope the best :)
>=20
>=20
> It probably helps to tag this patch as a candidate for stable also.

Tnx, already did :)

https://gitorious.org/linux-can/linux-can/commits/fixes-for-3.7

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0B0544FD7885CD05677160BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCz4kAACgkQjTAFq1RaXHPWDwCdFejmHU/soUolZ5V0ccLNGIfF
d9kAnRIbPI+oYwadsirw2EUH6y/njKbM
=frWE
-----END PGP SIGNATURE-----

--------------enig0B0544FD7885CD05677160BA--
