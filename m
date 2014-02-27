From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Thu, 27 Feb 2014 09:43:12 +0100
Message-ID: <530EFAA0.4090000@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N6tWILtJ3caxHRKpFc4gx8I9FKfJlhwqk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43542 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbaB0JP4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 04:15:56 -0500
In-Reply-To: <1393452662-3154-5-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N6tWILtJ3caxHRKpFc4gx8I9FKfJlhwqk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2014 11:11 PM, Oliver Hartkopp wrote:
> As CAN FD offers a second bitrate for the data section of the CAN frame=
 the
> infrastructure for storing and configuring this second bitrate is intro=
duced.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c            | 42 ++++++++++++++++++++++++++++++++=
+++++++-
>  include/linux/can/dev.h          |  6 ++++--
>  include/uapi/linux/can/netlink.h |  2 ++
>  3 files changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 368d92d..7887691 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -660,6 +660,10 @@ static const struct nla_policy can_policy[IFLA_CAN=
_MAX + 1] =3D {
>  				=3D { .len =3D sizeof(struct can_bittiming_const) },
>  	[IFLA_CAN_CLOCK]	=3D { .len =3D sizeof(struct can_clock) },
>  	[IFLA_CAN_BERR_COUNTER]	=3D { .len =3D sizeof(struct can_berr_counter=
) },
> +	[IFLA_CAN_DATA_BITTIMING]
> +				=3D { .len =3D sizeof(struct can_bittiming) },
> +	[IFLA_CAN_DATA_BITTIMING_CONST]
> +				=3D { .len =3D sizeof(struct can_bittiming_const) },
>  };
> =20
>  static int can_changelink(struct net_device *dev,
> @@ -693,6 +697,29 @@ static int can_changelink(struct net_device *dev,
>  		}
>  	}
> =20
> +	if (data[IFLA_CAN_DATA_BITTIMING]) {
> +		struct can_bittiming bt;
> +
> +		/* Do not allow changing bittiming while running */
> +		if (dev->flags & IFF_UP)
> +			return -EBUSY;
> +		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> +		       sizeof(bt));
> +		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
> +			return -EINVAL;
> +		err =3D can_get_bittiming(dev, &bt, priv->data_bittiming_const);
> +		if (err)
> +			return err;
> +		memcpy(&priv->data_bittiming, &bt, sizeof(bt));
> +
> +		if (priv->do_set_data_bittiming) {
> +			/* Finally, set the bit-timing registers */
> +			err =3D priv->do_set_data_bittiming(dev);
> +			if (err)
> +				return err;
> +		}

Do we really need the do_set_data_bittiming() callback? Allmost all
drivers set the bitrate during open and not asynchronously (when the
interface is down) via the set_bittiming() callback. If there is a
driver which really needs this callback, we can introduce it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--N6tWILtJ3caxHRKpFc4gx8I9FKfJlhwqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMO+qAACgkQjTAFq1RaXHMw5QCeIJVx+0Vjc5IX899eem3U4Xe1
JPUAn2AY57tmTBu4orpLwbqfZNApw8VJ
=VXj3
-----END PGP SIGNATURE-----

--N6tWILtJ3caxHRKpFc4gx8I9FKfJlhwqk--
