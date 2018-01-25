From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 128/130] transport.c:undefined reference to
 `j1939_procdir'
Date: Thu, 25 Jan 2018 09:51:48 +0100
Message-ID: <bed080b7-662d-3c45-e3ae-bad0bb02ab40@pengutronix.de>
References: <201801250436.CoRYdOYe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7WUxO9b0SkqREzKird2c7sJ00WVPpcms1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50795 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeAYIwS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 03:52:18 -0500
In-Reply-To: <201801250436.CoRYdOYe%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7WUxO9b0SkqREzKird2c7sJ00WVPpcms1
Content-Type: multipart/mixed; boundary="bmWZciQ9BhmAdwdT7r1ywaSQFk15o97WT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <bed080b7-662d-3c45-e3ae-bad0bb02ab40@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 128/130] transport.c:undefined reference to
 `j1939_procdir'
References: <201801250436.CoRYdOYe%fengguang.wu@intel.com>
In-Reply-To: <201801250436.CoRYdOYe%fengguang.wu@intel.com>

--bmWZciQ9BhmAdwdT7r1ywaSQFk15o97WT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 09:40 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git j1939
> head:   37c59eac921feeb09570a44ee93bf128e00e8f19
> commit: 6cb1fe0d6eed02111afa4bc23d2569e869a2d689 [128/130] j1939: remov=
e proc support
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6cb1fe0d6eed02111afa4bc23d2569e869a2d689
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dsparc64=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdl=
c.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdl=
c.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdl=
c.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdl=
c.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    net/can/j1939/transport.o: In function `j1939tp_module_exit':
>>> transport.c:(.text+0x2af4): undefined reference to `j1939_procdir'
>    transport.c:(.text+0x2afc): undefined reference to `j1939_procdir'
>    net/can/j1939/transport.o: In function `j1939tp_module_init':
>>> transport.c:(.init.text+0x8): undefined reference to `j1939_procdir'
>    transport.c:(.init.text+0x10): undefined reference to `j1939_procdir=
'
>    transport.c:(.init.text+0x5c): undefined reference to `j1939_procdir=
'

This, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bmWZciQ9BhmAdwdT7r1ywaSQFk15o97WT--

--7WUxO9b0SkqREzKird2c7sJ00WVPpcms1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlppmqQACgkQHv7KIOw4
HPYm4Af+MI4OidqpXmD2Epchn4pN1YcRfJO3LKbQ/RUvLbDln1pZLS/IkTWEp41Y
fTRozyIAcSvhvI/hnfiB/HrHT0jcWAHJUJrRukMSdDNuGG8Qjh01Ez2LqUw607ky
4y52RIfO6iUxYVWFu3AVXYDQedY9z94Hsrhp7w8ULwWqPhi3ew82ZG5IB1Z9xeTd
aBO8O+2QklWE0Co2Y1cD8HBbXDRjWm8SU7w13AQ8XV07U+Ky7iXsb2RFG7GCSXGk
NecH8hKnSrVZkvDYWoN+WtXI/npB23JgRlQthF4DsRsmVOU8W+l7qD3sfzyBOaZQ
zpP2QGG7Uw1U2fe6ShB9pVppUs+OrA==
=QJak
-----END PGP SIGNATURE-----

--7WUxO9b0SkqREzKird2c7sJ00WVPpcms1--
