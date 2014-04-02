From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: add hash based access to single EFF frame filters
Date: Wed, 02 Apr 2014 12:06:43 +0200
Message-ID: <533BE133.8020600@pengutronix.de>
References: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net> <1396378632-5413-3-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PcHMUkGrP8X8n7HjgeBB9W4JeTJNm5KfG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47360 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163AbaDBKG7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 06:06:59 -0400
In-Reply-To: <1396378632-5413-3-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PcHMUkGrP8X8n7HjgeBB9W4JeTJNm5KfG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2014 08:57 PM, Oliver Hartkopp wrote:
> In contrast to the direct access to the single SFF frame filters (which=
 are
> indexed by the SFF CAN ID itself) the single EFF frame filters are arra=
nged
> in a single linked hlist. To reduce the hlist traversal in the case of =
many
> filter subscriptions a hash based access is introduced for single EFF f=
ilters.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Looks good, some comments on style inline.

> ---
>  net/can/af_can.c | 31 ++++++++++++++++++++++++++-----
>  net/can/af_can.h |  5 ++++-
>  net/can/proc.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++---=

>  3 files changed, 75 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index a27f8aa..56fd1e2 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -338,6 +338,29 @@ static struct dev_rcv_lists *find_dev_rcv_lists(st=
ruct net_device *dev)
>  }
> =20
>  /**
> + * effhash - hash function for 29 bit CAN identifier reduction
> + * @can_id: 29 bit CAN identifier
> + *
> + * Description:
> + *  To reduce the linear traversal in one linked list of _single_ EFF =
CAN
> + *  frame subscriptions the 29 bit identifier is mapped to 10 bits.
> + *  (see CAN_EFF_RCV_HASH_BITS definition)
> + *
> + * Return:
> + *  Hash value from 0x000 - 0x3FF ( enforced by CAN_EFF_RCV_HASH_BITS =
mask )
> + */
> +static unsigned int effhash(canid_t can_id)
> +{
> +	unsigned int hash;
> +
> +	hash =3D can_id>>(2*CAN_EFF_RCV_HASH_BITS);
> +	hash ^=3D can_id>>CAN_EFF_RCV_HASH_BITS;

Please add spaces around the >> and the * operator.

> +	hash ^=3D can_id;
> +
> +	return hash & ((1<<CAN_EFF_RCV_HASH_BITS) - 1);
> +}

Poking the compilers with a stick I found out that...[1]

> +
> +/**
>   * find_rcv_list - determine optimal filterlist inside device filter s=
truct
>   * @can_id: pointer to CAN identifier of a given can_filter
>   * @mask: pointer to CAN mask of a given can_filter
> @@ -400,10 +423,8 @@ static struct hlist_head *find_rcv_list(canid_t *c=
an_id, canid_t *mask,
>  	    !(*can_id & CAN_RTR_FLAG)) {
> =20
>  		if (*can_id & CAN_EFF_FLAG) {
> -			if (*mask =3D=3D (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS)) {
> -				/* RFC: a future use-case for hash-tables? */
> -				return &d->rx[RX_EFF];
> -			}
> +			if (*mask =3D=3D (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS))
> +				return &d->rx_eff[effhash(*can_id)];
>  		} else {
>  			if (*mask =3D=3D (CAN_SFF_MASK | CAN_EFF_RTR_FLAGS))
>  				return &d->rx_sff[*can_id];
> @@ -632,7 +653,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, =
struct sk_buff *skb)
>  		return matches;
> =20
>  	if (can_id & CAN_EFF_FLAG) {
> -		hlist_for_each_entry_rcu(r, &d->rx[RX_EFF], list) {
> +		hlist_for_each_entry_rcu(r, &d->rx_eff[effhash(can_id)], list) {
>  			if (r->can_id =3D=3D can_id) {
>  				deliver(skb, r);
>  				matches++;
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index 989e695..5796bc9 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -60,13 +60,16 @@ struct receiver {
>  };
> =20
>  #define CAN_SFF_RCV_ARRAY_SZ (1<<CAN_SFF_ID_BITS)
> +#define CAN_EFF_RCV_HASH_BITS 10
> +#define CAN_EFF_RCV_ARRAY_SZ (1<<CAN_EFF_RCV_HASH_BITS)

Please add spaces around the <<.

> =20
> -enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_EFF, RX_MAX };
> +enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
> =20
>  /* per device receive filters linked at dev->ml_priv */
>  struct dev_rcv_lists {
>  	struct hlist_head rx[RX_MAX];
>  	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
> +	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
>  	int remove_on_zero_entries;
>  	int entries;
>  };
> diff --git a/net/can/proc.c b/net/can/proc.c
> index 1f8e1e6..e26499d 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -80,7 +80,6 @@ static const char rx_list_name[][8] =3D {
>  	[RX_ALL] =3D "rx_all",
>  	[RX_FIL] =3D "rx_fil",
>  	[RX_INV] =3D "rx_inv",
> -	[RX_EFF] =3D "rx_eff",
>  };
> =20
>  /*
> @@ -456,6 +455,49 @@ static const struct file_operations can_rcvlist_sf=
f_proc_fops =3D {
>  	.release	=3D single_release,
>  };
> =20
> +
> +static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
> +{
> +	struct net_device *dev;
> +	struct dev_rcv_lists *d;
> +
> +	/* RX_EFF */
> +	seq_puts(m, "\nreceive list 'rx_eff':\n");
> +
> +	rcu_read_lock();
> +
> +	/* eff receive list for 'all' CAN devices (dev =3D=3D NULL) */
> +	d =3D &can_rx_alldev_list;
> +	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, CAN_EFF_RCV_ARRAY_SZ)=
;
> +
> +	/* eff receive list for registered CAN devices */
> +	for_each_netdev_rcu(&init_net, dev) {
> +		if (dev->type =3D=3D ARPHRD_CAN && dev->ml_priv) {
> +			d =3D dev->ml_priv;
> +			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
> +						    CAN_EFF_RCV_ARRAY_SZ);
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
> +static int can_rcvlist_eff_proc_open(struct inode *inode, struct file =
*file)
> +{
> +	return single_open(file, can_rcvlist_eff_proc_show, NULL);
> +}
> +
> +static const struct file_operations can_rcvlist_eff_proc_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D can_rcvlist_eff_proc_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};
> +
>  /*
>   * proc utility functions
>   */
> @@ -495,8 +537,8 @@ void can_init_proc(void)
>  					   &can_rcvlist_proc_fops, (void *)RX_FIL);
>  	pde_rcvlist_inv =3D proc_create_data(CAN_PROC_RCVLIST_INV, 0644, can_=
dir,
>  					   &can_rcvlist_proc_fops, (void *)RX_INV);
> -	pde_rcvlist_eff =3D proc_create_data(CAN_PROC_RCVLIST_EFF, 0644, can_=
dir,
> -					   &can_rcvlist_proc_fops, (void *)RX_EFF);
> +	pde_rcvlist_eff =3D proc_create(CAN_PROC_RCVLIST_EFF, 0644, can_dir,
> +				      &can_rcvlist_eff_proc_fops);
>  	pde_rcvlist_sff =3D proc_create(CAN_PROC_RCVLIST_SFF, 0644, can_dir,
>  				      &can_rcvlist_sff_proc_fops);
>  }
>=20

Marc

[1] After a long long long search I found a compiler (Debian clang
version 3.4-2 (tags/RELEASE_34/final) (based on LLVM 3.4) in 32 Bit
mode) that produces a function with more more instruction for your
"backwards" hash compared to a "forward" hash:

	hash =3D can_id;
	hash ^=3D can_id >> CAN_EFF_RCV_HASH_BITS;
	hash ^=3D can_id >> (2 * CAN_EFF_RCV_HASH_BITS);

	return hash & ((1 << CAN_EFF_RCV_HASH_BITS) - 1);

In 64 bit mode it issues the same number of instructions, though your
backwards hash is a byte shorter :) gcc 4.7 in contrast creates same
number of instructions and bytes for 32 and 64 bit.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PcHMUkGrP8X8n7HjgeBB9W4JeTJNm5KfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM74TQACgkQjTAFq1RaXHN6FwCdGBLxiXMj1lXaUw0U3M4Evuxu
YOYAnjGfSMszotdOUGJfXNXqndXEbnW9
=1lKI
-----END PGP SIGNATURE-----

--PcHMUkGrP8X8n7HjgeBB9W4JeTJNm5KfG--
