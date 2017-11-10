From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
Date: Fri, 10 Nov 2017 11:06:41 +0100
Message-ID: <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Qj3tG7jDNnup5umVeDpprBWrj5hq0JfRi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53679 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752451AbdKJKqj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 05:46:39 -0500
In-Reply-To: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com, linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qj3tG7jDNnup5umVeDpprBWrj5hq0JfRi
Content-Type: multipart/mixed; boundary="GcSdDuiaAiDm4NLsPCQ3ULOq7qe1B8TQ3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, wg@grandegger.com,
 linux-can@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Sakar Arora <Sakar.Arora@freescale.com>
Message-ID: <a08c34d0-5870-b4b3-f68d-3db33ba3e950@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: Remodel FlexCAN register r/w APIs for
 big endian FlexCAN controllers.
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
In-Reply-To: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>

--GcSdDuiaAiDm4NLsPCQ3ULOq7qe1B8TQ3
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 10:59 AM, Pankaj Bansal wrote:
> The FlexCAN driver assumed that FlexCAN controller is big endian for
> powerpc architecture and little endian for other architectures.
>=20
> But this may not be the case. FlexCAN controller can be little or
> big endian on any architecture. For e.g. NXP LS1021A ARM based SOC
> has big endian FlexCAN controller.
>=20
> Therefore, the driver has been modified to add a provision for both
> types of controllers using an additional device tree property. Big
> Endian controllers should have "big-endian" set in the device tree.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
> Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
> Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> ---
> Tested on Arm32 based NXP LS1021A-TWR board (linux-can-next/master bran=
ch)
> Tested on PowerPC based NXP P1010RDB board (after back porting to Frees=
cale SDK 1.4 linux)
>=20
>  drivers/net/can/flexcan.c | 212 ++++++++++++++++++++----------------
>  1 file changed, 116 insertions(+), 96 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index a13a489..d4ce2df 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -279,6 +279,10 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +
> +	/* Read and Write APIs */
> +	u32 (*read)(void __iomem *addr);
> +	void (*write)(u32 val, void __iomem *addr);
>  };
> =20
>  static const struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
> @@ -312,39 +316,45 @@ static const struct can_bittiming_const flexcan_b=
ittiming_const =3D {
>  	.brp_inc =3D 1,
>  };
> =20
> -/* Abstract off the read/write for arm versus ppc. This
> - * assumes that PPC uses big-endian registers and everything
> - * else uses little-endian registers, independent of CPU
> - * endianness.
> +/* FlexCAN module is essentially modelled as a little-endian IP in mos=
t
> + * SoCs, i.e the registers as well as the message buffer areas are
> + * implemented in a little-endian fashion.
> + *
> + * However there are some SoCs (e.g. LS1021A) which implement the Flex=
CAN
> + * module in a big-endian fashion (i.e the registers as well as the
> + * message buffer areas are implemented in a big-endian way).
> + *
> + * In addition, the FlexCAN module can be found on SoCs having ARM or
> + * PPC cores. So, we need to abstract off the register read/write
> + * functions, ensuring that these cater to all the combinations of mod=
ule
> + * endianness and underlying CPU endianness.
>   */
> -#if defined(CONFIG_PPC)
> -static inline u32 flexcan_read(void __iomem *addr)
> +static inline u32 flexcan_read_le(void __iomem *addr)
>  {
> -	return in_be32(addr);
> +	return ioread32(addr);
>  }
> =20
> -static inline void flexcan_write(u32 val, void __iomem *addr)
> +static inline void flexcan_write_le(u32 val, void __iomem *addr)
>  {
> -	out_be32(addr, val);
> +	iowrite32(val, addr);
>  }

Please make this the be variants, followed by the le below. Should make
the patch easier to read.

> -#else
> -static inline u32 flexcan_read(void __iomem *addr)
> +
> +static inline u32 flexcan_read_be(void __iomem *addr)
>  {
> -	return readl(addr);
> +	return ioread32be(addr);
>  }
> =20
> -static inline void flexcan_write(u32 val, void __iomem *addr)
> +static inline void flexcan_write_be(u32 val, void __iomem *addr)
>  {
> -	writel(val, addr);
> +	iowrite32be(val, addr);
>  }
> -#endif
> =20
>  static inline void flexcan_error_irq_enable(const struct flexcan_priv =
*priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 reg_ctrl =3D (priv->reg_ctrl_default | FLEXCAN_CTRL_ERR_MSK);
> =20
> -	flexcan_write(reg_ctrl, &regs->ctrl);
> +	priv->write(reg_ctrl, &regs->ctrl);
>  }
> =20
>  static inline void flexcan_error_irq_disable(const struct flexcan_priv=
 *priv)
> @@ -352,7 +362,7 @@ static inline void flexcan_error_irq_disable(const =
struct flexcan_priv *priv)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 reg_ctrl =3D (priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_MSK);
> =20
> -	flexcan_write(reg_ctrl, &regs->ctrl);
> +	priv->write(reg_ctrl, &regs->ctrl);
>  }
> =20
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv=
 *priv)
> @@ -377,14 +387,14 @@ static int flexcan_chip_enable(struct flexcan_pri=
v *priv)
>  	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>  	u32 reg;
> =20
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	reg &=3D ~FLEXCAN_MCR_MDIS;
> -	flexcan_write(reg, &regs->mcr);
> +	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))=

> +	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
>  		udelay(10);
> =20
> -	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> +	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
>  		return -ETIMEDOUT;
> =20
>  	return 0;
> @@ -396,14 +406,14 @@ static int flexcan_chip_disable(struct flexcan_pr=
iv *priv)
>  	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>  	u32 reg;
> =20
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	reg |=3D FLEXCAN_MCR_MDIS;
> -	flexcan_write(reg, &regs->mcr);
> +	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)=
)
> +	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
>  		udelay(10);
> =20
> -	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
>  		return -ETIMEDOUT;
> =20
>  	return 0;
> @@ -415,14 +425,14 @@ static int flexcan_chip_freeze(struct flexcan_pri=
v *priv)
>  	unsigned int timeout =3D 1000 * 1000 * 10 / priv->can.bittiming.bitra=
te;
>  	u32 reg;
> =20
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	reg |=3D FLEXCAN_MCR_HALT;
> -	flexcan_write(reg, &regs->mcr);
> +	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)=
)
> +	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
>  		udelay(100);
> =20
> -	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
>  		return -ETIMEDOUT;
> =20
>  	return 0;
> @@ -434,14 +444,14 @@ static int flexcan_chip_unfreeze(struct flexcan_p=
riv *priv)
>  	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>  	u32 reg;
> =20
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	reg &=3D ~FLEXCAN_MCR_HALT;
> -	flexcan_write(reg, &regs->mcr);
> +	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))=

> +	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
>  		udelay(10);
> =20
> -	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> +	if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
>  		return -ETIMEDOUT;
> =20
>  	return 0;
> @@ -452,11 +462,11 @@ static int flexcan_chip_softreset(struct flexcan_=
priv *priv)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
> =20
> -	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> -	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))=

> +	priv->write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> +	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
>  		udelay(10);
> =20
> -	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
> +	if (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
>  		return -ETIMEDOUT;
> =20
>  	return 0;
> @@ -467,7 +477,7 @@ static int __flexcan_get_berr_counter(const struct =
net_device *dev,
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> -	u32 reg =3D flexcan_read(&regs->ecr);
> +	u32 reg =3D priv->read(&regs->ecr);
> =20
>  	bec->txerr =3D (reg >> 0) & 0xff;
>  	bec->rxerr =3D (reg >> 8) & 0xff;
> @@ -523,24 +533,24 @@ static int flexcan_start_xmit(struct sk_buff *skb=
, struct net_device *dev)
> =20
>  	if (cf->can_dlc > 0) {
>  		data =3D be32_to_cpup((__be32 *)&cf->data[0]);
> -		flexcan_write(data, &priv->tx_mb->data[0]);
> +		priv->write(data, &priv->tx_mb->data[0]);
>  	}
>  	if (cf->can_dlc > 3) {
>  		data =3D be32_to_cpup((__be32 *)&cf->data[4]);
> -		flexcan_write(data, &priv->tx_mb->data[1]);
> +		priv->write(data, &priv->tx_mb->data[1]);
>  	}
> =20
>  	can_put_echo_skb(skb, dev, 0);
> =20
> -	flexcan_write(can_id, &priv->tx_mb->can_id);
> -	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
> +	priv->write(can_id, &priv->tx_mb->can_id);
> +	priv->write(ctrl, &priv->tx_mb->can_ctrl);
> =20
>  	/* Errata ERR005829 step8:
>  	 * Write twice INACTIVE(0x8) code to first MB.
>  	 */
> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  		      &priv->tx_mb_reserved->can_ctrl);
> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  		      &priv->tx_mb_reserved->can_ctrl);
> =20
>  	return NETDEV_TX_OK;
> @@ -659,7 +669,7 @@ static unsigned int flexcan_mailbox_read(struct can=
_rx_offload *offload,
>  		u32 code;
> =20
>  		do {
> -			reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> +			reg_ctrl =3D priv->read(&mb->can_ctrl);
>  		} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
> =20
>  		/* is this MB empty? */
> @@ -674,17 +684,17 @@ static unsigned int flexcan_mailbox_read(struct c=
an_rx_offload *offload,
>  			offload->dev->stats.rx_errors++;
>  		}
>  	} else {
> -		reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +		reg_iflag1 =3D priv->read(&regs->iflag1);
>  		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
>  			return 0;
> =20
> -		reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> +		reg_ctrl =3D priv->read(&mb->can_ctrl);
>  	}
> =20
>  	/* increase timstamp to full 32 bit */
>  	*timestamp =3D reg_ctrl << 16;
> =20
> -	reg_id =3D flexcan_read(&mb->can_id);
> +	reg_id =3D priv->read(&mb->can_id);
>  	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
>  		cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
>  	else
> @@ -694,19 +704,19 @@ static unsigned int flexcan_mailbox_read(struct c=
an_rx_offload *offload,
>  		cf->can_id |=3D CAN_RTR_FLAG;
>  	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
> =20
> -	*(__be32 *)(cf->data + 0) =3D cpu_to_be32(flexcan_read(&mb->data[0]))=
;
> -	*(__be32 *)(cf->data + 4) =3D cpu_to_be32(flexcan_read(&mb->data[1]))=
;
> +	*(__be32 *)(cf->data + 0) =3D cpu_to_be32(priv->read(&mb->data[0]));
> +	*(__be32 *)(cf->data + 4) =3D cpu_to_be32(priv->read(&mb->data[1]));
> =20
>  	/* mark as read */
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
>  		/* Clear IRQ */
>  		if (n < 32)
> -			flexcan_write(BIT(n), &regs->iflag1);
> +			priv->write(BIT(n), &regs->iflag1);
>  		else
> -			flexcan_write(BIT(n - 32), &regs->iflag2);
> +			priv->write(BIT(n - 32), &regs->iflag2);
>  	} else {
> -		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> -		flexcan_read(&regs->timer);
> +		priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> +		priv->read(&regs->timer);
>  	}
> =20
>  	return 1;
> @@ -718,8 +728,8 @@ static inline u64 flexcan_read_reg_iflag_rx(struct =
flexcan_priv *priv)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 iflag1, iflag2;
> =20
> -	iflag2 =3D flexcan_read(&regs->iflag2) & priv->reg_imask2_default;
> -	iflag1 =3D flexcan_read(&regs->iflag1) & priv->reg_imask1_default &
> +	iflag2 =3D priv->read(&regs->iflag2) & priv->reg_imask2_default;
> +	iflag1 =3D priv->read(&regs->iflag1) & priv->reg_imask1_default &
>  		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> =20
>  	return (u64)iflag2 << 32 | iflag1;
> @@ -735,7 +745,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	u32 reg_iflag1, reg_esr;
>  	enum can_state last_state =3D priv->can.state;
> =20
> -	reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +	reg_iflag1 =3D priv->read(&regs->iflag1);
> =20
>  	/* reception interrupt */
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> @@ -758,7 +768,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  		/* FIFO overflow interrupt */
>  		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
>  			handled =3D IRQ_HANDLED;
> -			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
> +			priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW,
> +				      &regs->iflag1);
>  			dev->stats.rx_over_errors++;
>  			dev->stats.rx_errors++;
>  		}
> @@ -772,18 +783,18 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>  		can_led_event(dev, CAN_LED_EVENT_TX);
> =20
>  		/* after sending a RTR frame MB is in RX mode */
> -		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  			      &priv->tx_mb->can_ctrl);
> -		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
> +		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
>  		netif_wake_queue(dev);
>  	}
> =20
> -	reg_esr =3D flexcan_read(&regs->esr);
> +	reg_esr =3D priv->read(&regs->esr);
> =20
>  	/* ACK all bus error and state change IRQ sources */
>  	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
>  		handled =3D IRQ_HANDLED;
> -		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> +		priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>  	}
> =20
>  	/* state change interrupt or broken error state quirk fix is enabled =
*/
> @@ -845,7 +856,7 @@ static void flexcan_set_bittiming(struct net_device=
 *dev)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 reg;
> =20
> -	reg =3D flexcan_read(&regs->ctrl);
> +	reg =3D priv->read(&regs->ctrl);
>  	reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
>  		 FLEXCAN_CTRL_RJW(0x3) |
>  		 FLEXCAN_CTRL_PSEG1(0x7) |
> @@ -869,11 +880,11 @@ static void flexcan_set_bittiming(struct net_devi=
ce *dev)
>  		reg |=3D FLEXCAN_CTRL_SMP;
> =20
>  	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
> -	flexcan_write(reg, &regs->ctrl);
> +	priv->write(reg, &regs->ctrl);
> =20
>  	/* print chip status */
>  	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
> -		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> +		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
>  }
> =20
>  /* flexcan_chip_start
> @@ -912,7 +923,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  	 * choose format C
>  	 * set max mailbox number
>  	 */
> -	reg_mcr =3D flexcan_read(&regs->mcr);
> +	reg_mcr =3D priv->read(&regs->mcr);
>  	reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
>  	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
>  		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
> @@ -926,7 +937,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>  	}
>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
> -	flexcan_write(reg_mcr, &regs->mcr);
> +	priv->write(reg_mcr, &regs->mcr);
> =20
>  	/* CTRL
>  	 *
> @@ -939,7 +950,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  	 * enable bus off interrupt
>  	 * (=3D=3D FLEXCAN_CTRL_ERR_STATE)
>  	 */
> -	reg_ctrl =3D flexcan_read(&regs->ctrl);
> +	reg_ctrl =3D priv->read(&regs->ctrl);
>  	reg_ctrl &=3D ~FLEXCAN_CTRL_TSYN;
>  	reg_ctrl |=3D FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
>  		FLEXCAN_CTRL_ERR_STATE;
> @@ -959,45 +970,45 @@ static int flexcan_chip_start(struct net_device *=
dev)
>  	/* leave interrupts disabled for now */
>  	reg_ctrl &=3D ~FLEXCAN_CTRL_ERR_ALL;
>  	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
> -	flexcan_write(reg_ctrl, &regs->ctrl);
> +	priv->write(reg_ctrl, &regs->ctrl);
> =20
>  	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
> -		reg_ctrl2 =3D flexcan_read(&regs->ctrl2);
> +		reg_ctrl2 =3D priv->read(&regs->ctrl2);
>  		reg_ctrl2 |=3D FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
> -		flexcan_write(reg_ctrl2, &regs->ctrl2);
> +		priv->write(reg_ctrl2, &regs->ctrl2);
>  	}
> =20
>  	/* clear and invalidate all mailboxes first */
>  	for (i =3D priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
> -		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
> +		priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
>  			      &regs->mb[i].can_ctrl);
>  	}
> =20
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
>  		for (i =3D priv->offload.mb_first; i <=3D priv->offload.mb_last; i++=
)
> -			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
> +			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
>  				      &regs->mb[i].can_ctrl);
>  	}
> =20
>  	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  		      &priv->tx_mb_reserved->can_ctrl);
> =20
>  	/* mark TX mailbox as INACTIVE */
> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>  		      &priv->tx_mb->can_ctrl);
> =20
>  	/* acceptance mask/acceptance code (accept everything) */
> -	flexcan_write(0x0, &regs->rxgmask);
> -	flexcan_write(0x0, &regs->rx14mask);
> -	flexcan_write(0x0, &regs->rx15mask);
> +	priv->write(0x0, &regs->rxgmask);
> +	priv->write(0x0, &regs->rx14mask);
> +	priv->write(0x0, &regs->rx15mask);
> =20
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
> -		flexcan_write(0x0, &regs->rxfgmask);
> +		priv->write(0x0, &regs->rxfgmask);
> =20
>  	/* clear acceptance filters */
>  	for (i =3D 0; i < ARRAY_SIZE(regs->mb); i++)
> -		flexcan_write(0, &regs->rximr[i]);
> +		priv->write(0, &regs->rximr[i]);
> =20
>  	/* On Vybrid, disable memory error detection interrupts
>  	 * and freeze mode.
> @@ -1010,16 +1021,16 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>  		 * and Correction of Memory Errors" to write to
>  		 * MECR register
>  		 */
> -		reg_ctrl2 =3D flexcan_read(&regs->ctrl2);
> +		reg_ctrl2 =3D priv->read(&regs->ctrl2);
>  		reg_ctrl2 |=3D FLEXCAN_CTRL2_ECRWRE;
> -		flexcan_write(reg_ctrl2, &regs->ctrl2);
> +		priv->write(reg_ctrl2, &regs->ctrl2);
> =20
> -		reg_mecr =3D flexcan_read(&regs->mecr);
> +		reg_mecr =3D priv->read(&regs->mecr);
>  		reg_mecr &=3D ~FLEXCAN_MECR_ECRWRDIS;
> -		flexcan_write(reg_mecr, &regs->mecr);
> +		priv->write(reg_mecr, &regs->mecr);
>  		reg_mecr &=3D ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
>  			      FLEXCAN_MECR_FANCEI_MSK);
> -		flexcan_write(reg_mecr, &regs->mecr);
> +		priv->write(reg_mecr, &regs->mecr);
>  	}
> =20
>  	err =3D flexcan_transceiver_enable(priv);
> @@ -1035,14 +1046,14 @@ static int flexcan_chip_start(struct net_device=
 *dev)
> =20
>  	/* enable interrupts atomically */
>  	disable_irq(dev->irq);
> -	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> -	flexcan_write(priv->reg_imask1_default, &regs->imask1);
> -	flexcan_write(priv->reg_imask2_default, &regs->imask2);
> +	priv->write(priv->reg_ctrl_default, &regs->ctrl);
> +	priv->write(priv->reg_imask1_default, &regs->imask1);
> +	priv->write(priv->reg_imask2_default, &regs->imask2);
>  	enable_irq(dev->irq);
> =20
>  	/* print chip status */
>  	netdev_dbg(dev, "%s: reading mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,=

> -		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> +		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
> =20
>  	return 0;
> =20
> @@ -1067,9 +1078,9 @@ static void flexcan_chip_stop(struct net_device *=
dev)
>  	flexcan_chip_disable(priv);
> =20
>  	/* Disable all interrupts */
> -	flexcan_write(0, &regs->imask2);
> -	flexcan_write(0, &regs->imask1);
> -	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> +	priv->write(0, &regs->imask2);
> +	priv->write(0, &regs->imask1);
> +	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
>  		      &regs->ctrl);
> =20
>  	flexcan_transceiver_disable(priv);
> @@ -1185,26 +1196,26 @@ static int register_flexcandev(struct net_devic=
e *dev)
>  	err =3D flexcan_chip_disable(priv);
>  	if (err)
>  		goto out_disable_per;
> -	reg =3D flexcan_read(&regs->ctrl);
> +	reg =3D priv->read(&regs->ctrl);
>  	reg |=3D FLEXCAN_CTRL_CLK_SRC;
> -	flexcan_write(reg, &regs->ctrl);
> +	priv->write(reg, &regs->ctrl);
> =20
>  	err =3D flexcan_chip_enable(priv);
>  	if (err)
>  		goto out_chip_disable;
> =20
>  	/* set freeze, halt and activate FIFO, restrict register access */
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	reg |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
>  		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
> -	flexcan_write(reg, &regs->mcr);
> +	priv->write(reg, &regs->mcr);
> =20
>  	/* Currently we only support newer versions of this core
>  	 * featuring a RX hardware FIFO (although this driver doesn't
>  	 * make use of it on some cores). Older cores, found on some
>  	 * Coldfire derivates are not tested.
>  	 */
> -	reg =3D flexcan_read(&regs->mcr);
> +	reg =3D priv->read(&regs->mcr);
>  	if (!(reg & FLEXCAN_MCR_FEN)) {
>  		netdev_err(dev, "Could not enable RX FIFO, unsupported core\n");
>  		err =3D -ENODEV;
> @@ -1313,6 +1324,15 @@ static int flexcan_probe(struct platform_device =
*pdev)
>  	dev->flags |=3D IFF_ECHO;
> =20
>  	priv =3D netdev_priv(dev);
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "big-endian")) {

Don't do this. This is not backwards compatible with the existing PPC
boards. Please add all needed information to the devtype_data.

> +		priv->read =3D flexcan_read_be;
> +		priv->write =3D flexcan_write_be;
> +	} else {
> +		priv->read =3D flexcan_read_le;
> +		priv->write =3D flexcan_write_le;
> +	}
> +
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GcSdDuiaAiDm4NLsPCQ3ULOq7qe1B8TQ3--

--Qj3tG7jDNnup5umVeDpprBWrj5hq0JfRi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloFejEACgkQHv7KIOw4
HPbrVAf/TyojaBq+1ebVB1rIEYq8UB95SJxEqN71zKooY6epIXQqhc7dZvT7hL4Y
0fWF7b+OEc6KjYbwVLV3nzNYitIILRIWD+cd3GhOS4M3UjxIlGlQp+lbfKjEyuaH
0n4pcLJaZtcrenquefZ6gTESlxc8QQdBpPWuEhH2YrPC3xdMUdz6QPh03Xujr5IS
/AgElfT8k8ULOMnDk1cfk7BOoCITWhgE6noaV5BqrmU9Gs2YbKUeWuZmqZt5DELh
39tWNQcUW2nJ6WJfZQ9kkmgJKd66uvzpDKQKQthNFOdpcEC2THisQniARva1KFn4
wetiMzQuzZnVgTOsVYivkmR7+nEUHA==
=eHtM
-----END PGP SIGNATURE-----

--Qj3tG7jDNnup5umVeDpprBWrj5hq0JfRi--
