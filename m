From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Fri, 07 Dec 2012 10:55:40 +0100
Message-ID: <50C1BD1C.9090108@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com> <9545085.epYbjMqEeA@ws-stein> <50C12B77.1060501@pengutronix.de> <50C1B64D.8030209@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB4A79751481F7741FF2DD4C2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36355 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab2LGJ4S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Dec 2012 04:56:18 -0500
In-Reply-To: <50C1B64D.8030209@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4A79751481F7741FF2DD4C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/07/2012 10:26 AM, Wolfgang Grandegger wrote:
> On 12/07/2012 12:34 AM, Marc Kleine-Budde wrote:
>> On 12/06/2012 06:14 PM, Alexander Stein wrote:
>>>> This is a typical out-of-sequence reception with a=20
>>>> RX-goes-into-first-free-mailbox hardware. I've implemented the
>>>> algorithm used in the at91 and fixed the one for the ti_hecc.
>>>
>>> Marc, do you mean out-of-sequence reception with such mailbox types
>>> can happen even with the algorithm used in c_can and at91?
>>
>> It can happen, if the algorithm isn't implemented properly and adopted=

>> to the needs of the hardware. On the unmodified ti_hecc we see this
>> out-of-sequence problems, too.
>=20
> Yep, that's the tricky part and the pch_can and c_can use a different
> approach to solve the problem. Let's concentrate on the c_can driver.
> Key-point is that the controller does put the message into the FIFO
> object with the lowest number. Here is the relevant code:
>=20
> /*
>  * theory of operation:
>  *
>  * c_can core saves a received CAN message into the first free message
>  * object it finds free (starting with the lowest). Bits NEWDAT and
>  * INTPND are set for this message object indicating that a new message=

>  * has arrived. To work-around this issue, we keep two groups of messag=
e
>  * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
>  *
>  * To ensure in-order frame reception we use the following
>  * approach while re-activating a message object to receive further
>  * frames:
>  * - if the current message object number is lower than
>  *   C_CAN_MSG_RX_LOW_LAST, do not clear the NEWDAT bit while clearing
>  *   the INTPND bit.
>  * - if the current message object number is equal to
>  *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of all lower
>  *   receive message objects.
>  * - if the current message object number is greater than
>  *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of
>  *   only this message object.
>  */
> static int c_can_do_rx_poll(struct net_device *dev, int quota)
> {
> 	u32 num_rx_pkts =3D 0;
> 	unsigned int msg_obj, msg_ctrl_save;
> 	struct c_can_priv *priv =3D netdev_priv(dev);
> 	u32 val =3D c_can_read_reg32(priv, C_CAN_INTPND1_REG);
>=20
> 	for (msg_obj =3D C_CAN_MSG_OBJ_RX_FIRST;
> 			msg_obj <=3D C_CAN_MSG_OBJ_RX_LAST && quota > 0;
> 			val =3D c_can_read_reg32(priv, C_CAN_INTPND1_REG),
> 			msg_obj++) {
> 		/*
> 		 * as interrupt pending register's bit n-1 corresponds to
> 		 * message object n, we need to handle the same properly.
> 		 */
> 		if (val & (1 << (msg_obj - 1))) {
> 			c_can_object_get(dev, IFACE_RX, msg_obj, IF_COMM_ALL &
> 					~IF_COMM_TXRQST);
> 			msg_ctrl_save =3D priv->read_reg(priv,
> 					C_CAN_IFACE(MSGCTRL_REG, IFACE_RX));
>=20
> 			if (msg_ctrl_save & IF_MCONT_EOB)
> 				return num_rx_pkts;
>=20
> 			if (msg_ctrl_save & IF_MCONT_MSGLST) {
> 				c_can_handle_lost_msg_obj(dev, IFACE_RX,
> 								msg_obj);
> 				num_rx_pkts++;
> 				quota--;
> 				continue;
> 			}
>=20
> 			if (!(msg_ctrl_save & IF_MCONT_NEWDAT))
> 				continue;
>=20
> 			/* read the data from the message object */
> 			c_can_read_msg_object(dev, IFACE_RX, msg_ctrl_save);
>=20
> 			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
> 				c_can_mark_rx_msg_obj(dev, IFACE_RX,
> 						msg_ctrl_save, msg_obj);
> 			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
> 				/* activate this msg obj */
> 				c_can_activate_rx_msg_obj(dev, IFACE_RX,
> 						msg_ctrl_save, msg_obj);
> 			else if (msg_obj =3D=3D C_CAN_MSG_RX_LOW_LAST)
> 				/* activate all lower message objects */
> 				c_can_activate_all_lower_rx_msg_obj(dev,
> 						IFACE_RX, msg_ctrl_save);
>=20
> 			num_rx_pkts++;
> 			quota--;
> 		}
> 	}
>=20
> 	return num_rx_pkts;
> }
>=20
>=20
> I see a problem if the current message object number is greater than
> C_CAN_MSG_RX_LOW_LAST, which is #8. Lets assume the FIFO filled up to
> message number #8 when we read INTPND1_REG. Before the we call
> c_can_activate_all_lower_rx_msg_obj(), another message is received
> into #9. Then we call c_can_activate_all_lower_rx_msg_obj() and shortly=

> after another messages is received into #0. The next time we enter
> this function it will read first #1 and then #9, which is the wrong
> order.

This is the my reworked version of the ti_hecc poll loop.
Note: the ti_hecc fills the mailboxes from highest number to lowest, not
lowest to highest like the c_can.

>         do {

It's not a for loop starting at the first mailbox. It always works on
the the next one....

>                 reg_rmp =3D hecc_read(priv, HECC_CANRMP) & priv->rx_act=
ive;
>                 if (!(reg_rmp & BIT(priv->rx_next))) {
>                         /*
>                          * Wrap around only if:
>                          * - we are in the lower group and
>                          * - there is a CAN frame in the first mailbox
>                          *   of the high group.
>                          */

=2E..and only wraps around to the first one under certain circumstances.

>                         if ((priv->rx_next <=3D HECC_RX_BUFFER_MBOX) &&=

>                             (reg_rmp & BIT(HECC_RX_FIRST_MBOX)))
>                                 priv->rx_next =3D HECC_RX_FIRST_MBOX;
>                         else
>                                 break;
>                 }
>                 mb =3D priv->rx_next--;
>=20
>                 /* disable mailbox */
>                 priv->rx_active &=3D ~BIT(mb);
>=20
>                 ti_hecc_rx_pkt(priv, mb);
>=20
>                 /* enable mailboxes */
>                 if (mb =3D=3D HECC_RX_BUFFER_MBOX) {
>                         hecc_write(priv, HECC_CANRMP, HECC_RX_HIGH_MBOX=
_MASK);
>                         priv->rx_active |=3D HECC_RX_HIGH_MBOX_MASK;
>                 } else if (mb =3D=3D HECC_RX_FIRST_MBOX) {
>                         hecc_write(priv, HECC_CANRMP, HECC_RX_LOW_MBOX_=
MASK);
>                         priv->rx_active |=3D HECC_RX_LOW_MBOX_MASK;
>                 }

The enabling of the mailboxes is delayed compared to the original algorit=
hm.

>=20
>                 received++;
>                 quota--;
>         } while (quota);

We have at least 3 drivers with the same algorithm. I'm thinking if it
is possible to create a library helper for this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB4A79751481F7741FF2DD4C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDBvSAACgkQjTAFq1RaXHN+tQCfSdD73Tffk4CsZNoH8lXzvoOQ
CeEAn2Gnh/YinDssZ5UTc8sWtkXVOwAd
=Fopc
-----END PGP SIGNATURE-----

--------------enigB4A79751481F7741FF2DD4C2--
