From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 16/142] net/can/j1939/socket.c:789:20:
 sparse: incorrect type in initializer (incompatible argument 3 (different
 base types))
Date: Thu, 15 Feb 2018 09:44:27 +0100
Message-ID: <148c13b8-1f28-93c6-e1c1-61d90b9acb08@pengutronix.de>
References: <201802151457.cPtB0nDc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MrmiNMRN7pvc6s6iFcjTRaGE0c2e0bQOs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754825AbeBOIpX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Feb 2018 03:45:23 -0500
In-Reply-To: <201802151457.cPtB0nDc%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MrmiNMRN7pvc6s6iFcjTRaGE0c2e0bQOs
Content-Type: multipart/mixed; boundary="tP2u3HKJ68Th50Ka1pjs3CgFp2OYjhRaS";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>,
 Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <148c13b8-1f28-93c6-e1c1-61d90b9acb08@pengutronix.de>
Subject: Re: [mkl-can-next:j1939 16/142] net/can/j1939/socket.c:789:20:
 sparse: incorrect type in initializer (incompatible argument 3 (different
 base types))
References: <201802151457.cPtB0nDc%fengguang.wu@intel.com>
In-Reply-To: <201802151457.cPtB0nDc%fengguang.wu@intel.com>

--tP2u3HKJ68Th50Ka1pjs3CgFp2OYjhRaS
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/15/2018 07:40 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git j1939
> head:   3849d25ff0e2c0a6fa5ecfcf649661aa3dc371a2
> commit: 434d073b7e77f77c072253b03ab0e6ca3668e8a6 [16/142] can-j1939: Im=
port SAE J1939
> reproduce:
>         # apt-get install sparse
>         git checkout 434d073b7e77f77c072253b03ab0e6ca3668e8a6
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
>    net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv'=
 in incomplete struct dev_rcv_lists
>    net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv'=
 in incomplete struct dev_rcv_lists
>    net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv'=
 in incomplete struct dev_rcv_lists
>    net/can/j1939/j1939-priv.h:271:41: sparse: using member 'j1939_priv'=
 in incomplete struct dev_rcv_lists
>    net/can/j1939/socket.c:707:32: sparse: incorrect type in argument 2 =
(different base types) @@ expected unsigned short tsflags @@ got ed] tsfl=
ags @@
>    net/can/j1939/socket.c:707:32: expected unsigned short tsflags
>    net/can/j1939/socket.c:707:32: got unsigned char
>    net/can/j1939/socket.c:707:26: sparse: not enough arguments for func=
tion sock_tx_timestamp
>>> net/can/j1939/socket.c:789:20: sparse: incorrect type in initializer =
(incompatible argument 3 (different base types)) @@ expected int ( )( ...=
 ) @@ got int ( )( ... ) @@

Fixed.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tP2u3HKJ68Th50Ka1pjs3CgFp2OYjhRaS--

--MrmiNMRN7pvc6s6iFcjTRaGE0c2e0bQOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqFSGsACgkQk9IU1zQo
ZfFb2Qf/UGRbYo3dnaobwUD7kPAtrrGkWON3d0LNiTexbTQvxmiR2DK3sCwVqhlK
lnuMDw7yYcpF1IwaEpXZ6R0wIchHhWOFYYW+nlZMkTtVrGNx+0ndaNmxBosR88/W
yW4GYo0Czl6IkLw4s24NLP8U2AyEQHxn0wwtWP6m9OMAym7iSGk2eNC1+iXvUdFP
+f1wskKdwgl3TFalimXnOkqNQZkHJzMy1Y7GSqlRlnQ74HNLsJY1ysD4rAGkAxnV
hOCTp22r1Lm8BLF1BIRZMFht8Bb8svUEBlRWBgJdcwBEL6nSRtiT6QXOpmRpLuNP
g7SmglpC+Z5qS/DO9w58oYIVB4dsTQ==
=CnVu
-----END PGP SIGNATURE-----

--MrmiNMRN7pvc6s6iFcjTRaGE0c2e0bQOs--
