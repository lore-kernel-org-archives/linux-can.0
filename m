From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Thu, 9 May 2019 08:38:29 +0200
Message-ID: <b6d6daab-ff49-76d1-e363-6179100be560@pengutronix.de>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
 <35d179a7-2682-111e-638b-903559f0974a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a3xXgYU38s46hzqdXcmCpGMtxhdaaPBt4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35d179a7-2682-111e-638b-903559f0974a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a3xXgYU38s46hzqdXcmCpGMtxhdaaPBt4
Content-Type: multipart/mixed; boundary="VQj2Tbcz15jDp4XUoPDDM0DRxRoZdHHvZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <b6d6daab-ff49-76d1-e363-6179100be560@pengutronix.de>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
References: <20190319172651.10012-1-dmurphy@ti.com>
 <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
 <35d179a7-2682-111e-638b-903559f0974a@ti.com>
In-Reply-To: <35d179a7-2682-111e-638b-903559f0974a@ti.com>

--VQj2Tbcz15jDp4XUoPDDM0DRxRoZdHHvZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 5/8/19 9:54 PM, Dan Murphy wrote:
>>> -/* m_can private data structure */
>>> -struct m_can_priv {
>>> -	struct can_priv can;	/* must be the first member */
>>> -	struct napi_struct napi;
>>> -	struct net_device *dev;
>>> -	struct device *device;
>>> -	struct clk *hclk;
>>> -	struct clk *cclk;
>>> -	void __iomem *base;
>>> -	u32 irqstatus;
>>> -	int version;
>>> -
>>> -	/* message ram configuration */
>>> -	void __iomem *mram_base;
>>> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
>>> -};
>>> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
>>> +{
>>> +	if (priv->ops->read_reg)
>>> +		return priv->ops->read_reg(priv, reg);
>>> +	else
>>> +		return -EINVAL;
>>> +}
>>
>> How do you plan to check the return value here?
>> What's the difference between a register value of 0xffffffe9 and
>> returning -EINVAL?
>=20
> Good point.  I could just inline this and return whatever is sent
> from the callback and as you said allow a backtrace to happen if
> read_reg is invalid.

ACK.
A minimal function will look like this:

static inline u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)=

{
	return priv->ops->read_reg(priv, reg);
}

And of ops or read_reg is NULL, the kernel will access a NULL pointer
that would then generate a backtrace.

>>> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_c=
an_reg reg)
>>> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, =
u32 val)
>>>  {
>>> -	return readl(priv->base + reg);
>>> +	if (priv->ops->write_reg)
>>> +		return priv->ops->write_reg(priv, reg, val);
>>> +	else
>>> +		return -EINVAL;
>>>  }
>>
>> I don't see anyone checking the return value. Better just dereference
>> the pointer and the kernel will produce a nice backtrace.
>>
>> Same should be done for all read and write variants.
>>
>=20
> I will need to go through this and see if there is any caller checking =
the return.  But
> I think you are correct.  If thats true I will just change this to a vo=
id, inline the function
> and allow a backtrace if the callback is null

ok

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VQj2Tbcz15jDp4XUoPDDM0DRxRoZdHHvZ--

--a3xXgYU38s46hzqdXcmCpGMtxhdaaPBt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlzTyuUACgkQWsYho5Hk
nSBiEQgAomIXBCvMCBf188HH8++++IsfVDErPHlwIp+jyLFokfKE8bEUwxRR/U4R
oa7B9WgfoejxfrLsN0AnmhW4lIZPwCWjbSUcVnS/FxQfHBG3L37xwD/qr5hz7Wtx
CigXUeuKEQwH5phx7Ht+hDZNi1NCoAwuISekww7wTLlXGMRsJdmhrVFFaPk51S4o
LnQALH2bcuwJB0VAAjGdIg05X+VQcdISRYlqydol7uVdPbvvE7UuHvUZMzg59AzQ
wRT3s5nN5z+8d+41xtWYiFJgPQoUfFfIgrE+DppxaNxAbj9EqDVok1cylRmLiAcS
K6sbNLefiU1uhw9UusZgFjYuWu8PaA==
=7e44
-----END PGP SIGNATURE-----

--a3xXgYU38s46hzqdXcmCpGMtxhdaaPBt4--
