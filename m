From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Bus off
Date: Fri, 27 Jun 2014 09:04:19 +0200
Message-ID: <53AD1773.1090300@pengutronix.de>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com> <1403823263.24938.12.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nCId5havIFWL4aCdt7iDMghQ6NfQerGnG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaF0HEi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jun 2014 03:04:38 -0400
In-Reply-To: <1403823263.24938.12.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCId5havIFWL4aCdt7iDMghQ6NfQerGnG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/27/2014 12:54 AM, Max S. wrote:
> When there is only one node. The lone node will continuously attempt to=

> transmit.
>=20
> the tx error counter will increase and the node will move from
> error_active to error_passive, and then to bus_off. At least one node I=

> know of will leave bus_off when it receives 128x11 consecutive dominant=

> bits and ten try to send again.

If the bus is properly terminated, a lone CAN node will not go into bus
off, though its error counters will increase until error passive.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nCId5havIFWL4aCdt7iDMghQ6NfQerGnG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOtF3oACgkQjTAFq1RaXHMvQwCeLInJ4Ix0cO2Jowtj33RClTjQ
lrIAnj9AqHPOSJYHfOLwQLx6rpCLDIMM
=DbwX
-----END PGP SIGNATURE-----

--nCId5havIFWL4aCdt7iDMghQ6NfQerGnG--
