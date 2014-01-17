From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC 2/2] net: Make minimum SO_SNDBUF size dependent on
 the protocol family
Date: Fri, 17 Jan 2014 10:08:00 +0100
Message-ID: <52D8F2F0.3080305@pengutronix.de>
References: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz> <1389902301-24505-2-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WNT2fb53GELQMe2GkLRI1BMnRhHUCpmvH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44987 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbaAQJIH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 04:08:07 -0500
In-Reply-To: <1389902301-24505-2-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org
Cc: yegorslists@googlemail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNT2fb53GELQMe2GkLRI1BMnRhHUCpmvH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2014 08:58 PM, Michal Sojka wrote:
> For CAN bus it is desired to have the size of the socket send queue
> much smaller than for Ethernet-based protocols. This patch makes the
> limit for setsockopt(SO_SNDBUF) values smaller for PF_CAN sockets.

Why don't you introduce another define, that's only used in
sock_setsockopt, so you don't have to change any tcp hot path related
functions?

Marc

> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> ---
>  include/net/sock.h | 11 +++++++++--
>  include/net/tcp.h  |  2 +-
>  net/can/raw.c      |  1 +
>  net/core/sock.c    |  2 +-
>  4 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 808cbc2..54d26e6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -969,6 +969,7 @@ struct proto {
>  	int			*sysctl_rmem;
>  	int			max_header;
>  	bool			no_autobind;
> +	int			min_sndbuf;
> =20
>  	struct kmem_cache	*slab;
>  	unsigned int		obj_size;
> @@ -2072,14 +2073,20 @@ static inline void sk_wake_async(struct sock *s=
k, int how, int band)
>   */
>  #define TCP_SKB_MIN_TRUESIZE	(2048 + SKB_DATA_ALIGN(sizeof(struct sk_b=
uff)))
> =20
> -#define SOCK_MIN_SNDBUF		(TCP_SKB_MIN_TRUESIZE * 2)
> +#define SOCK_MIN_SNDBUF(sk)	((sk)->sk_prot->min_sndbuf ? \
> +				 (sk)->sk_prot->min_sndbuf : \
> +				 (TCP_SKB_MIN_TRUESIZE * 2))
>  #define SOCK_MIN_RCVBUF		 TCP_SKB_MIN_TRUESIZE
> =20
>  static inline void sk_stream_moderate_sndbuf(struct sock *sk)
>  {
>  	if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK)) {
>  		sk->sk_sndbuf =3D min(sk->sk_sndbuf, sk->sk_wmem_queued >> 1);
> -		sk->sk_sndbuf =3D max_t(u32, sk->sk_sndbuf, SOCK_MIN_SNDBUF);
> +		/* This seems to be called quite often and mainly for
> +		 * TCP. Should we stick with the constant instead of
> +		 * changing it to double dereference to not hurt
> +		 * performance? */
> +		sk->sk_sndbuf =3D max_t(u32, sk->sk_sndbuf, SOCK_MIN_SNDBUF(sk));
>  	}
>  }
> =20
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index b1aa324..814cef5 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -306,7 +306,7 @@ static inline bool between(__u32 seq1, __u32 seq2, =
__u32 seq3)
> =20
>  static inline bool tcp_out_of_memory(struct sock *sk)
>  {
> -	if (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
> +	if (sk->sk_wmem_queued > SOCK_MIN_SNDBUF(sk) &&
>  	    sk_memory_allocated(sk) > sk_prot_mem_limits(sk, 2))
>  		return true;
>  	return false;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 4ad0bb2..b58f53f 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -818,6 +818,7 @@ static struct proto raw_proto __read_mostly =3D {
>  	.owner      =3D THIS_MODULE,
>  	.obj_size   =3D sizeof(struct raw_sock),
>  	.init       =3D raw_init,
> +	.min_sndbuf =3D SKB_TRUESIZE(sizeof(struct can_frame) + sizeof(struct=
 can_skb_priv)),
>  };
> =20
>  static const struct can_proto raw_can_proto =3D {
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 0b39e7a..3f0d8a0 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -681,7 +681,7 @@ int sock_setsockopt(struct socket *sock, int level,=
 int optname,
>  		val =3D min_t(u32, val, sysctl_wmem_max);
>  set_sndbuf:
>  		sk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
> -		sk->sk_sndbuf =3D max_t(u32, val * 2, SOCK_MIN_SNDBUF);
> +		sk->sk_sndbuf =3D max_t(u32, val * 2, SOCK_MIN_SNDBUF(sk));
>  		/* Wake up sending tasks if we upped the value. */
>  		sk->sk_write_space(sk);
>  		break;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WNT2fb53GELQMe2GkLRI1BMnRhHUCpmvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLY8vAACgkQjTAFq1RaXHNJmQCfdES++4nW5s7LKUT0vZOoiBVt
PzsAniiy/julI6U919E8AV/+bTIG/Bj3
=7wn0
-----END PGP SIGNATURE-----

--WNT2fb53GELQMe2GkLRI1BMnRhHUCpmvH--
