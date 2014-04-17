From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net can softing: drop 'channel' sysfs attribute
Date: Thu, 17 Apr 2014 22:29:28 +0200
Message-ID: <535039A8.1050002@pengutronix.de>
References: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nd1B2SLgUVork3jGgA10VSsiSIDSF19UI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53535 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaDQU3d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:29:33 -0400
In-Reply-To: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nd1B2SLgUVork3jGgA10VSsiSIDSF19UI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 09:17 PM, Kurt Van Dijck wrote:
> netdev->dev_id obsoletes this property.
> None of the remaining properties contribute to udev detection methods.
> The regular calls for the sysfs group can thus safely be restored.
>=20
> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
> ---
>  drivers/net/can/softing/softing_main.c |   16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/s=
ofting/softing_main.c
> index 65eef1e..6cfbccd 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -558,15 +558,6 @@ failed:
>  /*
>   * netdev sysfs
>   */
> -static ssize_t show_channel(struct device *dev, struct device_attribut=
e *attr,
> -		char *buf)
> -{
> -	struct net_device *ndev =3D to_net_dev(dev);
> -	struct softing_priv *priv =3D netdev2softing(ndev);
> -
> -	return sprintf(buf, "%i\n", priv->index);
> -}
> -
>  static ssize_t show_chip(struct device *dev, struct device_attribute *=
attr,
>  		char *buf)
>  {
> @@ -611,12 +602,10 @@ static ssize_t store_output(struct device *dev, s=
truct device_attribute *attr,
>  	return count;
>  }
> =20
> -static const DEVICE_ATTR(channel, S_IRUGO, show_channel, NULL);
>  static const DEVICE_ATTR(chip, S_IRUGO, show_chip, NULL);
>  static const DEVICE_ATTR(output, S_IRUGO | S_IWUSR, show_output, store=
_output);
> =20
>  static const struct attribute *const netdev_sysfs_attrs[] =3D {
> -	&dev_attr_channel.attr,
>  	&dev_attr_chip.attr,
>  	&dev_attr_output.attr,
>  	NULL,
> @@ -680,17 +669,20 @@ static int softing_netdev_register(struct net_dev=
ice *netdev)
>  {
>  	int ret;
> =20
> -	netdev->sysfs_groups[0] =3D &netdev_sysfs_group;
>  	ret =3D register_candev(netdev);
>  	if (ret) {
>  		dev_alert(&netdev->dev, "register failed\n");
>  		return ret;
>  	}
> +	if (sysfs_create_group(&netdev->dev.kobj, &netdev_sysfs_group) < 0)
> +		netdev_alert(netdev, "sysfs group failed\n");
> +

What is the difference between using sysfs_create_group() and
netdev->sysfs_groups[0]?

>  	return 0;
>  }
> =20
>  static void softing_netdev_cleanup(struct net_device *netdev)
>  {
> +	sysfs_remove_group(&netdev->dev.kobj, &netdev_sysfs_group);
>  	unregister_candev(netdev);
>  	free_candev(netdev);
>  }
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nd1B2SLgUVork3jGgA10VSsiSIDSF19UI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQOagACgkQjTAFq1RaXHOrYACgjPYZWw9DZyh/qzWdg3SNdgQ5
1ksAnR2MoIc81Bk3OcjLe7teT4myOHz3
=vTTt
-----END PGP SIGNATURE-----

--nd1B2SLgUVork3jGgA10VSsiSIDSF19UI--
