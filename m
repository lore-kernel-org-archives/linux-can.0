From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: esd_usb2: check index of array before accessing
Date: Wed, 03 Jul 2013 12:04:57 +0200
Message-ID: <51D3F749.5010304@pengutronix.de>
References: <1372840409-13481-1-git-send-email-mkl@pengutronix.de> <51D3F638.3080207@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TBNALORGGHORNAOPNEXT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43016 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab3GCKFH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 06:05:07 -0400
In-Reply-To: <51D3F638.3080207@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Maximilian Schneider <max@schneidersoft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TBNALORGGHORNAOPNEXT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2013 12:00 PM, Matthias Fuchs wrote:
> did anybody encounter an issue with invalid net codes comming from the
> device?

No, but we should not trust data coming from the "outside" into the
kernel to be valid. I don't want to have a driver in the CAN subsystem
that may be used to exploit the kernel.

> Well, you may add my
> Acked-by: Matthias Fuchs <matthias.fuchs@esd.eu>

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TBNALORGGHORNAOPNEXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHT90oACgkQjTAFq1RaXHNgDwCgjxMqOvH///9pw6kR6Ap/NEKQ
KXQAn1z9qWq8DyhUsgZaskqf+jRn6N5E
=Q3Bs
-----END PGP SIGNATURE-----

------enig2TBNALORGGHORNAOPNEXT--
