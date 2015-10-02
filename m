From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: When SocketCAN added to Kernel
Date: Fri, 2 Oct 2015 11:12:59 +0200
Message-ID: <560E4A9B.6080304@pengutronix.de>
References: <2013087604.53661.1443776992363.JavaMail.Chmail@mstbz.chmail.ir>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PqxOvqQBfC6VF1sBoEGhoTCWC9T6O7C9s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58735 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbJBJNK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Oct 2015 05:13:10 -0400
In-Reply-To: <2013087604.53661.1443776992363.JavaMail.Chmail@mstbz.chmail.ir>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?2K/Yp9mI2K8=?= <davod.m@chmail.ir>
Cc: socketcan@hartkopp.net, linux-can@vger.kernel.org, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PqxOvqQBfC6VF1sBoEGhoTCWC9T6O7C9s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2015 11:09 AM, =D8=AF=D8=A7=D9=88=D8=AF wrote:

> Thank you for answer.
> I try to compare drivers of MCP2515, SJA1000 before and after SocketCAN=
=2E
> For this reason I asked from you about time of adding SocketCAN to the
> kernel
> For this work we need two drivers of MCP2515 and SJA1000 as character
> device and same as it for ShocketCAN.
> But I can't find drivers of MCP2515 and SJA1000 as a character device,
> Are you can see path them?

There never was any character device based CAN driver in the kernel.
There are several out-of-tree projects line can4linux, etc...

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PqxOvqQBfC6VF1sBoEGhoTCWC9T6O7C9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWDkqbAAoJEP5prqPJtc/HMjoIALu0dpxbtpp+6QQwtxSdZ6i2
G6XSI9yvdxwhKA8kYDa3gV7yER0gc7BjlBeLOxRSrKOhopM07vnybUtzSZUPL9vH
7ktD/47L4zOU0OYHudEdMBOuyJDEKhSEZ1JKgP8KjPYULINq5CMGr/aqMvDA+ncW
EB9O8YlwUizmP6UkXNdAfRi+eCsyrd2xk0g+FhcunTk70KJ4NSdNHI7hxqqL1+cn
JWGpLSTwizhvsXBhd/xt5APvswtbNyMlgNytEnJQI+7JgF8u6XgzA3TAc3qlQdDw
fZXqjcJvxZjFuRNyUKsdLNjIOg2JmPFJNjphI5r/T+f+rt3Ol/AA5n6NYDrYdNI=
=9gJi
-----END PGP SIGNATURE-----

--PqxOvqQBfC6VF1sBoEGhoTCWC9T6O7C9s--
