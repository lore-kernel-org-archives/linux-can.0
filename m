From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/4] ARM: dts: sun4i: Add CAN node
Date: Tue, 4 Apr 2017 17:40:18 +0200
Message-ID: <20170404154018.6phu2udfgwuzklkk@lukather>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-2-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ka5cukxufqo6yptp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491238814-4888-2-git-send-email-menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org


--ka5cukxufqo6yptp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 07:00:11PM +0200, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller.
> This patch adds the device node.
>=20
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> Signed-off-by: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index ba20b48..7c559e7 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1313,6 +1313,14 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		can0: can@01c2bc00 {
> +			compatible =3D "allwinner,sun4i-a10-can";
> +			reg =3D <0x01c2bc00 0x400>;
> +			interrupts =3D <26>;
> +			clocks =3D <&apb1_gates 4>;
> +			status =3D "disabled";
> +		};
> +

This wasn't ordered properly. Fixed and applied.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ka5cukxufqo6yptp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY475iAAoJEBx+YmzsjxAgUMoP/2RK7ZIuiKlVu21BoZAaEXIL
FaxXfL3i/31qgs06++m6tdWmln0frjmfQmCad8e4AuF5RFO3PvxvIP/0L+gpUXc2
rAjuOc4C4h+F7cP4PqbXA5iEKYl2gkc5o4Yfq5NdP90CAtvJRVGtQLoFtoHCXAzI
Dk3G90tj0NMF4Hf09Dc5Z/txYY70WU9ZalF9hgj4iFvsEgNS/vmWc1oMxZa7Go0M
oFPWDLGS6rkQ7kfVcnX0bvhVJnrVGJRvCvtUGKNjNon5p4K0akvBU9XvXwAP8+XR
oTtJ4hbwmbXRungSLv1folWIb3ORb3QunQt+QpQbogMf292SZKwamOrtIZBLaYOX
d9CSouBl7qWo2oMwuHt3hXUgNwrLLOBgmorzofh+/3iUxxQ8IArnLoOuRO6eZqGO
6lJ17tj6i0ckypC5n50tbnbLM3uyR7O5d/cC31n/ADXx/RXt8nGyqS5TorBsqB1K
YFiQuD5aDpYjLSSx0mHZLbpchIWJBE4vc1UK4r0xiDes4JxlfPMgHcoK2ls6AAZ3
J5P80GLmjFELX4PH/a6jy79FIZIqF4wfjFA2Gx8+ybWY4s3SLp9lcT+vLLOJYOec
joauYuKBZpiHqjMJZXSP8R2Gc5kRmlHh5gI3+72qU/s5yOwHWDh3WD9EgGEpzk7q
q03YHDYGu5FvaRWA3FY4
=v/hd
-----END PGP SIGNATURE-----

--ka5cukxufqo6yptp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
