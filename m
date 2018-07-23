From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] apalis_t30: fix can2
Date: Mon, 23 Jul 2018 10:16:23 +0200
Message-ID: <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>
References: <20180625075948.32040-1-marcel@ziswiler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ld08EnLgxkrgaK7Bm8HjfwaGb7NhYotQu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625075948.32040-1-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org, linux-can@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ld08EnLgxkrgaK7Bm8HjfwaGb7NhYotQu
Content-Type: multipart/mixed; boundary="ykCVeTTNicVzTeB6hHfnAlWAgjP5xqIlx";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org,
 linux-can@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>
Subject: Re: [PATCH] apalis_t30: fix can2
References: <20180625075948.32040-1-marcel@ziswiler.com>
In-Reply-To: <20180625075948.32040-1-marcel@ziswiler.com>

--ykCVeTTNicVzTeB6hHfnAlWAgjP5xqIlx
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 06/25/2018 09:59 AM, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> CAN2 currently fails on probe as follows:
>=20
> mcp251x spi1.1: Probe failed, err=3D19
>=20
> Fix this by enabling input on pin mux of resp. SPI4 pins.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

I can take this via the linux-can tree. Any acks from the DT people?

Marc

>=20
> ---
>=20
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/=
tegra30-apalis.dtsi
> index d1d21ec2a844..9ff6aafd72b3 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -118,6 +118,7 @@
>  				nvidia,function =3D "spi4";
>  				nvidia,pull =3D <TEGRA_PIN_PULL_NONE>;
>  				nvidia,tristate =3D <TEGRA_PIN_DISABLE>;
> +				nvidia,enable-input =3D <TEGRA_PIN_ENABLE>;
>  			};
>  			/* CAN_INT2 */
>  			spi2_cs2_n_pw3 {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ykCVeTTNicVzTeB6hHfnAlWAgjP5xqIlx--

--Ld08EnLgxkrgaK7Bm8HjfwaGb7NhYotQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVjtcACgkQk9IU1zQo
ZfH+Kgf/SiJUWYSH0+Zy+D4N0mH21tlPglTZm4y1PFD+duuK6DYGE2QbQYd21DE7
IrBsweupUHq+lNlDMT5+A1mqjNAhi2hCfeFWFGIFjnNWKqSNe7vZh12fkKSZRkQY
XNXGnVd1q34iJSO7TaDyF5MO9EiSu8dYnpM7dJLSz1YXpvKsPiEzPF7GutXdpogg
fKVM2oHT64u1xwR+e4f52A8boHp6N4eq5SYjAFG/o42h6mKQYMU2wtJblYBv5t9Q
hm7OwdFGsI0VPZihwuyMDVQb1YgEnP0C4NhpqL4/tyHhJa24Vgr3FWmY9V/L/Rsy
QsL5N4OPA9ebGgMrtgOdctKbbwWtBA==
=azuG
-----END PGP SIGNATURE-----

--Ld08EnLgxkrgaK7Bm8HjfwaGb7NhYotQu--
