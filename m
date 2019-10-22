From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
Date: Tue, 22 Oct 2019 14:58:33 +0200
Message-ID: <d6902a1c-af8f-7d47-4f9b-d037c6be70d5@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571748448-11190-1-git-send-email-vincent.prince.fr@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tPcSg41tjilYVek1CKPpL4Q39Eq8qDQ50"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1571748448-11190-1-git-send-email-vincent.prince.fr@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org, dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de, xiyou.wangcong@gmail.com, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tPcSg41tjilYVek1CKPpL4Q39Eq8qDQ50
Content-Type: multipart/mixed; boundary="taxEyksF3OwE4ibXOXGvTucjlIKJi2Li9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Prince <vincent.prince.fr@gmail.com>
Cc: jiri@resnulli.us, jhs@mojatatu.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, linux-can@vger.kernel.org, kernel@pengutronix.de,
 xiyou.wangcong@gmail.com, davem@davemloft.net
Message-ID: <d6902a1c-af8f-7d47-4f9b-d037c6be70d5@pengutronix.de>
Subject: Re: [PATCH] net: sch_generic: Use pfifo_fast as fallback scheduler
 for CAN hardware
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <1571748448-11190-1-git-send-email-vincent.prince.fr@gmail.com>
In-Reply-To: <1571748448-11190-1-git-send-email-vincent.prince.fr@gmail.com>

--taxEyksF3OwE4ibXOXGvTucjlIKJi2Li9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/22/19 2:47 PM, Vincent Prince wrote:
> Signed-off-by: Vincent Prince <vincent.prince.fr@gmail.com>

Please add the patch description, preferred that one from my original pat=
ch.

> ---
>  net/sched/sch_generic.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 77b289d..bff43de 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1008,6 +1008,8 @@ static void attach_one_default_qdisc(struct net_d=
evice *dev,
> =20
>  	if (dev->priv_flags & IFF_NO_QUEUE)
>  		ops =3D &noqueue_qdisc_ops;
> +        else if(dev->type =3D=3D ARPHRD_CAN)
^^^^^^^^^^^^^^^
use one tab to indent.

> +		ops =3D &pfifo_fast_ops;
> =20
>  	qdisc =3D qdisc_create_dflt(dev_queue, ops, TC_H_ROOT, NULL);
>  	if (!qdisc) {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--taxEyksF3OwE4ibXOXGvTucjlIKJi2Li9--

--tPcSg41tjilYVek1CKPpL4Q39Eq8qDQ50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2u/PkACgkQWsYho5Hk
nSCPIggAoq8lWlAC3IBcR06Q+DeEWiEKclgtKi+v+AWw/Fwj19KNH4nrLIrmaGUy
iyUxQmvESzf9mLg+mbcuBV8FLJnBJGvUwa44gNFDzqaDhkbpjI5rnT/Y2a+pmEok
OL12pKBf3tMJQH3TAPpg8Fg/ygW/zRjSXjTZzbv0DYibVCAIMX/HWWv71ks8LubC
UB++DkuQqXHVSQzOjbWdPhaN/LfEym8sAIg+9jrCwiEObKgDAwZLhTjmND2xi98T
7sOgZUvQtfYOnv9TAh2xWPrzarwvEjANDxBM+5k8ApezSR7NpokVl+j5nXOuGq88
XbVa8zHqnpiLeYajRrxzDdxiA1RCYA==
=/N5Z
-----END PGP SIGNATURE-----

--tPcSg41tjilYVek1CKPpL4Q39Eq8qDQ50--
