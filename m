From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Mon, 18 Nov 2019 22:15:29 +0100
Message-ID: <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GSRNMkB6q7mORL9530vsr7mWeDe0KhvpW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GSRNMkB6q7mORL9530vsr7mWeDe0KhvpW
Content-Type: multipart/mixed; boundary="nvdRAzj7gUVqtuJtc70X8UCmXxkH6ioAB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>,
 davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Message-ID: <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
Subject: Re: KMSAN: uninit-value in can_receive
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
In-Reply-To: <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>

--nvdRAzj7gUVqtuJtc70X8UCmXxkH6ioAB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/18/19 9:49 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 18/11/2019 21.29, Marc Kleine-Budde wrote:
>> On 11/18/19 9:25 PM, Oliver Hartkopp wrote:
>=20
>>>> IMPORTANT: if you fix the bug, please add the following tag to the c=
ommit:
>>>> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>> BUG: KMSAN: uninit-value in can_receive+0x23c/0x5e0 net/can/af_can.c=
:649
>>>> CPU: 1 PID: 3490 Comm: syz-executor.2 Not tainted 5.4.0-rc5+ #0
>=20
>>>
>>> In line 649 of 5.4.0-rc5+ we can find a while() statement:
>>>
>>> while (!(can_skb_prv(skb)->skbcnt))
>>> 	can_skb_prv(skb)->skbcnt =3D atomic_inc_return(&skbcounter);
>>>
>>> In linux/include/linux/can/skb.h we see:
>>>
>>> static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>>> {
>>> 	return (struct can_skb_priv *)(skb->head);
>>> }
>>>
>>> IMO accessing can_skb_prv(skb)->skbcnt at this point is a valid
>>> operation which has no uninitialized value.
>>>
>>> Can this probably be a false positive of KMSAN?
>>
>> The packet is injected via the packet socket into the kernel. Where do=
es
>> skb->head point to in this case? When the skb is a proper
>> kernel-generated skb containing a CAN-2.0 or CAN-FD frame skb->head is=

>> maybe properly initialized?
>=20
> The packet is either received via vcan or vxcan which checks via=20
> can_dropped_invalid_skb() if we have a valid ETH_P_CAN type skb.

According to the call stack it's injected into the kernel via a packet
socket and not via v(x)can.

> We additionally might think about introducing a check whether we have a=
=20
> can_skb_reserve() created skbuff.
>=20
> But even if someone forged a skbuff without this reserved space the=20
> access to can_skb_prv(skb)->skbcnt would point into some CAN frame=20
> content - which is still no access to uninitialized content, right?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--nvdRAzj7gUVqtuJtc70X8UCmXxkH6ioAB--

--GSRNMkB6q7mORL9530vsr7mWeDe0KhvpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3TCfIACgkQWsYho5Hk
nSB19wf+M0JzIsfzRW9GZjE4vTRXrTQPRkpjokJi+ZcdGheUz9E4Euvj5MrWG8RD
XXh9msEXTGNNVe8hBB80KLS5TvtkEiCcmMwRI4DXWEnKqjmbUv/W3gSNNzFnIgI4
JEHIzXN+tE37LkS4kGIozh/XLozBELIIWb9x3sr2rdq3SI/6QkV+9qrGi8nLyfDC
l18cciXo/0OAKTb7pFBTz0YJkqc4EvLbGvaUhjH7EHFnNKVGqDgjHxLft43vJZLE
UB2ylD+ikiFc5vzr3YV62EA/zi6Aa37y6M3kFDuowu8X1jX8djNQ+BLv4+VxZEmh
+RCtWrjQBcQlnVitWhCJfxaRVmE05w==
=Ui1f
-----END PGP SIGNATURE-----

--GSRNMkB6q7mORL9530vsr7mWeDe0KhvpW--
