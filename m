From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 128/130] ERROR: "j1939_procdir"
 [net/can/j1939/can-j1939.ko] undefined!
Date: Thu, 25 Jan 2018 09:51:14 +0100
Message-ID: <1bcbca33-9cc5-dae6-48f5-9c6830cc7129@pengutronix.de>
References: <201801250242.O2XryQsW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7VYQXXiJg9pX6Lmk24rYmPYbZ9fydvNxh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeAYIvv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 03:51:51 -0500
In-Reply-To: <201801250242.O2XryQsW%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7VYQXXiJg9pX6Lmk24rYmPYbZ9fydvNxh
Content-Type: multipart/mixed; boundary="aAxlxKFwULXLB4qe1IOZqlOSMM7Jn1jE6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <1bcbca33-9cc5-dae6-48f5-9c6830cc7129@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 128/130] ERROR: "j1939_procdir"
 [net/can/j1939/can-j1939.ko] undefined!
References: <201801250242.O2XryQsW%fengguang.wu@intel.com>
In-Reply-To: <201801250242.O2XryQsW%fengguang.wu@intel.com>

--aAxlxKFwULXLB4qe1IOZqlOSMM7Jn1jE6
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 07:07 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git j1939
> head:   37c59eac921feeb09570a44ee93bf128e00e8f19
> commit: 6cb1fe0d6eed02111afa4bc23d2569e869a2d689 [128/130] j1939: remov=
e proc support
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6cb1fe0d6eed02111afa4bc23d2569e869a2d689
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dia64=20
>=20
> All errors (new ones prefixed by >>):

>>> ERROR: "j1939_procdir" [net/can/j1939/can-j1939.ko] undefined!

Should be fixed.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--aAxlxKFwULXLB4qe1IOZqlOSMM7Jn1jE6--

--7VYQXXiJg9pX6Lmk24rYmPYbZ9fydvNxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlppmoIACgkQHv7KIOw4
HPbo2ggAwaHL48pFsy03O8hWHJjuQ/F+TBFHEFBaGfNxpl9K2bAuJGspt5bONGzC
xoUFY6XW8pGHxErVK5CNU9PUlTxIwdWtAMMpTmLkjFZswWST7oJtoP3EBrFcEMch
19uwI9EJyB3qJdSq5jOKT6MQ9HPGQCyOdztGSZ3yFdK8QDT8iaytvyY0DElEGX88
Gu/8f+Ypruqa/jcbNNDmATcEfVgvtq+GuZsbLwDmMUl7QLNdP5tUbVlQ8Up6l7Ap
maDZ1VkUS5g6/7pacRBq4SZ3Kyt9EhD190YQ/HKXHCrvz2BL68LKWIfNhT0b+LTP
XrU2wG6rNCI4sBnJAefYqOaLDdbOnA==
=X2eZ
-----END PGP SIGNATURE-----

--7VYQXXiJg9pX6Lmk24rYmPYbZ9fydvNxh--
