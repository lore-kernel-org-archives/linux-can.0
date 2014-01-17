From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC 1/2] can: Limit default size of CAN_RAW socket send
 queue
Date: Fri, 17 Jan 2014 10:13:46 +0100
Message-ID: <52D8F44A.7000007@pengutronix.de>
References: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MPlnoRwRbX3WoXvhPmfDLd3IaofbleMVd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35344 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbaAQJNv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 04:13:51 -0500
In-Reply-To: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org
Cc: yegorslists@googlemail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MPlnoRwRbX3WoXvhPmfDLd3IaofbleMVd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2014 08:58 PM, Michal Sojka wrote:
> This fixes the infamous ENOBUFS problem, which appears when an
> application sends CAN frames faster than they leave the system.
>=20
> Packets for sending can be queued at three places: socket, queueing
> discipline and device driver. Only the socket queue is able to block
> the sender; other queues are non-blocking. Since the size of the qdisc
> queue was set by default to 10 packets, this queue was full much
> earlier than the socket queue and this resulted in ENOBUFS error.
>=20
> This patch limits the default size of the socket send queue to
> approximately 3 CAN frames and increases the size of the qdisc queue
> to 100 frames. This setting allows for at least 33 CAN_RAW sockets to
> be used simultaneously in the system without getting ENOBUFS errors.

Do you mean in the system, per CAN interface or per socket? How many CAN
frames does a socket take before it blocks (with the default values), in
case the CAN interface doesn't send any messages?

> Note that the size of the socket queue is only approximate, because it
> is counted in bytes and the realy allocated memory (skb->truesize) can
> be bigger than what is reported by SKB_TRUESIZE(). For example, on my
> 32 bit PowerPC system, SKB_TRUESIZE() =3D 408, but skb->truesize =3D 44=
8.

What does that mean for number of CAN frames in the above question?

> Open issues:
> - Will this work with CANFD?

Can you calculate the size in bytes depending if we have a CAN or a
CANFD network card at this socket?

> - What about other AF_CAN protocols?
>=20
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
> ---
>  drivers/net/can/dev.c | 2 +-
>  net/can/raw.c         | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 1870c47..a0bce83 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -492,7 +492,7 @@ static void can_setup(struct net_device *dev)
>  	dev->mtu =3D CAN_MTU;
>  	dev->hard_header_len =3D 0;
>  	dev->addr_len =3D 0;
> -	dev->tx_queue_len =3D 10;
> +	dev->tx_queue_len =3D 100;
> =20
>  	/* New-style flags. */
>  	dev->flags =3D IFF_NOARP;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index fdda5f6..4ad0bb2 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -291,6 +291,10 @@ static int raw_init(struct sock *sk)
>  {
>  	struct raw_sock *ro =3D raw_sk(sk);
> =20
> +	/* allow at most 3 frames to wait for transmission in socket queue */=

> +	sk->sk_sndbuf =3D 3 * SKB_TRUESIZE(sizeof(struct can_frame) +
> +					 sizeof(struct can_skb_priv));
> +
>  	ro->bound            =3D 0;
>  	ro->ifindex          =3D 0;
> =20
>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MPlnoRwRbX3WoXvhPmfDLd3IaofbleMVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLY9EoACgkQjTAFq1RaXHNB7ACdF14r0FL/SMCvVRuDEsug43yf
8N0An3cmd4ItHuEcBybKGFTBH0rGA7GB
=+Don
-----END PGP SIGNATURE-----

--MPlnoRwRbX3WoXvhPmfDLd3IaofbleMVd--
