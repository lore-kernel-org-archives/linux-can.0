From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make
 use of IRQ offloading
Date: Thu, 10 Dec 2015 15:04:29 +0100
Message-ID: <5669866D.9030100@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
 <CAOpc7mGK9WEnbowHJONbP-szW7mVQbU46uUPXF8V09omqWLQMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NqG2lH9RQb4C9gKloEw2bsqTcFqPDJpNo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55303 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541AbbLJOEh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 09:04:37 -0500
In-Reply-To: <CAOpc7mGK9WEnbowHJONbP-szW7mVQbU46uUPXF8V09omqWLQMA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, bhupesh.sharma@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NqG2lH9RQb4C9gKloEw2bsqTcFqPDJpNo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/10/2015 02:52 PM, Holger Schurig wrote:
> Why did you invent your own rx-fifo.c/.h and didn't reuse the kernel's
> fifo, kfifo ?

Good question. We actually make use of the kernel circular buffer
(linux/circ_buf.h). However, it seems we need a more powerful data
structure anyways, e.g. list sorted by timestamp (with some magic taking
care of the limited width of the timestamp register).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NqG2lH9RQb4C9gKloEw2bsqTcFqPDJpNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWaYZtAAoJEP5prqPJtc/HzlsH/2ufmrjujexK1hlgW7LLXPAB
gFdlkcRq6iCYHaR5qXSKHOIAkNC09a64DyMjpZHZlJbxQqKaLa3w40IVkAqHyU/o
SuBvc6D7VWvk8KNifkOx0ip3aPQ4RKKETR9EXj2jXOK/i5P2M/NBW5Ee5rFvqBvq
xbjivUb+9SxPTb4gv6NpV9537iBQEgjTf/kFEkEcXhCaPzWXDCkJihRwmgqe1sqF
2fC8GKKdp7PrEDyFPTjpnFwNq+1nVAVtrCQITZHT8RFfpQYV7Kn3X4uBBLscl06z
t9bW/czCbcM1n+AxhKw6SfhnpXUOOVlf5E/088FtDPOgbKtOhnTbVIzj7l+p/7g=
=21Nr
-----END PGP SIGNATURE-----

--NqG2lH9RQb4C9gKloEw2bsqTcFqPDJpNo--
