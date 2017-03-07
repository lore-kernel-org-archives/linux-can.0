From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: m_can: handle bitrate setup on IP core >= 3.1.x
Date: Tue, 7 Mar 2017 08:46:38 +0100
Message-ID: <de1b08ac-6c5e-da23-12de-7113e80e9716@pengutronix.de>
References: <20170306212011.29519-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gds74hhfepoSjDqtEK4K2MgInP9TSnFWN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48107 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbdCGIHp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Mar 2017 03:07:45 -0500
In-Reply-To: <20170306212011.29519-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Florian Vallee <fvallee@eukrea.fr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gds74hhfepoSjDqtEK4K2MgInP9TSnFWN
Content-Type: multipart/mixed; boundary="iXJuOQ96TjG7Kg2RW9fC71Vd3bMaxToUL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Florian Vallee <fvallee@eukrea.fr>
Message-ID: <de1b08ac-6c5e-da23-12de-7113e80e9716@pengutronix.de>
Subject: Re: [PATCH 1/2] can: m_can: handle bitrate setup on IP core >= 3.1.x
References: <20170306212011.29519-1-socketcan@hartkopp.net>
In-Reply-To: <20170306212011.29519-1-socketcan@hartkopp.net>

--iXJuOQ96TjG7Kg2RW9fC71Vd3bMaxToUL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:20 PM, Oliver Hartkopp wrote:
> From: Florian Vallee <fvallee@eukrea.fr>
>=20
> According to the m_can user manual changelog the BTP register layout wa=
s
> updated with core revision 3.1.0
>=20
> This change is not backward-compatible and using the current driver alo=
ng
> with a recent IP results in an incorrect bitrate on the wire.
>=20
> Tested with a SAMA5D2 SoC (CREL =3D 0x31040730)
>=20
> Signed-off-by: Florian Vallee <fvallee@eukrea.fr>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I'm missing Quentin Schulz's and your S-o-B here.

> ---
>  drivers/net/can/m_can/m_can.c | 38 +++++++++++++++++++++++++++++++++++=
---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 7a6554efd42b..650b656f3c05 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -105,6 +105,10 @@ enum m_can_mram_cfg {
>  	MRAM_CFG_NUM,
>  };
> =20
> +/* Core Release Register (CREL) */
> +#define CRR_REL_MASK		0xfff
> +#define CRR_REL_SHIFT		20
> +
>  /* Fast Bit Timing & Prescaler Register (FBTP) */
>  #define FBTR_FBRP_MASK		0x1f
>  #define FBTR_FBRP_SHIFT		16
> @@ -136,7 +140,7 @@ enum m_can_mram_cfg {
>  #define CCCR_INIT		BIT(0)
>  #define CCCR_CANFD		0x10
> =20
> -/* Bit Timing & Prescaler Register (BTP) */
> +/* Bit Timing & Prescaler Register (BTP) (M_CAN IP < 3.1.0) */
>  #define BTR_BRP_MASK		0x3ff
>  #define BTR_BRP_SHIFT		16
>  #define BTR_TSEG1_SHIFT		8
> @@ -146,6 +150,16 @@ enum m_can_mram_cfg {
>  #define BTR_SJW_SHIFT		0
>  #define BTR_SJW_MASK		0xf
> =20
> +/* Nominal Bit Timing & Prescaler Register (NBTP) (M_CAN IP >=3D 3.1.0=
) */
> +#define NBTR_SJW_SHIFT		25
> +#define NBTR_SJW_MASK		(0x7f << NBTR_SJW_SHIFT)
> +#define NBTR_BRP_SHIFT		16
> +#define NBTR_BRP_MASK		(0x3ff << NBTR_BRP_SHIFT)
> +#define NBTR_TSEG1_SHIFT	8
> +#define NBTR_TSEG1_MASK		(0xff << NBTR_TSEG1_SHIFT)
> +#define NBTR_TSEG2_SHIFT	0
> +#define NBTR_TSEG2_MASK		(0x7f << NBTR_TSEG2_SHIFT)

Please use BTR_310_ as a prefix here.

> +
>  /* Error Counter Register(ECR) */
>  #define ECR_RP			BIT(15)
>  #define ECR_REC_SHIFT		8
> @@ -200,6 +214,9 @@ enum m_can_mram_cfg {
>  			 IR_RF1L | IR_RF0L)
>  #define IR_ERR_ALL	(IR_ERR_STATE | IR_ERR_BUS)
> =20
> +/* Core Version */
> +#define M_CAN_COREREL_3_1_0	0x310

M_CAN_COREREL_310 should be fine

> +
>  /* Interrupt Line Select (ILS) */
>  #define ILS_ALL_INT0	0x0
>  #define ILS_ALL_INT1	0xFFFFFFFF
> @@ -357,6 +374,13 @@ static inline void m_can_disable_all_interrupts(co=
nst struct m_can_priv *priv)
>  	m_can_write(priv, M_CAN_ILE, 0x0);
>  }
> =20
> +static inline int m_can_read_core_rev(const struct m_can_priv *priv)

make it an u16

> +{
> +	u32 reg =3D m_can_read(priv, M_CAN_CREL);
> +
> +	return ((reg >> CRR_REL_SHIFT) & CRR_REL_MASK);
> +}
> +
>  static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  {
>  	struct net_device_stats *stats =3D &dev->stats;
> @@ -811,8 +835,16 @@ static int m_can_set_bittiming(struct net_device *=
dev)
>  	sjw =3D bt->sjw - 1;
>  	tseg1 =3D bt->prop_seg + bt->phase_seg1 - 1;
>  	tseg2 =3D bt->phase_seg2 - 1;
> -	reg_btp =3D (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
> -			(tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
> +
> +	if (m_can_read_core_rev(priv) < M_CAN_COREREL_3_1_0)
> +		reg_btp =3D (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
> +				(tseg1 << BTR_TSEG1_SHIFT) |
> +				(tseg2 << BTR_TSEG2_SHIFT);
> +	else
> +		reg_btp =3D (brp << NBTR_BRP_SHIFT) | (sjw << NBTR_SJW_SHIFT) |
> +				(tseg1 << NBTR_TSEG1_SHIFT) |
> +				(tseg2 << NBTR_TSEG2_SHIFT);
> +
>  	m_can_write(priv, M_CAN_BTP, reg_btp);
> =20
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iXJuOQ96TjG7Kg2RW9fC71Vd3bMaxToUL--

--gds74hhfepoSjDqtEK4K2MgInP9TSnFWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli+ZV4ACgkQHv7KIOw4
HPb69ggAn5EqE+bE3hXLy5coGLEQ3J2XKFeks8XeZJt9lijcxycja2z4o967y6xZ
gPGfmpHEEofEmFIR6QhnGxArjMPcG8FC1IZZXZ6fYoBgPtKfWnk/7QRdf2iv5tMM
KULyD8Ueu/v2dI80z4mQFlLISELa3Bh85PL5RtKiZY7hYwRTN0qAbg/0NFMWPbvG
lDE2K71Z4riMiPB+kX9cZICFrOq03HchFCs0gNQvdJXeKTwBqTY7xh52C/hl6e5w
j31Z+OGFiusU7B1luT1f/0MDPYpASm8sMpKQm6/IsA+EnAHEVhdx+uDXToRKVn6q
Z+h9R8zzZi0lelmaZf++N6FzwUui4A==
=jNx5
-----END PGP SIGNATURE-----

--gds74hhfepoSjDqtEK4K2MgInP9TSnFWN--
