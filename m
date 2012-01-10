From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Tue, 10 Jan 2012 13:53:13 +0100
Message-ID: <4F0C34B9.4000406@pengutronix.de>
References: <871799.098418222-sendEmail@ubuntu-i386> <4EF3A40E.4080206@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig30506A0A383FDA9C687E8841"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53053 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab2AJMxT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 07:53:19 -0500
In-Reply-To: <4EF3A40E.4080206@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30506A0A383FDA9C687E8841
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/22/2011 10:41 PM, Sebastian Haas wrote:
> Hi again,
>=20
> some nitpicking this time. ;-)
>=20
> You are mixing pr_*, dev_* and netdev_* please check if it is possible
> to harmonize the usage.

I think, that you should use netdev_* whenever you have a netdev
pointer, dev_* until no netdev has been registered and pr_* if not even
a device pointer is available.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig30506A0A383FDA9C687E8841
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8MNLwACgkQjTAFq1RaXHM8jQCglzoR/UbmVFc6jeuDO9wT6IlQ
7LsAn0oVAMiX0OeWMr5ut8o/yLVTzMGe
=VmPZ
-----END PGP SIGNATURE-----

--------------enig30506A0A383FDA9C687E8841--
