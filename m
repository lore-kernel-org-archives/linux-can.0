From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/4] can: Properly fill the netlink header when responding
 to RTM_GETROUTE
Date: Tue, 10 Jul 2012 17:29:14 +0200
Message-ID: <4FFC4A4A.3020009@pengutronix.de>
References: <cover.1341489914.git.tgraf@suug.ch> <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch> <4FF7FEE9.1000509@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA88C42D06BA60020989B85A4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44844 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab2GJP3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 11:29:19 -0400
In-Reply-To: <4FF7FEE9.1000509@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Thomas Graf <tgraf@suug.ch>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA88C42D06BA60020989B85A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/07/2012 11:18 AM, Oliver Hartkopp wrote:
> Hello Thomas,
>=20
> besides the fact that i would like to simplify this patch (3/4) as show=
n
> below, i was able to test it now.
>=20
> You may add my
>=20
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> to the next post.
>=20
> Do you have an URL to pull this patch set for Marc?

I can take this series as is and add your Tested-by and Acked-by to each
patch. Is this okay?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA88C42D06BA60020989B85A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/8SkoACgkQjTAFq1RaXHOf7gCeJsvKIvH3J2OXxMpSgKPO74bk
rMEAniwIF8WUjUJLZCChlCjLkL40GfUE
=8p3p
-----END PGP SIGNATURE-----

--------------enigA88C42D06BA60020989B85A4--
