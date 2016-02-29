From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-calc-bit-timing: add support for rcar_can
Date: Mon, 29 Feb 2016 11:29:19 +0100
Message-ID: <56D41D7F.2020705@pengutronix.de>
References: <1456741125-50017-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="e9siHc4KoNvmblpfT8Ij7OQqnjSHSGLbv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37622 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753289AbcB2K3a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 05:29:30 -0500
In-Reply-To: <1456741125-50017-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9siHc4KoNvmblpfT8Ij7OQqnjSHSGLbv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/29/2016 11:18 AM, Ramesh Shanmugasundaram wrote:
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.rene=
sas.com>
> ---
> Hi Mark,
>=20
>    This patch is generated on top of can-utils master
>=20
>    commit:
>    cda6117 can: avoid using timeval for uapi
>=20
>    in response to https://www.mail-archive.com/netdev@vger.kernel.org/m=
sg99549.html
>=20
>  can-calc-bit-timing.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> index 9031a78..b6236f0 100644
> --- a/can-calc-bit-timing.c
> +++ b/can-calc-bit-timing.c
> @@ -219,6 +219,26 @@ static void printf_btr_ti_hecc(struct can_bittimin=
g *bt, int hdr)
>  	}
>  }
> =20
> +static void printf_btr_rcar_can(struct can_bittiming *bt, int hdr)
> +{
> +	if (hdr) {
> +		printf("%10s", "CiBCR");
> +	} else {
> +		uint32_t bcr;
> +#define RCAR_CAN_BCR_TSEG1(x)   (((x) & 0x0f) << 20)
> +#define RCAR_CAN_BCR_BPR(x)     (((x) & 0x3ff) << 8)
> +#define RCAR_CAN_BCR_SJW(x)     (((x) & 0x3) << 4)
> +#define RCAR_CAN_BCR_TSEG2(x)   ((x) & 0x07)
> +
> +		bcr =3D RCAR_CAN_BCR_TSEG1(bt->phase_seg1 + bt->prop_seg - 1) |
> +			RCAR_CAN_BCR_BPR(bt->brp - 1) |
> +			RCAR_CAN_BCR_SJW(bt->sjw - 1) |
> +			RCAR_CAN_BCR_TSEG2(bt->phase_seg2 - 1);
> +
> +		printf("0x%08x", bcr<<8);
> +	}
> +}
> +
>  static struct can_bittiming_const can_calc_consts[] =3D {
>  	{
>  		.name =3D "sja1000",
> @@ -472,6 +492,21 @@ static struct can_bittiming_const can_calc_consts[=
] =3D {
> =20
>  		.ref_clk =3D 13000000,
>  		.printf_btr =3D printf_btr_ti_hecc,
> +	},
> +	{
> +		.name =3D "rcar_can",
> +		.tseg1_min =3D 4,
> +		.tseg1_max =3D 16,
> +		.tseg2_min =3D 2,
> +		.tseg2_max =3D 8,
> +		.sjw_max =3D 4,
> +		.brp_min =3D 1,
> +		.brp_max =3D 1024,
> +		.brp_inc =3D 1,
> +
> +		.ref_clk =3D 65000000,
> +		.printf_btr =3D printf_btr_rcar_can,
> +	},
>  	}
       ^^^

This doesn't look right, fixed while applying.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--e9siHc4KoNvmblpfT8Ij7OQqnjSHSGLbv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW1B1/AAoJED07qiWsqSVqjkAIAIfIBM6bVEiUFFNHLVywbsQf
bwJABm7ETWGtPRwL5Nqib3mTFQ8beoflbQLkM+77DgGHIFkQ58+9VcVFNXIw8h5I
tPDSSG6+oS9cPImV4wt1ftVRuu1c47xRN78Y3pEfyESxMa7IykhEQKuRwb2tOLTe
l9IrXOPkpF2Eq2NKHeBzhqANhx7mdd0kcJgbruPxDsLGk/xK9yg/2VoSTFxh69+q
jSJA865niN7t9JE0/H4cl1Sx5mJ16H/E6VYn8Dbv3faqZFtNrB3RxxY+r2icXcmG
aZCjdkt1PUrgOIHn6R4PzkMWRk9M83FhJt0GUD4VuaijWpi0ulZXhFZoUR/6Kgk=
=fODj
-----END PGP SIGNATURE-----

--e9siHc4KoNvmblpfT8Ij7OQqnjSHSGLbv--
