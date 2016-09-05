From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Possible NULL sample_point in the new way of computing
 bit-timings
Date: Mon, 5 Sep 2016 14:14:58 +0200
Message-ID: <25ca562e-25b6-8517-eb92-36ff0ee1b2d2@pengutronix.de>
References: <1a3f3f0a-5648-345b-b197-3e956d9ef39b@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CRlnECO7GcKdhnQ4thRab3kxkF1Dg7Ikr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48182 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755127AbcIEMPG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2016 08:15:06 -0400
In-Reply-To: <1a3f3f0a-5648-345b-b197-3e956d9ef39b@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CRlnECO7GcKdhnQ4thRab3kxkF1Dg7Ikr
Content-Type: multipart/mixed; boundary="gr5pNUrPOwOiWCT4MEfkEhqEobihbKJtJ"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Message-ID: <25ca562e-25b6-8517-eb92-36ff0ee1b2d2@pengutronix.de>
Subject: Re: Possible NULL sample_point in the new way of computing
 bit-timings
References: <1a3f3f0a-5648-345b-b197-3e956d9ef39b@peak-system.com>
In-Reply-To: <1a3f3f0a-5648-345b-b197-3e956d9ef39b@peak-system.com>

--gr5pNUrPOwOiWCT4MEfkEhqEobihbKJtJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2016 04:17 PM, Stephane Grosjean wrote:
> Hi all,
>=20
> With the new way of computing bit-timings introduced in linux-can-next,=
=20
> when CONFIG_CAN_CALC_BITTIMING is defined, I think there's a chance to =

> set 0 in "bt->sample_point" of a can device. This is a different=20
> behavior than with the previous versions.
>=20
> IMHO, there are cases where "can_update_sample_point()" might return 0 =

> ("best_sample_point" is initialized to 0). There is no real damage in=20
> the main loop of "can_calc_bittiming()": its returned value is ignored =

> (and only *sample_point_error matters). But it is not, outside this=20
> loop, when setting the (real) value of the sample_point. So I think tha=
t=20
> the real value of the sample_point must be computed using the final=20
> values of tseg and tseg2, something like:
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 7188137..de422b3 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -200,8 +200,8 @@ static int can_calc_bittiming(struct net_device=20
> *dev, struct can_bittiming *bt,
>          }
>=20
>          /* real sample point */
> -       bt->sample_point =3D can_update_sample_point(btc, sample_point_=
nominal, best_tseg,
> -                                         &tseg1, &tseg2, NULL);
> +       bt->sample_point =3D 1000 * (best_tseg + CAN_CALC_SYNC_SEG - ts=
eg2) /
> +                                       (best_tseg + CAN_CALC_SYNC_SEG)=
;

You're using tseg2 as an input, where before it was used as an output
value. As the sample point has already been calculated in the loop, why
should it not be possible to calculate it again?

>=20
>          v64 =3D (u64)best_brp * 1000 * 1000 * 1000;
>          do_div(v64, priv->clock.freq);
>=20
> The best would be to introduce a function that implements the formula..=
=2E

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gr5pNUrPOwOiWCT4MEfkEhqEobihbKJtJ--

--CRlnECO7GcKdhnQ4thRab3kxkF1Dg7Ikr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXzWHCAAoJED07qiWsqSVqsNgH/iIeLa0xMDV7yScl2sz8Drsu
8Qj4hDaxYeUYnHBq5TOYIuLRMFgwaE8Bu+dRtgTsyrdJTDjlst7LscPIunncqt35
Q6fku/DXVEnbf0ue5t4kHRSPWYO0KqZrG49P95DIgbzOdJoMPwZK9BN7ny7bpQKd
Ua6HXUShfOgeUgrmCYfWe2tqdben6+5MuWWTBKNZeepHCgquss7+DR4wM2dLMpa7
MlOGPKJQgJWSozEADRKUI0BXpAgmPrnntLwc4o5xlXBwrQnuKLvBhxcOrJItGkwf
D9ptIQKm2yBPVtt8D2rMRjgWpP4W2SaGSaQD/IT86o5ZOhA9Ra3ilBD+vtj5UWU=
=ATRs
-----END PGP SIGNATURE-----

--CRlnECO7GcKdhnQ4thRab3kxkF1Dg7Ikr--
