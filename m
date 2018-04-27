From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
Date: Fri, 27 Apr 2018 09:55:16 +0200
Message-ID: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0
Content-Type: multipart/mixed; boundary="yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michal Simek <michal.simek@xilinx.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Message-ID: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
In-Reply-To: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>

--yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:49 AM, Michal Simek wrote:
> On 26.4.2018 23:13, Luc Van Oostenryck wrote:
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, but the implementation in this
>> driver returns an 'int'.
>>
>> Fix this by returning 'netdev_tx_t' in this driver too.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  drivers/net/can/xilinx_can.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can=
=2Ec
>> index 89aec07c2..a19648606 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *nde=
v, enum can_mode mode)
>>   *
>>   * Return: 0 on success and failure value on error
>>   */
>> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *nd=
ev)
>> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_de=
vice *ndev)
>>  {
>>  	struct xcan_priv *priv =3D netdev_priv(ndev);
>>  	struct net_device_stats *stats =3D &ndev->stats;
>>
>=20
> It was applied already but there should be also kernel-doc update too t=
o
> use enum values instead of 0.

Like this:

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index f07ce4945356..d0ad1473f689 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -398,7 +398,7 @@ static int xcan_do_set_mode(struct net_device *ndev=
, enum can_mode mode)
>   * function uses the next available free txbuff and populates their fi=
elds to
>   * start the transmission.
>   *
> - * Return: 0 on success and failure value on error
> + * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queu=
e is full
>   */
>  static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_dev=
ice *ndev)
>  {

I can squash in that change.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R--

--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlri12QACgkQk9IU1zQo
ZfHqwAf/cqCG3AErm/iOoSOY2W215bY+HgZ3uH7ZSO04WMQ6tU02XV6T7S8nWi/V
DWQKPhdaxg19A6FooOWmb7s6TJq9eVOerKhce2M8R7z+835gfXryOxi6M4elxWHh
mIrgvsJzCOKjtuOZE8LOpBkxtPBLcS0TVDEOva5RrinFOCcNU/nKmBDvK3LHE6f5
oVSCzjn4dXf6pk59qkmoVA3T+nUZYPzNT+wOiVnR4JB1Zpm96Lry4wCY8XS+WNJ0
6Vz8xdCP86x8OAHW1Vn5+dgWi/BR3jAA2LMNRbKZ8mHti3g1hSHKv2WmdmdQnwdU
qRmXV0NQ+uYavpdOf/76l/ljk38/MQ==
=jjQ4
-----END PGP SIGNATURE-----

--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0--
