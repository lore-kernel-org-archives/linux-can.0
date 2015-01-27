From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: mark current PEAK USB FD as non-ISO
Date: Tue, 27 Jan 2015 19:25:30 +0100
Message-ID: <54C7D81A.3030502@pengutronix.de>
References: <1422381484-3804-1-git-send-email-socketcan@hartkopp.net> <54C7D488.4010203@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LCwUj34Wc6Ntror801btEiHAwmrRO5J8g"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59230 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759088AbbA0SZ4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 13:25:56 -0500
In-Reply-To: <54C7D488.4010203@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LCwUj34Wc6Ntror801btEiHAwmrRO5J8g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 07:10 PM, Oliver Hartkopp wrote:
> your v10 series looks very good. The ARRAY_SIZE stuff is a good improve=
ment!
>=20
> I compiled the peak-next branch and inserting my single PCAN USB FD ada=
pter=20
> worked fine. I'll send my tested-by when I can access my second adapter=
 at=20
> work tomorrow.

Thanks.

> The  patch below finally sets the CAN_CTRLMODE_FD_NON_ISO flag.
> It's tested with the updated ip tool.

Thanks, squashed into patch 9/9

> But beware: The current linux-can-next is missing the CAN_CTRLMODE_FD_N=
ON_ISO=20
> patch for M_CAN. Therefore CAN_CTRLMODE_FD_NON_ISO is not defined until=
 Dave=20
> pulled net into net-next. So this patch creates a compile error in the =
latest=20
> linux-can-next.

I've cherry-picked the missing patch from net/master and put it into the
peak-next branch on kernel.org. So the series compiles and when rebasing
it to net-next after net has been merged, the patch will disappear.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LCwUj34Wc6Ntror801btEiHAwmrRO5J8g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx9gaAAoJECte4hHFiupU7BQP/3U4DNMcfm8GnkBnpG9p6MqO
ruywV3OwYa7o6UekWP0zfEXSGL533KIATXxLLZg4RKMr22w3fG6PlpZPiUR6/fBG
jCtheR8fCMlJDnWrVwqE7E38Wa+GmYc5WOYhwwwTt2XhEOGWMVvwJKNsr6HXgNsl
tgwnm8aTO+JUNK3TToLPRkSI8P5Ch3j5zAY65uYl/igGvyG2YRGsyUb+6l202Lak
7IYx2rYFa8wWaS6qVgtvoPkFR+jTkx3QoyGcxkXvrd+zlyXJjj4mSEcj2A3sLx5a
c7pzznmmNRrkXdARuBTnZ3473CIBFoUz+iMl2fP23v1N7AnYJlQ00S9Wc7H0SIyD
6pgO8FKd/AlUofOmXEEoD8kMk8XiTAHYJto/0M2E6AccbbvIW44/OOIppXXI78CX
Ani5aeTlSJm2tMv6yH+oyw1pBAb5tA82OCzJoKNebFhBajPv0KatmvCYf4NQllsx
BqRxqaYfnuQd4PgxKNAfig5dpzciYCMXMJQcR2NI7WQfq9ncyl6pRSELgy2U3x13
kJeq7saDbh1ELS8WAn1cPbFgBJad3kcnRKH8P3KhmGkwolUxvqfF5Dwz3jKhtFYU
rdn8Vv50dM+mQDQL8TY16vIR0ie2A1Rc7Q/3Chd+nWakf3bQrPtKeYFczK242adU
fXKGhPxza/TlV5G4KoH6
=dZ2D
-----END PGP SIGNATURE-----

--LCwUj34Wc6Ntror801btEiHAwmrRO5J8g--
