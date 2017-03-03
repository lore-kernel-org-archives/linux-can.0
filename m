From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:echo-queue 1/1] drivers/net/can/dev.c:476:3: error:
 expected '}' before 'else'
Date: Fri, 3 Mar 2017 16:31:02 +0100
Message-ID: <cc1c1d3c-7a46-f141-334c-52d745d5fcd2@pengutronix.de>
References: <201703032310.a1jlkeSM%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eO19Lt7Oc7XU4MInX8VjxaAQUwHvXT93o"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39807 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751459AbdCCPvs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Mar 2017 10:51:48 -0500
In-Reply-To: <201703032310.a1jlkeSM%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eO19Lt7Oc7XU4MInX8VjxaAQUwHvXT93o
Content-Type: multipart/mixed; boundary="uLnhiotJhjdtHQhSqbvdQ42bJcpn6pJvT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <cc1c1d3c-7a46-f141-334c-52d745d5fcd2@pengutronix.de>
Subject: Re: [mkl-can-next:echo-queue 1/1] drivers/net/can/dev.c:476:3: error:
 expected '}' before 'else'
References: <201703032310.a1jlkeSM%fengguang.wu@intel.com>
In-Reply-To: <201703032310.a1jlkeSM%fengguang.wu@intel.com>

--uLnhiotJhjdtHQhSqbvdQ42bJcpn6pJvT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 04:25 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git echo-queue
> head:   bf93005265bf23ccc01dd26e384301bddae6208e
> commit: bf93005265bf23ccc01dd26e384301bddae6208e [1/1] wip
> config: x86_64-randconfig-x016-201709 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout bf93005265bf23ccc01dd26e384301bddae6208e
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/net/can/dev.c: In function 'can_get_echo_skb':
>>> drivers/net/can/dev.c:476:3: error: expected '}' before 'else'
>       else
>       ^~~~

It's a work-in-progress branch. Please ignore - sorry for the noise :D

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uLnhiotJhjdtHQhSqbvdQ42bJcpn6pJvT--

--eO19Lt7Oc7XU4MInX8VjxaAQUwHvXT93o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli5jDYACgkQHv7KIOw4
HPYwUgf+MzCHFdGNsAYMvG6npRbI5YGjETFY31XH+SgTdeCGzES1B6jPg8HdizBX
fGi2mgA4+I3KU0/SGtIb1OgOy4eQ8eSCGfRQVPTRrSkgkrgoJB+rXgratz+F5Uw9
F0xOAfRLsG1lsdMqy79ECYtGSQ5w7Gp4AMnGVRohYVk/+jtoW0hFZdmbONa+DE2v
8kBiYgaWHXLuw6wWBjUZDYd/CNquSmGwHL4cRSUepbLodTHWGMnoHKXAKETWmEwI
mZRdSpwAdmLvHDftGyICKm7HK6NsfqkCYhXOJggqMPO9bpK3fwoeUxyjZEML5mEi
xirHTvZNLW8yXVpM7/8wJfG8zV8hSA==
=emac
-----END PGP SIGNATURE-----

--eO19Lt7Oc7XU4MInX8VjxaAQUwHvXT93o--
