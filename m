From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Patch for kvaser_usb
Date: Fri, 26 Apr 2013 17:00:29 +0200
Message-ID: <517A968D.20508@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SIHCMRPLEAAMJQEPUFCA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36969 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3DZPAk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 11:00:40 -0400
In-Reply-To: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jonas Peterson <jonas.peterson@gmail.com>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SIHCMRPLEAAMJQEPUFCA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Jonas,

adding Olivier Sobrie, the author of the driver to the loop.

On 04/26/2013 04:50 PM, Jonas Peterson wrote:
> I've tried the kvaser_usb driver with my Kvaser USBcan Pro and no can
> frames are properly received. It seems like they are all flagged as
> log messages. I patched the driver and have used it for a while now.
> Feel free to use it as you please.

Thanks for your feedback. Which firmware version of the Kvaser USBcan
Pro are you using?

Can I add a Signed-off-by[1] to your patch?

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298=

>=20
> Best regards,
> Jonas Peterson
>=20
> --- /drivers/net/can/usb/kvaser_usb.c 2013-04-26 16:20:19.748994249 +02=
00
> +++ kvaser_usb.c 2012-12-14 15:59:10.017829818 +0100
> @@ -858,6 +858,62 @@
>   stats->rx_bytes +=3D cf->can_dlc;
>  }
>=20
> +static void kvaser_usb_rx_can_log_msg(const struct kvaser_usb *dev,
> +   const struct kvaser_msg *msg)
> +{
> + struct kvaser_usb_net_priv *priv;
> + struct can_frame *cf;
> + struct sk_buff *skb;
> + struct net_device_stats *stats;
> + u8 channel =3D msg->u.log_message.channel;
> +
> + if (channel >=3D dev->nchannels) {
> + dev_err(dev->udev->dev.parent,
> + "Invalid channel number (%d)\n", channel);
> + return;
> + }
> +
> + priv =3D dev->nets[channel];
> + stats =3D &priv->netdev->stats;
> +
> + if (msg->u.log_message.flags & (MSG_FLAG_ERROR_FRAME | MSG_FLAG_NERR =
|
> +   MSG_FLAG_OVERRUN)) {
> + kvaser_usb_rx_can_err(priv, msg);
> + dev_err(dev->udev->dev.parent,
> + "Error frame (flags: 0x%02x)",
> +     msg->u.log_message.flags);
> + return;
> + } else if (msg->u.log_message.flags & ~MSG_FLAG_REMOTE_FRAME) {
> + dev_err(dev->udev->dev.parent,
> + "Unhandled frame (flags: 0x%02x)",
> +     msg->u.log_message.flags);
> + netdev_warn(priv->netdev,
> +     "Unhandled frame (flags: 0x%02x)",
> +     msg->u.log_message.flags);
> + return;
> + }
> +
> + skb =3D alloc_can_skb(priv->netdev, &cf);
> + if (!skb) {
> + dev_err(dev->udev->dev.parent, "Alloc error");
> + stats->tx_dropped++;
> + return;
> + }
> +
> + cf->can_id =3D msg->u.log_message.id;
> + cf->can_dlc =3D msg->u.log_message.dlc;
> +
> + if (msg->u.rx_can.flag & MSG_FLAG_REMOTE_FRAME)
> + cf->can_id |=3D CAN_RTR_FLAG;
> + else
> + memcpy(cf->data, &msg->u.log_message.data, cf->can_dlc);
> +
> + netif_rx(skb);
> +
> + stats->rx_packets++;
> + stats->rx_bytes +=3D cf->can_dlc;
> +}
> +
>  static void kvaser_usb_start_chip_reply(const struct kvaser_usb *dev,
>   const struct kvaser_msg *msg)
>  {
> @@ -921,8 +977,11 @@
>   break;
>=20
>   case CMD_LOG_MESSAGE:
> - if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME)
> + if (msg->u.log_message.flags & MSG_FLAG_ERROR_FRAME) {
>   kvaser_usb_rx_error(dev, msg);
> + } else {
> + kvaser_usb_rx_can_log_msg(dev, msg);
> + }
>   break;
>=20
>   case CMD_TX_ACKNOWLEDGE:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2SIHCMRPLEAAMJQEPUFCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF6lpIACgkQjTAFq1RaXHMZZgCeJ3HL5NoGXdWlxU2fePt8CoDG
l5MAn3H9pFb6Bmf4d2AvmjPKXsPC7/Ml
=bZdP
-----END PGP SIGNATURE-----

------enig2SIHCMRPLEAAMJQEPUFCA--
