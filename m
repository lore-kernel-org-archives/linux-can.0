From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v5 2/2] can: flexcan: add LED trigger support
Date: Wed, 01 Aug 2012 13:53:22 +0200
Message-ID: <501918B2.6070703@pengutronix.de>
References: <5018F8B3.6080404@pengutronix.de> <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com> <1343821782-1346-2-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4CE5093ABB553C7B4BCEB683"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45054 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab2HALx3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 07:53:29 -0400
In-Reply-To: <1343821782-1346-2-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CE5093ABB553C7B4BCEB683
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 01:49 PM, Fabio Baltieri wrote:
> Add support for canbus activity led indicators on flexcan devices by
> calling appropriate can_led_* functions.
>=20
> These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
> otherwise.
>=20
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
>  drivers/net/can/flexcan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index c5f1431..6467fc1 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -23,6 +23,7 @@
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> +#include <linux/can/led.h>
>  #include <linux/can/platform/flexcan.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -547,6 +548,8 @@ static int flexcan_read_frame(struct net_device *de=
v)
>  	stats->rx_packets++;
>  	stats->rx_bytes +=3D cf->can_dlc;
> =20
> +	can_led_event(dev, CAN_LED_EVENT_RX);
> +
>  	return 1;
>  }
> =20
> @@ -635,6 +638,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
>  		stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>  		stats->tx_packets++;
> +		can_led_event(dev, CAN_LED_EVENT_TX);

Should the led blink on TX or TX completion interrupt?

>  		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
>  		netif_wake_queue(dev);
>  	}
> @@ -844,6 +848,9 @@ static int flexcan_open(struct net_device *dev)
>  	err =3D flexcan_chip_start(dev);
>  	if (err)
>  		goto out_close;
> +
> +	can_led_event(dev, CAN_LED_EVENT_OPEN);
> +
>  	napi_enable(&priv->napi);
>  	netif_start_queue(dev);
> =20
> @@ -872,6 +879,8 @@ static int flexcan_close(struct net_device *dev)
> =20
>  	close_candev(dev);
> =20
> +	can_led_event(dev, CAN_LED_EVENT_STOP);
> +
>  	return 0;
>  }
> =20
> @@ -1068,6 +1077,8 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  		goto failed_register;
>  	}
> =20
> +	devm_can_led_init(dev);
> +
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",=

>  		 priv->base, dev->irq);
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4CE5093ABB553C7B4BCEB683
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZGLYACgkQjTAFq1RaXHMn+QCgkK+XP2RtYImLj2mvpBP6zd55
OQ4An3yLkjf4so1APqgGLMoG29qSLoCh
=kJ/p
-----END PGP SIGNATURE-----

--------------enig4CE5093ABB553C7B4BCEB683--
