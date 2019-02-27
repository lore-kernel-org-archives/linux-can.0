From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add TX support for variable payload size
Date: Wed, 27 Feb 2019 15:03:25 +0100
Message-ID: <cb0bf438-e3c3-5591-dcf7-8802346feefc@pengutronix.de>
References: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q
Content-Type: multipart/mixed; boundary="zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <cb0bf438-e3c3-5591-dcf7-8802346feefc@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add TX support for variable payload size
References: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181212064419.18613-1-qiangqing.zhang@nxp.com>

--zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/12/18 7:46 AM, Joakim Zhang wrote:
> Now the FlexCAN driver always use last mailbox for TX, it will work wel=
l
> when MB payload size is 8/16 bytes.
> TX mailbox would change to 13 when MB payload size is 64 bytes to
> support CANFD. So we may need to set iflag register to add support for
> variable payload size.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 42 +++++++++++++++++++++++++++++----------=

>  1 file changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0f36eafe3ac1..13fd085fcf84 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -141,7 +141,9 @@
>  #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
>  #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
>  #define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_=
TIMESTAMP + 1)
> -#define FLEXCAN_IFLAG_MB(x)		BIT((x) & 0x1f)
> +#define FLEXCAN_IFLAG1_MB_NUM		32
> +#define FLEXCAN_IFLAG1_MB(x)		BIT(x)
> +#define FLEXCAN_IFLAG2_MB(x)		BIT((x) & 0x1f)
>  #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
>  #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
>  #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
> @@ -822,9 +824,15 @@ static inline u64 flexcan_read_reg_iflag_rx(struct=
 flexcan_priv *priv)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 iflag1, iflag2;
> =20
> -	iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
> -		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> -	iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default &
> +			~FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default;
> +	} else {
> +		iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default;
> +		iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default &
> +			~FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +	}

I just noticed, that FLEXCAN_IFLAGx_MB(priv->tx_mb_idx) should already
be part of the corresponding imaskx_default. See flexcan_open(). So we
can remove it completely here, right?

> =20
>  	return (u64)iflag2 << 32 | iflag1;
>  }
> @@ -836,7 +844,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	irqreturn_t handled =3D IRQ_NONE;
> -	u32 reg_iflag2, reg_esr;
> +	u32 reg_tx_iflag, tx_iflag_idx, reg_esr;

"tx_iflag_idx" is not an index (going from 0...63) but a bit-mask.

> +	void __iomem *reg_iflag;

"reg_iflag" is not a register but a pointer to a register, better rename
it. There is a "u64 reg_iflag" in the same function already, but in a
different scope. Why not make it a u32 instead of a void?

>  	enum can_state last_state =3D priv->can.state;
> =20
>  	/* reception interrupt */
> @@ -870,10 +879,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>  		}
>  	}
> =20
> -	reg_iflag2 =3D priv->read(&regs->iflag2);
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		reg_tx_iflag =3D priv->read(&regs->iflag2);
> +		tx_iflag_idx =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +		reg_iflag =3D &regs->iflag2;
> +	} else {
> +		reg_tx_iflag =3D priv->read(&regs->iflag1);
> +		tx_iflag_idx =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +		reg_iflag =3D &regs->iflag1;
> +	}
> =20
>  	/* transmission complete interrupt */
> -	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
> +	if (reg_tx_iflag & tx_iflag_idx) {
>  		u32 reg_ctrl =3D priv->read(&priv->tx_mb->can_ctrl);
> =20
>  		handled =3D IRQ_HANDLED;
> @@ -885,7 +902,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  		/* after sending a RTR frame MB is in RX mode */
>  		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  			    &priv->tx_mb->can_ctrl);
> -		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
> +		priv->write(tx_iflag_idx, reg_iflag);
>  		netif_wake_queue(dev);
>  	}
> =20
> @@ -1244,8 +1261,13 @@ static int flexcan_open(struct net_device *dev)
>  	priv->tx_mb_idx =3D priv->mb_count - 1;
>  	priv->tx_mb =3D flexcan_get_mb(priv, priv->tx_mb_idx);
> =20
> -	priv->reg_imask1_default =3D 0;
> -	priv->reg_imask2_default =3D FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> +	if (priv->tx_mb_idx >=3D FLEXCAN_IFLAG1_MB_NUM) {
> +		priv->reg_imask1_default =3D 0;
> +		priv->reg_imask2_default =3D FLEXCAN_IFLAG2_MB(priv->tx_mb_idx);
> +	} else {
> +		priv->reg_imask1_default =3D FLEXCAN_IFLAG1_MB(priv->tx_mb_idx);
> +		priv->reg_imask2_default =3D 0;
> +	}
> =20
>  	priv->offload.mailbox_read =3D flexcan_mailbox_read;
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--zgwkDLGLmV2tiDDHkTxnm9pBa7hK27aPF--

--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2mK0ACgkQWsYho5Hk
nSDItAf/Tatpm6THsskAxHwTjMqsWpGTrRfXyNO7aYTMa4m7Td0IEjmxQ3TLguN7
Zfuo4zdLHI0iEJQrA5tyxHHmtJLhztV58l/ZTZG8yzL05R1pklxfDFxL8/+5gxjm
T2bTcKJN/kKDYTYQloklUaTEQqZLt5RPIYNW3ByyAcEyDS21vhDq8aQ2JoAY9+VF
bvOQmmTBzFG+GMj8vm4u3B6Y7FYYu2F4/IRa3BtMdIV+ZpB6LlOLWEMCa+sCQp56
50YeFAXbHq+22CX8VnzPwL6xz3w41xfGbBVDD2PeC6pFR1PUiPwnpOpHJ8n7lRbk
tjTySTzgzp9jDVCS9XPjWH/kGeLi0g==
=KmaZ
-----END PGP SIGNATURE-----

--rHzSW3w6iy4aDzcweX6WrcfMFAxHWKe9Q--
