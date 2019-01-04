From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Revert "can: dev: __can_get_echo_skb(): print error
 message, if trying to echo non existing skb"
Date: Fri, 4 Jan 2019 16:23:26 +0100
Message-ID: <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
References: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4g1j49Qmqo9X5TIflHHjLRJfuZfQ5boTp"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4g1j49Qmqo9X5TIflHHjLRJfuZfQ5boTp
Content-Type: multipart/mixed; boundary="0AmcdYEnMRPfK7Ru9wJ3TsUtOH7uyGm0r";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
Subject: Re: [PATCH] Revert "can: dev: __can_get_echo_skb(): print error
 message, if trying to echo non existing skb"
References: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
In-Reply-To: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>

--0AmcdYEnMRPfK7Ru9wJ3TsUtOH7uyGm0r
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/19/18 7:39 PM, Manfred Schlaegl wrote:
> This reverts commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a.
>=20
> After introduction of this change we encountered following new error
> message on various i.MX plattforms (flexcan)
> flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
> existing skb: can_priv::echo_skb[0]

Doh! I should have tested more extensive. Sorry.

> The introduction of the message was a mistake because
> priv->echo_skb[idx] =3D NULL is a perfectly valid in following case:
> If CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the
> pkt_type of the tx skb's given to can_put_echo_skb is set to
> PACKET_LOOPBACK. In this case can_put_echo_skb will not set
> priv->echo_skb[idx]. It is therefore kept NULL.
>=20
> (As additional argument for revert: The order of check and usage of idx=

> was changed. idx is used to access an array element before checking it'=
s
> boundaries)
>=20
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0AmcdYEnMRPfK7Ru9wJ3TsUtOH7uyGm0r--

--4g1j49Qmqo9X5TIflHHjLRJfuZfQ5boTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlwvem4ACgkQk9IU1zQo
ZfH2UAgA1AErpX58UHKNM3WP/lKMBZfeyALSn+gXODyjFY51g4HqgFuanY0Kprxb
UUG3L8s0GfgD+9XNmReO0GkXtJrGq48urYBbGd1BjiH5EreUnYRY9Lt5ALj2eUtW
aO6nwgv5hZNbGMNhC6xzsKY9ZMpdyvX+Jy87RQOLQCwrTZMtmqROMnN56aYfZyqJ
1rUHE89NL9MBzz1t0LjTEBtE1oDtHI0+4aPcx5yGUpvH/HhPiKSqEy4ae0IndiFS
vEQ8VrCt3YJVyKzbaVh7gvsrQ3j0pEr6CB2qzy7xslnn7gq79ph8dTLUOqxVSOfj
8YW5fUviUPTlf2ZP/Jtw+hOgCTm4CA==
=3mq/
-----END PGP SIGNATURE-----

--4g1j49Qmqo9X5TIflHHjLRJfuZfQ5boTp--
