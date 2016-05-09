From: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>
Subject: Re: [PATCH v2] can: janz-ican3: error handling for CAL/CANopen
 firmware
Date: Mon, 9 May 2016 20:04:15 +0200
Message-ID: <5730D11F.2050804@gmail.com>
References: <1462729709-17546-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34010 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcEISE0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 May 2016 14:04:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1azpXb-0000xl-Bg
	for linux-can@vger.kernel.org; Mon, 09 May 2016 20:04:23 +0200
Received: from p54a665c2.dip0.t-ipconnect.de ([84.166.101.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 May 2016 20:04:23 +0200
Received: from andreas24groeger by p54a665c2.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 09 May 2016 20:04:23 +0200
In-Reply-To: <1462729709-17546-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I have tested it, works fine. All NMTS indications are forwarded correc=
tly to ican3_handle_cevtind.
Remark: I have only tested on little-endian machines

Regards Andreas

Am 08.05.2016 um 19:48 schrieb Marc Kleine-Budde:
> From: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>
>=20
> My patch of May 2015 was missing the changed handling of error
> indications. With CAL/CANopen firmware the NMTS-SlaveEventIndication
> must be used instead of CAN-EventIndication. An appropriate slave nod=
e
> must be configured to report the errors.
>=20
> In our department (about 15 development systems with Janz ICAN3-
> modules with firmware 1.48, my system also with firmware ICANOS 1.35)
> we use the driver with this patch for about one year: no known proble=
ms.
>=20
> Signed-off-by: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v1:
> - fix endianness handling in ican3_handle_nmtsind()
>=20
> Andreas, please test this version.
>=20
> Marc
>=20
>  drivers/net/can/janz-ican3.c | 104 +++++++++++++++++++++++++++++++++=
++++++----
>  1 file changed, 95 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican=
3.c
> index 5d04f5464faf..f13bb8d9bb84 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -84,6 +84,7 @@
>  #define MSG_COFFREQ		0x42
>  #define MSG_CONREQ		0x43
>  #define MSG_CCONFREQ		0x47
> +#define MSG_NMTS		0xb0
>  #define MSG_LMTS		0xb4
> =20
>  /*
> @@ -130,6 +131,22 @@
> =20
>  #define ICAN3_CAN_DLC_MASK	0x0f
> =20
> +/* Janz ICAN3 NMTS subtypes */
> +#define NMTS_CREATE_NODE_REQ	0x0
> +#define NMTS_SLAVE_STATE_IND	0x8
> +#define NMTS_SLAVE_EVENT_IND	0x9
> +
> +/* Janz ICAN3 LMTS subtypes */
> +#define LMTS_BUSON_REQ		0x0
> +#define LMTS_BUSOFF_REQ		0x1
> +#define LMTS_CAN_CONF_REQ	0x2
> +
> +/* Janz ICAN3 NMTS Event indications */
> +#define NE_LOCAL_OCCURRED	0x3
> +#define NE_LOCAL_RESOLVED	0x2
> +#define NE_REMOTE_OCCURRED	0xc
> +#define NE_REMOTE_RESOLVED	0x8
> +
>  /*
>   * SJA1000 Status and Error Register Definitions
>   *
> @@ -800,21 +817,41 @@ static int ican3_set_bus_state(struct ican3_dev=
 *mod, bool on)
>  		return ican3_send_msg(mod, &msg);
> =20
>  	} else if (mod->fwtype =3D=3D ICAN3_FWTYPE_CAL_CANOPEN) {
> +		/* bittiming + can-on/off request */
>  		memset(&msg, 0, sizeof(msg));
>  		msg.spec =3D MSG_LMTS;
>  		if (on) {
>  			msg.len =3D cpu_to_le16(4);
> -			msg.data[0] =3D 0;
> +			msg.data[0] =3D LMTS_BUSON_REQ;
>  			msg.data[1] =3D 0;
>  			msg.data[2] =3D btr0;
>  			msg.data[3] =3D btr1;
>  		} else {
>  			msg.len =3D cpu_to_le16(2);
> -			msg.data[0] =3D 1;
> +			msg.data[0] =3D LMTS_BUSOFF_REQ;
>  			msg.data[1] =3D 0;
>  		}
> +		res =3D ican3_send_msg(mod, &msg);
> +		if (res)
> +			return res;
> =20
> -		return ican3_send_msg(mod, &msg);
> +		if (on) {
> +			/* create NMT Slave Node for error processing
> +			 *   class 2 (with error capability, see CiA/DS203-1)
> +			 *   id    1
> +			 *   name  locnod1 (must be exactly 7 bytes)
> +			 */
> +			memset(&msg, 0, sizeof(msg));
> +			msg.spec =3D MSG_NMTS;
> +			msg.len =3D cpu_to_le16(11);
> +			msg.data[0] =3D NMTS_CREATE_NODE_REQ;
> +			msg.data[1] =3D 0;
> +			msg.data[2] =3D 2;                 /* node class */
> +			msg.data[3] =3D 1;                 /* node id */
> +			strcpy(msg.data + 4, "locnod1"); /* node name  */
> +			return ican3_send_msg(mod, &msg);
> +		}
> +		return 0;
>  	}
>  	return -ENOTSUPP;
>  }
> @@ -849,12 +886,23 @@ static int ican3_set_buserror(struct ican3_dev =
*mod, u8 quota)
>  {
>  	struct ican3_msg msg;
> =20
> -	memset(&msg, 0, sizeof(msg));
> -	msg.spec =3D MSG_CCONFREQ;
> -	msg.len =3D cpu_to_le16(2);
> -	msg.data[0] =3D 0x00;
> -	msg.data[1] =3D quota;
> -
> +	if (mod->fwtype =3D=3D ICAN3_FWTYPE_ICANOS) {
> +		memset(&msg, 0, sizeof(msg));
> +		msg.spec =3D MSG_CCONFREQ;
> +		msg.len =3D cpu_to_le16(2);
> +		msg.data[0] =3D 0x00;
> +		msg.data[1] =3D quota;
> +	} else if (mod->fwtype =3D=3D ICAN3_FWTYPE_CAL_CANOPEN) {
> +		memset(&msg, 0, sizeof(msg));
> +		msg.spec =3D MSG_LMTS;
> +		msg.len =3D cpu_to_le16(4);
> +		msg.data[0] =3D LMTS_CAN_CONF_REQ;
> +		msg.data[1] =3D 0x00;
> +		msg.data[2] =3D 0x00;
> +		msg.data[3] =3D quota;
> +	} else {
> +		return -ENOTSUPP;
> +	}
>  	return ican3_send_msg(mod, &msg);
>  }
> =20
> @@ -1150,6 +1198,41 @@ static void ican3_handle_inquiry(struct ican3_=
dev *mod, struct ican3_msg *msg)
>  	}
>  }
> =20
> +/* Handle NMTS Slave Event Indication Messages from the firmware */
> +static void ican3_handle_nmtsind(struct ican3_dev *mod, struct ican3=
_msg *msg)
> +{
> +	u16 subspec;
> +
> +	subspec =3D msg->data[0] + msg->data[1] * 0x100;
> +	if (subspec =3D=3D NMTS_SLAVE_EVENT_IND) {
> +		switch (msg->data[2]) {
> +		case NE_LOCAL_OCCURRED:
> +		case NE_LOCAL_RESOLVED:
> +			/* now follows the same message as Raw ICANOS CEVTIND
> +			 * shift the data at the same place and call this method
> +			 */
> +			le16_add_cpu(&msg->len, -3);
> +			memmove(msg->data, msg->data + 3, le16_to_cpu(msg->len));
> +			ican3_handle_cevtind(mod, msg);
> +			break;
> +		case NE_REMOTE_OCCURRED:
> +		case NE_REMOTE_RESOLVED:
> +			/* should not occurre, ignore */
> +			break;
> +		default:
> +			netdev_warn(mod->ndev, "unknown NMTS event indication %x\n",
> +				    msg->data[2]);
> +			break;
> +		}
> +	} else if (subspec =3D=3D NMTS_SLAVE_STATE_IND) {
> +		/* ignore state indications */
> +	} else {
> +		netdev_warn(mod->ndev, "unhandled NMTS indication %x\n",
> +			    subspec);
> +		return;
> +	}
> +}
> +
>  static void ican3_handle_unknown_message(struct ican3_dev *mod,
>  					struct ican3_msg *msg)
>  {
> @@ -1179,6 +1262,9 @@ static void ican3_handle_message(struct ican3_d=
ev *mod, struct ican3_msg *msg)
>  	case MSG_INQUIRY:
>  		ican3_handle_inquiry(mod, msg);
>  		break;
> +	case MSG_NMTS:
> +		ican3_handle_nmtsind(mod, msg);
> +		break;
>  	default:
>  		ican3_handle_unknown_message(mod, msg);
>  		break;
>=20


