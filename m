From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 11:09:26 +0200
Message-ID: <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
 <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hhmB6CRB3nNUMoVMA2lCKRK2tPWDUrhES"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59987 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751636AbdHQJJb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 05:09:31 -0400
In-Reply-To: <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hhmB6CRB3nNUMoVMA2lCKRK2tPWDUrhES
Content-Type: multipart/mixed; boundary="Q8xLUQe7kavHn63UTaqdHhTW8LqJ4p81s";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
Subject: Re: j1939: generic addr struct
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
 <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170817085300.GC7870@airbook.vandijck-laurijssen.be>

--Q8xLUQe7kavHn63UTaqdHhTW8LqJ4p81s
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 10:53 AM, Kurt Van Dijck wrote:
>>>> I'd like to introduce a generic j1939 address struct, it's used insi=
de
>>>> the kernel only, so no userspace visible changes. What about:
>>>>
>>>>> +struct j1939_addr {
>>>>> +       name_t src_name;
>>>>> +       name_t dst_name;
>>>>> +       pgn_t pgn;
>>>>> +
>>>>> +       u8 sa;
>>>>> +       u8 da;
>>>>> +};
>>>
>>> Long ago, I had such a structure, and found that in most cases, littl=
e
>>> members were used. I found the structure containing too many members
>>> more confusing and got rid of it :-)
>>
>> I'm using it in struct j1939_sock::addr ...
>>
>>> @@ -43,14 +43,7 @@ struct j1939_sock {                               =
                                                                         =
                                                                         =
                                                                  =20
>>>
>>>         int ifindex_started; /* ifindex of netdev */
>>>
>>> -       struct {                                                     =
                                                                         =
                                                                         =
                                                                  =20
>>> -               name_t src;                                          =
                                                                         =
                                                                         =
                                                                  =20
>>> -               name_t dst;                                          =
                                                                         =
                                                                         =
                                                                  =20
>>> -               pgn_t pgn;                                           =
                                                                         =
                                                                         =
                                                                  =20
>>> -                                                                    =
                                                                         =
                                                                         =
                                                                  =20
>>> -               u8 sa, da;                                           =
                                                                         =
                                                                         =
                                                                  =20
>>> -       } addr;                                                      =
                                                                         =
                                                                         =
                                                                  =20
>>> -                                                                    =
                                                                         =
                                                                         =
                                                                  =20
>>> +       struct j1939_addr addr;                                      =
                                                                         =
                                                                         =
                                                                  =20
>>>         struct j1939_filter *filters;
>>>         int nfilters;
>>
>> ... and in struct j1939_sk_buff_cb:
>=20
> It's clear that you can replace this indeed.
>=20
>>
>>>  /* control buffer of the sk_buff */
>>>  struct j1939_sk_buff_cb {
>>> -       pgn_t pgn;                                                   =
                                                                         =
                                                                         =
                                                                  =20
>>> +       struct j1939_addr addr;                                      =
                                                                         =
                                                                         =
                                                                  =20
>>>         priority_t priority;
>>> -       u8 srcaddr;                                                  =
                                                                         =
                                                                         =
                                                                  =20
>>> -       u8 dstaddr;                                                  =
                                                                         =
                                                                         =
                                                                  =20
>>> -       name_t srcname;                                              =
                                                                         =
                                                                         =
                                                                  =20
>>> -       name_t dstname;                                              =
                                                                         =
                                                                         =
                                                                  =20
>>
>> Both have 2x name and 2x addr and the pgn.
>=20
> the max size of j1939_sk_buff_cb is limited, and using structs
> may consume more depending on the platform and alignment.
> I had troubles in the past, hence the decomposed definition.

We'll get a compile time error then and think of something then. :D

> Looking at the latest version, it seems to have some room left, and
> using structs will succeed :-)

Let's home so.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Q8xLUQe7kavHn63UTaqdHhTW8LqJ4p81s--

--hhmB6CRB3nNUMoVMA2lCKRK2tPWDUrhES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVXUYACgkQHv7KIOw4
HPbXKQgAoRQq6C6zSJ4Ahbv6ikJi3ATY3GVza3PIbUxhvBzZPZjqZ5R4ojRwDa3S
3SPIOW9jhhTO732+9DbBbbLt2MVnnD5ZGXIx76bJZUYNDTkUOq7ocJDPrp5rUkAf
UtF3yJgB6Y1751w3jaZtZXv7m1YkRWhGnC5h8pTyZ41tInxCrx1aldoFD84CFjlP
mjEn+eJIn9CJy4/G60y+OKQ+qaRNGMxxXJKrLNr7KU4XKOLZkbOQECyjU5mrgO9Z
i4f0UBnzz/r5RNDvIvI6itbOmcpgahWwgeZ1/NmxGuJ1iAD09cgVh5Hdd2mn62TQ
UYhsG+EkBROB66Z3bHJ+g9eXJGmIyw==
=ySRx
-----END PGP SIGNATURE-----

--hhmB6CRB3nNUMoVMA2lCKRK2tPWDUrhES--
