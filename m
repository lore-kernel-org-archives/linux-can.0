From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] can: dev: fix crtlmode_supported check
Date: Tue, 17 Feb 2015 00:41:45 +0000
Message-ID: <1424133705.23608.51.camel@decadent.org.uk>
References: <1422385920-29763-1-git-send-email-socketcan@hartkopp.net>
	 <54C89CFA.7080606@pengutronix.de> <54C9025D.9040702@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HKY610hnhFwloux75Omh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33420 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244AbbBQAl4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Feb 2015 19:41:56 -0500
In-Reply-To: <54C9025D.9040702@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Zefan Li <lizefan@huawei.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--=-HKY610hnhFwloux75Omh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2015-01-28 at 16:38 +0100, Oliver Hartkopp wrote:
> Hello all,
>=20
> just in the case you are interested to pick these patches up for 3.2 and =
3.4=20
> stable:
>=20
> The backported patch for Linux 3.2 ... 3.14 has been queued by GregKH for=
 the=20
> 3.10 kernel here:
>=20
> http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/tree/=
queue-3.10/can-dev-fix-crtlmode_supported-check.patch?id=3D332373aa9a50a1c1=
8027be7352d6138fa74263d0

I already queued this up while going through commits with 'cc: stable',
thanks.

Ben.

--=20
Ben Hutchings
Never attribute to conspiracy what can adequately be explained by stupidity=
.

--=-HKY610hnhFwloux75Omh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVOKOSee/yOyVhhEJAQqEyBAAv7VTHfxa0wC4cG6F7kzPSihXNWcntV2/
0CE/oXz76xzx16IUbGtcrPxHZdzQslZjWniobP5hONIcNz8Qbf8eFRXv/CKqnGRI
p2xdqOTAfUAnQcnZWmUY1APKTjnGcJx4LLEcZKhnXKgzeXO0yfjCcOr5fFDBvcgr
CmaYnEuJbw4OzLlgDPLggMtYKGF7+42jUnyl6AWbleke23eKmvDQuqt0KepJDejC
/y3kd/PE14EO0CTNmwNzvkbfFm7ofDvgUMk89oiWlrJ/mNOEezG71jmy+8/wvFGq
8uaeaFIqGQNtvwFQhUzCobKjLg58NcJX1O749gnisQNonGX2ETlYY2PaRQW5EUsq
CvjxhQ+HQiLEGyq4EaBonhslfqnrrVgMgL6DCwyH2SexlvrnzUi5rRzmv0xQghpw
vEBfl3gSQWajhDfYHq8BSizLCQZuFDeKBetqDPHiLeJzSXwBpMVpj8KgQ7cVOsF2
RwWInuZ3i/7J8MwjwgxrAfgu1cHCRO3lZN3vgQeh3TPZxxoSQQFvuK71fYpXF142
rR7w58VUGpuAI538shp/BJ7ilGJsf68FKFXkhWUwX7ZNjAGZJfr+C3VQ5lwgpse/
5IreUSu0pqGP6zwHUdiOOXUAIzORodDGeSenetAlEBHbtmCzLHB+xhIRqZ5em3B+
UboCEzfD8mw=
=NTd6
-----END PGP SIGNATURE-----

--=-HKY610hnhFwloux75Omh--
