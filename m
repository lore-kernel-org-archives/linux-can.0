From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gw: Fix error path of cgw_module_init
Date: Fri, 17 May 2019 12:40:28 +0200
Message-ID: <80ca1430-da86-42c3-75c7-eadf91b20220@pengutronix.de>
References: <20190516155435.42376-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cPuBWzThF7gPhGlulF8GCMJHLe8C2T2Qq"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516155435.42376-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, socketcan@hartkopp.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cPuBWzThF7gPhGlulF8GCMJHLe8C2T2Qq
Content-Type: multipart/mixed; boundary="7HyhubOsnI1bfLTM2ueTvbWhCyzvAY2W1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
 socketcan@hartkopp.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
Message-ID: <80ca1430-da86-42c3-75c7-eadf91b20220@pengutronix.de>
Subject: Re: [PATCH] can: gw: Fix error path of cgw_module_init
References: <20190516155435.42376-1-yuehaibing@huawei.com>
In-Reply-To: <20190516155435.42376-1-yuehaibing@huawei.com>

--7HyhubOsnI1bfLTM2ueTvbWhCyzvAY2W1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 5/16/19 5:54 PM, YueHaibing wrote:
> This patch fix error path for cgw_module_init
> to avoid possible crash if some error occurs.
>=20
> Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/can/gw.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>=20
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 53859346..8b53ec7 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -1046,32 +1046,48 @@ static __init int cgw_module_init(void)
>  	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=3D%d\=
n",
>  		max_hops);
> =20
> -	register_pernet_subsys(&cangw_pernet_ops);
> +	ret =3D register_pernet_subsys(&cangw_pernet_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D -ENOMEM;
>  	cgw_cache =3D kmem_cache_create("can_gw", sizeof(struct cgw_job),
>  				      0, 0, NULL);
> -
>  	if (!cgw_cache)
> -		return -ENOMEM;
> +		goto out_cache_create;
> =20
>  	/* set notifier */
>  	notifier.notifier_call =3D cgw_notifier;
> -	register_netdevice_notifier(&notifier);
> +	ret =3D register_netdevice_notifier(&notifier);
> +	if (ret)
> +		goto out_register_notifier;
> =20
>  	ret =3D rtnl_register_module(THIS_MODULE, PF_CAN, RTM_GETROUTE,
>  				   NULL, cgw_dump_jobs, 0);
> -	if (ret) {
> -		unregister_netdevice_notifier(&notifier);
> -		kmem_cache_destroy(cgw_cache);
> -		return -ENOBUFS;
> -	}
> -
> -	/* Only the first call to rtnl_register_module can fail */
> -	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
> -			     cgw_create_job, NULL, 0);
> -	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
> -			     cgw_remove_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register1;
> +
> +	ret =3D rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
> +				   cgw_create_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register2;
> +	ret =3D rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
> +				   cgw_remove_job, NULL, 0);
> +	if (ret)
> +		goto out_rtnl_register2;
> =20
>  	return 0;
> +
> +out_rtnl_register2:
> +	rtnl_unregister_all(PF_CAN);

Currently gw.c is the only user of rtnl_register_module(PF_CAN), but
PF_CAN is not specific to gw. Better change this to individual
rtnl_unregister(int protocol, int msgtype).

> +out_rtnl_register1:
> +	unregister_netdevice_notifier(&notifier);
> +out_register_notifier:
> +	kmem_cache_destroy(cgw_cache);
> +out_cache_create:
> +	unregister_pernet_subsys(&cangw_pernet_ops);
> +
> +	return ret;
>  }
> =20
>  static __exit void cgw_module_exit(void)
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7HyhubOsnI1bfLTM2ueTvbWhCyzvAY2W1--

--cPuBWzThF7gPhGlulF8GCMJHLe8C2T2Qq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlzej5wACgkQWsYho5Hk
nSDWnQgAiSTwIP05LGuj4vDQprzUDrSIm12iNB+pwMUbKo12heT6NLYMjcMlqwDl
LsYodfTBT4jqKsT4EwmVr9voAa78VbUyCPrCyovs1uVj8zehSqoh1m0unR26tNEh
N/7rhJUByPi9E0z00xFUsmlLzcybJmX2sEccbf0djNkP3No2Xfl3C5sEpmfIEl9W
M/+RedUAx7eTKh+Tv4Czp7Lma3DLGV43c2CoTmzXCB4E5oJUiw36zRk29hYKUmUP
NszCTwJfFpHFJg9AepFHWUFOeG3razNSm9b39kl3xQ+CahpdHV8cNAG4AyrmROTl
rB8jHWIb5gbi5Gk3W8msD4cKIMNtdQ==
=l9WC
-----END PGP SIGNATURE-----

--cPuBWzThF7gPhGlulF8GCMJHLe8C2T2Qq--
