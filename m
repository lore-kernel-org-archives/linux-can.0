From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can_pci: fix compilation on non HAVE_CLK archs
Date: Thu, 21 Jun 2012 19:50:26 +0200
Message-ID: <4FE35EE2.2010601@pengutronix.de>
References: <1340187910-3437-1-git-send-email-mkl@pengutronix.de> <CAH5GJ0pGNx9qD6snF1d0J7QYpreapA2KaPdieKL_z06CdjHYVg@mail.gmail.com> <4FE2156F.8030008@pengutronix.de> <1549020.T54Yk82Gkk@harkonnen>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9673862601DE81E5C819CBCF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34641 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760042Ab2FURud (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Jun 2012 13:50:33 -0400
In-Reply-To: <1549020.T54Yk82Gkk@harkonnen>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Federico Vaga <federico.vaga@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9673862601DE81E5C819CBCF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/21/2012 07:51 PM, Federico Vaga wrote:
>> I've already sent the patch to David. However please test it.

He already had applied it, however testing is still a good idea.

> My development board don't boot. I'll test the patch when I can boot my=
=20
> board or use a different one (hopefully soon).

Is the boot problems related to the patch?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9673862601DE81E5C819CBCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/jXuUACgkQjTAFq1RaXHP16wCfaTrShzhBVz5XLXfP2CgVs22+
UowAnjVn6/TLcqnetaus/SbM6BGHwx+L
=xlpn
-----END PGP SIGNATURE-----

--------------enig9673862601DE81E5C819CBCF--
