From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Add Travis-CI support
Date: Wed, 17 Jan 2018 16:19:03 +0100
Message-ID: <d2103951-7007-07dc-9210-55da363c7d9f@pengutronix.de>
References: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
 <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
 <CAGm1_ksbGxOJO_9a5kR_51nyc3eGKP5j7o-hGz=r6qB0cWZpwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J3bcECikCI5WJZZQVCvBjfA0HaNORL7XB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41753 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeAQPT2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 10:19:28 -0500
In-Reply-To: <CAGm1_ksbGxOJO_9a5kR_51nyc3eGKP5j7o-hGz=r6qB0cWZpwA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J3bcECikCI5WJZZQVCvBjfA0HaNORL7XB
Content-Type: multipart/mixed; boundary="PlJGDtsK1r7uLj5Rdb6UpEb4QQCAofIAl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d2103951-7007-07dc-9210-55da363c7d9f@pengutronix.de>
Subject: Re: [PATCH] Add Travis-CI support
References: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
 <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
 <CAGm1_ksbGxOJO_9a5kR_51nyc3eGKP5j7o-hGz=r6qB0cWZpwA@mail.gmail.com>
In-Reply-To: <CAGm1_ksbGxOJO_9a5kR_51nyc3eGKP5j7o-hGz=r6qB0cWZpwA@mail.gmail.com>

--PlJGDtsK1r7uLj5Rdb6UpEb4QQCAofIAl
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 04:15 PM, Yegor Yefremov wrote:
> On Wed, Jan 17, 2018 at 3:57 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 01/17/2018 03:33 PM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> This configuration performs build tests for GCC and Clang
>>> compilers.
>>>
>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Nice!
>>
>> For reasons we have non autotools based compilation, too. Can you use
>> this one, too?
>>
>> It's just "make" without prior autogen.sh && configure
>=20
> I'll add such a test.

tnx

>>> ---
>>>  .travis.yml | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>  create mode 100644 .travis.yml
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> new file mode 100644
>>> index 0000000..0a7cfc4
>>> --- /dev/null
>>> +++ b/.travis.yml
>>> @@ -0,0 +1,24 @@
>>> +language: c
>>> +
>>> +matrix:
>>> +    include:
>>> +        - os: linux
>>> +          dist: trusty
>>> +          sudo: required
>>> +          compiler: gcc
>>> +        - os: linux
>>> +          dist: trusty
>>> +          sudo: required
>>> +          compiler: clang
>>> +
>>> +addons:
>>> +    apt:
>>> +        packages:
>>> +            - autoconf
>>> +            - automake
>>> +            - libtool
>>> +            - m4
>>> +        sources:
>>> +            - ubuntu-toolchain-r-test
>>> +
>>> +script: ./autogen.sh && ./configure && make
>>
>> make distcheck
>=20
> Do you mean:
>=20
> script: ./autogen.sh && ./configure && make distcheck

ACK.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PlJGDtsK1r7uLj5Rdb6UpEb4QQCAofIAl--

--J3bcECikCI5WJZZQVCvBjfA0HaNORL7XB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpfaWcACgkQHv7KIOw4
HPYQogf/ZvV6YioDQ2vS36Q7xvjgGiNR+yo+htLh/MtyToiIjUFYH7y/nrhUL6FO
13qF6QjtvXty27LUbOfVCFbUekfLKq6SJp80fFUnawhrCL0e19Sk9gbiKs5naWw0
GKmwkQKk7AqqSY+s/uxGMLxzxQmKcgjXY/2V6VfqRgquBINqH0HSgiRZGzumxwBf
0ERGeuMN3wNTWDdxl4j1655Yv3yCBpWHM2OpVDb3Rc2bgRv3xIceSxYxtXybeRoV
VlwCzF6V6RX6glsRqE0TPQAR/5vQVzNAyKIVRXqN5Gzq8t1nZCCXI2vK6kdjq5Yx
KKWfEAL6LQfWNRI/Y/irUMEnHRl4KQ==
=FgTR
-----END PGP SIGNATURE-----

--J3bcECikCI5WJZZQVCvBjfA0HaNORL7XB--
