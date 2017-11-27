From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 0/6] Remodel FlexCAN register r/w APIs for big endian
Date: Mon, 27 Nov 2017 15:07:06 +0100
Message-ID: <8f8c2093-35db-306b-d054-4c27299bfa7c@pengutronix.de>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="W9J489nDTh2QNeMmkRT4kQxWCJ68wmGRq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W9J489nDTh2QNeMmkRT4kQxWCJ68wmGRq
Content-Type: multipart/mixed; boundary="Dvii0I7OuwxKclb6U3TTstTBmJWwOEfVO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org,
 linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
Message-ID: <8f8c2093-35db-306b-d054-4c27299bfa7c-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 0/6] Remodel FlexCAN register r/w APIs for big endian
References: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>

--Dvii0I7OuwxKclb6U3TTstTBmJWwOEfVO
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/24/2017 02:22 PM, Pankaj Bansal wrote:
> This patch series remodels the FlexCAN register r/w APIs for big endian=
=2E
> The endianness is checked based on optional big-endian property in
> device tree. if this property is not present in device tree node then=20
> controller is assumed to be little endian. if this property is present =
then
> controller is assumed to be big endian.
>=20
> An exception to this rule is powerpc P1010RDB, which is always
> big-endian, even if big-endian is not present in dts. This is
> checked using p1010-flexcan compatible in dts.
>=20
> Therefore, remove p1010-flexcan compatible from imx series dts,
> as their flexcan core is little endian.
>=20
> Finally this series adds support for NXP LS1021A SOC in flexcan,
> which is arm based SOC having big-endian FlexCAN controller.
>=20
> Pankaj Bansal (6):
>   can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCA=
N
>     controllers.
>   can: flexcan: adding platform specific details for LS1021A
>   Documentation : can : flexcan : Add big-endian property to device tre=
e
>   powerpc: dts: P1010: Add endianness property to flexcan node
>   arm: dts: Remove p1010-flexcan compatible from imx series dts
>   arm/dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Dvii0I7OuwxKclb6U3TTstTBmJWwOEfVO--

--W9J489nDTh2QNeMmkRT4kQxWCJ68wmGRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlocHAoACgkQHv7KIOw4
HPZ6pwgAhdUYsZa73eHRmsNhUiBOq1Jow9wH0tAr89HGh35id59SYES4Wg82WoE+
rsGddhUy0JbjZ1Y8DyKaWFf8hoJtEtC1JrPs2wbxf1SGARRMTioFGZcbmnb8PEZP
4St3cI9h2qWui7VglgUiX0H1vHA0fXK4lNbWvMoTfIBCxT3Z+2tU/aNffTtzP6RE
cByAn+VfTKNCf2um6NG75DNyI5o3s535I5pNo9pJjtot5HFIIoc7L5vdUbnqeYBG
1Km1AnvzoTZyeKvA7Y5eP2liRcZJAlwuJk/23ObSKhyZnVh+ap1LC4mRRN61LbsG
2AsCTW4PS+c8UXYnm2ZIOTmynMzObA==
=aZW9
-----END PGP SIGNATURE-----

--W9J489nDTh2QNeMmkRT4kQxWCJ68wmGRq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
