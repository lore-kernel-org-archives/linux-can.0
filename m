From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mkl-can-next:af_can 16/18] drivers/net/can/slcan.c:531:51:
 error: invalid application of 'sizeof' to incomplete type 'struct
 can_ml_priv'
Date: Wed, 6 Dec 2017 14:13:17 +0100
Message-ID: <5e65ff77-3f82-2880-5ccc-9c2972d9aa3e@pengutronix.de>
References: <201712062055.bgtxdnoo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LWeLdiT9qW13ND3k6KMpUwGekSAvWbaCq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41927 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752111AbdLFNNp (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Wed, 6 Dec 2017 08:13:45 -0500
In-Reply-To: <201712062055.bgtxdnoo%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LWeLdiT9qW13ND3k6KMpUwGekSAvWbaCq
Content-Type: multipart/mixed; boundary="3l05KJ3mcaPEsTf1fLFxFwDgtDFhUHgpD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
Message-ID: <5e65ff77-3f82-2880-5ccc-9c2972d9aa3e@pengutronix.de>
Subject: Re: [mkl-can-next:af_can 16/18] drivers/net/can/slcan.c:531:51:
 error: invalid application of 'sizeof' to incomplete type 'struct
 can_ml_priv'
References: <201712062055.bgtxdnoo%fengguang.wu@intel.com>
In-Reply-To: <201712062055.bgtxdnoo%fengguang.wu@intel.com>

--3l05KJ3mcaPEsTf1fLFxFwDgtDFhUHgpD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 01:49 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git af_can
> head:   f0c2db14e47365b89dd8e76a365f0f9d5a48a914
> commit: b6ecae37409c9654a3d6c4908ebfd6e0c1939c0c [16/18] can: introduce=
 CAN midlayer private and allocate it automatically
> config: x86_64-randconfig-x001-201749 (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>         git checkout b6ecae37409c9654a3d6c4908ebfd6e0c1939c0c
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/net/can/slcan.c: In function 'slc_alloc':
>>> drivers/net/can/slcan.c:531:51: error: invalid application of 'sizeof=
' to incomplete type 'struct can_ml_priv'
>      size =3D ALIGN(sizeof(*sl), NETDEV_ALIGN) + sizeof(struct can_ml_p=
riv);

Should be fixed already.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3l05KJ3mcaPEsTf1fLFxFwDgtDFhUHgpD--

--LWeLdiT9qW13ND3k6KMpUwGekSAvWbaCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlon7O0ACgkQHv7KIOw4
HPYrFwf/axTdvueud7LPmPETmYQrQWY9ZJSFWu6eiQXVLDT436/SSaxW/FZvAToo
4bpfCZ0fASa6HpNSHgcd8ezpmslicnrcfcE6wvKJWuRVWjyVXyhy+BcfE8gPBNBu
mj1rS5LgxT4eEx8yH7s1GAlVNeJ6R9afZ9w2nHA6ePKOJm1bvcMyme4Adv9OlCZm
CLy5hkTa1+pugfPt27/A+ZOLvY4l66oJfmfabGF51JM/kaTjY7WqQSBkj3ZKUmjy
Xu1qudtBoj3JjwGyiKe3dVRgzjpY7UbC5K1kH51OypUuz1QCcC/El3a/dcbqGIsd
jio7nlGD6XUvqil8xRK7LvMXRePBWA==
=JN4S
-----END PGP SIGNATURE-----

--LWeLdiT9qW13ND3k6KMpUwGekSAvWbaCq--
