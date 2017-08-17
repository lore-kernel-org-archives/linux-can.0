From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 10:40:37 +0200
Message-ID: <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6nEu28KGBFT8LgfNRIoGUtBQ6i0CTUvqJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41701 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751684AbdHQIkn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 04:40:43 -0400
In-Reply-To: <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6nEu28KGBFT8LgfNRIoGUtBQ6i0CTUvqJ
Content-Type: multipart/mixed; boundary="PkaUSXsQvfpFaSoKqnKcxujWgxrakUuIO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
Subject: Re: j1939: generic addr struct
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170817083145.GB7870@airbook.vandijck-laurijssen.be>

--PkaUSXsQvfpFaSoKqnKcxujWgxrakUuIO
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 10:31 AM, Kurt Van Dijck wrote:
>=20
>> I'd like to introduce a generic j1939 address struct, it's used inside=

>> the kernel only, so no userspace visible changes. What about:
>>
>>> +struct j1939_addr {
>>> +       name_t src_name;
>>> +       name_t dst_name;
>>> +       pgn_t pgn;
>>> +
>>> +       u8 sa;
>>> +       u8 da;
>>> +};
>=20
> Long ago, I had such a structure, and found that in most cases, little
> members were used. I found the structure containing too many members
> more confusing and got rid of it :-)

I'm using it in struct j1939_sock::addr ...

> @@ -43,14 +43,7 @@ struct j1939_sock {                                 =
                                                                         =
                                                                         =
                                                                =20
>=20
>         int ifindex_started; /* ifindex of netdev */
>=20
> -       struct {                                                       =
                                                                         =
                                                                         =
                                                                =20
> -               name_t src;                                            =
                                                                         =
                                                                         =
                                                                =20
> -               name_t dst;                                            =
                                                                         =
                                                                         =
                                                                =20
> -               pgn_t pgn;                                             =
                                                                         =
                                                                         =
                                                                =20
> -                                                                      =
                                                                         =
                                                                         =
                                                                =20
> -               u8 sa, da;                                             =
                                                                         =
                                                                         =
                                                                =20
> -       } addr;                                                        =
                                                                         =
                                                                         =
                                                                =20
> -                                                                      =
                                                                         =
                                                                         =
                                                                =20
> +       struct j1939_addr addr;                                        =
                                                                         =
                                                                         =
                                                                =20
>         struct j1939_filter *filters;
>         int nfilters;

=2E.. and in struct j1939_sk_buff_cb:

>  /* control buffer of the sk_buff */
>  struct j1939_sk_buff_cb {
> -       pgn_t pgn;                                                     =
                                                                         =
                                                                         =
                                                                =20
> +       struct j1939_addr addr;                                        =
                                                                         =
                                                                         =
                                                                =20
>         priority_t priority;
> -       u8 srcaddr;                                                    =
                                                                         =
                                                                         =
                                                                =20
> -       u8 dstaddr;                                                    =
                                                                         =
                                                                         =
                                                                =20
> -       name_t srcname;                                                =
                                                                         =
                                                                         =
                                                                =20
> -       name_t dstname;                                                =
                                                                         =
                                                                         =
                                                                =20

Both have 2x name and 2x addr and the pgn.

>> ...or use src_addr and dst_addr, instead of sa and da?
> IMO, sa & da are clear terminology.

Ok

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PkaUSXsQvfpFaSoKqnKcxujWgxrakUuIO--

--6nEu28KGBFT8LgfNRIoGUtBQ6i0CTUvqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVVoUACgkQHv7KIOw4
HPawJQf/VItCntXJ2XU30LYF1uy+U+osT4xExKCB9ZFwUSR/ZN0yE2wi9zXcuew+
f4P6i9brtXKfpuBbDHEfFMvezc6LFCad0sdVv5kGqSY7YKyjfQUjLPkOu7E54KRG
8yectkScdetW/HSTAkz371yLmJtLike3S4hxpWClI223y7vV/+s1RzPAERjFJuYw
pY3YQYvPjgh065h4qH7eHK1tLoxpK1q4Akd1J0LWhH/jrLolWaFglbDnTxvvg8Z6
ElTF73wpKY0ANF9R1WJ5QJn9gNtcTnorzYRDD0HA2NxRYbMKLlLlQDmfAs3zqFHr
Xs3YzO3eps6feiS9ZKXjTUh7mFe2lw==
=fQVN
-----END PGP SIGNATURE-----

--6nEu28KGBFT8LgfNRIoGUtBQ6i0CTUvqJ--
