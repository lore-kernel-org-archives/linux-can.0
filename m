From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: candump error flags
Date: Sun, 09 Nov 2014 16:01:10 +0100
Message-ID: <545F81B6.1090900@pengutronix.de>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net>	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>	<545E301F.7090708@hartkopp.net>	<CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>	<545E48D0.3020409@pengutronix.de> <CAHuoermH8js-WJYGRVbWkLK91yUBQOL8CxoyqfJgbqLpjvsX5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wQvpldHN1pnvwIHEI2rvxFBDGqkB7jw1k"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44344 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaKIPBS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 9 Nov 2014 10:01:18 -0500
In-Reply-To: <CAHuoermH8js-WJYGRVbWkLK91yUBQOL8CxoyqfJgbqLpjvsX5w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wQvpldHN1pnvwIHEI2rvxFBDGqkB7jw1k
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2014 03:52 PM, Paul Lever wrote:
>> As I said, make sue you use at least v3.15.
> Understood. At this time I'm stuck with the release I'm using,
> although I can update CAN drivers, etc. I won't be able to migrate to
> a latter OS build for a few months.

There are more than 50 patches between v3.12 and current net/master on
the c_can driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wQvpldHN1pnvwIHEI2rvxFBDGqkB7jw1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUX4G2AAoJECte4hHFiupUb0QP/i4/Saskd2uGKzNEWL9toteV
cK8dGOdxvqDKFtSPofVsr2HgnzKtU9SofZOTHk1WyKR90T5CzYof22h+uRh6ZWmv
9qvU0nznZwnZdTBdptgUeeNhmM2wZq3S16ZP/zf5GXekSF2FCSomnHEVoSqAJNgy
XA5BewNvaLgx4a32UoRLNUJ46bh+5GT1Fe/SdTlsmm0MS502KCFrNRvXeotPMlWM
7Kk7+la7koW6BDO0ct1CYa/czeQ+amgyYuVcu3YS6T+sVvusuWmGeCmlqz/zjJNu
Cp1gTqGivc2pr2AsJcqz87p0j16C0l9VfyCo89exhMJf1l6f+kfl0wfmmtGUm1aI
xV/8Uwh9YG3bXpngchtr3o38QySH0+kYC6zuzSaO0pgDGLBzw3lEwIcPg0REnT4H
fCKlwOZUXhxw/bW+1ktuzSRrod0kpkUqg3tvTqzh8cuiEtNh+mdAHBQAOEjlL+2p
5hFWbvt3Rj8cwELxKUY20pMHJBum0mGh6SQIlGouYGdtL1Hl+dkeOWo2fP+kE/r0
CQ58L2sfP6OGE/FyJGKi3aP1RhVXodItIf27g0ScJkFoeNihYjgr+3HyiK3dNMBl
S7MQ41GtWPUUjh+i4slR+WYD/q6mjR5O8J3o4VLd6uIjGjVmQPQUJpREhmOnqtrg
nsoaS1MTOOE2ag2VYpGZ
=lj/h
-----END PGP SIGNATURE-----

--wQvpldHN1pnvwIHEI2rvxFBDGqkB7jw1k--
