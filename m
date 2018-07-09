From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH] apalis_t30: fix can2
Date: Mon, 9 Jul 2018 17:08:34 +0200
Message-ID: <20180709150834.GC18353@ulmo>
References: <20180703150340.29580-1-marcel@ziswiler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703150340.29580-1-marcel@ziswiler.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, linux-can@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 05:03:39PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> CAN2 currently fails on probe as follows:
>=20
> mcp251x spi1.1: Probe failed, err=3D19
>=20
> Fix this by enabling input on pin mux of resp. SPI4 pins.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
>=20
>  arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.19/arm/dt, thanks.

Thierry

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDem8ACgkQ3SOs138+
s6FatA//Q3UsiK6S5OcpY2UDUoYQ8QzjfrGpvdIuFNXKQc1SOqme3oCTDaWwgRrU
j3B+9NXTG1NMrm7/sB/1J6CwEM4B0Hz3d08AF88D9G/xNElzBtH8N23VMthRRprZ
8a5wZ2gnQ7a6K6/X2apx3XRXExmQeDFyQqe/WCW0w+0ieVz1lrcxsn+QtFmc7URJ
1MvFxGUyIsChXVJyXOUeAAvLypQxopkOvonMMg0Nbamav/blFZ0VzcKGLduQUptH
Bxd7qPNAQ6cImWPMrsuWEMUK8Y+EjG8Lhc89eVQ3DNFfb0xUMWigp2eXa5Wzhh+h
+53ITy4uSwVqh9MqEWcC8t02dBiHpBIi5V0odYMT3vLgaL9paQ6m9q/gcJa9Lswr
sLAyxVqtqDOfrjxl0prV7cYIlZoOffUhTKPIEB72GNcXUGORPzf6obtoRUblyEL6
Cs7mi3GX38XqnxJZzF43wuY8pRh/9ehhTYc2BrtZUW8frc5zy/527ZdK1xa6QZLS
PsfYDI9CbPfzGSwdQUFNj+uAQR5P6nh4sNZbnd1YzHAqcprCHLNbrhZKyQywpBpm
zxtlw2fSZMCTyBHLlnigGnGCea9Xz0OVc16gLpXXPA6atNiMXsViLKTcTgQ3RzSu
ilIDzgh1yYE16QgP/OpD2PR88uSNoWBqV4jv16hcYxO0CeBtus4=
=v0+e
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
