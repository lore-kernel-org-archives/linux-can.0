From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] apalis_t30: fix can2
Date: Mon, 23 Jul 2018 12:18:57 +0200
Message-ID: <2fc4b2fb-fa2c-f9e7-82fd-58d0efc28499@pengutronix.de>
References: <20180625075948.32040-1-marcel@ziswiler.com>
 <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aA81cAebEog7KC9NSeaqhEMrrBU8BGxNw"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org, linux-can@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aA81cAebEog7KC9NSeaqhEMrrBU8BGxNw
Content-Type: multipart/mixed; boundary="W4PfbXg0chkN7Mv6MyAmJy6dmpOBXNC63";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marcel Ziswiler <marcel@ziswiler.com>, linux-tegra@vger.kernel.org,
 linux-can@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <2fc4b2fb-fa2c-f9e7-82fd-58d0efc28499@pengutronix.de>
Subject: Re: [PATCH] apalis_t30: fix can2
References: <20180625075948.32040-1-marcel@ziswiler.com>
 <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>
In-Reply-To: <c511af9e-e0d5-f7d8-e6cc-92ea0df7a290@pengutronix.de>

--W4PfbXg0chkN7Mv6MyAmJy6dmpOBXNC63
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/23/2018 10:16 AM, Marc Kleine-Budde wrote:
> On 06/25/2018 09:59 AM, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> CAN2 currently fails on probe as follows:
>>
>> mcp251x spi1.1: Probe failed, err=3D19
>>
>> Fix this by enabling input on pin mux of resp. SPI4 pins.
>>
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> I can take this via the linux-can tree. Any acks from the DT people?

Never mind - it has been applied by Thierry menawhile:

> Applied to for-4.19/arm/dt, thanks.
>=20
> Thierry

sorry for the noise.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--W4PfbXg0chkN7Mv6MyAmJy6dmpOBXNC63--

--aA81cAebEog7KC9NSeaqhEMrrBU8BGxNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVq5EACgkQk9IU1zQo
ZfFnUgf+LkYz8vgtoay/6c8fV1lY0u3HkJEvMvwuQMq6x0eADsusdknS42R25sUX
L7eYHh5BsdpFTJJ1m5WmWrQwEIQUy2Vrb+zjrU0J2tvm2/qWkDFy97hZcU6BggBp
SAsirF7jneiOozt8ZEhsj1YkUJh/BstXkWxw5aet69w7Fi16fS7c7JD8yaXkZpLV
Kaaj6tZAXd3C3FMbrZVOfm4m8PDPCAqDZo8PozT/YYmcaEyV48TJxswVdGJKN4Ug
WhAyzbd8c81QavtTZw4RIbpL6CRAOrlfZsHmmYPI/P5zs1CdKLy8IW/MJz7Hzjlu
uxreo8o31DY3189a/O1GTNjFz2T4cg==
=ajBJ
-----END PGP SIGNATURE-----

--aA81cAebEog7KC9NSeaqhEMrrBU8BGxNw--
