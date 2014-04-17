From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/5] can: slcan: Add bitrate change support
Date: Thu, 17 Apr 2014 21:13:20 +0200
Message-ID: <535027D0.5000608@pengutronix.de>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <1397573468-7619-5-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q1CH4uO9KVRtqiMsmjFd3xJg2o43LHDDA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51260 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaDQTNW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 15:13:22 -0400
In-Reply-To: <1397573468-7619-5-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q1CH4uO9KVRtqiMsmjFd3xJg2o43LHDDA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 04:51 PM, Alexander Stein wrote:
> Only a fixed set of bitrates are supported.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/net/can/Kconfig |  5 +++--
>  drivers/net/can/slcan.c | 53 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 56 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index daea043..267aec2 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -113,8 +113,9 @@ config CAN_SLCAN
>  	  via serial lines or via USB-to-serial adapters using the LAWICEL
>  	  ASCII protocol. The driver implements the tty linediscipline N_SLCA=
N.
> =20
> -	  As only the sending and receiving of CAN frames is implemented, thi=
s
> -	  driver should work with the (serial/USB) CAN hardware from:
> +	  Sending, receiving of CAN frames as well as bitrate setting is
> +	  implemented, this driver should work with the
> +	  (serial/USB) CAN hardware from:
>  	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.d=
e
> =20
>  	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index 8a578bb..8d98f50 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -454,6 +454,58 @@ static int slc_open(struct net_device *dev)
>  	return 0;
>  }
> =20
> +static int slc_set_bittiming(struct net_device *dev)
> +{
> +	struct slcan *sl =3D netdev_priv(dev);
> +	const struct can_bittiming *bt =3D &sl->can.bittiming;
> +	int index, written, len;
> +	char buf[4];
> +
> +	switch (bt->bitrate) {
> +	case 1000000:
> +		index =3D 8;
> +		break;
> +	case 800000:
> +		index =3D 7;
> +		break;
> +	case 500000:
> +		index =3D 6;
> +		break;
> +	case 250000:
> +		index =3D 5;
> +		break;
> +	case 125000:
> +		index =3D 4;
> +		break;
> +	case 100000:
> +		index =3D 3;
> +		break;
> +	case 50000:
> +		index =3D 2;
> +		break;
> +	case 20000:
> +		index =3D 1;
> +		break;
> +	case 10000:
> +		index =3D 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	if (!sl->tty)
> +		return -ENOENT;
> +
> +	len =3D snprintf(buf, sizeof(buf), "S%d\r", index);
> +	written =3D sl->tty->ops->write(sl->tty, buf, len);
> +	if (written !=3D len) {
> +		netdev_warn(sl->dev, "Setting bitrate command could not be sent!\n")=
;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Hook the destructor so we can free slcan devs at the right point in=
 time */
>  static void slc_free_netdev(struct net_device *dev)
>  {
> @@ -613,6 +665,7 @@ static int slcan_open(struct tty_struct *tty)
>  		sl->rcount   =3D 0;
>  		sl->xleft    =3D 0;
> =20
> +		sl->can.do_set_bittiming =3D slc_set_bittiming;

Can you move the slc_set_bittiming into the open function? Then you
don't need to assign this callback.

>  		set_bit(SLF_INUSE, &sl->flags);
> =20
>  		err =3D register_candev(sl->dev);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Q1CH4uO9KVRtqiMsmjFd3xJg2o43LHDDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQJ9AACgkQjTAFq1RaXHNqmgCfbMsokYBdwLEK0RPZSvq7XPnH
0xEAnjyo5BTEaF3a+PrQ4jTca20YZEWY
=1WC2
-----END PGP SIGNATURE-----

--Q1CH4uO9KVRtqiMsmjFd3xJg2o43LHDDA--
