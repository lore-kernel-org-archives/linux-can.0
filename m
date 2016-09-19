From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND v3] can: flexcan: fix resume function
Date: Mon, 19 Sep 2016 16:20:47 +0200
Message-ID: <101c826a-764d-4e44-c872-4f37a8289a90@pengutronix.de>
References: <1473113716-2834-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tscCwhEB4lqui9p8WqahIofnLlxoWPPXF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40011 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752203AbcISOU4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 10:20:56 -0400
In-Reply-To: <1473113716-2834-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tscCwhEB4lqui9p8WqahIofnLlxoWPPXF
Content-Type: multipart/mixed; boundary="w5dU0RDoJlfxooi899J9JFvwlOmtIcst8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>
Message-ID: <101c826a-764d-4e44-c872-4f37a8289a90@pengutronix.de>
Subject: Re: [PATCH RESEND v3] can: flexcan: fix resume function
References: <1473113716-2834-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1473113716-2834-1-git-send-email-festevam@gmail.com>

--w5dU0RDoJlfxooi899J9JFvwlOmtIcst8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2016 12:15 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> On a imx6ul-pico board the following error is seen during system suspen=
d:
>    =20
> dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -110    =20
> PM: Device 2090000.flexcan failed to resume: error -110         =20
>=20
> The reason for this suspend error is because when the CAN interface is =
not
> active the clocks are disabled and then flexcan_chip_enable() will
> always fail due to a timeout error.
>=20
> In order to fix this issue, only call flexcan_chip_enable/disable()
> when the CAN interface is active.
>=20
> Based on a patch from Dong Aisheng in the NXP kernel.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied to can with stable on Cc.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--w5dU0RDoJlfxooi899J9JFvwlOmtIcst8--

--tscCwhEB4lqui9p8WqahIofnLlxoWPPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX3/Q/AAoJED07qiWsqSVqZY4IAJIjIfGgOGsFjO9RIp5AQhS1
JOAufaT6bYbWlAXFYjoOoF0Hw5EfEGVYwbqJmaSC/RrTcH85n8LwcDzf0Rdj2R0S
dDpF9KgVgjyvx0PHPmDlrIM3yOba3GazzM8F2R+pAtlGtXRu4vw9U1isoB8buFKg
QJBjym3mCVy1qAdqKCb6sgj1lTIqj9SGFX4OUq1qfkp5NV+tMJO7Ikjd4qari3Cp
nW+gn4+ORRu/vFPD9RpnzEM4hgfjaYYYibjbEohDnxh6buFT/ZwOm9PNeuHK9Hqe
gA4F96yGb7MZA0X230QLw3ZcLshy7VFuEXv5GJHp2IJjGCRLGb46o0djovnWwGs=
=/D78
-----END PGP SIGNATURE-----

--tscCwhEB4lqui9p8WqahIofnLlxoWPPXF--
