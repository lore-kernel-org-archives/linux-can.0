From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [GIT PULL] Disintegrate UAPI for can
Date: Wed, 10 Oct 2012 19:40:04 +0200
Message-ID: <5075B2F4.60708@pengutronix.de>
References: <30687.1349789402@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5BF68A89947E52AE682F4C89"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46300 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab2JJRtv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Oct 2012 13:49:51 -0400
In-Reply-To: <30687.1349789402@warthog.procyon.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: socketcan@hartkopp.net, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BF68A89947E52AE682F4C89
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/09/2012 03:30 PM, David Howells wrote:
> Can you merge the following branch into the can tree please.
>=20
> This is to complete part of the Userspace API (UAPI) disintegration for=
 which
> the preparatory patches were pulled recently.  After these patches, use=
rspace
> headers will be segregated into:
>=20
> 	include/uapi/linux/.../foo.h
>=20
> for the userspace interface stuff, and:
>=20
> 	include/linux/.../foo.h
>=20
> for the strictly kernel internal stuff.

Nice work David. The upstream for can-next is David Miller's net-next
tree. He doesn't like if I pull unrelated stuff into my tree, so I'm
going to cherry pick your patch. This is not yet possible, as net-next
doesn't include the latest patches from the 3.7 merge window, so that
compilation breaks. After the merge window closes David Miller merges
back the latest changes to net-next. I'll postpone your patch until
then, this means the code will go into v3.8. I'm not familiar with the
UAPI conversion, should your patch go via linux-can and David's net into
v3.7?

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5BF68A89947E52AE682F4C89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB1svkACgkQjTAFq1RaXHP3WgCfciHeHTYM3mQLvyldV6D+feL+
1/EAnRlixVfp6dxZWdplNxojKVwWWBl/
=gloJ
-----END PGP SIGNATURE-----

--------------enig5BF68A89947E52AE682F4C89--
