From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: fix "BUG! echo_skb is occupied!" during
 transmit
Date: Tue, 24 Apr 2012 09:55:25 +0200
Message-ID: <4F965C6D.6030303@pengutronix.de>
References: <1334915862-29810-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig873AB8E7F107DD18AC4EE474"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41188 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab2DXHzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 03:55:40 -0400
In-Reply-To: <1334915862-29810-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig873AB8E7F107DD18AC4EE474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/20/2012 11:57 AM, AnilKumar Ch wrote:
> This patch fixes an issue with transmit routine, which causes
> "can_put_echo_skb: BUG! echo_skb is occupied!" messgae when
> using "cansequence -p" on D_CAN controller.
>=20
> In c_can driver, while transmitting packets tx_echo flag holds
> the no of can frames put for transmission into the hardware.
>=20
> As the comment above c_can_do_tx() indicates, if we find any packet
> which is not transmitted then we should stop looking for more.
> In the current implementation this is not taken care of causing the
> said message.
>=20
> Also, fix the condition used to find if the packet is transmitted
> or not. Current code skips the first tx message object and ends up
> checking one extra invalid object.

The two above listed issues can occur with the c_can hardware, too?
Please split into two separate patches. These should go to the stable
kernel, too. Can someone with a c_can hardware test these patches.

> While at it, fix the comment on top of c_can_do_tx() to use the
> terminology "packet" instead of "package" since it is more
> standard.

Add this to one of the above patches.

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/net/can/c_can/c_can.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 536bda0..9ac28df 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -686,7 +686,7 @@ static int c_can_get_berr_counter(const struct net_=
device *dev,
>   *
>   * We iterate from priv->tx_echo to priv->tx_next and check if the
>   * packet has been transmitted, echo it back to the CAN framework.
> - * If we discover a not yet transmitted package, stop looking for more=
=2E
> + * If we discover a not yet transmitted packet, stop looking for more.=

>   */
>  static void c_can_do_tx(struct net_device *dev)
>  {
> @@ -698,7 +698,7 @@ static void c_can_do_tx(struct net_device *dev)
>  	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++)=
 {
>  		msg_obj_no =3D get_tx_echo_msg_obj(priv);
>  		val =3D c_can_read_reg32(priv, &priv->regs->txrqst1);
> -		if (!(val & (1 << msg_obj_no))) {
> +		if (!(val & (1 << (msg_obj_no - 1)))) {
>  			can_get_echo_skb(dev,
>  					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
>  			stats->tx_bytes +=3D priv->read_reg(priv,
> @@ -706,6 +706,8 @@ static void c_can_do_tx(struct net_device *dev)
>  					& IF_MCONT_DLC_MASK;
>  			stats->tx_packets++;
>  			c_can_inval_msg_object(dev, 0, msg_obj_no);
> +		} else {
> +			break;
>  		}
>  	}
> =20

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig873AB8E7F107DD18AC4EE474
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+WXHEACgkQjTAFq1RaXHP2IwCfQeQxEgMCuFBsSietYyjaVrrJ
2cwAn3t2PryUTisZTTxjWs81CCvgVdBV
=NaCQ
-----END PGP SIGNATURE-----

--------------enig873AB8E7F107DD18AC4EE474--
