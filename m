From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can: sja1000: Optimise register accesses
Date: Mon, 19 Sep 2016 16:08:04 +0200
Message-ID: <6f96b7d9-e8b6-28cc-b1d3-dbd04bf1a46d@pengutronix.de>
References: <20160908135101.17978-1-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="q5JOeXOLRdsQufbJLeCdLH0nwQoW8nrE9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45205 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S938669AbcISOIM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2016 10:08:12 -0400
In-Reply-To: <20160908135101.17978-1-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q5JOeXOLRdsQufbJLeCdLH0nwQoW8nrE9
Content-Type: multipart/mixed; boundary="tKwHw7d1qxfbx1HQdihwIevoeFWM2LWGX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org
Message-ID: <6f96b7d9-e8b6-28cc-b1d3-dbd04bf1a46d@pengutronix.de>
Subject: Re: [PATCH v4] can: sja1000: Optimise register accesses
References: <20160908135101.17978-1-nebaruzdin@gmail.com>
In-Reply-To: <20160908135101.17978-1-nebaruzdin@gmail.com>

--tKwHw7d1qxfbx1HQdihwIevoeFWM2LWGX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2016 03:51 PM, Nikita Edward Baruzdin wrote:
> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
>=20
> Thus, this patch introduces [read|write]_reg_rep() interface functions
> that are used to read/write CAN ID and payload data.
>=20
>   * For plx_pci driver this interface is implemented as
>     plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
>     register accesses as much as possible to improve driver performance=
=2E
>=20
>   * For other drivers the default implementation,
>     sja1000_[read|write]_reg_rep(), is used for now. These functions
>     still access registers in a series of ioread8()/iowrite8() calls.
>=20
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
> ---
>  drivers/net/can/sja1000/plx_pci.c | 38 +++++++++++++++++++++++++++
>  drivers/net/can/sja1000/sja1000.c | 55 ++++++++++++++++++++++++-------=
--------
>  drivers/net/can/sja1000/sja1000.h |  4 +++
>  3 files changed, 76 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja100=
0/plx_pci.c
> index 3eb7430..ff2858f 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -371,6 +371,42 @@ static void plx_pci_write_reg(const struct sja1000=
_priv *priv, int port, u8 val)
>  	iowrite8(val, priv->reg_base + port);
>  }
> =20
> +static void plx_pci_read_reg_rep(const struct sja1000_priv *priv, int =
reg,
> +                                 u8 *buffer, size_t count)
> +{
> +	while (count >=3D 4) {
> +		*(__le32 *)buffer =3D cpu_to_le32(ioread32(priv->reg_base + reg));
> +		buffer +=3D 4;
> +		reg +=3D 4;
> +		count -=3D 4;
> +	}
> +	if (count & 2) {
> +		*(__le16 *)buffer =3D cpu_to_le16(ioread16(priv->reg_base + reg));
> +		buffer +=3D 2;
> +		reg +=3D 2;
> +	}
> +	if (count & 1)
> +		*buffer =3D ioread8(priv->reg_base + reg);
> +}
> +
> +static void plx_pci_write_reg_rep(const struct sja1000_priv *priv, int=
 reg,
> +                                  const u8 *buffer, size_t count)
> +{
> +	while (count >=3D 4) {
> +		iowrite32(le32_to_cpu(*(__le32 *)buffer), priv->reg_base + reg);
> +		buffer +=3D 4;
> +		reg +=3D 4;
> +		count -=3D 4;
> +	}
> +	if (count & 2) {
> +		iowrite16(le16_to_cpu(*(__le16 *)buffer), priv->reg_base + reg);
> +		buffer +=3D 2;
> +		reg +=3D 2;
> +	}
> +	if (count & 1)
> +		iowrite8(*buffer, priv->reg_base + reg);
> +}
> +
>  /*
>   * Check if a CAN controller is present at the specified location
>   * by trying to switch 'em from the Basic mode into the PeliCAN mode.
> @@ -626,6 +662,8 @@ static int plx_pci_add_card(struct pci_dev *pdev,
>  		priv->reg_base =3D addr + cm->offset;
>  		priv->read_reg =3D plx_pci_read_reg;
>  		priv->write_reg =3D plx_pci_write_reg;
> +		priv->read_reg_rep =3D plx_pci_read_reg_rep;
> +		priv->write_reg_rep =3D plx_pci_write_reg_rep;
> =20
>  		/* Check if channel is present */
>  		if (plx_pci_check_sja1000(priv)) {
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja100=
0/sja1000.c
> index 9f10779..ff046f3 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -82,6 +82,24 @@ static const struct can_bittiming_const sja1000_bitt=
iming_const =3D {
>  	.brp_inc =3D 1,
>  };
> =20
> +static void sja1000_read_reg_rep(const struct sja1000_priv *priv, int =
reg,
> +                                 u8 *buffer, size_t count)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++)
> +		buffer[i] =3D priv->read_reg(priv, reg + i);
> +}
> +
> +static void sja1000_write_reg_rep(const struct sja1000_priv *priv, int=
 reg,
> +                                  const u8 *buffer, size_t count)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++)
> +		priv->write_reg(priv, reg + i, buffer[i]);
> +}
> +
>  static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
>  {
>  	unsigned long flags;
> @@ -288,7 +306,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buf=
f *skb,
>  	canid_t id;
>  	uint8_t dreg;
>  	u8 cmd_reg_val =3D 0x00;
> -	int i;
> +	u8 id_buf[4];
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -305,19 +323,16 @@ static netdev_tx_t sja1000_start_xmit(struct sk_b=
uff *skb,
>  		fi |=3D SJA1000_FI_FF;
>  		dreg =3D SJA1000_EFF_BUF;
>  		priv->write_reg(priv, SJA1000_FI, fi);
> -		priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
> -		priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
> -		priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
> -		priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
> +		*(__be32 *)id_buf =3D cpu_to_be32(id << 3);
> +		priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 4);

I talked to my PCI expert and we came to the conclusion that it's a very
bad idea to acess the PCI bus with 32 bit on non aligned addresses.

#define SJA1000_ID1		0x11

This may work on x86 but we're not sure about other platforms.

Maybe it's an option to create a struct describing the memory layout
starting with 0x10. And then read it in different chunks, depending if
we have a read_rep function or not.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tKwHw7d1qxfbx1HQdihwIevoeFWM2LWGX--

--q5JOeXOLRdsQufbJLeCdLH0nwQoW8nrE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX3/FEAAoJED07qiWsqSVqHD0IAITpuR7bFST80peEqo25phfV
c1n55H1PpQXqb+TXmsEgEEOANLr3hZpX6Tor0AcvN15B2W4ckknXDmYcSJepWKfv
Mn1cbrUijQJRdz2c2V3YOgzjiu34VIxhkOgpoXw/pusEViXQ5wIGkXEmKctGB5ee
LgGBrijmfXseHTxyZlWXDFpvVA4AMXXlX4g76SAYMLN6Z8EliM/18bx2nKTOEA2a
Gp9slfE74OOz7UN03+RQHeI8KLZQvjcyVFgJ/bnKUL374W86DIfCmCxnIycCZocH
VZu2W3nhjmOSeIG4doLWZHKkdC+JPRbpFkmBFjdqC+hLKb13EoAYGnOWfAXpsqU=
=r8nZ
-----END PGP SIGNATURE-----

--q5JOeXOLRdsQufbJLeCdLH0nwQoW8nrE9--
