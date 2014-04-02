From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: proc: make array printing function indenpendent
 from sff frames
Date: Wed, 02 Apr 2014 09:16:10 +0200
Message-ID: <533BB93A.80905@pengutronix.de>
References: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net> <1396378632-5413-2-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Udmx0VseW9AspmVNj3BjsBkNWVD4jueLn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60584 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757951AbaDBHQN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 03:16:13 -0400
In-Reply-To: <1396378632-5413-2-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Udmx0VseW9AspmVNj3BjsBkNWVD4jueLn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2014 08:57 PM, Oliver Hartkopp wrote:
> The can_rcvlist_sff_proc_show_one() function which prints the array of =
filters
> for the single SFF CAN identifiers is prepared to be used by a second c=
aller.
> Therefore it is also renamed to properly describe its future functional=
ity.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Looks good, some nitpicks inline.

> ---
>  net/can/af_can.h |  4 +++-
>  net/can/proc.c   | 28 ++++++++++++++++------------
>  2 files changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index 6de58b4..989e695 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -59,12 +59,14 @@ struct receiver {
>  	char *ident;
>  };
> =20
> +#define CAN_SFF_RCV_ARRAY_SZ (1<<CAN_SFF_ID_BITS)

Please add spaces around the <<

> +
>  enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_EFF, RX_MAX };
> =20
>  /* per device receive filters linked at dev->ml_priv */
>  struct dev_rcv_lists {
>  	struct hlist_head rx[RX_MAX];
> -	struct hlist_head rx_sff[0x800];
> +	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
>  	int remove_on_zero_entries;
>  	int entries;
>  };
> diff --git a/net/can/proc.c b/net/can/proc.c
> index b543470..1f8e1e6 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -389,25 +389,26 @@ static const struct file_operations can_rcvlist_p=
roc_fops =3D {
>  	.release	=3D single_release,
>  };
> =20
> -static inline void can_rcvlist_sff_proc_show_one(struct seq_file *m,
> -						 struct net_device *dev,
> -						 struct dev_rcv_lists *d)
> +static inline void can_rcvlist_proc_show_array(struct seq_file *m,
> +					       struct net_device *dev,
> +					       struct hlist_head *rcv_array,
> +					       unsigned int rcv_array_sz)
>  {
	> -	int i;
> +	unsigned int i;
>  	int all_empty =3D 1;
> =20
>  	/* check whether at least one list is non-empty */
> -	for (i =3D 0; i < 0x800; i++)
> -		if (!hlist_empty(&d->rx_sff[i])) {
> +	for (i =3D 0; i < rcv_array_sz; i++)
> +		if (!hlist_empty(&rcv_array[i])) {
>  			all_empty =3D 0;
>  			break;
>  		}
> =20
>  	if (!all_empty) {
>  		can_print_recv_banner(m);
> -		for (i =3D 0; i < 0x800; i++) {
> -			if (!hlist_empty(&d->rx_sff[i]))
> -				can_print_rcvlist(m, &d->rx_sff[i], dev);
> +		for (i =3D 0; i < rcv_array_sz; i++) {
> +			if (!hlist_empty(&rcv_array[i]))
> +				can_print_rcvlist(m, &rcv_array[i], dev);
>  		}
>  	} else
>  		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
> @@ -425,12 +426,15 @@ static int can_rcvlist_sff_proc_show(struct seq_f=
ile *m, void *v)
> =20
>  	/* sff receive list for 'all' CAN devices (dev =3D=3D NULL) */
>  	d =3D &can_rx_alldev_list;
> -	can_rcvlist_sff_proc_show_one(m, NULL, d);
> +	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, CAN_SFF_RCV_ARRAY_SZ)=
;

Please use ARRAY_SIZE(d->rx_sff)

> =20
>  	/* sff receive list for registered CAN devices */
>  	for_each_netdev_rcu(&init_net, dev) {
> -		if (dev->type =3D=3D ARPHRD_CAN && dev->ml_priv)
> -			can_rcvlist_sff_proc_show_one(m, dev, dev->ml_priv);
> +		if (dev->type =3D=3D ARPHRD_CAN && dev->ml_priv) {
> +			d =3D dev->ml_priv;
> +			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
> +						    CAN_SFF_RCV_ARRAY_SZ);
Please use ARRAY_SIZE(d->rx_sff)
> +		}
>  	}
> =20
>  	rcu_read_unlock();
>=20
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Udmx0VseW9AspmVNj3BjsBkNWVD4jueLn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7uToACgkQjTAFq1RaXHP1qgCglrAYGDkD2fJHBXh/4lYHOyVL
Ym8AnRNfb+BvHGWjoucCOXemU6e/x6dQ
=UgXP
-----END PGP SIGNATURE-----

--Udmx0VseW9AspmVNj3BjsBkNWVD4jueLn--
