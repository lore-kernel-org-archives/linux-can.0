From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-bcm: initialize ifindex for timeouts without previous
 frame reception
Date: Mon, 26 Nov 2012 22:37:31 +0100
Message-ID: <50B3E11B.8040606@pengutronix.de>
References: <50B3DE07.7080506@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB67F5398DA0B9DD19A1D4CD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53385 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab2KZVhd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 16:37:33 -0500
In-Reply-To: <50B3DE07.7080506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andre Naujoks <nautsch2@googlemail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB67F5398DA0B9DD19A1D4CD
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 10:24 PM, Oliver Hartkopp wrote:
> Set in the rx_ifindex to pass the correct interface index in the case o=
f a
> message timeout detection. Usually the rx_ifindex value is set at recei=
ve
> time. But when no CAN frame has been received the RX_TIMEOUT notificati=
on
> did not contain a valid value.
>=20
> Reported-by: Andre Naujoks <nautsch2@googlemail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx, I'll send a pull request to David, let's hope the best :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigAB67F5398DA0B9DD19A1D4CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCz4RsACgkQjTAFq1RaXHNOBQCfSf7K6pWrhOROKLpyAlkDPebq
WQIAnRopA7M3Z4670UeMxTmMVgIwb3yo
=gkYJ
-----END PGP SIGNATURE-----

--------------enigAB67F5398DA0B9DD19A1D4CD--
