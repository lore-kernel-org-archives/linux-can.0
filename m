From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
Date: Tue, 2 Jan 2018 14:00:50 +0100
Message-ID: <b3cb6058-f61f-b643-a26f-c8330d9a3ffa@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lojS22k3aMN8TE3gRVpM7XGowopQoGyLZ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47695 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752816AbeABNKS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Jan 2018 08:10:18 -0500
In-Reply-To: <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lojS22k3aMN8TE3gRVpM7XGowopQoGyLZ
Content-Type: multipart/mixed; boundary="sXvgQo1jvj4cX6w3cKFDCEbI3gjdcaGHz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com
Message-ID: <b3cb6058-f61f-b643-a26f-c8330d9a3ffa@pengutronix.de>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>

--sXvgQo1jvj4cX6w3cKFDCEbI3gjdcaGHz
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 02:31 PM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> Various CAN or CAN-FD IP may be able to run at a faster rate than
> what the transceiver the CAN node is connected to. This can lead to
> unexpected errors. However, CAN transceivers typically have fixed
> limitations and provide no means to discover these limitations at
> runtime. Therefore, add support for a can-transceiver node that
> can be reused by other CAN peripheral drivers to determine for both
> CAN and CAN-FD what the max bitrate that can be used. If the user
> tries to configure CAN to pass these maximum bitrates it will throw
> an error.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> [nsekhar@ti.com: fix build error with !CONFIG_OF]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
> v6 changes:
> fix build error with !CONFIG_OF
>=20
>  drivers/net/can/dev.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h |  8 ++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 365a8cc..007cfc0 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -27,6 +27,7 @@
>  #include <linux/can/skb.h>
>  #include <linux/can/netlink.h>
>  #include <linux/can/led.h>
> +#include <linux/of.h>
>  #include <net/rtnetlink.h>
> =20
>  #define MOD_DESC "CAN device driver interface"
> @@ -814,6 +815,30 @@ int open_candev(struct net_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(open_candev);
> =20
> +#ifdef CONFIG_OF
> +/*
> + * Common function that can be used to understand the limitation of
> + * a transceiver when it provides no means to determine these limitati=
ons
> + * at runtime.
> + */
> +void of_can_transceiver(struct net_device *dev)
> +{
> +	struct device_node *dn;
> +	struct can_priv *priv =3D netdev_priv(dev);
> +	struct device_node *np =3D dev->dev.parent->of_node;
> +	int ret;
> +
> +	dn =3D of_get_child_by_name(np, "can-transceiver");
> +	if (!dn)
> +		return;
> +
> +	ret =3D of_property_read_u32(dn, "max-bitrate", &priv->max_bitrate);
> +	if ((ret && ret !=3D -EINVAL) || (!ret && !priv->max_bitrate))
> +		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignorin=
g bitrate limit.\n");
> +}
> +EXPORT_SYMBOL_GPL(of_can_transceiver);
> +#endif
> +
>  /*
>   * Common close function for cleanup before the device gets closed.
>   *
> @@ -913,6 +938,13 @@ static int can_changelink(struct net_device *dev, =
struct nlattr *tb[],
>  					priv->bitrate_const_cnt);
>  		if (err)
>  			return err;
> +
> +		if (priv->max_bitrate && bt.bitrate > priv->max_bitrate) {
> +			netdev_err(dev, "arbitration bitrate surpasses transceiver capabili=
ties of %d bps\n",
> +				   priv->max_bitrate);
> +			return -EINVAL;
> +		}

What about movong this check into can_get_bittiming()? Although we loose
the "arbitration" vs "canfd data".

> +
>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
> =20
>  		if (priv->do_set_bittiming) {
> @@ -997,6 +1029,13 @@ static int can_changelink(struct net_device *dev,=
 struct nlattr *tb[],
>  					priv->data_bitrate_const_cnt);
>  		if (err)
>  			return err;
> +
> +		if (priv->max_bitrate && dbt.bitrate > priv->max_bitrate) {
> +			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilit=
ies of %d bps\n",
> +				   priv->max_bitrate);
> +			return -EINVAL;
> +		}
> +
>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
> =20
>  		if (priv->do_set_data_bittiming) {
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 61f1cf2..fbb7810 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -48,6 +48,8 @@ struct can_priv {
>  	unsigned int data_bitrate_const_cnt;
>  	struct can_clock clock;
> =20
> +	unsigned int max_bitrate;

Please make it an u32, name it "bitrate_max" and ...

>> struct can_priv {
>> 	struct net_device *dev;
>> 	struct can_device_stats can_stats;
>>=20
>> 	struct can_bittiming bittiming, data_bittiming;
>> 	const struct can_bittiming_const *bittiming_const,
>> 		*data_bittiming_const;
>> 	const u16 *termination_const;
>> 	unsigned int termination_const_cnt;
>> 	u16 termination;
>> 	const u32 *bitrate_const;
>> 	unsigned int bitrate_const_cnt;
>> 	const u32 *data_bitrate_const;
>> 	unsigned int data_bitrate_const_cnt;

=2E..move it here.

>> 	struct can_clock clock;
>=20

> +
>  	enum can_state state;
> =20
>  	/* CAN controller features - see include/uapi/linux/can/netlink.h */
> @@ -166,6 +168,12 @@ void can_put_echo_skb(struct sk_buff *skb, struct =
net_device *dev,
>  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx=
);
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx);
> =20
> +#ifdef CONFIG_OF
> +void of_can_transceiver(struct net_device *dev);
> +#else
> +static inline void of_can_transceiver(struct net_device *dev) { }
> +#endif
> +
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame=
 **cf);
>  struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>  				struct canfd_frame **cfd);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sXvgQo1jvj4cX6w3cKFDCEbI3gjdcaGHz--

--lojS22k3aMN8TE3gRVpM7XGowopQoGyLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpLgoUACgkQHv7KIOw4
HPb0HAgAhHtoVDBzKmlHoWbNn/hn2mGPuclEs3uzGzYja/S18I162PCx8ACkkzqV
L33f2wTvDkp0uLM1tWMoeq37lhBQxLevEQku4FMa7tDE+6ySzuX/rPPsnMhK2pB5
CIeSCFpO3bbsx6x9cLeUHYGHxBarMRaTz+La7zN76pGuNBMuaavepm5f1aKELUkY
MPLd+eT1Gc2eGtaLN8evF1M5Ei4Qq2qBUVQz0eb28nHNiWhuE0msS6MchapgwLP8
ntfL0CrGjeG6bxH3v8cTYwDtKJHB1cicjALnBBioJCDxHcJApI5KFxKIxTxexFqA
IUd78eosFLxaSd1C6pD1RPlGW4cI/w==
=3Js8
-----END PGP SIGNATURE-----

--lojS22k3aMN8TE3gRVpM7XGowopQoGyLZ--
