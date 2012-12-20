From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] c_can: Update can support
Date: Thu, 20 Dec 2012 14:57:40 +0100
Message-ID: <50D31954.30501@pengutronix.de>
References: <cover.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2353675FBF4BE7ED99DB8C32"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36499 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2LTN5t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 08:57:49 -0500
In-Reply-To: <cover.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2353675FBF4BE7ED99DB8C32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/20/2012 11:05 AM, Amit Virdi wrote:
> This patchset aims to improve the Bosch c_can driver support. The chang=
es are
> as a result of problems encountered using the c_can driver on SPEAr pla=
tform.
>=20
> Although significant care has been taken to ensure that the changes don=
't break
> the existing functionality, however there might be some hiccups on othe=
r platforms.
>=20
> The patch to provide generic interface is provided to add more flexibil=
ity for
> the end applications.
>=20
> The patches have been tested on SPEAr1310 EVB and the patchset rebased =
on master
> of http://git.gitorious.org/linux-can/linux-can-next.git

I'm on vacation already. I'll have a look at the patches in about 2 weeks=
=2E

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2353675FBF4BE7ED99DB8C32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDTGVcACgkQjTAFq1RaXHNdZQCglpCenaBSQw8n1X9nfDUmYPES
pEkAnRUywXaRj2on8lNKCbirztIp4mDB
=jTSw
-----END PGP SIGNATURE-----

--------------enig2353675FBF4BE7ED99DB8C32--
