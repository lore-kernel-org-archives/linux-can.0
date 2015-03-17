From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] peak_usb: rename usb option cmds definition and structs
Date: Tue, 17 Mar 2015 12:27:18 +0100
Message-ID: <55080F96.9010402@pengutronix.de>
References: <1426503473-7403-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iIOndud04MeCW8IF1Sopbe0vUBLNEfu62"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60138 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbbCQL1Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 07:27:25 -0400
In-Reply-To: <1426503473-7403-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIOndud04MeCW8IF1Sopbe0vUBLNEfu62
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 11:57 AM, Stephane Grosjean wrote:
> The PUCAN_CMD_RX_FRAME_(ENABLE|DISABLE) command has extended its purpos=
e
> and was therefore renamed to PUCAN_CMD_SET_(EN|DIS)_OPTION.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

applied both to can/master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iIOndud04MeCW8IF1Sopbe0vUBLNEfu62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVCA+ZAAoJECte4hHFiupU6bkP/j+JytQK3GeuWd/RgiDsiVP/
MT4Mxqsj1pJ7IPI7YSRoBf9vQgoggD2NoXEU3qOppIHnscbvgmHKrQfk/vz0bd94
79ut0J8PZuncvQXEISqd0DLfEZtfBB4s1azkXMf6Y1c/yrQ7Ey+mq+h+Bp2jEW18
uc696GOA+rLpbYWrjVS/RvRFzDH6/bPeIYmBexhAli4NzUxW9iUeX81D47Ur7fjw
ofZqYiflXRp1AvYJB8BF0gVyi+a/vuCwH7qAUBnziZMVfDPeAgTXPFajH6b+hR+U
qXywIEW99sZWs6BxePRsldtECUjgLhRXeb5HPpqlyaNxq45w0zhMD7Ubqs7pE+5D
P+N8pYTu4MH7hA17V+Z2gvTD5zw8eXo8+AbVTVdcSA3rA9W6AWSAQo60fi4SWrGx
dB8t6ccEt4ZhOxoQNCfQqKYIO1dPGi9eSP5TDLEdZoyF0KF0N98qdFis9efZ+Wkh
p5I14SadqQsKwVEi9Kg5oKOwfoLcD2VwwIeaN6CN/xIsXmjAMOMjKwcNd1d8wE0r
RgCoupvSdy/UF8bGgLRO0Zf9Y4v63K+CPey2OHCwIELg07IF27iJvxqzkorHMK0L
ek0b+bakf1lurt5EILjFv2fNcG+lBnU3XNsiSTWUlZFmuOa45tIyMyYthkbvMmTs
ZQj1MCDozd1ylybkmi69
=dNAo
-----END PGP SIGNATURE-----

--iIOndud04MeCW8IF1Sopbe0vUBLNEfu62--
