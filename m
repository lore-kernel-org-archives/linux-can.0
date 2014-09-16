From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can] peak_pci: add PCI ID definition pcie card variant
Date: Tue, 16 Sep 2014 16:01:14 +0200
Message-ID: <541842AA.4020500@pengutronix.de>
References: <5417EF55.9050805@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kxDNQUeqtlsoAAL30hGXtnGFj1WvpE36H"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37572 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbaIPOBW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:01:22 -0400
In-Reply-To: <5417EF55.9050805@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kxDNQUeqtlsoAAL30hGXtnGFj1WvpE36H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2014 10:05 AM, Oliver Hartkopp wrote:
> Add PCI ID definition for the single channel PCAN ExpressCard 34 adapte=
r.
> Due to the subsystem id evaluation the correct number of channels (here=
 1)
> is created at initialization time. Tested including the LED functionali=
ty.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> CC: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can.

Thnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kxDNQUeqtlsoAAL30hGXtnGFj1WvpE36H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQYQqoACgkQjTAFq1RaXHMSygCeJHT0CPZuaVvNO1aA9WjRN07E
sPgAnivzWjGVL7O812fJMrcpD7Ss9wGg
=lRjx
-----END PGP SIGNATURE-----

--kxDNQUeqtlsoAAL30hGXtnGFj1WvpE36H--
