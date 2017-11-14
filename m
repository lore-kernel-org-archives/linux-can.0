From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Tue, 14 Nov 2017 13:59:08 +0100
Message-ID: <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dW8O9KRU4URi6hNOBS30eFkV0VU8BekdK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40063 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753971AbdKNM7V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Nov 2017 07:59:21 -0500
In-Reply-To: <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Bhupesh Sharma <bhupesh.sharma@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dW8O9KRU4URi6hNOBS30eFkV0VU8BekdK
Content-Type: multipart/mixed; boundary="Jcl1ncsBrgSSr9XqppDsoRhadqqMk2rjO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>
Message-ID: <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
In-Reply-To: <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>

--Jcl1ncsBrgSSr9XqppDsoRhadqqMk2rjO
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 12:56 PM, Pankaj Bansal wrote:
> This patch adds platform specific details for NXP SOC LS1021A to the
> flexcan driver code.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> ---
> Changes in v2:
>   - No change.
>=20
>  drivers/net/can/flexcan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 100b451..fa2d4c9 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -304,6 +304,11 @@ static const struct flexcan_devtype_data fsl_vf610=
_devtype_data =3D {
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
>  };
> =20
> +/* LS1021A-Rev2 has functional RX-FIFO mode  */

How big is the RX-FIFO? If the normal mailboxes can receive RTR
messages, we definitely want to use FLEXCAN_QUIRK_USE_OFF_TIMESTAMP. As
you can buffer > 60 CAN frames compared to only 6 in FIFO mode.

Please add your IP core to the "FLEXCAN hardware feature flags" table
[1] in the driver. Also please test the transition interrupts for
changes in the CAN error state, see the commits of ZHU Yi
(ST-FIR/ENG1-Zhu) <Yi.Zhu5@cn.bosch.com> on the driver. [2]

> +static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data =3D=
 {
> +	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
> +};
> +
>  static const struct can_bittiming_const flexcan_bittiming_const =3D {
>  	.name =3D DRV_NAME,
>  	.tseg1_min =3D 4,
> @@ -1245,6 +1250,8 @@ static const struct of_device_id flexcan_of_match=
[] =3D {
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,p1010-flexcan", .data =3D &fsl_p1010_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,vf610-flexcan", .data =3D &fsl_vf610_devtype_d=
ata, },
> +	{ .compatible =3D "fsl,ls1021ar2-flexcan",
> +	  .data =3D &fsl_ls1021a_r2_devtype_data, },

Please keep in in one line, even if it's more than 80 chars.

>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, flexcan_of_match);
>=20

Marc

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/can/flexcan.c#n182
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/net/can/flexcan.c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jcl1ncsBrgSSr9XqppDsoRhadqqMk2rjO--

--dW8O9KRU4URi6hNOBS30eFkV0VU8BekdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloK6JwACgkQHv7KIOw4
HPa0LQgAgLuw851nx9OKySdDS7J9fXGnFhtygN0BZoadPPKlXygb9V4H6n6OmRc1
ile/azqhOQOyVj53ByIoUza2WYC516F9AjD8tDoGJRqxbRO0acxiOeivfcZcCH12
Z5YQ03aufm0du2Be3piOw+KvSV2jb/0iT3aXjwbOsjAcis+cas+QqxstOnnX0GW4
RpznRs5XdtwqFqimTYuvuEdKWUY3H8+qLe83VydZY4qIALILG/RpkLQ8JfhyuP0d
fMPkUfizm8I/ry21UTwYLYs1MV2xUojZvXW2FzrY8K6B8CDJF05AO4YXVfX6w5VI
4Z1Rfrl7rMTJIpaiOH56Gzn5Tx7XdQ==
=KmF3
-----END PGP SIGNATURE-----

--dW8O9KRU4URi6hNOBS30eFkV0VU8BekdK--
