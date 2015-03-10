From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: add comment for sock_efree() usage
Date: Tue, 10 Mar 2015 20:55:23 +0100
Message-ID: <54FF4C2B.5000607@pengutronix.de>
References: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9fTs02OIOHUHiqu35pbTqjjn7ICFU1H1h"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49478 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbCJTzh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Mar 2015 15:55:37 -0400
In-Reply-To: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: eric.dumazet@gmail.com, alexander.h.duyck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9fTs02OIOHUHiqu35pbTqjjn7ICFU1H1h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2015 06:19 PM, Oliver Hartkopp wrote:
> In opposite to sock_rfree() and sock_wfree() the function sock_efree() =
does
> not need to change the sk_[rw]_mem_alloc length. Add the comment to poi=
nt out
> the idea for using sock_efree() in the _e_rror handler or e.g. timestam=
p path.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/core/sock.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 93c8b20..7a1eac8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1655,6 +1655,10 @@ void sock_rfree(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(sock_rfree);
> =20
> +/*
> + * Buffer destructor for skbs that don't have sk_[rw]_mem_alloc accoun=
ting.
> + * E.g. error handler / timestamp path. Automatically called from kfre=
e_skb.
> + */

/* multiline comments in net
 * work this
 * way
 */

>  void sock_efree(struct sk_buff *skb)
>  {
>  	sock_put(skb->sk);
>=20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9fTs02OIOHUHiqu35pbTqjjn7ICFU1H1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU/0wyAAoJECte4hHFiupUkbsQAJansCB06X4Xc7XC6e6Xj7Jv
YApqgu2bs/RLJJxnNNCaq6bb4efLIGBsciRS3LMQLG+XKepwZCjHx2pUiqSX7HNi
4jomB12EhiLBfp1wD4l8qAUW1woIaVKZZlIAgff5zixGeYzI4a+/qKjXVco08fgy
nQHVAlok5vtrp+r9LM6+YvgW0BP0Kngs3MT7151dQFnbYsPv6lCoVd3SWlIFxdHC
WxB/f5Hz9tLsu0Oz3t87hRbg1XS1grT5+lapPF3HNAfR4GEmMmY42mTmbIwP7L84
RrpPOU8k9RiF08nhJKDlG3kH/hg7Y0pZvNpJFUQ8oehI8xU1a5OOVkFlBztvUtwZ
eLwITR8d4lSmX8PvvZmCo21fe+nuQKklaEJKZyCITy0Veog2WRYrHxQrZ4n7boQj
BuHR2eHllwLXL3FxKJ+CBhwKn3k+6ONYRGI6B2u4J+oSca07X1GN9aXCzGUkQOHa
bu2n3Y+SEuabkpo49uyNE5k19epiLrH4MNyz4uXZNJFcbcxoEcbXADuHc3dimwFn
QmBfE/jtztA70I+9M6fhVxe5ppEthMW0e0B3PThDswZQ7KHSvU+1zzCsDicO0smw
bOX5ON++f+IdLtL8aAGrd9Aja2eTNnwyucLBNZ94x54XPm6om4ZaFXc9yptpiQjF
ooK+Zcw5tbPUYZ5BKB07
=jpEJ
-----END PGP SIGNATURE-----

--9fTs02OIOHUHiqu35pbTqjjn7ICFU1H1h--
