From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND] can: sja1000: plx_pci: Add support for Marathon
 CAN-bus-PCIe card
Date: Thu, 7 Apr 2016 13:42:30 +0200
Message-ID: <570647A6.3030809@pengutronix.de>
References: <1459943470-11524-1-git-send-email-gq@cs.msu.su>
 <1459947872-23086-1-git-send-email-nebaruzdin@gmail.com>
 <CAEJ7JO3YX3rmYU0b2mVqwUJ16URi9HSp1Tkckikm8T3MBqrr_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oD7d4EcvaMNWWPjPcl36SC6mDRVNubh67"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50395 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755418AbcDGLml (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Apr 2016 07:42:41 -0400
In-Reply-To: <CAEJ7JO3YX3rmYU0b2mVqwUJ16URi9HSp1Tkckikm8T3MBqrr_A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Alexander GQ Gerasiov <gq@cs.msu.su>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oD7d4EcvaMNWWPjPcl36SC6mDRVNubh67
Content-Type: multipart/mixed; boundary="RiFefbkUOs6XRfJ3a43NMeOj3VtvKUEuK"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Alexander GQ Gerasiov <gq@cs.msu.su>
Message-ID: <570647A6.3030809@pengutronix.de>
Subject: Re: [PATCH RESEND] can: sja1000: plx_pci: Add support for Marathon
 CAN-bus-PCIe card
References: <1459943470-11524-1-git-send-email-gq@cs.msu.su>
 <1459947872-23086-1-git-send-email-nebaruzdin@gmail.com>
 <CAEJ7JO3YX3rmYU0b2mVqwUJ16URi9HSp1Tkckikm8T3MBqrr_A@mail.gmail.com>
In-Reply-To: <CAEJ7JO3YX3rmYU0b2mVqwUJ16URi9HSp1Tkckikm8T3MBqrr_A@mail.gmail.com>

--RiFefbkUOs6XRfJ3a43NMeOj3VtvKUEuK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2016 03:59 PM, Nikita Edward Baruzdin wrote:
> Hi,
>=20
> To clarify: the first patch is an older one and doesn't really work.
> The last one was tested to work properly.

Thanks applied. I've changed the commit message to:

>     can: sja1000: plx_pci: Add support for Marathon CAN-bus-PCIe card
>    =20
>     This patch adds support for the Marathon CAN-bus-PCIe card to the
>     sja1000 driver. For more information see:
>    =20
>         http://can.marathon.ru/page/devices/can-bus-pcie
>    =20
>     Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RiFefbkUOs6XRfJ3a43NMeOj3VtvKUEuK--

--oD7d4EcvaMNWWPjPcl36SC6mDRVNubh67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXBkemAAoJED07qiWsqSVqKNoH/i0KwE1+T8N75hLQIlQabpYE
5ZXnHifDf0bIg+kSOXe7rM+po3FgE4mYdRZwE+pWaV6+2NJpyqBNMvHG8jt3zT5D
GLr+9N1Fp3pVeSxSG7O6jILvzXbw3twLBLpItXaXdmU+k718+jRH6Q6dfFJlQW0F
HLXQE576Ixg3GgUA7/jODKYcuhui8GhQ8MTdZH+FF5acmesZMe3Fz36B0IgRJD8I
s8zM3Jm5oag/Is8QCSVFCZlou04ph75MPjYILsEpCJLOQRU7Av0G4fcgRyFxY6S0
UjfWQsrZk373LZI+ip2XPMwnw0r6dex3azzTfk/JXWMj8tRKG0C5WbQ1845geno=
=jMSr
-----END PGP SIGNATURE-----

--oD7d4EcvaMNWWPjPcl36SC6mDRVNubh67--
