From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/9] upcoming pull request: const annoations + flexcan
 + janz-ican3 update
Date: Fri, 20 Jul 2012 13:15:44 +0200
Message-ID: <50093DE0.3030902@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig23EBFFDB59A79B154E55649B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2GTLPy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:15:54 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23EBFFDB59A79B154E55649B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/20/2012 01:11 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> this is my upcoming pull request to David. Ira, I had a trivial conflic=
t
> while merging your patches. Further I improved the ican3_to_can_frame a=
nd
> can_frame_to_ican3 functions. The helper "get_can_dlc()" is to limit th=
e
> dlc value coming from the controller, further only dlc bytes are copied=

> from and to the controller, not the whole frame. (see patch 5/9).
>=20
> This pull request will also contain the flexcan update for imx53 and th=
e
> bittiming_const annotation posted earlier this week.
>=20
> Pleae review and test.
> Feel free to send Acked-by, Tested-by, Reviewed-by etc :)

These patches can be found in linux-can-next repo in the for-davem branch=
:

    git://gitorious.org/linux-can/linux-can-next.git for-davem

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig23EBFFDB59A79B154E55649B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAJPecACgkQjTAFq1RaXHMvJQCgiua9Hqk1Vum/YwzpOugjjMjA
EcEAnRLVEgo6Ers7AMqg9D5A4XiTEURz
=jzjA
-----END PGP SIGNATURE-----

--------------enig23EBFFDB59A79B154E55649B--
