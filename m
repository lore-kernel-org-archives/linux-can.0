From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 1/7] can: peak_usb: export ctrlmode_supported to adapter
 specific
Date: Tue, 20 Jan 2015 15:28:48 +0100
Message-ID: <54BE6620.6030906@pengutronix.de>
References: <1421763329-21915-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="up3GCCR8tsd7CSoDhi71lNWRQrMGfKhBe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34804 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbATO2y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:28:54 -0500
In-Reply-To: <1421763329-21915-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--up3GCCR8tsd7CSoDhi71lNWRQrMGfKhBe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2015 03:15 PM, Marc Kleine-Budde wrote:
> From: Stephane Grosjean <s.grosjean@peak-system.com>

Somehow the summary mail got lost, sorry. Here it is:

picking up Stephane's work. This is basically the series split into
smaller patches. See my comments on the original series for more
information.

The series is available on kernel.org:

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?=
h=3Dpeak-next

and is based on current net-next/master.

Stephane feel free to pick up and add the changes proposed by Andri.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--up3GCCR8tsd7CSoDhi71lNWRQrMGfKhBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmYjAAoJECte4hHFiupUqgQP/Asfj2Ot5Yh8aJWRMiIbLKUi
Vl56Yb3ObiZ6HsFwkWNGAeekypcWllQFQQqlA0WHULmvusfGfpuENEvdZfdq/KDg
V8+uGF1b2ErLoSKJFq8X1Bh0NEDqEXsDAW27JysBM9DDKpVvkYmcTh+ZYpKuVTqy
wHpoNKPNEo6fyDYhTi6UBntwn/s9N0cKzk3Ab6bMBf/+q5lP8Lgsr5bgnbk9//lc
DQQ33aYHSrl3LjX7NL1pXDVOpzpEqZyoF8up5ev1sSVjMxcKCoTxkVAQ/LM2CpKz
6a5aRvlqfGmPUcf5sp5wmBAFKoWtDHAcJ8EgD8UV6b2haVW4K8Fyn2LQEfV/T/QK
h70uQGpGax1QckzL6/Yjln1yx2uKoGvNsLHcSW9Brei4yw0Hbywz07VXUz9F7B20
RoB6sW3oYS43vTEd4cJc+kH2ouuPcrZvI5XR/G9h85IRjg5zo/7aF56HSzZvJGro
KFUgvLumyyc7l6SwZ07HMSHeoxVg8CcoDHaZKKO96H2ClRyqwp0I21qVxwhbom1K
3ytYR54BkISKpyWkoSEyiLebIIgmUC6+Yn0cM8Wu9yCg/pFUcrH+z6MxvDbH4Kj/
Fn3xdY7E9iTNhMGcBNTqU93ISetQG174NcuCiJJWJ7l6SF8SrDoK6+BDFzrwNCj+
nLmdep6L9UWGvpd9uyup
=KV0w
-----END PGP SIGNATURE-----

--up3GCCR8tsd7CSoDhi71lNWRQrMGfKhBe--
