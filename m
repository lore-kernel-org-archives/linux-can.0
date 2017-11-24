From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 1/6] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
Date: Fri, 24 Nov 2017 16:02:39 +0100
Message-ID: <44f37aef-7f45-a7c7-7320-01a62e23fbde@pengutronix.de>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
 <1511529733-27942-2-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PDI8LeSMroWtCLntkPlc8MCGN1meiSRmi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-2-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PDI8LeSMroWtCLntkPlc8MCGN1meiSRmi
Content-Type: multipart/mixed; boundary="i6UCxtNfCd4d3R9x15cpWIPrVrfb5HBp2";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org,
 linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org,
 Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
 Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Message-ID: <44f37aef-7f45-a7c7-7320-01a62e23fbde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 1/6] can: flexcan: Remodel FlexCAN register r/w APIs
 for big endian FlexCAN controllers.
References: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
 <1511529733-27942-2-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
In-Reply-To: <1511529733-27942-2-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>

--i6UCxtNfCd4d3R9x15cpWIPrVrfb5HBp2
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/24/2017 02:22 PM, Pankaj Bansal wrote:
> The FlexCAN driver assumed that FlexCAN controller is big endian for
> powerpc architecture and little endian for other architectures.
>=20
> But this may not be the case. FlexCAN controller can be little or big
> endian on any architecture. For e.g. NXP LS1021A ARM based SOC has big
> endian FlexCAN controller.
>=20
> Therefore, the driver has been modified to add a provision for both
> types of controllers using an additional device tree property. On a
> "fsl,p1010-flexcan" device BE is default, on all other devices LE is.
>=20
> Big Endian controllers should have "big-endian" set in the device tree.=

> check "Documentation/devicetree/bindings/net/can/fsl-flexcan.txt" for
> usage.
>=20
> This is the standard practice followed in linux. for more info check:
> Documentation/devicetree/bindings/common-properties.txt
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Sakar Arora <Sakar.Arora-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Reviewed-by: Zhengxiong Jin <Jason.Jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
> ---
> Changes in v4:
>   - Merged device tree changes and driver changes in one series
> Changes in v3:
>   - Added fsl,imx25-flexcan, fsl,imx35-flexcan and fsl,imx53-flexcan
>     support to the driver.
>   - Modified patch deciption to state default endianness followed and
>     to include fsl-flexcan.txt referance.
> Changes in v2:
>   - Modified patch deciption to include common-properties.txt reference=
=2E
>   - Reorder the LE/BE read/write APIs for better readability of code
>   - Added an exception to force BE API selection, for powerpc based pla=
tform
>     P1010. This ensures that new linux kernel works with old P1010
>     device-tree, while future powerpc platforms that use big endian
>     FlexCAN controller need to specify big-endian in device tree in
>     FlexCAN node.
>   - Tested on P1010 after backporting to freescale sdk 1.4 linux, witho=
ut
>     any change in device-tree.
>   - Tested on NXP LS1021A arm based platform.
>=20
>  drivers/net/can/flexcan.c | 233 ++++++++++++++++++++----------------
>  1 file changed, 131 insertions(+), 102 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index a13a489..4c873fb 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c

[...]
I think this will select LE for non DT devices, right?

> +	if (of_property_read_bool(pdev->dev.of_node, "big-endian")) {
> +		priv->read =3D flexcan_read_be;
> +		priv->write =3D flexcan_write_be;
> +	} else {
> +		if (of_device_is_compatible(pdev->dev.of_node,
> +					    "fsl,p1010-flexcan")) {
> +			priv->read =3D flexcan_read_be;
> +			priv->write =3D flexcan_write_be;
> +		} else {
> +			priv->read =3D flexcan_read_le;
> +			priv->write =3D flexcan_write_le;
> +		}
> +	}
> +
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--i6UCxtNfCd4d3R9x15cpWIPrVrfb5HBp2--

--PDI8LeSMroWtCLntkPlc8MCGN1meiSRmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloYNI8ACgkQHv7KIOw4
HPb9MggAqvDq1Jl+gu3c+ZuG/pcTruSoDVIoMXddfEYGSPHBTix1Ruhe89VmXyIX
pIk53IY5NGx3STrvGJ/Gslai39Lxo6NAoBRSKHAWowu5VCanfKtwm5hwE0sHbzUy
6xezNm25IA3DWNx9GRyoxO+jmdXn0fIg5DDhC4+c8554c3ueq2hBZCX4DKZFtPQB
S4TOmy9HSPj1a0vWOppDbqDbsI1BOu0C4qUFZikPBA5cc2y9yFxlH1v6ef8RL/MR
owGphc/X0uv6kmNbPj0gX7+n77uUCubc+bJO+6fos5eue3Log8pPTTiSbciqcjhA
oWb9xFSEv+sUBU9GAdZzirgQmxf0yg==
=oug8
-----END PGP SIGNATURE-----

--PDI8LeSMroWtCLntkPlc8MCGN1meiSRmi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
