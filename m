From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: fix invalid error codes
Date: Sat, 26 Jan 2013 17:38:52 +0100
Message-ID: <5104069C.8070400@pengutronix.de>
References: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QSJHVRBVWMAHKKJWXGSG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48269 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3AZQi5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Jan 2013 11:38:57 -0500
In-Reply-To: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Bhupesh Sharma <bhupesh.sharma@st.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QSJHVRBVWMAHKKJWXGSG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/18/2013 09:32 AM, Olivier Sobrie wrote:
> Errors in CAN protocol (location) are reported in data[3] of the can
> frame instead of data[2].
>=20
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> Cc: Bhupesh Sharma <bhupesh.sharma@st.com>

Thanks, applied all three and added stable on Cc.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QSJHVRBVWMAHKKJWXGSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEEBpwACgkQjTAFq1RaXHOA9QCfe71FQHRwgC2OoGheEHP+loo4
vd4AnjbHPq9WAWxNob1QC2Gf46uaGQRe
=dIwR
-----END PGP SIGNATURE-----

------enig2QSJHVRBVWMAHKKJWXGSG--
