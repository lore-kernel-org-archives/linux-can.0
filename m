From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
Date: Tue, 12 Nov 2019 12:39:27 +0100
Message-ID: <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QADIWKTIrD8NcHZB4Xtkmum8vjDppTM8W"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112113724.pff6atmyii5ri4my@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QADIWKTIrD8NcHZB4Xtkmum8vjDppTM8W
Content-Type: multipart/mixed; boundary="XHfAHzUpqR7KtdT6a3rO3jSW08nagutHV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: dev.kurt@vandijck-laurijssen.be, wg@grandegger.com,
 netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
In-Reply-To: <20191112113724.pff6atmyii5ri4my@pengutronix.de>

--XHfAHzUpqR7KtdT6a3rO3jSW08nagutHV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/12/19 12:37 PM, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Nov 12, 2019 at 12:15:52PM +0100, Oleksij Rempel wrote:
>> In j1939 we need our own struct sock::sk_destruct callback. Export the=

>> generic af_can can_sock_destruct() that allows us to chain-call it.
>>
>> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  include/linux/can/core.h | 1 +
>>  net/can/af_can.c         | 3 ++-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
>> index 8339071ab08b..e20a0cd09ba5 100644
>> --- a/include/linux/can/core.h
>> +++ b/include/linux/can/core.h
>> @@ -65,5 +65,6 @@ extern void can_rx_unregister(struct net *net, struc=
t net_device *dev,
>>  			      void *data);
>> =20
>>  extern int can_send(struct sk_buff *skb, int loop);
>> +void can_sock_destruct(struct sock *sk);
>> =20
>>  #endif /* !_CAN_CORE_H */
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 5518a7d9eed9..128d37a4c2e0 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -86,11 +86,12 @@ static atomic_t skbcounter =3D ATOMIC_INIT(0);
>> =20
>>  /* af_can socket functions */
>> =20
>> -static void can_sock_destruct(struct sock *sk)
>> +void can_sock_destruct(struct sock *sk)
>>  {
>>  	skb_queue_purge(&sk->sk_receive_queue);
>>  	skb_queue_purge(&sk->sk_error_queue);
>>  }
>> +EXPORT_SYMBOL(can_sock_destruct);
>=20
> If the users are only expected to be another can module, it might make
> sense to use a namespace here?!

How?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--XHfAHzUpqR7KtdT6a3rO3jSW08nagutHV--

--QADIWKTIrD8NcHZB4Xtkmum8vjDppTM8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3Kme8ACgkQWsYho5Hk
nSCadggAm/XxOzN8MEwFh/n4yWfVx2Lb2RDb0s/HGZ3DB7LlTtrGoJKw9FpGR3o6
OZ12ZWt5qMSpzyPCNUqWmAtlENlho4bEfF6udBUW2yu+YwGBa38U/zRlyJGqxm8w
0CFHFFuJSWMIcAp6W+MrYXNRQ/K4YfRlQ7zlJwNpSOMD+hcnl05OcRv5b7+QgoHh
Miy98noqRIhVO/GBKf8KBIq50hwXFMpgAV2FnoaebqjIJwzucQJLXF4pIQwt/bMQ
69P8XeMRaMunBPNx1hapqrQ5Tl3/ex81oLsliUfyEVLamxEkyFlQT0PR0IsirITd
t21S5QUllwczNtmSZekwynKyWoaEGg==
=1a6X
-----END PGP SIGNATURE-----

--QADIWKTIrD8NcHZB4Xtkmum8vjDppTM8W--
