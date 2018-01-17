From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Add Travis-CI support
Date: Wed, 17 Jan 2018 15:57:53 +0100
Message-ID: <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
References: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7dltW6X0024Ga3coQSFJka2726wHUmi9I"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeAQO6S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 09:58:18 -0500
In-Reply-To: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: o.rempel@pengutronix.de, socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dltW6X0024Ga3coQSFJka2726wHUmi9I
Content-Type: multipart/mixed; boundary="Z833ic0XWtsufpKX93wcWKSWxLgJX1UjZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: o.rempel@pengutronix.de, socketcan@hartkopp.net
Message-ID: <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
Subject: Re: [PATCH] Add Travis-CI support
References: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
In-Reply-To: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>

--Z833ic0XWtsufpKX93wcWKSWxLgJX1UjZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 03:33 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> This configuration performs build tests for GCC and Clang
> compilers.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Nice!

For reasons we have non autotools based compilation, too. Can you use
this one, too?

It's just "make" without prior autogen.sh && configure

> ---
>  .travis.yml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 .travis.yml
>=20
> diff --git a/.travis.yml b/.travis.yml
> new file mode 100644
> index 0000000..0a7cfc4
> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,24 @@
> +language: c
> +
> +matrix:
> +    include:
> +        - os: linux
> +          dist: trusty
> +          sudo: required
> +          compiler: gcc
> +        - os: linux
> +          dist: trusty
> +          sudo: required
> +          compiler: clang
> +
> +addons:
> +    apt:
> +        packages:
> +            - autoconf
> +            - automake
> +            - libtool
> +            - m4
> +        sources:
> +            - ubuntu-toolchain-r-test
> +
> +script: ./autogen.sh && ./configure && make

make distcheck

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Z833ic0XWtsufpKX93wcWKSWxLgJX1UjZ--

--7dltW6X0024Ga3coQSFJka2726wHUmi9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpfZHEACgkQHv7KIOw4
HPYOQwgAnBmDf4zF9vb7ouE8Fp9zK7EelXoszZ+yBHWxOE52oaZSRKzjY4kbKmKy
YOeppd5r8oqSm6SvXsAh3rk4mhSsRTZ/wjqj3NPt8fLrP7YhbapcjeZIlUQ4f52k
wfSFwlAIGjdIDj5XAYYPmQcG4YCROKizDaiiApCsvf4UAszqJlLZkLY3ZLtwEXYf
Uk0Rp+9SNLyKqJohsBW037/KYPAW0pKH/pySv3FoykxrXIJGU7w1BBzAD/dH8jby
jrccnsns/Y4uXkukY+CLSUdZq9ByacSFv+dnjyZ1g+GSUqg4UdgYaKPtoRKZC96A
DEKvQFH9QnF6M2JapfKeyVyiQqVqwA==
=NCJa
-----END PGP SIGNATURE-----

--7dltW6X0024Ga3coQSFJka2726wHUmi9I--
