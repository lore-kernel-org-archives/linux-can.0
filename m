From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: esd_usb2: Fix sparse warnings
Date: Mon, 16 Mar 2015 11:53:50 +0100
Message-ID: <5506B63E.9060504@pengutronix.de>
References: <1426495709-10810-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VwtMgKEgLXnXjnsHJ3gktxVLP3bXr2pfc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbCPKx6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 06:53:58 -0400
In-Reply-To: <1426495709-10810-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Thomas_K=c3=b6rper?= <thomas.koerper@esd.eu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VwtMgKEgLXnXjnsHJ3gktxVLP3bXr2pfc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 09:48 AM, Thomas K=C3=B6rper wrote:
> The hnd field of the structs does not need to be __le32: the
> device just returns the value without using it itself.

Thanks, added to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VwtMgKEgLXnXjnsHJ3gktxVLP3bXr2pfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBrZBAAoJECte4hHFiupUb3EQAIgOPZ6PK13PovAvZ0I+MW5l
deCBz4zcznrPzEpdGJMv4JHQn8yQWgsAQcOmWXWNshv+c5Z9n5M1Vsw2HiZel3Aa
voqBJ0HclFsf+25lFMhrVwda7RQ0TqPs3IhYiyxtBpUHnU79DbRjN8iXfV92F7Ba
9t/L74Q6tApK18Zn25jDk48BLm1dJ/d1FmazFTsYH7MU4Le6+CVd8TDC4Zq+dj9y
ZtKsiVF0HsLgXVh2VJQUA89s6I1YS9EjMEBRATtVPvMv0l8VQQdRCHUf9ZPsqvUW
6dkbZyHtbHc9vqWQ6DTNpXmxhnA+MzdBlIEHct/mUk3DFOPNegePDYEapHdjKdwX
PL+0bScVxRxgSiWLMUp6lFu8iE4DslO/P6Uj9Ig/coRBLBQY1dcLDDZqpWx3ccsx
MmspJPY4U4VdO27X1891T4jkDz0NGTCSjYkTDz9f9wmXUM46zKDp9PRxt7bYarLk
xQ5zHjcG1pehQIg3Z5ZhZFzROV/vBkkF1eYTG96MDAvq7ojtuL4bn8VCleUcbWva
NnlnTql/6pU+5b+KoBBWY+dQr7bWdjOo1qToM67KYE4BozcWm6CjoCsZ/6/F+Bxs
+WYs0ELPUw1GH5vIcGvOl/8UNSx2XDOBcMpbDox5Pem4DDXi5KxpiFA+XGWU3HFz
7UXQfWvfaad3bPTy11vj
=Y/Ly
-----END PGP SIGNATURE-----

--VwtMgKEgLXnXjnsHJ3gktxVLP3bXr2pfc--
