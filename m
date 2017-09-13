From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/6] can: flexcan: implement error passive state quirk
Date: Wed, 13 Sep 2017 14:46:31 +0200
Message-ID: <7d6ec112-095c-c817-3d1c-6eb82ed78e1f@pengutronix.de>
References: <d69e202c5ff74516817f9e1e451eb357@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JoWKiDIbDxI3i7k7XNNANtINnIfLNqVdw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57217 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751120AbdIMMql (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 08:46:41 -0400
In-Reply-To: <d69e202c5ff74516817f9e1e451eb357@SGPMBX1017.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JoWKiDIbDxI3i7k7XNNANtINnIfLNqVdw
Content-Type: multipart/mixed; boundary="nO0ODlnwfFnws3qO1585vw0GMl3ITw9F1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Andri Yngvason <andri.yngvason@marel.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>,
 "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
 "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Message-ID: <7d6ec112-095c-c817-3d1c-6eb82ed78e1f@pengutronix.de>
Subject: Re: [PATCH 3/6] can: flexcan: implement error passive state quirk
References: <d69e202c5ff74516817f9e1e451eb357@SGPMBX1017.APAC.bosch.com>
In-Reply-To: <d69e202c5ff74516817f9e1e451eb357@SGPMBX1017.APAC.bosch.com>

--nO0ODlnwfFnws3qO1585vw0GMl3ITw9F1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 11:36 AM, ZHU Yi (ST-FIR/ENG1-Zhu) wrote:
> From d4e60c16aeb5f6108479cebb754539bcc3c2be5d Mon Sep 17 00:00:00 2001
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> Date: Thu, 31 Aug 2017 09:21:24 +0800
> Subject: [PATCH 3/6] can: flexcan: implement error passive state quirk
>=20
> Add FLEXCAN_QUIRK_BROKEN_PERR_STATE for better description
> of the missing error passive interrupt quirk.
>=20
> Error interrupt flooding may happen if the broken error state quirk
> fix is enabled. For example, in case there is singled out node on
> the bus and the node sends a frame, then error interrupt flooding
> happens and will not stop because the node cannot go to bus off. The
> flooding will stop after another node connected to the bus again.
>=20
> If high bitrate configured on the low end system, then the flooding
> may causes performance issue, hence, this patch mitigates this by:
> 1. disable error interrupt upon error passive state transition
> 2. re-enable error interrupt upon error warning state transition
> 3. disable/enable error interrupt upon error active state transition
>    depends on FLEXCAN_QUIRK_BROKEN_WERR_STATE
>=20
> In this way, the driver is still able to report correct state
> transitions without additional latency. When there are bus problems,
> flooding of error interrupts is limited to the number of frames
> required to change state from error warning to error passive if the
> core has [TR]WRN_INT connected (FLEXCAN_QUIRK_BROKEN_WERR_STATE is
> not enabled), otherwise, the flooding is limited to the number of
> frames required to change state from error active to error passive.
>=20
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/net/can/flexcan.c | 79 +++++++++++++++++++++++++++++++++++++++=
++------
>  1 file changed, 70 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e163c55..52b69fc 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -182,14 +182,14 @@
>  /* FLEXCAN hardware feature flags
>   *
>   * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT Memory err RTR r=
e-
> - *                                Filter? connected?  detection  cepti=
on in MB
> - *   MX25  FlexCAN2  03.00.00.00     no        no         no        no=

> - *   MX28  FlexCAN2  03.00.04.00    yes       yes         no        no=

> - *   MX35  FlexCAN2  03.00.00.00     no        no         no        no=

> - *   MX53  FlexCAN2  03.00.00.00    yes        no         no        no=

> - *   MX6s  FlexCAN3  10.00.12.00    yes       yes         no       yes=

> - *   VF610 FlexCAN3  ?               no       yes        yes       yes=
?
> + *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory e=
rr RTR re-
> + *                                Filter? connected?  Passive detectio=
n  ception in MB
> + *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no  =
      no
> + *   MX28  FlexCAN2  03.00.04.00    yes       yes         ?       no  =
      no
> + *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no  =
      no
> + *   MX53  FlexCAN2  03.00.00.00    yes        no        no?      no  =
      no
> + *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no  =
     yes
> + *   VF610 FlexCAN3  ?               no       yes         ?      yes  =
     yes?
                                                            ^^^

Is there new information on this table after the tests on the mx53 and mx=
28?

>   *
>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connecte=
d.
>   */
> @@ -198,6 +198,7 @@
>  #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS =
bit in ctrl2 */
>  #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error dete=
ction */
>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based =
offloading */
> +#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for err=
or passive */
> =20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -335,6 +336,26 @@ static inline void flexcan_write(u32 val, void __i=
omem *addr)
>  }
>  #endif
> =20
> +static inline void flexcan_error_irq_enable(const struct flexcan_priv =
*priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_ctrl;
> +
> +	reg_ctrl =3D flexcan_read(&regs->ctrl);

Please make use of "priv->reg_ctrl_default", there should be no need to
read regs->ctrl during runtime.

> +	reg_ctrl |=3D FLEXCAN_CTRL_ERR_MSK;
> +	flexcan_write(reg_ctrl, &regs->ctrl);
> +}
> +
> +static inline void flexcan_error_irq_disable(const struct flexcan_priv=
 *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_ctrl;
> +
> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
> +	reg_ctrl &=3D ~FLEXCAN_CTRL_ERR_MSK;

same here

> +	flexcan_write(reg_ctrl, &regs->ctrl);
> +}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nO0ODlnwfFnws3qO1585vw0GMl3ITw9F1--

--JoWKiDIbDxI3i7k7XNNANtINnIfLNqVdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlm5KKcACgkQHv7KIOw4
HPbr/Qf/YEwcUahXe7tmhrkX9xjEKgRZJ07kmmOMVUPuxJV9jYDHDwMv6x4ahzM+
PL2gWbfQSWzKfGMG4mVza0ryuhwoG0U5l++/YiRLV8Vz0hPuKqTkUMrRIPaV5hZf
WsUknx8BddZBrsqiebzk1cPv3BZ6U0y4qw7cqmV6uaV4ujUsaoxNo9yKxWNR+HEt
+ypY0P2/rwaylTFJgPW0Nq1tF9lxxeqiC3YTruoa7l+1kJsNHo2dMF1dsNfy2gKV
PQC0B3QPXxSMk9wSAPmT6RKxVb/H4XimTPTFiBxHq7X0v9zibztJZ2UH4E+m2FzB
A2VfuU06Xrk1+g/6yyK/GU44iyd4Lw==
=PywQ
-----END PGP SIGNATURE-----

--JoWKiDIbDxI3i7k7XNNANtINnIfLNqVdw--
