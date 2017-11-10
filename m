From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation : can : flexcan : Add big-endian
 property to device tree
Date: Fri, 10 Nov 2017 11:36:12 +0100
Message-ID: <5ebd21fe-9733-2caf-bafd-e1fe773837f0@pengutronix.de>
References: <1510309043-16777-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sEse9B9aw7plEa3NlS6NhEIALbLfEthoc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510309043-16777-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sEse9B9aw7plEa3NlS6NhEIALbLfEthoc
Content-Type: multipart/mixed; boundary="NU5a0SdbQTrkxgJJLpLm8BhlaS2RtrUTL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org,
 linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org
Message-ID: <5ebd21fe-9733-2caf-bafd-e1fe773837f0-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation : can : flexcan : Add big-endian
 property to device tree
References: <1510309043-16777-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
In-Reply-To: <1510309043-16777-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>

--NU5a0SdbQTrkxgJJLpLm8BhlaS2RtrUTL
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 11:17 AM, Pankaj Bansal wrote:
> The FlexCAN controller can be modelled as little or big endian
> depending on SOC design. This device tree property identifies the
> controller endianness and the driver reads/writes controller registers
> based on that.
>=20
> This is optional property. i.e. if this property is not present in
> device tree node then controller is assumed to be little endian. if
> this property is present then controller is assumed to be big endian.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>

NACK, this is not backwards compatible.

See mail on linux-can for better solution.

Marc

> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 56d6cc3..b9693c7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -18,6 +18,8 @@ Optional properties:
> =20
>  - xceiver-supply: Regulator that powers the CAN transceiver
> =20
> +- big-endian: This means the registers of FlexCAN controller are big e=
ndian
> +
>  Example:
> =20
>  	can@1c000 {
> @@ -26,4 +28,5 @@ Example:
>  		interrupts =3D <48 0x2>;
>  		interrupt-parent =3D <&mpic>;
>  		clock-frequency =3D <200000000>; // filled in by bootloader
> +		big-endian;
>  	};
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NU5a0SdbQTrkxgJJLpLm8BhlaS2RtrUTL--

--sEse9B9aw7plEa3NlS6NhEIALbLfEthoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFgRwACgkQHv7KIOw4
HPb3FQf9E4i2dStcSJZQalg71K+3iVqgdNNdkwYg9IAwn459O0KLMyhxFumBSsLp
NTdgat+vbk/eLTJlm/lsrcxRrqDTnAxWxSqMaKJrjhHEXTBVrYkNXamukH9dmx3E
vjmoCI5Q6lUhnIyypDrMjgyuOhOD4Gl/O6FSJOtvIIFuU/Iqudz1vHS9QXhJGA1x
Y2GSr+UiYPgryLEv785LmA6NHOvxFXkCmDnhCdir/hnKWLeYt1IMo9C2DQIs6WOT
FXjk59PwACxowD4RbylOYg9P1E3kg1TKuHWXh08z5JYc1ZDG3j/ISTTVOg+M4dmd
+bCAPRzDtXV80jJIhGj3RDU2149Nlw==
=FIwA
-----END PGP SIGNATURE-----

--sEse9B9aw7plEa3NlS6NhEIALbLfEthoc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
