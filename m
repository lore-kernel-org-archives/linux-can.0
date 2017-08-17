From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 12:15:42 +0200
Message-ID: <817d02ed-45f0-d114-2043-097b8c5cf46e@pengutronix.de>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
 <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
 <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qPGgN8XuWc3qQ3DE4ouROgBWVreTjLrwh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46971 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdHQKPs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 06:15:48 -0400
In-Reply-To: <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qPGgN8XuWc3qQ3DE4ouROgBWVreTjLrwh
Content-Type: multipart/mixed; boundary="B0Dcf4PL0sgevE16mBR8FvISXqnio5ksX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <817d02ed-45f0-d114-2043-097b8c5cf46e@pengutronix.de>
Subject: Re: j1939: generic addr struct
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
 <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
 <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
In-Reply-To: <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>

--B0Dcf4PL0sgevE16mBR8FvISXqnio5ksX
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 11:09 AM, Marc Kleine-Budde wrote:
> On 08/17/2017 10:53 AM, Kurt Van Dijck wrote:
>>>>> I'd like to introduce a generic j1939 address struct, it's used ins=
ide
>>>>> the kernel only, so no userspace visible changes. What about:
>>>>>
>>>>>> +struct j1939_addr {
>>>>>> +       name_t src_name;
>>>>>> +       name_t dst_name;
>>>>>> +       pgn_t pgn;
>>>>>> +
>>>>>> +       u8 sa;
>>>>>> +       u8 da;
>>>>>> +};

[...]

>> the max size of j1939_sk_buff_cb is limited, and using structs
>> may consume more depending on the platform and alignment.
>> I had troubles in the past, hence the decomposed definition.
>=20
> We'll get a compile time error then and think of something then. :D

With that struct, it still fits into the struct j1939_sk_buff_cb on
arm64 and amd64.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--B0Dcf4PL0sgevE16mBR8FvISXqnio5ksX--

--qPGgN8XuWc3qQ3DE4ouROgBWVreTjLrwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVbM8ACgkQHv7KIOw4
HPYGrwgA1d27E2eRvlIYMk652iCA+Ebb5qIvg3v7Nzn2OmkOIUnNBC85U65XC7TU
2SrJVRWAN/AzMVVuHvszmhYryQkgbZ7+D/ChCj/+liXG7BzcONBFzUM+xTKH6PSc
7gEqswoFdCcGyObABvFzcBtxN+l+1ltKyaMNRr9K9GoPPucgS41B/JgSimzqvlAz
F4YhZ3+wdvJyxu4NuwZET7B9l7FIr1tNHC7MvNx6vl1Kp+JJ9C3jtrgVb+2kYFbO
Im+htAOoeR6Nx1koKQmrhkn5AP7ZkvcOUOF9Lp+YpDr7OqyrXqW9e4PwnNMrW1RB
uajjdaQJvyQPGrdvdncXCcxCZT8pNw==
=pH0S
-----END PGP SIGNATURE-----

--qPGgN8XuWc3qQ3DE4ouROgBWVreTjLrwh--
