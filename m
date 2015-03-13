From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add combined rx/tx LED trigger support
Date: Fri, 13 Mar 2015 16:20:07 +0100
Message-ID: <55030027.7010204@pengutronix.de>
References: <1426259760-14394-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="I3EPUKGcNV2jFBltA21V3CELgHSSaMJaB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbbCMPUU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Mar 2015 11:20:20 -0400
In-Reply-To: <1426259760-14394-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: fabio.baltieri@gmail.com, socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I3EPUKGcNV2jFBltA21V3CELgHSSaMJaB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2015 04:16 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Add <ifname>-rxtx trigger, that will be activated both for tx
> as rx events. This trigger mimics "activity" LED for Ethernet
> devices.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/net/can/led.c   |   14 ++++++++++++--
>  include/linux/can/dev.h |    2 ++
>  include/linux/can/led.h |    2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
> index ab7f1b0..56d940a 100644
> --- a/drivers/net/can/led.c
> +++ b/drivers/net/can/led.c
> @@ -36,14 +36,20 @@ void can_led_event(struct net_device *netdev, enum =
can_led_event event)
>  		led_trigger_event(priv->rx_led_trig, LED_OFF);
>  		break;
>  	case CAN_LED_EVENT_TX:
> -		if (led_delay)
> +		if (led_delay) {
>  			led_trigger_blink_oneshot(priv->tx_led_trig,
>  						  &led_delay, &led_delay, 1);
> +			led_trigger_blink_oneshot(priv->rxtx_led_trig,
> +						  &led_delay, &led_delay, 1);
> +		}
>  		break;
>  	case CAN_LED_EVENT_RX:
> -		if (led_delay)
> +		if (led_delay) {
>  			led_trigger_blink_oneshot(priv->rx_led_trig,
>  						  &led_delay, &led_delay, 1);
> +			led_trigger_blink_oneshot(priv->rxtx_led_trig,
> +						  &led_delay, &led_delay, 1);
> +		}
>  		break;
>  	}
>  }
> @@ -76,11 +82,15 @@ void devm_can_led_init(struct net_device *netdev)
>  		 "%s-tx", netdev->name);
>  	snprintf(priv->rx_led_trig_name, sizeof(priv->rx_led_trig_name),
>  		 "%s-rx", netdev->name);
> +	snprintf(priv->rxtx_led_trig_name, sizeof(priv->rxtx_led_trig_name),
> +		 "%s-rxtx", netdev->name);
> =20
>  	led_trigger_register_simple(priv->tx_led_trig_name,
>  				    &priv->tx_led_trig);
>  	led_trigger_register_simple(priv->rx_led_trig_name,
>  				    &priv->rx_led_trig);
> +	led_trigger_register_simple(priv->rxtx_led_trig_name,
> +				    &priv->rxtx_led_trig);
> =20
>  	devres_add(&netdev->dev, res);
>  }
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index c05ff0f..c3a9c8f 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -61,6 +61,8 @@ struct can_priv {
>  	char tx_led_trig_name[CAN_LED_NAME_SZ];
>  	struct led_trigger *rx_led_trig;
>  	char rx_led_trig_name[CAN_LED_NAME_SZ];
> +	struct led_trigger *rxtx_led_trig;
> +	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
>  #endif
>  };
> =20
> diff --git a/include/linux/can/led.h b/include/linux/can/led.h
> index e0475c5..c60f542 100644
> --- a/include/linux/can/led.h
> +++ b/include/linux/can/led.h
> @@ -22,7 +22,7 @@ enum can_led_event {
>  #ifdef CONFIG_CAN_LEDS
> =20
>  /* keep space for interface name + "-tx"/"-rx" suffix and null termina=
tor */
                                      ^^^^^^^^^^^
Nitpick: can you update the comment.

> -#define CAN_LED_NAME_SZ (IFNAMSIZ + 4)
> +#define CAN_LED_NAME_SZ (IFNAMSIZ + 6)
> =20
>  void can_led_event(struct net_device *netdev, enum can_led_event event=
);
>  void devm_can_led_init(struct net_device *netdev);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--I3EPUKGcNV2jFBltA21V3CELgHSSaMJaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVAwArAAoJECte4hHFiupUb3wP/R+jd3SjbQCqtH9ZEeVpzHnf
1tDPLP7da0S68jWFa0D2hFwAhjjS+QnNgqHpcumdXQkibs3lQNPeDjIO5szWnBBi
hoFVfLd/+whTyuUFI3GEeO41BeV1VqLYOdQmZqDdeYkJbSwR2Nq+cjv09h42R3K3
m6/a23w8i/ouorJM7GS/9231KI5yi2P3m9NJ9hegQjAA3b83FqdS0NZcl9gBRRBT
b5UUrfQ3wJz3eiCksmcfbOVmDeq97riUb/zVLb/hWc6Q6S+s9CJ+y9s2Ti+XiU6y
2RutZxF8Aq1fmEFOzWwaqez8haaE7kI8n7EgJa9hvifYj1kUnoMozx2SD7juRMPD
CSAegI8XWW35y63omQO50RirOViRcft4MpgGmRYXujUZkJY/CIrAqirgX1fX1z36
815CW7L9elPCf/1HHClGsDBjxrbsO6DxuQlptoCc1YDguLs8F3/54eoIyoS1zIVU
wE6aFcuJ44UcYdzE+/KoRMD4Vjsl5WoCufbVOGXO53TdS5iF4wxX3ocyXy1V7rMQ
yxzY6dnamIGNsrQG3e6NX4QKddJ/tV1XCZkSCv2nOkfLB/vJatS8vYq6nvh2+U8J
m54JStl8ZwIWwP72NJPCn3+AyeXpf53LyJbuC2ZidiwsjUFmL3j9SKPujgCNTygg
tEfyu7CozCbsTObOAyqv
=ZO+w
-----END PGP SIGNATURE-----

--I3EPUKGcNV2jFBltA21V3CELgHSSaMJaB--
