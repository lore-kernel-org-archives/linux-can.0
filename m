From: Sharma Bhupesh <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH v2 4/5] can: flexcan: Remodel FlexCAN register r/w APIs
 for BE instances
Date: Mon, 18 May 2015 16:37:32 +0000
Message-ID: <BY1PR0301MB1303C428D95631C9A040F2FA82C40@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-5-git-send-email-bhupesh.sharma@freescale.com>
 <555A1087.1090600@melag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <555A1087.1090600@melag.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>
List-Id: linux-can.vger.kernel.org

> -----Original Message-----
> From: Enrico Weigelt, metux IT consult [mailto:weigelt@melag.de]
> Am 14.05.2015 um 13:33 schrieb Bhupesh Sharma:
> 
> > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > index deaa24e..b0222ae 100644
> > --- a/drivers/net/can/flexcan.c
> > +++ b/drivers/net/can/flexcan.c
> > @@ -258,6 +258,10 @@ struct flexcan_priv {
> >       struct flexcan_platform_data *pdata;
> >       const struct flexcan_devtype_data *devtype_data;
> >       struct regulator *reg_xceiver;
> > +
> > +     /* Read and Write APIs */
> > +     u32 (*read)(void __iomem *addr);
> > +     void (*write)(u32 val, void __iomem *addr);
> 
> Does it *really* need to be a far call ?
> Why not just give the existing flexcan_read()/flexcan_write() inline's an
> additional bit to decide whether to swab or not ?
> 
> > -#if defined(CONFIG_PPC)
> > -static inline u32 flexcan_read(void __iomem *addr)
> > +static inline u32 flexcan_read_le(void __iomem *addr)
> 
> _static inline_ as a callback ? seriously ?
> 
> >   static inline int flexcan_transceiver_enable(const struct
> flexcan_priv *priv)
> >   {
> > @@ -356,14 +366,14 @@ static int flexcan_chip_enable(struct
> flexcan_priv *priv)
> >       unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> >       u32 reg;
> >
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       reg &= ~FLEXCAN_MCR_MDIS;
> > -     flexcan_write(reg, &regs->mcr);
> > +     priv->write(reg, &regs->mcr);
> >
> > -     while (timeout-- && (flexcan_read(&regs->mcr) &
> FLEXCAN_MCR_LPM_ACK))
> > +     while (timeout-- && (priv->read(&regs->mcr) &
> > + FLEXCAN_MCR_LPM_ACK))
> >               udelay(10);
> >
> > -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> > +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> >               return -ETIMEDOUT;
> >
> >       return 0;
> > @@ -375,14 +385,14 @@ static int flexcan_chip_disable(struct
> flexcan_priv *priv)
> >       unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> >       u32 reg;
> >
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       reg |= FLEXCAN_MCR_MDIS;
> > -     flexcan_write(reg, &regs->mcr);
> > +     priv->write(reg, &regs->mcr);
> >
> > -     while (timeout-- && !(flexcan_read(&regs->mcr) &
> FLEXCAN_MCR_LPM_ACK))
> > +     while (timeout-- && !(priv->read(&regs->mcr) &
> > + FLEXCAN_MCR_LPM_ACK))
> >               udelay(10);
> >
> > -     if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> > +     if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> >               return -ETIMEDOUT;
> >
> >       return 0;
> > @@ -394,14 +404,14 @@ static int flexcan_chip_freeze(struct
> flexcan_priv *priv)
> >       unsigned int timeout = 1000 * 1000 * 10 / priv-
> >can.bittiming.bitrate;
> >       u32 reg;
> >
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       reg |= FLEXCAN_MCR_HALT;
> > -     flexcan_write(reg, &regs->mcr);
> > +     priv->write(reg, &regs->mcr);
> >
> > -     while (timeout-- && !(flexcan_read(&regs->mcr) &
> FLEXCAN_MCR_FRZ_ACK))
> > +     while (timeout-- && !(priv->read(&regs->mcr) &
> > + FLEXCAN_MCR_FRZ_ACK))
> >               udelay(100);
> >
> > -     if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> > +     if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> >               return -ETIMEDOUT;
> >
> >       return 0;
> > @@ -413,14 +423,14 @@ static int flexcan_chip_unfreeze(struct
> flexcan_priv *priv)
> >       unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> >       u32 reg;
> >
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       reg &= ~FLEXCAN_MCR_HALT;
> > -     flexcan_write(reg, &regs->mcr);
> > +     priv->write(reg, &regs->mcr);
> >
> > -     while (timeout-- && (flexcan_read(&regs->mcr) &
> FLEXCAN_MCR_FRZ_ACK))
> > +     while (timeout-- && (priv->read(&regs->mcr) &
> > + FLEXCAN_MCR_FRZ_ACK))
> >               udelay(10);
> >
> > -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> > +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> >               return -ETIMEDOUT;
> >
> >       return 0;
> > @@ -431,23 +441,22 @@ static int flexcan_chip_softreset(struct
> flexcan_priv *priv)
> >       struct flexcan_regs __iomem *regs = priv->base;
> >       unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> >
> > -     flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> > -     while (timeout-- && (flexcan_read(&regs->mcr) &
> FLEXCAN_MCR_SOFTRST))
> > +     priv->write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> > +     while (timeout-- && (priv->read(&regs->mcr) &
> > + FLEXCAN_MCR_SOFTRST))
> >               udelay(10);
> >
> > -     if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
> > +     if (priv->read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
> >               return -ETIMEDOUT;
> >
> >       return 0;
> >   }
> >
> > -
> >   static int __flexcan_get_berr_counter(const struct net_device *dev,
> >                                     struct can_berr_counter *bec)
> >   {
> >       const struct flexcan_priv *priv = netdev_priv(dev);
> >       struct flexcan_regs __iomem *regs = priv->base;
> > -     u32 reg = flexcan_read(&regs->ecr);
> > +     u32 reg = priv->read(&regs->ecr);
> >
> >       bec->txerr = (reg >> 0) & 0xff;
> >       bec->rxerr = (reg >> 8) & 0xff;
> > @@ -503,24 +512,24 @@ static int flexcan_start_xmit(struct sk_buff
> > *skb, struct net_device *dev)
> >
> >       if (cf->can_dlc > 0) {
> >               u32 data = be32_to_cpup((__be32 *)&cf->data[0]);
> > -             flexcan_write(data, &regs-
> >cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
> > +             priv->write(data,
> > + &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
> >       }
> >       if (cf->can_dlc > 3) {
> >               u32 data = be32_to_cpup((__be32 *)&cf->data[4]);
> > -             flexcan_write(data, &regs-
> >cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
> > +             priv->write(data,
> > + &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
> >       }
> >
> >       can_put_echo_skb(skb, dev, 0);
> >
> > -     flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
> > -     flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> > +     priv->write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
> > +     priv->write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> >
> >       /* Errata ERR005829 step8:
> >        * Write twice INACTIVE(0x8) code to first MB.
> >        */
> > -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> > +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
> >                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
> > -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> > +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
> >                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
> >
> >       return NETDEV_TX_OK;
> > @@ -645,8 +654,8 @@ static void flexcan_read_fifo(const struct
> net_device *dev,
> >       struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
> >       u32 reg_ctrl, reg_id;
> >
> > -     reg_ctrl = flexcan_read(&mb->can_ctrl);
> > -     reg_id = flexcan_read(&mb->can_id);
> > +     reg_ctrl = priv->read(&mb->can_ctrl);
> > +     reg_id = priv->read(&mb->can_id);
> >       if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
> >               cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) |
> CAN_EFF_FLAG;
> >       else
> > @@ -656,12 +665,12 @@ static void flexcan_read_fifo(const struct
> net_device *dev,
> >               cf->can_id |= CAN_RTR_FLAG;
> >       cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
> >
> > -     *(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb-
> >data[0]));
> > -     *(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb-
> >data[1]));
> > +     *(__be32 *)(cf->data + 0) = cpu_to_be32(priv->read(&mb-
> >data[0]));
> > +     *(__be32 *)(cf->data + 4) =
> > + cpu_to_be32(priv->read(&mb->data[1]));
> >
> >       /* mark as read */
> > -     flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> > -     flexcan_read(&regs->timer);
> > +     priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> > +     priv->read(&regs->timer);
> >   }
> >
> >   static int flexcan_read_frame(struct net_device *dev) @@ -699,17
> > +708,17 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
> >        * The error bits are cleared on read,
> >        * use saved value from irq handler.
> >        */
> > -     reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
> > +     reg_esr = priv->read(&regs->esr) | priv->reg_esr;
> >
> >       /* handle state changes */
> >       work_done += flexcan_poll_state(dev, reg_esr);
> >
> >       /* handle RX-FIFO */
> > -     reg_iflag1 = flexcan_read(&regs->iflag1);
> > +     reg_iflag1 = priv->read(&regs->iflag1);
> >       while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
> >              work_done < quota) {
> >               work_done += flexcan_read_frame(dev);
> > -             reg_iflag1 = flexcan_read(&regs->iflag1);
> > +             reg_iflag1 = priv->read(&regs->iflag1);
> >       }
> >
> >       /* report bus errors */
> > @@ -719,8 +728,8 @@ static int flexcan_poll(struct napi_struct *napi,
> int quota)
> >       if (work_done < quota) {
> >               napi_complete(napi);
> >               /* enable IRQs */
> > -             flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> > -             flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> > +             priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> > +             priv->write(priv->reg_ctrl_default, &regs->ctrl);
> >       }
> >
> >       return work_done;
> > @@ -734,11 +743,11 @@ static irqreturn_t flexcan_irq(int irq, void
> *dev_id)
> >       struct flexcan_regs __iomem *regs = priv->base;
> >       u32 reg_iflag1, reg_esr;
> >
> > -     reg_iflag1 = flexcan_read(&regs->iflag1);
> > -     reg_esr = flexcan_read(&regs->esr);
> > +     reg_iflag1 = priv->read(&regs->iflag1);
> > +     reg_esr = priv->read(&regs->esr);
> >       /* ACK all bus error and state change IRQ sources */
> >       if (reg_esr & FLEXCAN_ESR_ALL_INT)
> > -             flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> > +             priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> >
> >       /*
> >        * schedule NAPI in case of:
> > @@ -754,16 +763,16 @@ static irqreturn_t flexcan_irq(int irq, void
> *dev_id)
> >                * save them for later use.
> >                */
> >               priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
> > -             flexcan_write(FLEXCAN_IFLAG_DEFAULT &
> > +             priv->write(FLEXCAN_IFLAG_DEFAULT &
> >                       ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
> > -             flexcan_write(priv->reg_ctrl_default &
> ~FLEXCAN_CTRL_ERR_ALL,
> > +             priv->write(priv->reg_ctrl_default &
> > + ~FLEXCAN_CTRL_ERR_ALL,
> >                      &regs->ctrl);
> >               napi_schedule(&priv->napi);
> >       }
> >
> >       /* FIFO overflow */
> >       if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
> > -             flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs-
> >iflag1);
> > +             priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW,
> > + &regs->iflag1);
> >               dev->stats.rx_over_errors++;
> >               dev->stats.rx_errors++;
> >       }
> > @@ -774,9 +783,9 @@ static irqreturn_t flexcan_irq(int irq, void
> *dev_id)
> >               stats->tx_packets++;
> >               can_led_event(dev, CAN_LED_EVENT_TX);
> >               /* after sending a RTR frame mailbox is in RX mode */
> > -             flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> > +             priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
> >                             &regs-
> >cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> > -             flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
> > +             priv->write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
> >               netif_wake_queue(dev);
> >       }
> >
> > @@ -790,7 +799,7 @@ static void flexcan_set_bittiming(struct net_device
> *dev)
> >       struct flexcan_regs __iomem *regs = priv->base;
> >       u32 reg;
> >
> > -     reg = flexcan_read(&regs->ctrl);
> > +     reg = priv->read(&regs->ctrl);
> >       reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
> >                FLEXCAN_CTRL_RJW(0x3) |
> >                FLEXCAN_CTRL_PSEG1(0x7) | @@ -814,11 +823,11 @@ static
> > void flexcan_set_bittiming(struct net_device *dev)
> >               reg |= FLEXCAN_CTRL_SMP;
> >
> >       netdev_info(dev, "writing ctrl=0x%08x\n", reg);
> > -     flexcan_write(reg, &regs->ctrl);
> > +     priv->write(reg, &regs->ctrl);
> >
> >       /* print chip status */
> >       netdev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
> > -                flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> > +                priv->read(&regs->mcr), priv->read(&regs->ctrl));
> >   }
> >
> >   /*
> > @@ -858,14 +867,14 @@ static int flexcan_chip_start(struct net_device
> *dev)
> >        * disable local echo
> >        *
> >        */
> > -     reg_mcr = flexcan_read(&regs->mcr);
> > +     reg_mcr = priv->read(&regs->mcr);
> >       reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
> >       reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
> >               FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
> >               FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
> >               FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
> >       netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
> > -     flexcan_write(reg_mcr, &regs->mcr);
> > +     priv->write(reg_mcr, &regs->mcr);
> >
> >       /*
> >        * CTRL
> > @@ -879,7 +888,7 @@ static int flexcan_chip_start(struct net_device
> *dev)
> >        * enable bus off interrupt
> >        * (== FLEXCAN_CTRL_ERR_STATE)
> >        */
> > -     reg_ctrl = flexcan_read(&regs->ctrl);
> > +     reg_ctrl = priv->read(&regs->ctrl);
> >       reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
> >       reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
> >               FLEXCAN_CTRL_ERR_STATE;
> > @@ -897,29 +906,29 @@ static int flexcan_chip_start(struct net_device
> *dev)
> >       /* save for later use */
> >       priv->reg_ctrl_default = reg_ctrl;
> >       netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
> > -     flexcan_write(reg_ctrl, &regs->ctrl);
> > +     priv->write(reg_ctrl, &regs->ctrl);
> >
> >       /* clear and invalidate all mailboxes first */
> >       for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
> > -             flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
> > +             priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
> >                             &regs->cantxfg[i].can_ctrl);
> >       }
> >
> >       /* Errata ERR005829: mark first TX mailbox as INACTIVE */
> > -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> > +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
> >                     &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
> >
> >       /* mark TX mailbox as INACTIVE */
> > -     flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> > +     priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
> >                     &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> >
> >       /* acceptance mask/acceptance code (accept everything) */
> > -     flexcan_write(0x0, &regs->rxgmask);
> > -     flexcan_write(0x0, &regs->rx14mask);
> > -     flexcan_write(0x0, &regs->rx15mask);
> > +     priv->write(0x0, &regs->rxgmask);
> > +     priv->write(0x0, &regs->rx14mask);
> > +     priv->write(0x0, &regs->rx15mask);
> >
> >       if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
> > -             flexcan_write(0x0, &regs->rxfgmask);
> > +             priv->write(0x0, &regs->rxfgmask);
> >
> >       /*
> >        * On Vybrid, disable memory error detection interrupts @@
> > -934,16 +943,16 @@ static int flexcan_chip_start(struct net_device
> *dev)
> >                * and Correction of Memory Errors" to write to
> >                * MECR register
> >                */
> > -             reg_crl2 = flexcan_read(&regs->crl2);
> > +             reg_crl2 = priv->read(&regs->crl2);
> >               reg_crl2 |= FLEXCAN_CRL2_ECRWRE;
> > -             flexcan_write(reg_crl2, &regs->crl2);
> > +             priv->write(reg_crl2, &regs->crl2);
> >
> > -             reg_mecr = flexcan_read(&regs->mecr);
> > +             reg_mecr = priv->read(&regs->mecr);
> >               reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
> > -             flexcan_write(reg_mecr, &regs->mecr);
> > +             priv->write(reg_mecr, &regs->mecr);
> >               reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ |
> FLEXCAN_MECR_HANCEI_MSK |
> >                               FLEXCAN_MECR_FANCEI_MSK);
> > -             flexcan_write(reg_mecr, &regs->mecr);
> > +             priv->write(reg_mecr, &regs->mecr);
> >       }
> >
> >       err = flexcan_transceiver_enable(priv); @@ -958,11 +967,11 @@
> > static int flexcan_chip_start(struct net_device *dev)
> >       priv->can.state = CAN_STATE_ERROR_ACTIVE;
> >
> >       /* enable FIFO interrupts */
> > -     flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> > +     priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> >
> >       /* print chip status */
> >       netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
> > -                flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> > +                priv->read(&regs->mcr), priv->read(&regs->ctrl));
> >
> >       return 0;
> >
> > @@ -989,8 +998,8 @@ static void flexcan_chip_stop(struct net_device
> *dev)
> >       flexcan_chip_disable(priv);
> >
> >       /* Disable all interrupts */
> > -     flexcan_write(0, &regs->imask1);
> > -     flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> > +     priv->write(0, &regs->imask1);
> > +     priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> >                     &regs->ctrl);
> >
> >       flexcan_transceiver_disable(priv);
> > @@ -1108,26 +1117,26 @@ static int register_flexcandev(struct
> net_device *dev)
> >       err = flexcan_chip_disable(priv);
> >       if (err)
> >               goto out_disable_per;
> > -     reg = flexcan_read(&regs->ctrl);
> > +     reg = priv->read(&regs->ctrl);
> >       reg |= FLEXCAN_CTRL_CLK_SRC;
> > -     flexcan_write(reg, &regs->ctrl);
> > +     priv->write(reg, &regs->ctrl);
> >
> >       err = flexcan_chip_enable(priv);
> >       if (err)
> >               goto out_chip_disable;
> >
> >       /* set freeze, halt and activate FIFO, restrict register access
> */
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
> >               FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
> > -     flexcan_write(reg, &regs->mcr);
> > +     priv->write(reg, &regs->mcr);
> >
> >       /*
> >        * Currently we only support newer versions of this core
> >        * featuring a RX FIFO. Older cores found on some Coldfire
> >        * derivates are not yet supported.
> >        */
> > -     reg = flexcan_read(&regs->mcr);
> > +     reg = priv->read(&regs->mcr);
> >       if (!(reg & FLEXCAN_MCR_FEN)) {
> >               netdev_err(dev, "Could not enable RX FIFO, unsupported
> core\n");
> >               err = -ENODEV;
> > @@ -1183,6 +1192,8 @@ static int flexcan_probe(struct platform_device
> *pdev)
> >       void __iomem *base;
> >       int err, irq;
> >       u32 clock_freq = 0;
> > +     /* Default case for most ARM based FSL SoC having BE FlexCAN IP
> */
> > +     bool core_is_little = true, module_is_little = false;
> >
> >       reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
> >       if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER) @@ -1237,6 +1248,25
> > @@ static int flexcan_probe(struct platform_device *pdev)
> >       dev->flags |= IFF_ECHO;
> >
> >       priv = netdev_priv(dev);
> > +
> > +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > +             core_is_little = false;
> 
> Why not just using IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) directly ?
> (anyways, cpu_is_le seems a more appropriate name)
> 
> > +     if (of_property_read_bool(dev->dev.of_node, "little-endian"))
> > +             module_is_little = true;
> 
> Why that misleading name, instead of, eg. "chip_is_le" ?
> 
> Oh, and you'll expect explicitly set a new DTB attribute, if the chip is
> in LE - the default case.
> 
> Didn't you just say, you dont wanna break anything ?
> 
> Can you imagine that some people use DTB as a _board_ config (eg. in
> bootloader) instead of externalized kernel config ? ;-o
> 
> > +     if ((core_is_little && module_is_little) ||
> > +         (!core_is_little && !module_is_little)) {
> > +             priv->read = flexcan_read_le;
> > +             priv->write = flexcan_write_le;
> > +     }
> > +
> > +     if ((!core_is_little && module_is_little) ||
> > +         (core_is_little && !module_is_little)) {
> > +             priv->read = flexcan_read_be;
> > +             priv->write = flexcan_write_be;
> > +     }
> 
> At that point, the naming gets completely wrong - instead should be
> something like flexcan_read_swab / flexcan_write_swab.
> And the decision can easily be made on:
> 
>     IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) != module_is_little
> 
> 
> Putting these together, I'd rather:
> 
> #1: add a new feature flag:
>      #define FLEXCAN_HAS_BIG_ENDIAN BIT(4)
> 
> #2: add a new dts device type for the new chip variant
>      (eg. fsl,flexcan-qorliq)
> 
> #2: pass the priv pointer to the *_read()/*_write() functions,
>      so they can pick up the BE flag and decide whether to
>      swab or not (based on cpu endianess)
> 

You seem to have missed the endian property discussions that happened regarding DTS
Several months back. Have a look at them: [1] & [2]. This patch is compliant to various DTS that
already have such a property.

And BTW, I have already mentioned this during the v1 review of this patchset:

We are dealing with 4 possible cases here:
1. Core is LE (ARM) <-> FlexCAN IP is BE = FSL LS1021A SoC
2. Core is BE (PPC) <-> FlexCAN IP is BE = FSL P1010 SoC
3. Core is BE (PPC) <-> FlexCAN IP is LE = No SoC with this configuration yet
4. Core is LE (PPC) <-> FlexCAN IP is LE = FSL I.MX series

So, no this _simply_ won't work the way you described for the above cases.

I remember testing this patchset also on a P1010, so I don't find any legacy stuff breaking.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254533.html
[2] http://lxr.free-electrons.com/source/arch/arm/boot/dts/ls1021a.dtsi#L127

Regards,
Bhupesh
