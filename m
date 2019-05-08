From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 8 May 2019 16:35:46 +0200
Message-ID: <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
References: <20190319172651.10012-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1r7rTP50MEDVwdj8E3He51a7N0s6cxNS3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319172651.10012-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1r7rTP50MEDVwdj8E3He51a7N0s6cxNS3
Content-Type: multipart/mixed; boundary="E6g4mkyKo6xVnHLkhPyEKWZ1mgUQRAkAe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
References: <20190319172651.10012-1-dmurphy@ti.com>
In-Reply-To: <20190319172651.10012-1-dmurphy@ti.com>

--E6g4mkyKo6xVnHLkhPyEKWZ1mgUQRAkAe
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 3/19/19 6:26 PM, Dan Murphy wrote:
> Create a m_can platform framework that peripheral
> devices can register to and use common code and register sets.
> The peripheral devices may provide read/write and configuration
> support of the IP.
>=20
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

[...]

> -/* m_can private data structure */
> -struct m_can_priv {
> -	struct can_priv can;	/* must be the first member */
> -	struct napi_struct napi;
> -	struct net_device *dev;
> -	struct device *device;
> -	struct clk *hclk;
> -	struct clk *cclk;
> -	void __iomem *base;
> -	u32 irqstatus;
> -	int version;
> -
> -	/* message ram configuration */
> -	void __iomem *mram_base;
> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
> -};
> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
> +{
> +	if (priv->ops->read_reg)
> +		return priv->ops->read_reg(priv, reg);
> +	else
> +		return -EINVAL;
> +}

How do you plan to check the return value here?
What's the difference between a register value of 0xffffffe9 and
returning -EINVAL?

> =20
> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can=
_reg reg)
> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u3=
2 val)
>  {
> -	return readl(priv->base + reg);
> +	if (priv->ops->write_reg)
> +		return priv->ops->write_reg(priv, reg, val);
> +	else
> +		return -EINVAL;
>  }

I don't see anyone checking the return value. Better just dereference
the pointer and the kernel will produce a nice backtrace.

Same should be done for all read and write variants.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--E6g4mkyKo6xVnHLkhPyEKWZ1mgUQRAkAe--

--1r7rTP50MEDVwdj8E3He51a7N0s6cxNS3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlzS6UIACgkQWsYho5Hk
nSCf8wgAmQ8w7vrPaGZeDrxDQfBebFsuHOnulVeEZZ7YnwRN3y7fCVBIByDYv0ye
BNEn8YzfkVWWg/nbqt3zvrP+YORxBCX1tvzi6CMen1GxB2IbdIuuRKZyLDhR2fHn
ejD9uMteJ74EfYPS/Yr2GyascWbq9rd4FgAM/8SBwI5QVtJEjkm4BYu9rT+B4PmO
X1aHpaQ8kSSCF9uXY2fxpOEihc2eWA+kGTyIGEfMV+Ubyweqs9ehz9CECB7A1/xu
0HC5fkLLln791p+Gv4kWJHHjVwZIDrw99SXDqdgokYlckJCa2Fnxbl7sTqRa2Drk
l1ZEEnWVBxlg8jpurCSLl2a1QdqZww==
=3wV/
-----END PGP SIGNATURE-----

--1r7rTP50MEDVwdj8E3He51a7N0s6cxNS3--
