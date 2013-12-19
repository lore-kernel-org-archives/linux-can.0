From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: tx interrupts can be missed, check for tx
 outside of just the tx interrupt routine
Date: Thu, 19 Dec 2013 21:55:37 +0100
Message-ID: <52B35D49.5040602@pengutronix.de>
References: <F29A6C278512904F884221EFA2821933C357@AMEHLEX01.ehl.pri>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Jrh4Htk4b84G4XOSePFsQWFNEDSOWCxXu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45709 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab3LSUz6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Dec 2013 15:55:58 -0500
In-Reply-To: <F29A6C278512904F884221EFA2821933C357@AMEHLEX01.ehl.pri>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Glen, Andrew" <AGlen@bepmarine.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jrh4Htk4b84G4XOSePFsQWFNEDSOWCxXu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2013 08:38 PM, Glen, Andrew wrote:
> Using the c_can driver on an AM335x platform (the Beaglebone Black) I
> have found that tx interrupts can be occasionally missed, causing the
> tx queue to halt indefinitely (i.e. until manually restarted with a
> can down/up).
>=20
> The fault occurs when there is a high can-bus load (~40% @ 250k) and
> I hot-swapping a usb devices (i.e. continuously plugging and
> unplugging a usb flash drive the fault will occur about 1/10 of the
> time) - I'd assume there would be other processor intensive
> combinations of things that would also cause this problem.
>=20
> The can device continues to rx fine, and reports no obvious fault,
> other than rejecting new message writes due to a tx buffer overflow,
> which can then only be cleared by bringing the device down and then
> back up again.
>=20
> To ensure tx events are always handled even if a tx interrupt is
> missed, I propose the following patch to check for a successful tx on
> every can interrupt, including rx and state changes. If a successful
> tx is detected in any of these cases a conditional call to
> netif_wake_queue is called.
>=20
> My initial thought was to perform this check the 'c_can_start_xmit'
> function, but it is my understanding that once 'netif_stop_queue' has
> been called there will be no further calls made to 'c_can_start_xmit'
> until 'netif_wake_queue' has been called - which is only ever occurs
> after a tx interrupt has been handled - which as noted earlier can be
> problematic. So even checking for a successful tx in
> 'c_can_start_xmit' would catch most cases of missed tx interrupts, it
> would still leave open the corner case that if the tx buffer did
> become full and then very next successful tx was missed, the tx queue
> would become stuck.
>=20
> This obviously introduces some redundancy, in terms of the frequency
> at which the tx register is checked, but I think this is a necessary
> backstop for missed interrupts under all circumstances.
>=20
> Reported-by: Andrew Glen <AGlen@bepmarine.com>
> Tested-by: Andrew Glen <AGlen@bepmarine.com>

When you write a patch, you should add your Signed-off-by here, please
remove the Reported and Tested by.

> ---
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 77061ee..447c873 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -756,6 +756,7 @@ static void c_can_do_tx(struct net_device *dev)
>         u32 msg_obj_no;
>         struct c_can_priv *priv =3D netdev_priv(dev);
>         struct net_device_stats *stats =3D &dev->stats;
> +       bool tx_done =3D false;
>=20
>         for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_e=
cho++) {
>                 msg_obj_no =3D get_tx_echo_msg_obj(priv);
> @@ -770,15 +771,19 @@ static void c_can_do_tx(struct net_device *dev)
>                         stats->tx_packets++;
>                         can_led_event(dev, CAN_LED_EVENT_TX);
>                         c_can_inval_msg_object(dev, 0, msg_obj_no);
> +                       tx_done =3D true;
>                 } else {
>                         break;
>                 }
>         }
>=20
> -       /* restart queue if wrap-up or if queue stalled on last pkt */
> -       if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) !=3D 0) ||
> -                       ((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) =3D=3D=
 0))
> -               netif_wake_queue(dev);
> +    if (tx_done)
> +    {
> +               /* restart queue if wrap-up or if queue stalled on last=
 pkt */
> +               if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) !=3D 0) =
||
> +                               ((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MA=
SK) =3D=3D 0))
> +                   netif_wake_queue(dev);
> +       }
>  }
>=20
>  /*
> @@ -1082,6 +1087,9 @@ static int c_can_poll(struct napi_struct *napi, i=
nt quota)
>                 c_can_do_tx(dev);
>         }
>=20
> +       /* Always check for successful tx */
> +       c_can_do_tx(dev);
> +
>  end:
>         if (work_done < quota) {
>                 napi_complete(napi);
>=20
> ________________________________

You change the driver to always check for a TX Interrupt, right? Having
a quick look at c_can_pollc_can_poll() I think the driver has a problem,
when more than one Interrupt occurs:

	if (irqstatus =3D=3D STATUS_INTERRUPT) {
	} else if ((irqstatus >=3D C_CAN_MSG_OBJ_RX_FIRST) &&
			(irqstatus <=3D C_CAN_MSG_OBJ_RX_LAST)) {
	} else if ((irqstatus >=3D C_CAN_MSG_OBJ_TX_FIRST) &&
			(irqstatus <=3D C_CAN_MSG_OBJ_TX_LAST)) {
	}

I think there should be individual if()s checking for the bits set,
about like this:

	if (irqstatus & STATUS_INTERRUPT) {
	}
	if (irqstatus & C_CAN_MSG_OBJ_RX_MASK) {
	}
	if ((irqstatus & C_CAN_MSG_OBJ_TX_MASK) {
	}

C_CAN_MSG_OBJ_RX_MASK and C_CAN_MSG_OBJ_TX_MASK must be defined
appropriately.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jrh4Htk4b84G4XOSePFsQWFNEDSOWCxXu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKzXU4ACgkQjTAFq1RaXHNBcACeN4ufoGK000qW8NaSqoivehZa
hdsAn12fHYxiTt5kGjgLqicsS7NAH7yu
=hXwK
-----END PGP SIGNATURE-----

--Jrh4Htk4b84G4XOSePFsQWFNEDSOWCxXu--
