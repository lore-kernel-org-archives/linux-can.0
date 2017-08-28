From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 07/14] can: af_can: give variable holding the CAN receiver
 and the receiver list a sensible name
Date: Mon, 28 Aug 2017 17:24:19 +0200
Message-ID: <07b77743-2544-3387-5fa4-bd1896138524@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-8-mkl@pengutronix.de>
 <dcc2b165-e262-d442-d97d-db60b64bc3ae@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="saAPeEaUsA318optm1NfrMHrA0df4eBsJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40803 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbdH1PYY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 11:24:24 -0400
In-Reply-To: <dcc2b165-e262-d442-d97d-db60b64bc3ae@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--saAPeEaUsA318optm1NfrMHrA0df4eBsJ
Content-Type: multipart/mixed; boundary="KMRjuUvANTfhgUiLUCfkSKSp7QJvsQjCT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <07b77743-2544-3387-5fa4-bd1896138524@pengutronix.de>
Subject: Re: [PATCH 07/14] can: af_can: give variable holding the CAN receiver
 and the receiver list a sensible name
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-8-mkl@pengutronix.de>
 <dcc2b165-e262-d442-d97d-db60b64bc3ae@hartkopp.net>
In-Reply-To: <dcc2b165-e262-d442-d97d-db60b64bc3ae@hartkopp.net>

--KMRjuUvANTfhgUiLUCfkSKSp7QJvsQjCT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:27 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch gives the variables holding the CAN receiver and the receiv=
er
>> list a better name by renaming them from "r to "rcv" and "rl" to
>> "recv_list".
>=20
> Comment not consistent to code.
>=20
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Indeed I would suggest 'rcv' and 'rcvlist'
>=20
>> -		hlist_add_head_rcu(&r->list, rl);
>> +		hlist_add_head_rcu(&rcv->list, rcv_list);
>=20
> would lead to
>=20
>  > +		hlist_add_head_rcu(&rcv->list, rcvlist);
>=20
> which looks better to me.

We have the spelling with an underscore already in the code:

> diff --git a/include/net/netns/can.h b/include/net/netns/can.h         =
                                                                         =
                                                                         =
                                                                =20
> index b106e6ae2e5b..1fcd395ed506 100644                                =
                                                                         =
                                                                         =
                                                                =20
> --- a/include/net/netns/can.h                                          =
                                                                         =
                                                                         =
                                                                =20
> +++ b/include/net/netns/can.h                                          =
                                                                         =
                                                                         =
                                                                =20
> @@ -9,6 +9,6 @@                                                        =
                                                                         =
                                                                         =
                                                                =20
>=20
>  struct dev_rcv_lists;
> -struct s_stats;                                                       =
                                                                         =
                                                                         =
                                                                =20
> -struct s_pstats;                                                      =
                                                                         =
                                                                         =
                                                                =20
> +struct can_pkg_stats;                                                 =
                                                                         =
                                                                         =
                                                                =20
> +struct can_rcv_lists_stats;=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KMRjuUvANTfhgUiLUCfkSKSp7QJvsQjCT--

--saAPeEaUsA318optm1NfrMHrA0df4eBsJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmkNaMACgkQHv7KIOw4
HPZiNwgAq/xXODw7ueXjZ4Rn4vL0blnQctDKcK5EWfkCqUhzmIChyIowbh7SA6we
58OjGUPAfKFBKOMhh4DjPMxY08Wh3VvHYixyQNHgkPcGZXbJ8wTiiCQUbIm2PViD
qkmvK/cScvFzBblLvawlpMyPPNWS5zV17y502ZBx10ALxDPCMYxO46vCQxgrPB5g
pN6rThcHqbMi83xxhXwU4c4uj0L+7j/IRt6dgtESLbgjZE1U6/J73WPLW7RwVsGw
FfOJnAfJA36KG9M6Cb9gs1JFF061fsfS6VI972fN0cA4YSNBTEEXzNIZhLaOiFYM
S6Ux5JsNxm8CVU/2nfqbDxxzr1DOhA==
=v+1x
-----END PGP SIGNATURE-----

--saAPeEaUsA318optm1NfrMHrA0df4eBsJ--
