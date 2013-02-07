From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Retrieve amount of queued frames in the txqueue of a interface
Date: Thu, 07 Feb 2013 11:42:39 +0100
Message-ID: <5113851F.1060501@pengutronix.de>
References: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TLODNONQIQJRKKOSTPRQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35466 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab3BGKmm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 05:42:42 -0500
In-Reply-To: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TLODNONQIQJRKKOSTPRQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2013 12:59 PM, Felix Obenhuber wrote:
> Hi,
>=20
> how can I retrive the number of frames currently queued for
> transmission on a SocketCAN interface? Is this possible via netlink?
>=20
> Maybe someone has the answer by hand...

Sorry, I don't know. What's you usecase?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TLODNONQIQJRKKOSTPRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEThSAACgkQjTAFq1RaXHPBFQCfU0Di9CADAVDxVwUZA87IwZ6A
vkEAnisPEIszjfbt68FKutBzHNJoTIPX
=awxP
-----END PGP SIGNATURE-----

------enig2TLODNONQIQJRKKOSTPRQ--
