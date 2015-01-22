From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:46:10 +0100
Message-ID: <54C11B42.9090400@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com> <54C117BC.2080905@pengutronix.de> <54C11978.200@peak-system.com> <54C119D4.5050104@pengutronix.de> <54C11A82.5050800@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jHSqdVfXr5aWUX1IwRGAwhOJTEhLx0sFt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39977 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbbAVPqN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:46:13 -0500
In-Reply-To: <54C11A82.5050800@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jHSqdVfXr5aWUX1IwRGAwhOJTEhLx0sFt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:42 PM, Stephane Grosjean wrote:
>>>>> Add a common function that pushes the skb in the network queue with=
 adding
>>>>> timestamps information, converted from time values read from the
>>>>> PEAK USB adapters.
>>>> Why is this function in core.c, it's only used by pcan_usb_fd.c.
>>> Because it should be able to use it from older source files (pcan_usb=

>>> and pcan_usb_pro, AFAIR)
>> Are you planing to make use of the function in an upcoming patch?

> Yes, I am. Not sure I will have enough time to do this soon. How much=20
> times do we have before next Kernel release, please?

Okay, then leave it as it is.

http://phb-crystal-ball.org/

> Predictions
>=20
> Based on the last 47 kernel releases,with an average development time o=
f 75 days, 5:15:03.391304,
> the v3.19 kernel is predicted for Tuesday, 2015-02-10
> the v3.20 kernel is predicted for Wednesday, 2015-04-15
> the v3.21 kernel is predicted for Friday, 2015-06-19

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jHSqdVfXr5aWUX1IwRGAwhOJTEhLx0sFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRtCAAoJECte4hHFiupUvIAP/joDJM7yMV5VYhU4V/xbf44K
Pgjj27WftsKhkL2RS4H6bktL6pMI26S4woi5//Gk8pF3ppnwgvTxsp0rUkPe/r+A
GtrMq/ytae4I6nNmejIjJ8kzHJrk1ZkZZnSUltZpnwsrjZS++qLSHDE+pEP7DW6F
vv3AXOBgIzEfoC0rE3pWyCLpWIYwtHz5z9xiXy/m7Gx2Or2OsA2AeNizuir9IW5w
BXLjzW3NX50JBYlBNVPvz16yvW/twxOfH/WjMH1BB9UjEvUz8HpLn1XUxEbEwJCL
O3XkKe3/DOJUp6XAJFFCHZtevsFRJZXYUHQCd5mJKICdg5OcQptsZbi6voHDpOBd
mG4d8dvb/eLLbQbCj+vfg9t3x6iXaNgN7dqYTW7huV5QfT6tgxDmNoKNiLKdKvYv
FjMuAeu1RwaIbd3OzIAzZRQSqNt9Ew6IacCEQVOzhCJ4NdTiQXXP95e+Z8g5T/ji
xog0+MHAUdbgtiGR3sfaN3AAPNdXm5v2qkdvjtZt3uxA0GI03LfE5WBtw2dO8s3O
zVMKJdjjDU/V/OX8TXTQ5pc5JnWP2QROL+jKWIQ3eufs+8EGkdtQ8M8fQdtcBgc1
LBjkXeHSjpKmdF4Vrz21oSmdLUeI+atGC8rVFavCThp22oxwj8Ktiw0tKfnv3wut
RsbCI0jJa/ygoZxuCovZ
=P5mw
-----END PGP SIGNATURE-----

--jHSqdVfXr5aWUX1IwRGAwhOJTEhLx0sFt--
