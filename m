From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 4/6] can: m_can: Support higher speed CAN-FD bitrates
Date: Tue, 2 Jan 2018 14:35:08 +0100
Message-ID: <f2a063cd-9456-c21d-2544-02179e0f4f27@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FQPVdkH75G8gkp4eQMUX2wSVP0L4obEBA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33241 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751916AbeABNfc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Jan 2018 08:35:32 -0500
In-Reply-To: <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FQPVdkH75G8gkp4eQMUX2wSVP0L4obEBA
Content-Type: multipart/mixed; boundary="WFHa2VtGep9xgmHuMjieilSprSLkghsEc";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com
Message-ID: <f2a063cd-9456-c21d-2544-02179e0f4f27@pengutronix.de>
Subject: Re: [PATCH v6 4/6] can: m_can: Support higher speed CAN-FD bitrates
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1513949488-13026-5-git-send-email-faiz_abbas@ti.com>

--WFHa2VtGep9xgmHuMjieilSprSLkghsEc
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 02:31 PM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> During test transmitting using CAN-FD at high bitrates (> 2 Mbps)
> would fail. Scoping the signals I noticed that only a single bit
> was being transmitted and with a bit more investigation realized the ac=
tual
> MCAN IP would go back to initialization mode automatically.
>=20
> It appears this issue is due to the MCAN needing to use the Transmitter=

> Delay Compensation Mode with the correct value for the transmitter dela=
y
> compensation offset (tdco). What impacts the tdco value isn't 100% clea=
r
> but to calculate it you use an equation defined in the MCAN User's Guid=
e.
>=20
> The user guide mentions that this register needs to be set based on clo=
ck
> values, secondary sample point and the data bitrate. One of the key
> variables that can't automatically be determined is the secondary
> sample point (ssp). This ssp is similar to the sp but is specific to th=
is
> transmitter delay compensation mode. The guidelines for configuring
> ssp is rather vague but via some CAN test it appears for DRA76x that pu=
tting
> the value same as data sampling point works.
>=20
> The CAN-CIA's "Bit Time Requirements for CAN FD" paper presented at
> the International CAN Conference 2013 indicates that this TDC mode is
> only needed for data bit rates above 2.5 Mbps. Therefore, only enable
> this mode when the data bit rate is above 2.5 Mbps.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 41 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 53e764f..371ffc1 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -127,6 +127,12 @@ enum m_can_mram_cfg {
>  #define DBTP_DSJW_SHIFT		0
>  #define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
> =20
> +/* Transmitter Delay Compensation Register (TDCR) */
> +#define TDCR_TDCO_SHIFT		8
> +#define TDCR_TDCO_MASK		(0x7F << TDCR_TDCO_SHIFT)
> +#define TDCR_TDCF_SHIFT		0
> +#define TDCR_TDCF_MASK		(0x7F << TDCR_TDCF_SHIFT)
> +
>  /* Test Register (TEST) */
>  #define TEST_LBCK		BIT(4)
> =20
> @@ -991,7 +997,8 @@ static int m_can_set_bittiming(struct net_device *d=
ev)
>  	const struct can_bittiming *bt =3D &priv->can.bittiming;
>  	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
>  	u16 brp, sjw, tseg1, tseg2;
> -	u32 reg_btp;
> +	u32 reg_btp, tdco, ssp;

Please move the tdco and the ssp into "if (dbt->bitrate > 2500000)" scope=
=2E

Initialize "reg_btp =3D 0", see below.

> +	bool enable_tdc =3D false;

Please remove, see below.

> =20
>  	brp =3D bt->brp - 1;
>  	sjw =3D bt->sjw - 1;
> @@ -1006,9 +1013,41 @@ static int m_can_set_bittiming(struct net_device=
 *dev)
>  		sjw =3D dbt->sjw - 1;
>  		tseg1 =3D dbt->prop_seg + dbt->phase_seg1 - 1;
>  		tseg2 =3D dbt->phase_seg2 - 1;
> +
> +		/* TDC is only needed for bitrates beyond 2.5 MBit/s.
> +		 * This is mentioned in the "Bit Time Requirements for CAN FD"
> +		 * paper presented at the International CAN Conference 2013
> +		 */
> +		if (dbt->bitrate > 2500000) {
> +			/* Use the same value of secondary sampling point
> +			 * as the data sampling point
> +			 */
> +			ssp =3D dbt->sample_point;
> +
> +			/* Equation based on Bosch's M_CAN User Manual's
> +			 * Transmitter Delay Compensation Section
> +			 */
> +			tdco =3D (priv->can.clock.freq / 1000) *
> +			       ssp / dbt->bitrate;
> +
> +			/* Max valid TDCO value is 127 */
> +			if (tdco > 127) {
> +				netdev_warn(dev, "TDCO value of %u is beyond maximum limit. Disabl=
ing Transmitter Delay Compensation mode\n",

"maximum limit"? Either "maximum" or "limit" should be enough. If the
value is above 127, does it make sense to disable the tdco completely?

> +					    tdco);
> +			} else {
> +				enable_tdc =3D true;

Why not set "reg_btp |=3D DBTP_TDC;" here directly?

> +				m_can_write(priv, M_CAN_TDCR,
> +					    tdco << TDCR_TDCO_SHIFT);
> +			}
> +		}
> +
>  		reg_btp =3D (brp << DBTP_DBRP_SHIFT) | (sjw << DBTP_DSJW_SHIFT) |
>  			(tseg1 << DBTP_DTSEG1_SHIFT) |
>  			(tseg2 << DBTP_DTSEG2_SHIFT);

Adjust this to "reg_btp |=3D".

> +
> +		if (enable_tdc)
> +			reg_btp |=3D DBTP_TDC;

Please remove.

> +
>  		m_can_write(priv, M_CAN_DBTP, reg_btp);
>  	}
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WFHa2VtGep9xgmHuMjieilSprSLkghsEc--

--FQPVdkH75G8gkp4eQMUX2wSVP0L4obEBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpLiowACgkQHv7KIOw4
HPaNFwgA0HOh1Z1y1tYcGoC2MTMoFRCxtd1q5VVMSHHKr1wMnCl0Yndapn4T+sLg
TxV2JTOhzqTYeTVlqYjcmTjStFwcFQNwIkjST5RYMJSv4MLij/fQCnUP2yPdzJio
OybKUbEUAR+pJ1GXy82v2E6/OvXrCEFtrEcgEcJEy/X5I18ToDNYE0t7AUWQu7wz
fuUk1TKuW2IExOOJli/L7ARgKFbk15DTMD3gO2nRIq01vcdjEPK8dHsK+IJaxg+6
k23aoebo4Zu1Bfi9axEF4Bx4gLLmWYXJR7HUX+tKJrr2s/9w47FPNAcT+JOu14/6
itbsCdi6DuN2RZCz+b8fNWCU6ahu7Q==
=DoBv
-----END PGP SIGNATURE-----

--FQPVdkH75G8gkp4eQMUX2wSVP0L4obEBA--
