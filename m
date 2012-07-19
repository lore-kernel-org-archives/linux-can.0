From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 3/3] can: janz-ican3: add support for one shot mode
Date: Thu, 19 Jul 2012 10:01:12 +0200
Message-ID: <5007BEC8.3080301@pengutronix.de>
References: <20120713230521.GD4538@ovro.caltech.edu> <1342220831-11039-1-git-send-email-iws@ovro.caltech.edu> <5005EC57.7030504@pengutronix.de> <20120718182047.GB25905@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1F74558178F703575A04E2A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49597 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2GSIBW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jul 2012 04:01:22 -0400
In-Reply-To: <20120718182047.GB25905@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1F74558178F703575A04E2A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/18/2012 08:20 PM, Ira W. Snyder wrote:
[...]

>> Can you please test in normal mode (i.e. non-oneshot-mode) on a proper=

>> terminated bus without a second CAN station on the bus. Send a single
>> CAN message. How does the controller behave? What happens if you then
>> add a second member to the bus? Is the original CAN message finally
>> received?
>>
>=20
> I configured the bus like so:
> ip link set can0 up type can bitrate 1000000 one-shot off berr-reportin=
g off
>=20
> And get this output:
> 21: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOW=
N mode DEFAULT qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 1000000 sample-point 0.750
>     tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 1
>     janz-ican3: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          0          0          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     0          0        0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        0       0       0       0
>=20
> Then I ran:
> cangen -n 1 -e -L 8 can0
>=20
> The candump tool shows the following:
> candump -e any,0:0,#FFFFFFFF
>   can0  20000004  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
>         controller-problem{tx-error-warning}
>         error-counter-tx-rx{{96}{0}}
>   can0  20000004  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
>         controller-problem{tx-error-passive}
>         error-counter-tx-rx{{128}{0}}
>=20
> And the ip tool shows:
> 21: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOW=
N mode DEFAULT qlen 10
>     link/can=20
>     can state ERROR-PASSIVE restart-ms 0=20
>     bitrate 1000000 sample-point 0.750=20
>     tq 125 prop-seg 2 phase-seg1 3 phase-seg2 2 sjw 1
>     janz-ican3: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          1          1          0        =20
>     RX: bytes  packets  errors  dropped overrun mcast  =20
>     0          0        2       0       0       0     =20
>     TX: bytes  packets  errors  dropped carrier collsns=20
>     0          0        1822    0       0       0     =20
>=20
>=20
> After I plug in another CAN station, the bus remains in exactly the sam=
e
> state. I DO NOT receive the frame I sent, on either the sending station=
,
> nor on the newly connected station. The bus remains in ERROR-PASSIVE
> state.
>=20
> If I send packets with my second CAN station, it starts getting bus
> errors. The first CAN station acts as if it has dropped off the bus
> completely, so there is no second device on the bus.
>=20
> The firmware seems to go into some bad state where it will not respond
> to control messages at all. It doesn't ever respond to control messages=

> again until I reset the card (by rmmod + insmod the driver).

Uhh, error handling is always complicated and controllers behave in a
strange way :)

[...]

>>> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican=
3.c
>>> index 5fff829..fccfc3a 100644
>>> --- a/drivers/net/can/janz-ican3.c
>>> +++ b/drivers/net/can/janz-ican3.c
>>> @@ -116,6 +116,7 @@
>>>  #define ICAN3_BUSERR_QUOTA_MAX	255
>>> =20
>>>  /* Janz ICAN3 CAN Frame Conversion */
>>> +#define ICAN3_SNGL	0x02
>>>  #define ICAN3_ECHO	0x10
>>>  #define ICAN3_EFF_RTR	0x40
>>>  #define ICAN3_SFF_RTR	0x10
>>> @@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev =
*mod,
>>>  	desc->data[0] |=3D cf->can_dlc;
>>>  	desc->data[1] |=3D ICAN3_ECHO;
>>> =20
>>> +	/* support single transmission (no retries) mode */
>>> +	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>>> +		desc->data[1] |=3D ICAN3_SNGL;
>>> +
>>
>> Is this a per-CAN-message flag, not controller wide setting?
>> (just curious)
>>
>=20
> Yes, this setting is per-message. The ICAN3_ECHO bit is also
> per-message.
>=20
>>>  	if (cf->can_id & CAN_RTR_FLAG)
>>>  		desc->data[0] |=3D ICAN3_EFF_RTR;
>>> =20
>>> @@ -911,7 +916,6 @@ static void ican3_handle_msglost(struct ican3_dev=
 *mod, struct ican3_msg *msg)
>>>  		cf->can_id |=3D CAN_ERR_CRTL;
>>>  		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>>>  		stats->rx_errors++;
>>> -		stats->rx_bytes +=3D cf->can_dlc;
>>>  		netif_rx(skb);
>>>  	}
>>>  }
>>> @@ -928,7 +932,7 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>>>  	struct net_device *dev =3D mod->ndev;
>>>  	struct net_device_stats *stats =3D &dev->stats;
>>>  	enum can_state state =3D mod->can.state;
>>> -	u8 status, isrc, rxerr, txerr;
>>> +	u8 isrc, ecc, status, rxerr, txerr;
>>>  	struct can_frame *cf;
>>>  	struct sk_buff *skb;
>>> =20
>>> @@ -949,6 +953,7 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>>>  		return -ENOMEM;
>>> =20
>>>  	isrc =3D msg->data[0];
>>> +	ecc =3D msg->data[2];
>>>  	status =3D msg->data[3];
>>>  	rxerr =3D msg->data[4];
>>>  	txerr =3D msg->data[5];
>>> @@ -959,7 +964,6 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>>>  		cf->can_id |=3D CAN_ERR_CRTL;
>>>  		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>>>  		stats->rx_over_errors++;
>>> -		stats->rx_errors++;
>>>  	}
>>> =20
>>>  	/* error warning + passive interrupt */
>>> @@ -981,11 +985,28 @@ static int ican3_handle_cevtind(struct ican3_de=
v *mod, struct ican3_msg *msg)
>>> =20
>>>  	/* bus error interrupt */
>>>  	if (isrc =3D=3D CEVTIND_BEI) {
>>> -		u8 ecc =3D msg->data[2];
>>> -
>>>  		dev_dbg(mod->dev, "bus error interrupt\n");
>>> +
>>> +		/*
>>> +		 * This hardware lacks any support other than bus error
>>> +		 * messages to determine if the packet transmission failed.
>>> +		 *
>>> +		 * This is a TX error, so we free an echo skb from the front
>>> +		 * of the queue.
>>> +		 */
>>> +		if ((ecc & ECC_DIR) =3D=3D 0) {
>>
>> maybe:
>>     if (!(ecc & ECC_DIR)) {
>> then it's consistent with the if (!...)
>>
>=20
> Ok.
>=20
>>> +			cf->data[2] |=3D CAN_ERR_PROT_TX;
>>> +			kfree_skb(skb_dequeue(&mod->echoq));
>>> +			stats->tx_errors++;
>>> +		}
>>> +
>>> +		/* bus error reporting is off, drop the error skb */
>>> +		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
>>> +			kfree_skb(skb);
>>> +			return 0;
>>> +		}
>>
>> Can you move the "if there is a tx-bus error, free echo queue" to the
>> front and return if bus error reporting is disabled? I don't like the
>> idea to alloc a skb and then free it, if it's not needed.
>>
>=20
> Sure. That sounds good to me.
>=20
> I will have to duplicate the "ecc & ECC_DIR" check twice in the code:
> 1) determine if this is a TX bus error to drop the echo packet
> 2) after error skb allocation, for "cf->data[2] |=3D CAN_ERR_PROT_TX"

Having a "ecc & ECC_DIR" is probably much, much more cheaper than to
allocate an skb and free it. The compiler has the chance to optimize the
code if you have two "ecc & ECC_DIR", but it cannot optimize skb
alloc+free :)

>=20
>>> +
>>>  		mod->can.can_stats.bus_error++;
>>> -		stats->rx_errors++;
>>>  		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
>>> =20
>>>  		switch (ecc & ECC_MASK) {
>>> @@ -1004,9 +1025,6 @@ static int ican3_handle_cevtind(struct ican3_de=
v *mod, struct ican3_msg *msg)
>>>  			break;
>>>  		}
>>> =20
>>> -		if ((ecc & ECC_DIR) =3D=3D 0)
>>> -			cf->data[2] |=3D CAN_ERR_PROT_TX;
>>> -
>>>  		cf->data[6] =3D txerr;
>>>  		cf->data[7] =3D rxerr;
>>>  	}
>>> @@ -1031,8 +1049,8 @@ static int ican3_handle_cevtind(struct ican3_de=
v *mod, struct ican3_msg *msg)
>>>  	}
>>> =20
>>>  	mod->can.state =3D state;
>>> -	stats->rx_errors++;
>>> -	stats->rx_bytes +=3D cf->can_dlc;
>>> +	if (!(cf->data[2] & CAN_ERR_PROT_TX))
>>> +		stats->rx_errors++;
>>>  	netif_rx(skb);
>>>  	return 0;
>>>  }
>>> @@ -1467,19 +1485,6 @@ static int ican3_open(struct net_device *ndev)=

>>>  		return ret;
>>>  	}
>>> =20
>>> -	/* set the bus error generation state appropriately */
>>> -	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>>> -		quota =3D ICAN3_BUSERR_QUOTA_MAX;
>>> -	else
>>> -		quota =3D 0;
>>> -
>>> -	ret =3D ican3_set_buserror(mod, quota);
>>> -	if (ret) {
>>> -		dev_err(mod->dev, "unable to set bus-error\n");
>>> -		close_candev(ndev);
>>> -		return ret;
>>> -	}
>>
>> What happened to these two functions? Not needed anymore?
>>
>=20
> If you look through the initialization ican3_startup_module(), the
> ican3_set_buserror() function is still used.
>=20
> The code above *disables* the hardware from generating bus errors if
> CAN_CTRLMODE_BERR_REPORTING is not set. I am now using bus errors to
> determine if a TX error happened. They must always be enabled, so this
> code was removed.

Thanks for the explanation.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE1F74558178F703575A04E2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAHvs4ACgkQjTAFq1RaXHNU9QCfct6yk7+e39Dvt9IWF2iO/Yab
xpwAnizpmC1/MlU8xBMt463VdrnGl3hN
=HgYA
-----END PGP SIGNATURE-----

--------------enigE1F74558178F703575A04E2A--
