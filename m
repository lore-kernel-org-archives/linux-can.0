From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Subject: Re: [PATCH v2 4/5] can: flexcan: Remodel FlexCAN register r/w APIs
 for BE instances
Date: Mon, 18 May 2015 18:17:11 +0200
Message-ID: <555A1087.1090600@melag.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com> <1431603215-25546-5-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:26442 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbbERQRW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 May 2015 12:17:22 -0400
In-Reply-To: <1431603215-25546-5-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh Sharma <bhupesh.sharma@freescale.com>, arnd@arndb.de, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org, Sakar.Arora@freescale.com

Am 14.05.2015 um 13:33 schrieb Bhupesh Sharma:

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index deaa24e..b0222ae 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -258,6 +258,10 @@ struct flexcan_priv {
>       struct flexcan_platform_data *pdata;
>       const struct flexcan_devtype_data *devtype_data;
>       struct regulator *reg_xceiver;
> +
> +     /* Read and Write APIs */
> +     u32 (*read)(void __iomem *addr);
> +     void (*write)(u32 val, void __iomem *addr);

Does it *really* need to be a far call ?
Why not just give the existing flexcan_read()/flexcan_write() inline's
an additional bit to decide whether to swab or not ?

> -#if defined(CONFIG_PPC)
> -static inline u32 flexcan_read(void __iomem *addr)
> +static inline u32 flexcan_read_le(void __iomem *addr)

_static inline_ as a callback ? seriously ?

>   static inline int flexcan_transceiver_enable(const struct flexcan_p=
riv *priv)
>   {
> @@ -356,14 +366,14 @@ static int flexcan_chip_enable(struct flexcan_p=
riv *priv)
>       unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>       u32 reg;
>
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       reg &=3D ~FLEXCAN_MCR_MDIS;
> -     flexcan_write(reg, &regs->mcr);
> +     priv->write(reg, &regs->mcr);
>
> -     while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM=
_ACK))
> +     while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_A=
CK))
>               udelay(10);
>
> -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
>               return -ETIMEDOUT;
>
>       return 0;
> @@ -375,14 +385,14 @@ static int flexcan_chip_disable(struct flexcan_=
priv *priv)
>       unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>       u32 reg;
>
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       reg |=3D FLEXCAN_MCR_MDIS;
> -     flexcan_write(reg, &regs->mcr);
> +     priv->write(reg, &regs->mcr);
>
> -     while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LP=
M_ACK))
> +     while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_=
ACK))
>               udelay(10);
>
> -     if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +     if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
>               return -ETIMEDOUT;
>
>       return 0;
> @@ -394,14 +404,14 @@ static int flexcan_chip_freeze(struct flexcan_p=
riv *priv)
>       unsigned int timeout =3D 1000 * 1000 * 10 / priv->can.bittiming=
=2Ebitrate;
>       u32 reg;
>
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       reg |=3D FLEXCAN_MCR_HALT;
> -     flexcan_write(reg, &regs->mcr);
> +     priv->write(reg, &regs->mcr);
>
> -     while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FR=
Z_ACK))
> +     while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_=
ACK))
>               udelay(100);
>
> -     if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +     if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
>               return -ETIMEDOUT;
>
>       return 0;
> @@ -413,14 +423,14 @@ static int flexcan_chip_unfreeze(struct flexcan=
_priv *priv)
>       unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>       u32 reg;
>
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       reg &=3D ~FLEXCAN_MCR_HALT;
> -     flexcan_write(reg, &regs->mcr);
> +     priv->write(reg, &regs->mcr);
>
> -     while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ=
_ACK))
> +     while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_A=
CK))
>               udelay(10);
>
> -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
>               return -ETIMEDOUT;
>
>       return 0;
> @@ -431,23 +441,22 @@ static int flexcan_chip_softreset(struct flexca=
n_priv *priv)
>       struct flexcan_regs __iomem *regs =3D priv->base;
>       unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>
> -     flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> -     while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOF=
TRST))
> +     priv->write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> +     while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTR=
ST))
>               udelay(10);
>
> -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
> +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
>               return -ETIMEDOUT;
>
>       return 0;
>   }
>
> -
>   static int __flexcan_get_berr_counter(const struct net_device *dev,
>                                     struct can_berr_counter *bec)
>   {
>       const struct flexcan_priv *priv =3D netdev_priv(dev);
>       struct flexcan_regs __iomem *regs =3D priv->base;
> -     u32 reg =3D flexcan_read(&regs->ecr);
> +     u32 reg =3D priv->read(&regs->ecr);
>
>       bec->txerr =3D (reg >> 0) & 0xff;
>       bec->rxerr =3D (reg >> 8) & 0xff;
> @@ -503,24 +512,24 @@ static int flexcan_start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>
>       if (cf->can_dlc > 0) {
>               u32 data =3D be32_to_cpup((__be32 *)&cf->data[0]);
> -             flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].d=
ata[0]);
> +             priv->write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].dat=
a[0]);
>       }
>       if (cf->can_dlc > 3) {
>               u32 data =3D be32_to_cpup((__be32 *)&cf->data[4]);
> -             flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].d=
ata[1]);
> +             priv->write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].dat=
a[1]);
>       }
>
>       can_put_echo_skb(skb, dev, 0);
>
> -     flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id)=
;
> -     flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl)=
;
> +     priv->write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
> +     priv->write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
>
>       /* Errata ERR005829 step8:
>        * Write twice INACTIVE(0x8) code to first MB.
>        */
> -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl)=
;
> -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl)=
;
>
>       return NETDEV_TX_OK;
> @@ -645,8 +654,8 @@ static void flexcan_read_fifo(const struct net_de=
vice *dev,
>       struct flexcan_mb __iomem *mb =3D &regs->cantxfg[0];
>       u32 reg_ctrl, reg_id;
>
> -     reg_ctrl =3D flexcan_read(&mb->can_ctrl);
> -     reg_id =3D flexcan_read(&mb->can_id);
> +     reg_ctrl =3D priv->read(&mb->can_ctrl);
> +     reg_id =3D priv->read(&mb->can_id);
>       if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
>               cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF=
_FLAG;
>       else
> @@ -656,12 +665,12 @@ static void flexcan_read_fifo(const struct net_=
device *dev,
>               cf->can_id |=3D CAN_RTR_FLAG;
>       cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
>
> -     *(__be32 *)(cf->data + 0) =3D cpu_to_be32(flexcan_read(&mb->dat=
a[0]));
> -     *(__be32 *)(cf->data + 4) =3D cpu_to_be32(flexcan_read(&mb->dat=
a[1]));
> +     *(__be32 *)(cf->data + 0) =3D cpu_to_be32(priv->read(&mb->data[=
0]));
> +     *(__be32 *)(cf->data + 4) =3D cpu_to_be32(priv->read(&mb->data[=
1]));
>
>       /* mark as read */
> -     flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> -     flexcan_read(&regs->timer);
> +     priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> +     priv->read(&regs->timer);
>   }
>
>   static int flexcan_read_frame(struct net_device *dev)
> @@ -699,17 +708,17 @@ static int flexcan_poll(struct napi_struct *nap=
i, int quota)
>        * The error bits are cleared on read,
>        * use saved value from irq handler.
>        */
> -     reg_esr =3D flexcan_read(&regs->esr) | priv->reg_esr;
> +     reg_esr =3D priv->read(&regs->esr) | priv->reg_esr;
>
>       /* handle state changes */
>       work_done +=3D flexcan_poll_state(dev, reg_esr);
>
>       /* handle RX-FIFO */
> -     reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +     reg_iflag1 =3D priv->read(&regs->iflag1);
>       while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
>              work_done < quota) {
>               work_done +=3D flexcan_read_frame(dev);
> -             reg_iflag1 =3D flexcan_read(&regs->iflag1);
> +             reg_iflag1 =3D priv->read(&regs->iflag1);
>       }
>
>       /* report bus errors */
> @@ -719,8 +728,8 @@ static int flexcan_poll(struct napi_struct *napi,=
 int quota)
>       if (work_done < quota) {
>               napi_complete(napi);
>               /* enable IRQs */
> -             flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> -             flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> +             priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> +             priv->write(priv->reg_ctrl_default, &regs->ctrl);
>       }
>
>       return work_done;
> @@ -734,11 +743,11 @@ static irqreturn_t flexcan_irq(int irq, void *d=
ev_id)
>       struct flexcan_regs __iomem *regs =3D priv->base;
>       u32 reg_iflag1, reg_esr;
>
> -     reg_iflag1 =3D flexcan_read(&regs->iflag1);
> -     reg_esr =3D flexcan_read(&regs->esr);
> +     reg_iflag1 =3D priv->read(&regs->iflag1);
> +     reg_esr =3D priv->read(&regs->esr);
>       /* ACK all bus error and state change IRQ sources */
>       if (reg_esr & FLEXCAN_ESR_ALL_INT)
> -             flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr=
);
> +             priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>
>       /*
>        * schedule NAPI in case of:
> @@ -754,16 +763,16 @@ static irqreturn_t flexcan_irq(int irq, void *d=
ev_id)
>                * save them for later use.
>                */
>               priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
> -             flexcan_write(FLEXCAN_IFLAG_DEFAULT &
> +             priv->write(FLEXCAN_IFLAG_DEFAULT &
>                       ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1=
);
> -             flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ER=
R_ALL,
> +             priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_=
ALL,
>                      &regs->ctrl);
>               napi_schedule(&priv->napi);
>       }
>
>       /* FIFO overflow */
>       if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
> -             flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->if=
lag1);
> +             priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->ifla=
g1);
>               dev->stats.rx_over_errors++;
>               dev->stats.rx_errors++;
>       }
> @@ -774,9 +783,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>               stats->tx_packets++;
>               can_led_event(dev, CAN_LED_EVENT_TX);
>               /* after sending a RTR frame mailbox is in RX mode */
> -             flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +             priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>                             &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctr=
l);
> -             flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
> +             priv->write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
>               netif_wake_queue(dev);
>       }
>
> @@ -790,7 +799,7 @@ static void flexcan_set_bittiming(struct net_devi=
ce *dev)
>       struct flexcan_regs __iomem *regs =3D priv->base;
>       u32 reg;
>
> -     reg =3D flexcan_read(&regs->ctrl);
> +     reg =3D priv->read(&regs->ctrl);
>       reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
>                FLEXCAN_CTRL_RJW(0x3) |
>                FLEXCAN_CTRL_PSEG1(0x7) |
> @@ -814,11 +823,11 @@ static void flexcan_set_bittiming(struct net_de=
vice *dev)
>               reg |=3D FLEXCAN_CTRL_SMP;
>
>       netdev_info(dev, "writing ctrl=3D0x%08x\n", reg);
> -     flexcan_write(reg, &regs->ctrl);
> +     priv->write(reg, &regs->ctrl);
>
>       /* print chip status */
>       netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
> -                flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl))=
;
> +                priv->read(&regs->mcr), priv->read(&regs->ctrl));
>   }
>
>   /*
> @@ -858,14 +867,14 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>        * disable local echo
>        *
>        */
> -     reg_mcr =3D flexcan_read(&regs->mcr);
> +     reg_mcr =3D priv->read(&regs->mcr);
>       reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
>       reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HA=
LT |
>               FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
>               FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
>               FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
>       netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
> -     flexcan_write(reg_mcr, &regs->mcr);
> +     priv->write(reg_mcr, &regs->mcr);
>
>       /*
>        * CTRL
> @@ -879,7 +888,7 @@ static int flexcan_chip_start(struct net_device *=
dev)
>        * enable bus off interrupt
>        * (=3D=3D FLEXCAN_CTRL_ERR_STATE)
>        */
> -     reg_ctrl =3D flexcan_read(&regs->ctrl);
> +     reg_ctrl =3D priv->read(&regs->ctrl);
>       reg_ctrl &=3D ~FLEXCAN_CTRL_TSYN;
>       reg_ctrl |=3D FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
>               FLEXCAN_CTRL_ERR_STATE;
> @@ -897,29 +906,29 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>       /* save for later use */
>       priv->reg_ctrl_default =3D reg_ctrl;
>       netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl=
);
> -     flexcan_write(reg_ctrl, &regs->ctrl);
> +     priv->write(reg_ctrl, &regs->ctrl);
>
>       /* clear and invalidate all mailboxes first */
>       for (i =3D FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i+=
+) {
> -             flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
> +             priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
>                             &regs->cantxfg[i].can_ctrl);
>       }
>
>       /* Errata ERR005829: mark first TX mailbox as INACTIVE */
> -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl)=
;
>
>       /* mark TX mailbox as INACTIVE */
> -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
>                     &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
>
>       /* acceptance mask/acceptance code (accept everything) */
> -     flexcan_write(0x0, &regs->rxgmask);
> -     flexcan_write(0x0, &regs->rx14mask);
> -     flexcan_write(0x0, &regs->rx15mask);
> +     priv->write(0x0, &regs->rxgmask);
> +     priv->write(0x0, &regs->rx14mask);
> +     priv->write(0x0, &regs->rx15mask);
>
>       if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
> -             flexcan_write(0x0, &regs->rxfgmask);
> +             priv->write(0x0, &regs->rxfgmask);
>
>       /*
>        * On Vybrid, disable memory error detection interrupts
> @@ -934,16 +943,16 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>                * and Correction of Memory Errors" to write to
>                * MECR register
>                */
> -             reg_crl2 =3D flexcan_read(&regs->crl2);
> +             reg_crl2 =3D priv->read(&regs->crl2);
>               reg_crl2 |=3D FLEXCAN_CRL2_ECRWRE;
> -             flexcan_write(reg_crl2, &regs->crl2);
> +             priv->write(reg_crl2, &regs->crl2);
>
> -             reg_mecr =3D flexcan_read(&regs->mecr);
> +             reg_mecr =3D priv->read(&regs->mecr);
>               reg_mecr &=3D ~FLEXCAN_MECR_ECRWRDIS;
> -             flexcan_write(reg_mecr, &regs->mecr);
> +             priv->write(reg_mecr, &regs->mecr);
>               reg_mecr &=3D ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HA=
NCEI_MSK |
>                               FLEXCAN_MECR_FANCEI_MSK);
> -             flexcan_write(reg_mecr, &regs->mecr);
> +             priv->write(reg_mecr, &regs->mecr);
>       }
>
>       err =3D flexcan_transceiver_enable(priv);
> @@ -958,11 +967,11 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>       priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>
>       /* enable FIFO interrupts */
> -     flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> +     priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
>
>       /* print chip status */
>       netdev_dbg(dev, "%s: reading mcr=3D0x%08x ctrl=3D0x%08x\n", __f=
unc__,
> -                flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl))=
;
> +                priv->read(&regs->mcr), priv->read(&regs->ctrl));
>
>       return 0;
>
> @@ -989,8 +998,8 @@ static void flexcan_chip_stop(struct net_device *=
dev)
>       flexcan_chip_disable(priv);
>
>       /* Disable all interrupts */
> -     flexcan_write(0, &regs->imask1);
> -     flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> +     priv->write(0, &regs->imask1);
> +     priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
>                     &regs->ctrl);
>
>       flexcan_transceiver_disable(priv);
> @@ -1108,26 +1117,26 @@ static int register_flexcandev(struct net_dev=
ice *dev)
>       err =3D flexcan_chip_disable(priv);
>       if (err)
>               goto out_disable_per;
> -     reg =3D flexcan_read(&regs->ctrl);
> +     reg =3D priv->read(&regs->ctrl);
>       reg |=3D FLEXCAN_CTRL_CLK_SRC;
> -     flexcan_write(reg, &regs->ctrl);
> +     priv->write(reg, &regs->ctrl);
>
>       err =3D flexcan_chip_enable(priv);
>       if (err)
>               goto out_chip_disable;
>
>       /* set freeze, halt and activate FIFO, restrict register access=
 */
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       reg |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
>               FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
> -     flexcan_write(reg, &regs->mcr);
> +     priv->write(reg, &regs->mcr);
>
>       /*
>        * Currently we only support newer versions of this core
>        * featuring a RX FIFO. Older cores found on some Coldfire
>        * derivates are not yet supported.
>        */
> -     reg =3D flexcan_read(&regs->mcr);
> +     reg =3D priv->read(&regs->mcr);
>       if (!(reg & FLEXCAN_MCR_FEN)) {
>               netdev_err(dev, "Could not enable RX FIFO, unsupported =
core\n");
>               err =3D -ENODEV;
> @@ -1183,6 +1192,8 @@ static int flexcan_probe(struct platform_device=
 *pdev)
>       void __iomem *base;
>       int err, irq;
>       u32 clock_freq =3D 0;
> +     /* Default case for most ARM based FSL SoC having BE FlexCAN IP=
 */
> +     bool core_is_little =3D true, module_is_little =3D false;
>
>       reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
>       if (PTR_ERR(reg_xceiver) =3D=3D -EPROBE_DEFER)
> @@ -1237,6 +1248,25 @@ static int flexcan_probe(struct platform_devic=
e *pdev)
>       dev->flags |=3D IFF_ECHO;
>
>       priv =3D netdev_priv(dev);
> +
> +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +             core_is_little =3D false;

Why not just using IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) directly ?
(anyways, cpu_is_le seems a more appropriate name)

> +     if (of_property_read_bool(dev->dev.of_node, "little-endian"))
> +             module_is_little =3D true;

Why that misleading name, instead of, eg. "chip_is_le" ?

Oh, and you'll expect explicitly set a new DTB attribute, if the chip
is in LE - the default case.

Didn't you just say, you dont wanna break anything ?

Can you imagine that some people use DTB as a _board_ config
(eg. in bootloader) instead of externalized kernel config ? ;-o

> +     if ((core_is_little && module_is_little) ||
> +         (!core_is_little && !module_is_little)) {
> +             priv->read =3D flexcan_read_le;
> +             priv->write =3D flexcan_write_le;
> +     }
> +
> +     if ((!core_is_little && module_is_little) ||
> +         (core_is_little && !module_is_little)) {
> +             priv->read =3D flexcan_read_be;
> +             priv->write =3D flexcan_write_be;
> +     }

At that point, the naming gets completely wrong - instead should
be something like flexcan_read_swab / flexcan_write_swab.
And the decision can easily be made on:

    IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) !=3D module_is_little


Putting these together, I'd rather:

#1: add a new feature flag:
     #define FLEXCAN_HAS_BIG_ENDIAN BIT(4)

#2: add a new dts device type for the new chip variant
     (eg. fsl,flexcan-qorliq)

#2: pass the priv pointer to the *_read()/*_write() functions,
     so they can pick up the BE flag and decide whether to
     swab or not (based on cpu endianess)

At that point, maybe we could even replace the struct flexcan_regs
by a list of #define's.



cu

By the way: who had the genious idea of adding _hardware specific_
hacks into a widget library (qt) ? Perhaps the same guy, who decided
that _unprivileged userland_ should tell ipu/vpu/gpu which _hardware_
addresses to use ? ;-o

--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg =
HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=C3=BCr =
einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie i=
st ausschlie=C3=9Flich f=C3=BCr denjenigen bestimmt, an den sie gericht=
et worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d=C3=BCr=
fen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz o=
der teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irr=
t=C3=BCmlich erhalten haben, so benachrichtigen Sie bitte den Absender,=
 indem Sie auf diese Nachricht antworten. Bitte l=C3=B6schen Sie in die=
sem Fall diese Nachricht und alle Anh=C3=A4nge, ohne eine Kopie zu beha=
lten.
Important Notice: This message may contain confidential or privileged i=
nformation. It is intended only for the person it was addressed to. If =
you are not the intended recipient of this email you may not copy, forw=
ard, disclose or otherwise use it or any part of it in any form whatsoe=
ver. If you received this email in error please notify the sender by re=
plying and delete this message and any attachments without retaining a =
copy.
