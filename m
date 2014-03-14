From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: Fix regulators operation without CONFIG_REGULATOR
Date: Fri, 14 Mar 2014 10:49:36 +0100
Message-ID: <5322D0B0.9070006@pengutronix.de>
References: <1394786780-24083-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6s6VF5vvLdcFe2rsrpp0R5UJGjLC6soLN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbaCNJti (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Mar 2014 05:49:38 -0400
In-Reply-To: <1394786780-24083-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6s6VF5vvLdcFe2rsrpp0R5UJGjLC6soLN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2014 09:46 AM, Alexander Shiyan wrote:
> If CONFIG_REGULATOR is not set, devm_regulator_get() returns NULL,
> so use IS_ERR_OR_NULL() macro for checks.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

This should probably go into net, right?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6s6VF5vvLdcFe2rsrpp0R5UJGjLC6soLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMi0LAACgkQjTAFq1RaXHNQoACfUvzJarlrjop4Re19agMBwfy6
bp8AoIAr8BTjXkSbLIijQMU+m+MTrveY
=qWC2
-----END PGP SIGNATURE-----

--6s6VF5vvLdcFe2rsrpp0R5UJGjLC6soLN--
