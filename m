From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 3/3] can: janz-ican3: add support for one shot mode
Date: Wed, 18 Jul 2012 00:51:03 +0200
Message-ID: <5005EC57.7030504@pengutronix.de>
References: <20120713230521.GD4538@ovro.caltech.edu> <1342220831-11039-1-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig626F4E7C0D93E4523CBAF70C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50238 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab2GQWvQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jul 2012 18:51:16 -0400
In-Reply-To: <1342220831-11039-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig626F4E7C0D93E4523CBAF70C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/14/2012 01:07 AM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The Janz VMOD-ICAN3 hardware has support for one shot packet
> transmission. This means that a packet will be attempted to be sent
> once, with no automatic retries.
>=20
> The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.
>=20
> Every time a packet transmission failure happens, one packet needs to b=
e
> dropped from the front of the ECHO queue. This hardware lacks support
> for TX-error interrupts, and so bus error indications are used as a
> workaround. Every time a TX bus error is received, we know a packet
> failed to transmit. If bus error reporting is off, do not forward the
> bus error packets to userspace.

Can you please test in normal mode (i.e. non-oneshot-mode) on a proper
terminated bus without a second CAN station on the bus. Send a single
CAN message. How does the controller behave? What happens if you then
add a second member to the bus? Is the original CAN message finally
received?

With the scheme "drop frame from echo queue on tx error" in the worst
case you loose some echo messages, but at least the queue will not overfl=
ow.

>=20
> The rx_bytes and tx_bytes counters were audited to make sure they only
> reflect actual data bytes received from the bus. They do not include
> error packets.
>=20
> The rx_errors and tx_errors counters were audited to make sure they are=

> correct in all situations. Previously, the rx_errors counts were
> sometimes too high.

Maybe split the _byte and _error fixes into a seperate patch (both fixes
can be in the same patch, though).
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>=20
> This patch should superceed the previous patch posted with this title.
>=20
>  drivers/net/can/janz-ican3.c |   56 +++++++++++++++++++++++-----------=
-------
>  1 files changed, 31 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.=
c
> index 5fff829..fccfc3a 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -116,6 +116,7 @@
>  #define ICAN3_BUSERR_QUOTA_MAX	255
> =20
>  /* Janz ICAN3 CAN Frame Conversion */
> +#define ICAN3_SNGL	0x02
>  #define ICAN3_ECHO	0x10
>  #define ICAN3_EFF_RTR	0x40
>  #define ICAN3_SFF_RTR	0x10
> @@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev *m=
od,
>  	desc->data[0] |=3D cf->can_dlc;
>  	desc->data[1] |=3D ICAN3_ECHO;
> =20
> +	/* support single transmission (no retries) mode */
> +	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +		desc->data[1] |=3D ICAN3_SNGL;
> +

Is this a per-CAN-message flag, not controller wide setting?
(just curious)

>  	if (cf->can_id & CAN_RTR_FLAG)
>  		desc->data[0] |=3D ICAN3_EFF_RTR;
> =20
> @@ -911,7 +916,6 @@ static void ican3_handle_msglost(struct ican3_dev *=
mod, struct ican3_msg *msg)
>  		cf->can_id |=3D CAN_ERR_CRTL;
>  		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>  		stats->rx_errors++;
> -		stats->rx_bytes +=3D cf->can_dlc;
>  		netif_rx(skb);
>  	}
>  }
> @@ -928,7 +932,7 @@ static int ican3_handle_cevtind(struct ican3_dev *m=
od, struct ican3_msg *msg)
>  	struct net_device *dev =3D mod->ndev;
>  	struct net_device_stats *stats =3D &dev->stats;
>  	enum can_state state =3D mod->can.state;
> -	u8 status, isrc, rxerr, txerr;
> +	u8 isrc, ecc, status, rxerr, txerr;
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
> =20
> @@ -949,6 +953,7 @@ static int ican3_handle_cevtind(struct ican3_dev *m=
od, struct ican3_msg *msg)
>  		return -ENOMEM;
> =20
>  	isrc =3D msg->data[0];
> +	ecc =3D msg->data[2];
>  	status =3D msg->data[3];
>  	rxerr =3D msg->data[4];
>  	txerr =3D msg->data[5];
> @@ -959,7 +964,6 @@ static int ican3_handle_cevtind(struct ican3_dev *m=
od, struct ican3_msg *msg)
>  		cf->can_id |=3D CAN_ERR_CRTL;
>  		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>  		stats->rx_over_errors++;
> -		stats->rx_errors++;
>  	}
> =20
>  	/* error warning + passive interrupt */
> @@ -981,11 +985,28 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
> =20
>  	/* bus error interrupt */
>  	if (isrc =3D=3D CEVTIND_BEI) {
> -		u8 ecc =3D msg->data[2];
> -
>  		dev_dbg(mod->dev, "bus error interrupt\n");
> +
> +		/*
> +		 * This hardware lacks any support other than bus error
> +		 * messages to determine if the packet transmission failed.
> +		 *
> +		 * This is a TX error, so we free an echo skb from the front
> +		 * of the queue.
> +		 */
> +		if ((ecc & ECC_DIR) =3D=3D 0) {

maybe:
    if (!(ecc & ECC_DIR)) {
then it's consistent with the if (!...)

> +			cf->data[2] |=3D CAN_ERR_PROT_TX;
> +			kfree_skb(skb_dequeue(&mod->echoq));
> +			stats->tx_errors++;
> +		}
> +
> +		/* bus error reporting is off, drop the error skb */
> +		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
> +			kfree_skb(skb);
> +			return 0;
> +		}

Can you move the "if there is a tx-bus error, free echo queue" to the
front and return if bus error reporting is disabled? I don't like the
idea to alloc a skb and then free it, if it's not needed.

> +
>  		mod->can.can_stats.bus_error++;
> -		stats->rx_errors++;
>  		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> =20
>  		switch (ecc & ECC_MASK) {
> @@ -1004,9 +1025,6 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>  			break;
>  		}
> =20
> -		if ((ecc & ECC_DIR) =3D=3D 0)
> -			cf->data[2] |=3D CAN_ERR_PROT_TX;
> -
>  		cf->data[6] =3D txerr;
>  		cf->data[7] =3D rxerr;
>  	}
> @@ -1031,8 +1049,8 @@ static int ican3_handle_cevtind(struct ican3_dev =
*mod, struct ican3_msg *msg)
>  	}
> =20
>  	mod->can.state =3D state;
> -	stats->rx_errors++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	if (!(cf->data[2] & CAN_ERR_PROT_TX))
> +		stats->rx_errors++;
>  	netif_rx(skb);
>  	return 0;
>  }
> @@ -1467,19 +1485,6 @@ static int ican3_open(struct net_device *ndev)
>  		return ret;
>  	}
> =20
> -	/* set the bus error generation state appropriately */
> -	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> -		quota =3D ICAN3_BUSERR_QUOTA_MAX;
> -	else
> -		quota =3D 0;
> -
> -	ret =3D ican3_set_buserror(mod, quota);
> -	if (ret) {
> -		dev_err(mod->dev, "unable to set bus-error\n");
> -		close_candev(ndev);
> -		return ret;
> -	}

What happened to these two functions? Not needed anymore?

> -
>  	/* bring the bus online */
>  	ret =3D ican3_set_bus_state(mod, true);
>  	if (ret) {
> @@ -1791,7 +1796,8 @@ static int __devinit ican3_probe(struct platform_=
device *pdev)
>  	mod->can.do_set_mode =3D ican3_set_mode;
>  	mod->can.do_get_berr_counter =3D ican3_get_berr_counter;
>  	mod->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES
> -				    | CAN_CTRLMODE_BERR_REPORTING;
> +				    | CAN_CTRLMODE_BERR_REPORTING
> +				    | CAN_CTRLMODE_ONE_SHOT;
> =20
>  	/* find our IRQ number */
>  	mod->irq =3D platform_get_irq(pdev, 0);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig626F4E7C0D93E4523CBAF70C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAF7F4ACgkQjTAFq1RaXHPV4gCghRUubhBE9Kzp/5v7wgzB+2Wj
cpQAoII6yooz6zpqNzxSVAbJk6phd1kA
=kSXj
-----END PGP SIGNATURE-----

--------------enig626F4E7C0D93E4523CBAF70C--
