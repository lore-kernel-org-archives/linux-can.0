From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: free error skb if enqueueing failed
Date: Thu, 10 Oct 2019 10:08:03 +0200
Message-ID: <e3f0c5a2-e93b-5eaa-518e-b5651c302ea3@pengutronix.de>
References: <20190715185308.104333-1-martin@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="toEBBwY3wjijzcRdoFQ14mpch1pQ5SGWX"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190715185308.104333-1-martin@geanix.com>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--toEBBwY3wjijzcRdoFQ14mpch1pQ5SGWX
Content-Type: multipart/mixed; boundary="mXWb766kwOLC8dXhv3fNyuMMB30u8LOkc";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Sean Nyekjaer <sean@geanix.com>
Message-ID: <e3f0c5a2-e93b-5eaa-518e-b5651c302ea3@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: free error skb if enqueueing failed
References: <20190715185308.104333-1-martin@geanix.com>
In-Reply-To: <20190715185308.104333-1-martin@geanix.com>

--mXWb766kwOLC8dXhv3fNyuMMB30u8LOkc
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/15/19 8:53 PM, Martin Hundeb=C3=B8ll wrote:
> If the call to can_rx_offload_queue_sorted() fails, the passed skb isn'=
t
> consumed, so the caller must do so.
>=20
> Fixes: 30164759db1b ("can: flexcan: make use of rx-offload's irq_offloa=
d_fifo")
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

I've fixed the problem by adding the kfree_skb() to
can_rx_offload_queue_sorted().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mXWb766kwOLC8dXhv3fNyuMMB30u8LOkc--

--toEBBwY3wjijzcRdoFQ14mpch1pQ5SGWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2e5uMACgkQWsYho5Hk
nSBybAf/Xc8YaWP7iCnpPTHOJHwl7YCUWbOqKm8dY1C1tqjV0A7y37M2W8aEfhzB
G8FHQheCyiv9Gxh3Tx1saICa+7ckopeUkxaWhOTaoMNLpmr7KDoCZI5XDB56S20A
D7/0zZ8FC6J3wek0UiJOVtpITgta0VCF2DQB9E87yyNv/4ldX8oVGnapIJwwJJ7C
heQ/OzJYSys/6wxaG0Gq1BvBYh9MKDaafhmyAqEhXubcUgFRcPActpXvm6HJ7WTl
Zd7Lpr4pKXm7wPN4dY3GJ8Hrv+FynVcCTuP2LJaceYYpltguvqO3+5qilTJfcEQU
wNf+7FfEPOD5+HgaCO6qfKK5DMszjQ==
=9FU9
-----END PGP SIGNATURE-----

--toEBBwY3wjijzcRdoFQ14mpch1pQ5SGWX--
