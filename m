From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Thu, 23 Nov 2017 10:16:31 +0100
Message-ID: <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="416drGsFK2epbTXob3dTQv80eDetdU5Mj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37217 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751755AbdKWJQp (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Thu, 23 Nov 2017 04:16:45 -0500
In-Reply-To: <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--416drGsFK2epbTXob3dTQv80eDetdU5Mj
Content-Type: multipart/mixed; boundary="k7DHVdGCEJ1INSBoc7Cmpq8Qs7Rn4SX31";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>
Message-ID: <f7413c59-978e-fad1-6df0-3226067e64fa@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: flexcan: adding platform specific details for
 LS1021A
References: <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-1-git-send-email-pankaj.bansal@nxp.com>
 <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>
In-Reply-To: <1511428158-28710-2-git-send-email-pankaj.bansal@nxp.com>

--k7DHVdGCEJ1INSBoc7Cmpq8Qs7Rn4SX31
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 10:09 AM, Pankaj Bansal wrote:
> This patch adds platform specific details for NXP SOC LS1021A to the
> flexcan driver code.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> ---
> Changes in v3:
>   - Add LS1021 in FLEXCAN hardware feature flags table
>   - Kept LS1021 compatible in one line, even if it's more than 80
>     chars.
>   - Add PERR_STATE quirk and USE_OFF_TIMESTAMP quirk and
>     ENABLE_EACEN_RRS quirk for LS1021A.
>   - Tested on LS1021A using "cangen can0 -D 11223344DEADBEEF -L 8 -R"
>     and "cangen can0 -D 11223344DEADBEEF -L 8"
> Changes in v2:
>   - No change.
>=20
>  drivers/net/can/flexcan.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 4c873fb..21d0dd8 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -190,6 +190,7 @@
>   *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no  =
      no
>   *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no  =
     yes
>   *   VF610 FlexCAN3  ?               no       yes         ?      yes  =
     yes?
> + * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no  =
     yes

Out of curiosity, where have you got the IP core version from?

>   *
>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connecte=
d.
>   */
> @@ -304,6 +305,13 @@ static const struct flexcan_devtype_data fsl_vf610=
_devtype_data =3D {
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
>  };
> =20
> +/* LS1021A-Rev2 has functional RX-FIFO mode  */

That comment is obsolete, isn't it? If it's a noteworthy feature, add it
to the overview table above.

> +static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data =3D=
 {
> +	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_R=
RS |
> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
> +};
> +
>  static const struct can_bittiming_const flexcan_bittiming_const =3D {
>  	.name =3D DRV_NAME,
>  	.tseg1_min =3D 4,
> @@ -1248,6 +1256,7 @@ static const struct of_device_id flexcan_of_match=
[] =3D {
>  	{ .compatible =3D "fsl,imx25-flexcan", .data =3D &fsl_p1010_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,p1010-flexcan", .data =3D &fsl_p1010_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,vf610-flexcan", .data =3D &fsl_vf610_devtype_d=
ata, },
> +	{ .compatible =3D "fsl,ls1021ar2-flexcan", .data =3D &fsl_ls1021a_r2_=
devtype_data, },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, flexcan_of_match);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k7DHVdGCEJ1INSBoc7Cmpq8Qs7Rn4SX31--

--416drGsFK2epbTXob3dTQv80eDetdU5Mj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWke8ACgkQHv7KIOw4
HPb/vgf+LuvVQ6Nnn63W/n4M+b++yZH3qUgKsVmu0u6wDUxjVq3MvmM3xNH/h2qW
LKcTNa1KdEFaYCt2/hLLkfV8PpwWE/siBTQE7wQl/XmdFl+y7tO2Ws6QMJRNzvhM
ewdDMe4KzZ4Wfn3M/0VaCp+vlg5sPCxud6jkdzp8j8hbTTdzOK32e2MLUHDKRWJB
zDO0Q0RDeeiJ3am51Pg7JyI3ZjhKjlenvLDFvyZVC31Se84+vFuP8EIKpYRzsppA
ZkrzclknQK7vz3mF3Fe/SgizP9zB4Nw4b0BLtNTIlurRD4rvk54ndO4Gf8LFoF2K
F/W9oOTUsAPf7vJs7MYPmzUtQCbdxg==
=NlbJ
-----END PGP SIGNATURE-----

--416drGsFK2epbTXob3dTQv80eDetdU5Mj--
