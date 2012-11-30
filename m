From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 3/7] c_can: use different sets of interface registers
 for rx and tx
Date: Fri, 30 Nov 2012 09:39:13 +0100
Message-ID: <50B870B1.4050907@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-4-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3F69D013370C547D8914769"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58393 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2K3IjS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 03:39:18 -0500
In-Reply-To: <1354199987-10350-4-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3F69D013370C547D8914769
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
> To avoid conflicts between CPU access to the message RAM we now
> use the first set of interface registers for RX and the second
> for TX.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/c_can/c_can.c |   37 ++++++++++++++++++++++-----------=
----
>  1 file changed, 22 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 3ae356f..27e45e6 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -158,6 +158,10 @@
>  #define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
>  #define RECEIVE_OBJECT_BITS	0x0000ffff
> =20
> +/* message interface used for rx and tx */
> +#define IFACE_RX		0
> +#define IFACE_TX		1

Can you give these defines a common C_CAN_ prefix? And you can make them
an enum and change the signature of the function you're changing below.

Marc

> +
>  /* status interrupt */
>  #define STATUS_INTERRUPT	0x8000
> =20
> @@ -544,7 +548,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff =
*skb,
>  	msg_obj_no =3D get_tx_next_msg_obj(priv);
> =20
>  	/* prepare message object for transmission */
> -	c_can_write_msg_object(dev, 0, frame, msg_obj_no);
> +	c_can_write_msg_object(dev, IFACE_TX, frame, msg_obj_no);
>  	can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
> =20
>  	/*
> @@ -606,16 +610,18 @@ static void c_can_configure_msg_objects(struct ne=
t_device *dev)
>  	int i;
> =20
>  	/* first invalidate all message objects */
> -	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_NO_OF_OBJECTS; i++)
> -		c_can_inval_msg_object(dev, 0, i);
> +	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_OBJ_RX_LAST; i++)=

> +		c_can_inval_msg_object(dev, IFACE_RX, i);
> +	for (i =3D C_CAN_MSG_OBJ_TX_FIRST; i <=3D C_CAN_MSG_OBJ_TX_LAST; i++)=

> +		c_can_inval_msg_object(dev, IFACE_TX, i);
> =20
>  	/* setup receive message objects */
>  	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
> -		c_can_setup_receive_object(dev, 0, i, 0, 0,
> +		c_can_setup_receive_object(dev, IFACE_RX, i, 0, 0,
>  			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
> =20
> -	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
> -			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
> +	c_can_setup_receive_object(dev, IFACE_RX, C_CAN_MSG_OBJ_RX_LAST,
> +			0, 0, IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
>  }
> =20
>  /*
> @@ -748,10 +754,10 @@ static void c_can_do_tx(struct net_device *dev)
>  			can_get_echo_skb(dev,
>  					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
>  			stats->tx_bytes +=3D priv->read_reg(priv,
> -					C_CAN_IFACE(MSGCTRL_REG, 0))
> +					C_CAN_IFACE(MSGCTRL_REG, IFACE_TX))
>  					& IF_MCONT_DLC_MASK;
>  			stats->tx_packets++;
> -			c_can_inval_msg_object(dev, 0, msg_obj_no);
> +			c_can_inval_msg_object(dev, IFACE_TX, msg_obj_no);
>  		} else {
>  			break;
>  		}
> @@ -801,16 +807,17 @@ static int c_can_do_rx_poll(struct net_device *de=
v, int quota)
>  		 * message object n, we need to handle the same properly.
>  		 */
>  		if (val & (1 << (msg_obj - 1))) {
> -			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
> +			c_can_object_get(dev, IFACE_RX, msg_obj, IF_COMM_ALL &
>  					~IF_COMM_TXRQST);
>  			msg_ctrl_save =3D priv->read_reg(priv,
> -					C_CAN_IFACE(MSGCTRL_REG, 0));
> +					C_CAN_IFACE(MSGCTRL_REG, IFACE_RX));
> =20
>  			if (msg_ctrl_save & IF_MCONT_EOB)
>  				return num_rx_pkts;
> =20
>  			if (msg_ctrl_save & IF_MCONT_MSGLST) {
> -				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
> +				c_can_handle_lost_msg_obj(dev, IFACE_RX,
> +								msg_obj);
>  				num_rx_pkts++;
>  				quota--;
>  				continue;
> @@ -820,19 +827,19 @@ static int c_can_do_rx_poll(struct net_device *de=
v, int quota)
>  				continue;
> =20
>  			/* read the data from the message object */
> -			c_can_read_msg_object(dev, 0, msg_ctrl_save);
> +			c_can_read_msg_object(dev, IFACE_RX, msg_ctrl_save);
> =20
>  			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
> -				c_can_mark_rx_msg_obj(dev, 0,
> +				c_can_mark_rx_msg_obj(dev, IFACE_RX,
>  						msg_ctrl_save, msg_obj);
>  			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
>  				/* activate this msg obj */
> -				c_can_activate_rx_msg_obj(dev, 0,
> +				c_can_activate_rx_msg_obj(dev, IFACE_RX,
>  						msg_ctrl_save, msg_obj);
>  			else if (msg_obj =3D=3D C_CAN_MSG_RX_LOW_LAST)
>  				/* activate all lower message objects */
>  				c_can_activate_all_lower_rx_msg_obj(dev,
> -						0, msg_ctrl_save);
> +						IFACE_RX, msg_ctrl_save);
> =20
>  			num_rx_pkts++;
>  			quota--;
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD3F69D013370C547D8914769
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC4cLEACgkQjTAFq1RaXHOKswCfebUMi0hFA/I2aSSt41fcrSSW
K1MAn12zOTlsniVmZwpauf70jM3VpO0o
=vGuP
-----END PGP SIGNATURE-----

--------------enigD3F69D013370C547D8914769--
