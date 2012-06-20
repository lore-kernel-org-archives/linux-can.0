From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can_pci: fix compilation on non HAVE_CLK archs
Date: Wed, 20 Jun 2012 20:24:47 +0200
Message-ID: <4FE2156F.8030008@pengutronix.de>
References: <1340187910-3437-1-git-send-email-mkl@pengutronix.de> <4FE1CA49.3010503@pengutronix.de> <CAH5GJ0pGNx9qD6snF1d0J7QYpreapA2KaPdieKL_z06CdjHYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E934183D46810F52C608D70"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589Ab2FTSYu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jun 2012 14:24:50 -0400
In-Reply-To: <CAH5GJ0pGNx9qD6snF1d0J7QYpreapA2KaPdieKL_z06CdjHYVg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Federico Vaga <federico.vaga@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E934183D46810F52C608D70
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2012 07:20 PM, Federico Vaga wrote:
>> have you found Time to test the patch?
>>
> I don=E2=80=98t have the hardware with me at the moment. I can test it =
tomorrow
> morning.

I've already sent the patch to David. However please test it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2E934183D46810F52C608D70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/iFW8ACgkQjTAFq1RaXHPn4QCfd7xwxFdejx6AdDCbArkNsHvA
NbIAnR5wwrzfEP+EvoxJmUdtkm0NPwtU
=MP4n
-----END PGP SIGNATURE-----

--------------enig2E934183D46810F52C608D70--
