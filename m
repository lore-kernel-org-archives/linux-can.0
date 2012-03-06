From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [libsocketcan] Add can_get_link_stats()
Date: Tue, 06 Mar 2012 11:30:16 +0100
Message-ID: <4F55E738.5020302@pengutronix.de>
References: <6686CF564BC462488080D46D3C933CA4089576@EXCH02-AKLNZ.MARINE.NET.INT>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3E336449E06F73ADDEB35723"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55646 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536Ab2CFKad (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Mar 2012 05:30:33 -0500
In-Reply-To: <6686CF564BC462488080D46D3C933CA4089576@EXCH02-AKLNZ.MARINE.NET.INT>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Reuben Dowle <Reuben.Dowle@navico.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E336449E06F73ADDEB35723
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/2012 12:00 AM, Reuben Dowle wrote:
> Add can_get_link_stats()
>=20
> This function gets link_stats64 information for the can interface.
> This structure can be for any interface (not just can), but it
> seems logical to keep functions for getting any statistics relevant
> to CAN in this library.

nice :)

I cannot test it currently, but one nitpick inline:

>=20
> Signed-off-by: Reuben Dowle <reuben.dowle@navico.com>
>=20
> diff --git a/include/libsocketcan.h b/include/libsocketcan.h
> index dc52053..06b37d6 100644
> --- a/include/libsocketcan.h
> +++ b/include/libsocketcan.h
> @@ -50,6 +50,7 @@ int can_get_clock(const char *name, struct can_clock =
*clock);
>  int can_get_bittiming_const(const char *name, struct can_bittiming_con=
st *btc);
>  int can_get_berr_counter(const char *name, struct can_berr_counter *bc=
);
>  int can_get_device_stats(const char *name, struct can_device_stats *cd=
s);
> +int can_get_link_stats(const char *name, struct rtnl_link_stats64 *ls)=
;
> =20
>  #ifdef __cplusplus
>  }
> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> index 26da338..ed33332 100644
> --- a/src/libsocketcan.c
> +++ b/src/libsocketcan.c
> @@ -54,6 +54,7 @@
>  #define GET_BITTIMING_CONST 6
>  #define GET_BERR_COUNTER 7
>  #define GET_XSTATS 8
> +#define GET_LINK_STATS64 9
> =20
>  struct get_req {
>  	struct nlmsghdr n;
> @@ -380,6 +381,19 @@ static int do_get_nl_link(int fd, __u8 acquire, co=
nst char *name, void *res)
>  		    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
>  		     sizeof(name)) !=3D 0)
>  			continue;
> +	=09
> +		if (acquire =3D=3D GET_LINK_STATS64) {
> +			if (!tb[IFLA_STATS64]) {
> +				fprintf(stderr, "no link_stats64 data found\n");
> +			}
> +			else {

pleae use "} else {"

> +				memcpy(res,
> +				       RTA_DATA(tb[IFLA_STATS64]),
> +				       sizeof(struct rtnl_link_stats64));
> +				ret =3D 0;
> +			}
> +			continue;
> +		}
> =20
>  		if (tb[IFLA_LINKINFO])
>  			parse_rtattr_nested(linkinfo,
> @@ -1154,3 +1168,24 @@ int can_get_device_stats(const char *name, struc=
t can_device_stats *cds)
>  {
>  	return get_link(name, GET_XSTATS, cds);
>  }
> +
> +/**
> + * @ingroup extern
> + * can_get_link_stats - get the rtnl_link_stats64.
> + *
> + * @param name name of the can device. This is the netdev name, as ifc=
onfig -a shows
> + * in your system. usually it contains prefix "can" and the numer of t=
he can
> + * line. e.g. "can0"
> + * @param bc pointer to the error counter struct..
> + *
> + * This one gets the current rtnl_link_stats64.
> + *
> + * Please see struct rtnl_link_stats64 for more information.
> + *
> + * @return 0 if success
> + * @return -1 if failed
> + */
> +int can_get_link_stats(const char *name, struct rtnl_link_stats64 *ls)=

> +{
> +	return get_link(name, GET_LINK_STATS64, ls);
> +}
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3E336449E06F73ADDEB35723
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9V5zgACgkQjTAFq1RaXHPpoQCfQCPdiW+AZ2CyFtyLvYTdcY0d
VWsAoILh60TFhOxnHYOfKvCGfm7jRBr0
=JZrp
-----END PGP SIGNATURE-----

--------------enig3E336449E06F73ADDEB35723--
