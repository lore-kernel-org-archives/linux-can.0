From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 22 Sep 2013 12:40:53 +0200
Message-ID: <523EC935.90408@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DA147.7090403@pengutronix.de> <CADGMhsU2fD3VnSkRqCJ9AT3SCmKRaX_965i6Kr-gdaFFwDejvw@mail.gmail.com> <523DD2C3.7000505@pengutronix.de> <523DE2C9.4020407@hartkopp.net> <CADGMhsXaJOpbdCgEAoOguZWX2rS_P0a-H5UDZwUWiHD4Nj=upw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7qMfAGILcwJHOI17sgW9bfI7U64uBoTOD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3IVKlB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Sep 2013 06:41:01 -0400
In-Reply-To: <CADGMhsXaJOpbdCgEAoOguZWX2rS_P0a-H5UDZwUWiHD4Nj=upw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qMfAGILcwJHOI17sgW9bfI7U64uBoTOD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/22/2013 08:39 AM, Sebastian Haas wrote:
>> If there would be a solution to handle all this within a user-space dr=
iver
>> this would be my favorite solution too.
> Just found CUSE made by Tejun. It is in mainline since 2.6.31. I'm goin=
g
> to implement a demo for this.

+1

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7qMfAGILcwJHOI17sgW9bfI7U64uBoTOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlI+yTUACgkQjTAFq1RaXHMILACffhazfXkq/5WpG7+HbWzUrBYz
xngAmwUsC6qb8N8Cq75RbBhaIBoxA6si
=DJ0C
-----END PGP SIGNATURE-----

--7qMfAGILcwJHOI17sgW9bfI7U64uBoTOD--
