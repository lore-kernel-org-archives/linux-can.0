From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Sun, 9 Oct 2016 10:40:53 +0200
Message-ID: <bc2c73d3-57cc-2861-aa7d-b3f98cc0d076@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161008194820.GC10286@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HsGGeVjjDJvtoIBKikINHhEkPEJ1sC2gM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54202 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753183AbcJIIlB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Oct 2016 04:41:01 -0400
In-Reply-To: <20161008194820.GC10286@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HsGGeVjjDJvtoIBKikINHhEkPEJ1sC2gM
Content-Type: multipart/mixed; boundary="jh74O388nQWu69q7riEkas1f9Qu4E45tD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <bc2c73d3-57cc-2861-aa7d-b3f98cc0d076@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161008194820.GC10286@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161008194820.GC10286@airbook.vandijck-laurijssen.be>

--jh74O388nQWu69q7riEkas1f9Qu4E45tD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2016 09:48 PM, Kurt Van Dijck wrote:
> I tried to replace a spinlock+int by an atomic_t.
> Is it something similar that you had in mind.
> You were right in your comments that it is replaceable by an atomic_t.
> I pushed it to my repo, and appended it to this email.
>=20
> David, this should be transparent, but I wasn't able to test it.

Added to as a squash commit to linux-can-next/j1939.

> Kind regards,
> Kurt
>=20
> commit b8bfd1fe84869ee1c5eed3b8e6717da67dc3da60
> Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Date:   Sat Oct 8 21:43:04 2016
>=20
>     can-j1939: replace spinlock+counter by atomic_t
>    =20
>     The skb_pending member of j1939 sockets does not really need an ext=
ra spinlock
>    =20
>     Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>=20
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 66d2301..41d59dd 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -57,8 +57,7 @@ struct j1939_sock {
>  	 * when transport protocol comes in.
>  	 * To allow emitting in order, keep a 'pending' nr. of packets
>  	 */
> -	int skb_pending;	/* TODO: convert to atomic_t */
> -	spinlock_t lock;	/* protects skb_pending */
> +	atomic_t skb_pending;
>  	wait_queue_head_t waitq;
>  };
> =20
> @@ -67,42 +66,39 @@ static inline struct j1939_sock *j1939_sk(const str=
uct sock *sk)
>  	return container_of(sk, struct j1939_sock, sk);
>  }
> =20
> -/* skb_pending issues */
> +/*
> + * j1939_sock_pending_add_first
> + * Succeeds when the first pending SKB is scheduled
> + * Fails when SKB are already pending
> + */

I've added a fixup commit to convert to net multi line comment style,
which has text directly in the first line of the comment.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jh74O388nQWu69q7riEkas1f9Qu4E45tD--

--HsGGeVjjDJvtoIBKikINHhEkPEJ1sC2gM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX+gKVAAoJED07qiWsqSVquXUH/A1/KAGKcrZZP3a4eAXQDSx5
ot5mJgDCt37ef6tTtXMop1H43N0CihMqAzLBtjiqosC+cxMlg91x4Fk9YxryHGrA
kELN3vVXosVTjQuT/6WQ20YctXYCFqFjt7fNjiwlNQbc0JzqR4xCSkcERn9ntqsS
wJhqrA9SbxXfOeJl8NQK+6AgRoXEaGCNZezURHlDu6qGKWQwYMVMjaD/OHGVn1+y
J06s/nJ/5P1PzsfmT/SHz5x/pLS7rgY5ilbPAnCG/8Cow39AeSiasIUdcygz2OtU
fL8i/qvm7enR49q28RTNoUdez9s1g2qmR/DQD/2egeT78pzZceozxAx5iQnRqgA=
=FTaj
-----END PGP SIGNATURE-----

--HsGGeVjjDJvtoIBKikINHhEkPEJ1sC2gM--
