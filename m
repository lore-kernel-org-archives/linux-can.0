From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 5/5] can: allow to change the device mtu for CAN FD
 capable devices
Date: Sat, 15 Feb 2014 17:59:56 +0100
Message-ID: <52FF9D0C.30406@pengutronix.de>
References: <1392481934-12569-1-git-send-email-socketcan@hartkopp.net> <1392481934-12569-5-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NJsuuqrO9W42afeuewPEa1CmcK3vMFjXt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36089 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbaBOQ77 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Feb 2014 11:59:59 -0500
In-Reply-To: <1392481934-12569-5-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJsuuqrO9W42afeuewPEa1CmcK3vMFjXt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

please add a cover letter (--compose option to git send-email) when
sending a new version of the series, briefly listing your changes (one
line per change).

Please add a patch description to patch 4, as in the kernel it's
considered bad style to have patches without a description.

On 02/15/2014 05:32 PM, Oliver Hartkopp wrote:
> The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in the =
driver
> specific ctrlmode_supported capabilities.
>=20
> The configuration can be done either with the 'fd { on | off }' option =
in the
> 'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU =
(16) or
> to CANFD_MTU (72).

Please don't add two possibilities to activate canfd on a CAN network
card. There should only be one.

>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c            | 40 ++++++++++++++++++++++++++++++++=
++++++++
>  include/linux/can/dev.h          |  1 +
>  include/uapi/linux/can/netlink.h |  1 +
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index a2b9bce..397efa4 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -598,6 +598,40 @@ void free_candev(struct net_device *dev)
>  EXPORT_SYMBOL_GPL(free_candev);
> =20
>  /*
> + * changing MTU and control mode for CAN/CANFD devices
> + */
> +int can_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct can_priv *priv =3D netdev_priv(dev);
> +
> +	/* Do not allow changing the MTU while running */
> +	if (dev->flags & IFF_UP)
> +		return -EBUSY;
> +
> +	/* allow change of MTU according to the CANFD ability of the device *=
/
> +	switch (new_mtu) {
> +
> +	case CAN_MTU:
> +		priv->ctrlmode &=3D ~CAN_CTRLMODE_FD;
> +		break;
> +
> +	case CANFD_MTU:
> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
> +			return -EINVAL;
> +
> +		priv->ctrlmode |=3D CAN_CTRLMODE_FD;
> +		break;
> +
> +	default:
> +			return -EINVAL;
> +	}
> +
> +	dev->mtu =3D new_mtu;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(can_change_mtu);

Who will be the user of this function? The individual network drivers?

> +
> +/*
>   * Common open function when the device gets opened.
>   *
>   * This function should be called in the open function of the device
> @@ -721,6 +755,12 @@ static int can_changelink(struct net_device *dev,
>  			return -EOPNOTSUPP;
>  		priv->ctrlmode &=3D ~cm->mask;
>  		priv->ctrlmode |=3D cm->flags;
> +
> +		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
> +		if (priv->ctrlmode & CAN_CTRLMODE_FD)
> +			dev->mtu =3D CANFD_MTU;
> +		else
> +			dev->mtu =3D CAN_MTU;
>  	}
> =20
>  	if (data[IFLA_CAN_RESTART_MS]) {
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 8adaee9..3ce5e52 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -113,6 +113,7 @@ struct can_priv *safe_candev_priv(struct net_device=
 *dev);
> =20
>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
> +int can_change_mtu(struct net_device *dev, int new_mtu);
> =20
>  int register_candev(struct net_device *dev);
>  void unregister_candev(struct net_device *dev);
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> index b41933d..7e2e186 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -96,6 +96,7 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
>  #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>  #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
> +#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
> =20
>  /*
>   * CAN device statistics
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NJsuuqrO9W42afeuewPEa1CmcK3vMFjXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL/nQwACgkQjTAFq1RaXHOIhQCffSXULmzWXhCNTzSIdGwGy5KM
DEUAn0Bd6XPM9JZ7TqvPZRj3AVGM7Zb9
=S58I
-----END PGP SIGNATURE-----

--NJsuuqrO9W42afeuewPEa1CmcK3vMFjXt--
