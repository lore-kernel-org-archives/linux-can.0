From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Mon, 14 Jul 2014 15:01:51 +0200
Message-ID: <53C3D4BF.8030409@pengutronix.de>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com> <1405338041-19945-2-git-send-email-b29396@freescale.com> <53C3D155.8080005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rRVhhPXGUMEjdbAmKp95LHrabgQKmhSIt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43108 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbaGNNCK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Jul 2014 09:02:10 -0400
In-Reply-To: <53C3D155.8080005@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rRVhhPXGUMEjdbAmKp95LHrabgQKmhSIt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2014 02:47 PM, Varka Bhadram wrote:
> On 07/14/2014 05:10 PM, Dong Aisheng wrote:
>=20
> (...)
>=20
>> diff --git a/drivers/net/can/m_can/Makefile
>> b/drivers/net/can/m_can/Makefile
>> new file mode 100644
>> index 0000000..a6aae67
>> --- /dev/null
>> +++ b/drivers/net/can/m_can/Makefile
>> @@ -0,0 +1,7 @@
>> +#
>> +#  Makefile for the Bosch M_CAN controller drivers.
>> +#
>> +
>> +obj-$(CONFIG_CAN_M_CAN) +=3D m_can.o
>> +
>> +ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
>=20
> I think this will enable the debugging for all the time ?????

I think only when switched on via Kconfig:

> config CAN_DEBUG_DEVICES
> 	bool "CAN devices debugging messages"


>=20
>> diff --git a/drivers/net/can/m_can/m_can.c
>> b/drivers/net/can/m_can/m_can.c
>> new file mode 100644
>> index 0000000..8e48213
>> --- /dev/null
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -0,0 +1,1189 @@
>> +/*
>> + * CAN bus driver for Bosch M_CAN controller
>> + *
>> + * Copyright (C) 2014 Freescale Semiconductor, Inc.
>> + *    Dong Aisheng <b29396@freescale.com>
>> + *
>> + * Bosch M_CAN user manual can be obtained from:
>> + * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>> + * mcan_users_manual_v302.pdf
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <linux/can/dev.h>
>> +
>> +/* napi related */
>> +#define M_CAN_NAPI_WEIGHT    64
>> +
>> +/* message ram configuration data length */
>> +#define MRAM_CFG_LEN    8
>> +
>> +/* registers definition */
>> +enum m_can_reg {
>> +    M_CAN_CREL    =3D 0x0,
>> +    M_CAN_ENDN    =3D 0x4,
>> +    M_CAN_CUST    =3D 0x8,
>> +    M_CAN_FBTP    =3D 0xc,
>> +    M_CAN_TEST    =3D 0x10,
>> +    M_CAN_RWD    =3D 0x14,
>> +    M_CAN_CCCR    =3D 0x18,
>> +    M_CAN_BTP    =3D 0x1c,
>> +    M_CAN_TSCC    =3D 0x20,
>> +    M_CAN_TSCV    =3D 0x24,
>> +    M_CAN_TOCC    =3D 0x28,
>> +    M_CAN_TOCV    =3D 0x2c,
>> +    M_CAN_ECR    =3D 0x40,
>> +    M_CAN_PSR    =3D 0x44,
>> +    M_CAN_IR    =3D 0x50,
>> +    M_CAN_IE    =3D 0x54,
>> +    M_CAN_ILS    =3D 0x58,
>> +    M_CAN_ILE    =3D 0x5c,
>> +    M_CAN_GFC    =3D 0x80,
>> +    M_CAN_SIDFC    =3D 0x84,
>> +    M_CAN_XIDFC    =3D 0x88,
>> +    M_CAN_XIDAM    =3D 0x90,
>> +    M_CAN_HPMS    =3D 0x94,
>> +    M_CAN_NDAT1    =3D 0x98,
>> +    M_CAN_NDAT2    =3D 0x9c,
>> +    M_CAN_RXF0C    =3D 0xa0,
>> +    M_CAN_RXF0S    =3D 0xa4,
>> +    M_CAN_RXF0A    =3D 0xa8,
>> +    M_CAN_RXBC    =3D 0xac,
>> +    M_CAN_RXF1C    =3D 0xb0,
>> +    M_CAN_RXF1S    =3D 0xb4,
>> +    M_CAN_RXF1A    =3D 0xb8,
>> +    M_CAN_RXESC    =3D 0xbc,
>> +    M_CAN_TXBC    =3D 0xc0,
>> +    M_CAN_TXFQS    =3D 0xc4,
>> +    M_CAN_TXESC    =3D 0xc8,
>> +    M_CAN_TXBRP    =3D 0xcc,
>> +    M_CAN_TXBAR    =3D 0xd0,
>> +    M_CAN_TXBCR    =3D 0xd4,
>> +    M_CAN_TXBTO    =3D 0xd8,
>> +    M_CAN_TXBCF    =3D 0xdc,
>> +    M_CAN_TXBTIE    =3D 0xe0,
>> +    M_CAN_TXBCIE    =3D 0xe4,
>> +    M_CAN_TXEFC    =3D 0xf0,
>> +    M_CAN_TXEFS    =3D 0xf4,
>> +    M_CAN_TXEFA    =3D 0xf8,
>> +};
>> +
>> +/* m_can lec values */
>> +enum m_can_lec_type {
>> +    LEC_NO_ERROR =3D 0,
>> +    LEC_STUFF_ERROR,
>> +    LEC_FORM_ERROR,
>> +    LEC_ACK_ERROR,
>> +    LEC_BIT1_ERROR,
>> +    LEC_BIT0_ERROR,
>> +    LEC_CRC_ERROR,
>> +    LEC_UNUSED,
>> +};
>> +
>> +enum m_can_mram_cfg {
>> +    MRAM_SIDF =3D 0,
>> +    MRAM_XIDF,
>> +    MRAM_RXF0,
>> +    MRAM_RXF1,
>> +    MRAM_RXB,
>> +    MRAM_TXE,
>> +    MRAM_TXB,
>> +    MRAM_CFG_NUM,
>> +};
>> +
>> +/* Test Register (TEST) */
>> +#define TEST_LBCK    BIT(4)
>> +
>> +/* CC Control Register(CCCR) */
>> +#define CCCR_TEST    BIT(7)
>> +#define CCCR_MON    BIT(5)
>> +#define CCCR_CCE    BIT(1)
>> +#define CCCR_INIT    BIT(0)
>> +
>> +/* Bit Timing & Prescaler Register (BTP) */
>> +#define BTR_BRP_MASK        0x3ff
>> +#define BTR_BRP_SHIFT        16
>> +#define BTR_TSEG1_SHIFT        8
>> +#define BTR_TSEG1_MASK        (0x3f << BTR_TSEG1_SHIFT)
>> +#define BTR_TSEG2_SHIFT        4
>> +#define BTR_TSEG2_MASK        (0xf << BTR_TSEG2_SHIFT)
>> +#define BTR_SJW_SHIFT        0
>> +#define BTR_SJW_MASK        0xf
>> +
>> +/* Error Counter Register(ECR) */
>> +#define ECR_RP            BIT(15)
>> +#define ECR_REC_SHIFT        8
>> +#define ECR_REC_MASK        (0x7f << ECR_REC_SHIFT)
>> +#define ECR_TEC_SHIFT        0
>> +#define ECR_TEC_MASK        0xff
>> +
>> +/* Protocol Status Register(PSR) */
>> +#define PSR_BO        BIT(7)
>> +#define PSR_EW        BIT(6)
>> +#define PSR_EP        BIT(5)
>> +#define PSR_LEC_MASK    0x7
>> +
>> +/* Interrupt Register(IR) */
>> +#define IR_ALL_INT    0xffffffff
>> +#define IR_STE        BIT(31)
>> +#define IR_FOE        BIT(30)
>> +#define IR_ACKE        BIT(29)
>> +#define IR_BE        BIT(28)
>> +#define IR_CRCE        BIT(27)
>> +#define IR_WDI        BIT(26)
>> +#define IR_BO        BIT(25)
>> +#define IR_EW        BIT(24)
>> +#define IR_EP        BIT(23)
>> +#define IR_ELO        BIT(22)
>> +#define IR_BEU        BIT(21)
>> +#define IR_BEC        BIT(20)
>> +#define IR_DRX        BIT(19)
>> +#define IR_TOO        BIT(18)
>> +#define IR_MRAF        BIT(17)
>> +#define IR_TSW        BIT(16)
>> +#define IR_TEFL        BIT(15)
>> +#define IR_TEFF        BIT(14)
>> +#define IR_TEFW        BIT(13)
>> +#define IR_TEFN        BIT(12)
>> +#define IR_TFE        BIT(11)
>> +#define IR_TCF        BIT(10)
>> +#define IR_TC        BIT(9)
>> +#define IR_HPM        BIT(8)
>> +#define IR_RF1L        BIT(7)
>> +#define IR_RF1F        BIT(6)
>> +#define IR_RF1W        BIT(5)
>> +#define IR_RF1N        BIT(4)
>> +#define IR_RF0L        BIT(3)
>> +#define IR_RF0F        BIT(2)
>> +#define IR_RF0W        BIT(1)
>> +#define IR_RF0N        BIT(0)
>> +#define IR_ERR_STATE    (IR_BO | IR_EW | IR_EP)
>> +#define IR_ERR_LEC    (IR_STE    | IR_FOE | IR_ACKE | IR_BE | IR_CRCE=
)
>> +#define IR_ERR_BUS    (IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | IR_BEC=
 \
>> +            | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L \
>> +            | IR_RF0L)

Please move the '|' to the end of the line.

>> +#define IR_ERR_ALL    (IR_ERR_STATE | IR_ERR_BUS)
>> +
>> +/* Interrupt Line Select (ILS) */
>> +#define ILS_ALL_INT0    0x0
>> +#define ILS_ALL_INT1    0xFFFFFFFF
>> +
>> +/* Interrupt Line Enable (ILE) */
>> +#define ILE_EINT0    BIT(0)
>> +#define ILE_EINT1    BIT(1)
>> +
>> +/* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
>> +#define RXFC_FWM_OFF    24
>> +#define RXFC_FWM_MASK    0x7f
>> +#define RXFC_FWM_1    (1 << RXFC_FWM_OFF)
>> +#define RXFC_FS_OFF    16
>> +#define RXFC_FS_MASK    0x7f
>> +
>> +/* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
>> +#define RXFS_RFL    BIT(25)
>> +#define RXFS_FF        BIT(24)
>> +#define RXFS_FPI_OFF    16
>> +#define RXFS_FPI_MASK    0x3f0000
>> +#define RXFS_FGI_OFF    8
>> +#define RXFS_FGI_MASK    0x3f00
>> +#define RXFS_FFL_MASK    0x7f
>> +
>> +/* Tx Buffer Configuration(TXBC) */
>> +#define TXBC_NDTB_OFF    16
>> +#define TXBC_NDTB_MASK    0x3f
>> +
>> +/* Tx Buffer Element Size Configuration(TXESC) */
>> +#define TXESC_TBDS_8BYTES    0x0
>> +/* Tx Buffer Element */
>> +#define TX_BUF_XTD    BIT(30)
>> +#define TX_BUF_RTR    BIT(29)
>> +
>> +/* Rx Buffer Element Size Configuration(TXESC) */
>> +#define M_CAN_RXESC_8BYTES    0x0
>> +/* Tx Buffer Element */
>> +#define RX_BUF_ESI    BIT(31)
>> +#define RX_BUF_XTD    BIT(30)
>> +#define RX_BUF_RTR    BIT(29)
>> +
>> +/* Tx Event FIFO Con.guration (TXEFC) */
>> +#define TXEFC_EFS_OFF    16
>> +#define TXEFC_EFS_MASK    0x3f
>> +
>> +/* Message RAM Configuration (in bytes) */
>> +#define SIDF_ELEMENT_SIZE    4
>> +#define XIDF_ELEMENT_SIZE    8
>> +#define RXF0_ELEMENT_SIZE    16
>> +#define RXF1_ELEMENT_SIZE    16
>> +#define RXB_ELEMENT_SIZE    16
>> +#define TXE_ELEMENT_SIZE    8
>> +#define TXB_ELEMENT_SIZE    16
>=20
> Alignment for all the includes

What do you mean? If we change something here, better no alignment at
all, as it tends to break, if another define is added.=09

>=20
>> +
>> +/* address offset and element number for each FIFO/Buffer in the
>> Message RAM */
>> +struct mram_cfg {
>> +    u16 off;
>> +    u8  num;
>> +};
>> +
>> +/* m_can private data structure */
>> +struct m_can_priv {
>> +    struct can_priv can;    /* must be the first member */
>> +    struct napi_struct napi;
>> +    struct net_device *dev;
>> +    struct device *device;
>> +    struct clk *hclk;
>> +    struct clk *cclk;
>> +    void __iomem *base;
>> +    u32 irqstatus;
>> +
>> +    /* message ram configuration */
>> +    void __iomem *mram_base;
>> +    struct mram_cfg mcfg[MRAM_CFG_NUM];
>> +};
>> +
>> +static inline u32 m_can_read(const struct m_can_priv *priv, enum
>> m_can_reg reg)
>> +{
>> +    return readl(priv->base + reg);
>> +}
>> +
>> +static inline void m_can_write(const struct m_can_priv *priv,
>> +                   enum m_can_reg reg, u32 val)
>> +{
>> +    writel(val, priv->base + reg);
>> +}
>> +
>> +static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>> +                  u32 fgi, unsigned int offset)
>> +{
>> +    return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>> +                fgi * RXF0_ELEMENT_SIZE + offset);
>=20
> Here alignment should match the open parenthesis.
> ...
> return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>          fgi * RXF0_ELEMENT_SIZE + offset);
>=20
>> +}
>> +
>> +static inline void m_can_config_endisable(const struct m_can_priv *pr=
iv,
>> +                      bool enable)
>> +{
>> +    u32 cccr =3D m_can_read(priv, M_CAN_CCCR);
>> +    u32 timeout =3D 10;
>> +    u32 val =3D 0;
>> +
>> +    if (enable) {
>> +        /* enable m_can configuration */
>> +        m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>> +        /* CCCR.CCE can only be set/reset while CCCR.INIT =3D '1' */
>> +        m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
>> +    } else {
>> +        m_can_write(priv, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE))=
;
>> +    }
>> +
>> +    /* there's a delay for module initialization */
>> +    if (enable)
>> +        val =3D CCCR_INIT | CCCR_CCE;
>> +
>> +    while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE))
>> +                !=3D val)
>=20
> Ditto..
>=20
>>   {
>> +        if (timeout =3D=3D 0) {
>> +            netdev_warn(priv->dev, "Failed to init module\n");
>> +            return;
>> +        }
>> +        timeout--;
>> +        udelay(1);
>> +    }
>> +}
>> +
>> +static inline void m_can_enable_all_interrupts(const struct
>> m_can_priv *priv)
>> +{
>> +    m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
>> +}
>> +
>> +static inline void m_can_disable_all_interrupts(const struct
>> m_can_priv *priv)
>> +{
>> +    m_can_write(priv, M_CAN_ILE, 0x0);
>> +}
>> +
>> +static void m_can_read_fifo(const struct net_device *dev, struct
>> can_frame *cf,
>> +                u32 rxfs)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    u32 flags, fgi;
>> +
>> +    /* calculate the fifo get index for where to read data */
>> +    fgi =3D (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
>> +    flags =3D m_can_fifo_read(priv, fgi, 0x0);
>> +    if (flags & RX_BUF_XTD)
>> +        cf->can_id =3D (flags & CAN_EFF_MASK) | CAN_EFF_FLAG;
>> +    else
>> +        cf->can_id =3D (flags >> 18) & CAN_SFF_MASK;
>> +
>> +    if (flags & RX_BUF_RTR) {
>> +        cf->can_id |=3D CAN_RTR_FLAG;
>> +    } else {
>> +        flags =3D m_can_fifo_read(priv, fgi, 0x4);
>> +        cf->can_dlc =3D get_can_dlc((flags >> 16) & 0x0F);
>> +        *(u32 *)(cf->data + 0) =3D m_can_fifo_read(priv, fgi, 0x8);
>> +        *(u32 *)(cf->data + 4) =3D m_can_fifo_read(priv, fgi, 0xC);
>> +    }
>> +
>> +    /* acknowledge rx fifo 0 */
>> +    m_can_write(priv, M_CAN_RXF0A, fgi);
>> +}
>> +
>> +static int m_can_do_rx_poll(struct net_device *dev, int quota)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    struct net_device_stats *stats =3D &dev->stats;
>> +    struct sk_buff *skb;
>> +    struct can_frame *frame;
>> +    u32 pkts =3D 0;
>> +    u32 rxfs;
>> +
>> +    rxfs =3D m_can_read(priv, M_CAN_RXF0S);
>> +    if (!(rxfs & RXFS_FFL_MASK)) {
>> +        netdev_dbg(dev, "no messages in fifo0\n");
>> +        return 0;
>> +    }
>> +
>> +    while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
>> +        if (rxfs & RXFS_RFL)
>> +            netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
>> +
>> +        skb =3D alloc_can_skb(dev, &frame);
>> +        if (!skb) {
>> +            stats->rx_dropped++;
>> +            return 0;
>> +        }
>> +
>> +        m_can_read_fifo(dev, frame, rxfs);
>> +
>> +        stats->rx_packets++;
>> +        stats->rx_bytes +=3D frame->can_dlc;
>> +
>> +        netif_receive_skb(skb);
>> +
>> +        quota--;
>> +        pkts++;
>> +        rxfs =3D m_can_read(priv, M_CAN_RXF0S);
>> +    };
>> +
>> +    if (pkts)
>> +        can_led_event(dev, CAN_LED_EVENT_RX);
>> +
>> +    return pkts;
>> +}
>> +
>> +static int m_can_handle_lost_msg(struct net_device *dev)
>> +{
>> +    struct net_device_stats *stats =3D &dev->stats;
>> +    struct sk_buff *skb;
>> +    struct can_frame *frame;
>> +
>> +    netdev_err(dev, "msg lost in rxf0\n");
>> +
>> +    stats->rx_errors++;
>> +    stats->rx_over_errors++;
>> +
>> +    skb =3D alloc_can_err_skb(dev, &frame);
>> +    if (unlikely(!skb))
>> +        return 0;
>> +
>> +    frame->can_id |=3D CAN_ERR_CRTL;
>> +    frame->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>> +
>> +    netif_receive_skb(skb);
>> +
>> +    return 1;
>> +}
>> +
>> +static int m_can_handle_lec_err(struct net_device *dev,
>> +                enum m_can_lec_type lec_type)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    struct net_device_stats *stats =3D &dev->stats;
>> +    struct can_frame *cf;
>> +    struct sk_buff *skb;
>> +
>> +    /* early exit if no lec update */
>> +    if (lec_type =3D=3D LEC_UNUSED)
>> +        return 0;
>> +
>> +    if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>> +        return 0;
>> +
>> +    priv->can.can_stats.bus_error++;
>> +    stats->rx_errors++;
>> +
>> +    /* propagate the error condition to the CAN stack */
>> +    skb =3D alloc_can_err_skb(dev, &cf);
>> +    if (unlikely(!skb))
>> +        return 0;
>> +
>> +    /* check for 'last error code' which tells us the
>> +     * type of the last error to occur on the CAN bus
>> +     */
>> +    cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
>> +    cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
>> +
>> +    switch (lec_type) {
>> +    case LEC_STUFF_ERROR:
>> +        netdev_dbg(dev, "stuff error\n");
>> +        cf->data[2] |=3D CAN_ERR_PROT_STUFF;
>> +        break;
>> +    case LEC_FORM_ERROR:
>> +        netdev_dbg(dev, "form error\n");
>> +        cf->data[2] |=3D CAN_ERR_PROT_FORM;
>> +        break;
>> +    case LEC_ACK_ERROR:
>> +        netdev_dbg(dev, "ack error\n");
>> +        cf->data[3] |=3D (CAN_ERR_PROT_LOC_ACK |
>> +                CAN_ERR_PROT_LOC_ACK_DEL);
>> +        break;
>> +    case LEC_BIT1_ERROR:
>> +        netdev_dbg(dev, "bit1 error\n");
>> +        cf->data[2] |=3D CAN_ERR_PROT_BIT1;
>> +        break;
>> +    case LEC_BIT0_ERROR:
>> +        netdev_dbg(dev, "bit0 error\n");
>> +        cf->data[2] |=3D CAN_ERR_PROT_BIT0;
>> +        break;
>> +    case LEC_CRC_ERROR:
>> +        netdev_dbg(dev, "CRC error\n");
>> +        cf->data[3] |=3D (CAN_ERR_PROT_LOC_CRC_SEQ |
>> +                CAN_ERR_PROT_LOC_CRC_DEL);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    stats->rx_packets++;
>> +    stats->rx_bytes +=3D cf->can_dlc;
>> +    netif_receive_skb(skb);
>> +
>> +    return 1;
>> +}
>> +
>> +static int m_can_get_berr_counter(const struct net_device *dev,
>> +                  struct can_berr_counter *bec)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    unsigned int ecr;
>> +    int err;
>> +
>> +    err =3D clk_prepare_enable(priv->hclk);
>> +    if (err)
>> +        return err;
>> +
>> +    err =3D clk_prepare_enable(priv->cclk);
>> +    if (err) {
>> +        clk_disable_unprepare(priv->hclk);
>> +        return err;
>> +    }
>> +
>> +    ecr =3D m_can_read(priv, M_CAN_ECR);
>> +    bec->rxerr =3D (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
>> +    bec->txerr =3D ecr & ECR_TEC_MASK;
>> +
>> +    clk_disable_unprepare(priv->cclk);
>> +    clk_disable_unprepare(priv->hclk);
>> +
>> +    return 0;
>> +}
>> +
>> +static int m_can_handle_state_change(struct net_device *dev,
>> +                     enum can_state new_state)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    struct net_device_stats *stats =3D &dev->stats;
>> +    struct can_frame *cf;
>> +    struct sk_buff *skb;
>> +    struct can_berr_counter bec;
>> +    unsigned int ecr;
>> +
>> +    switch (new_state) {
>> +    case CAN_STATE_ERROR_ACTIVE:
>> +        /* error warning state */
>> +        priv->can.can_stats.error_warning++;
>> +        priv->can.state =3D CAN_STATE_ERROR_WARNING;
>> +        break;
>> +    case CAN_STATE_ERROR_PASSIVE:
>> +        /* error passive state */
>> +        priv->can.can_stats.error_passive++;
>> +        priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
>> +        break;
>> +    case CAN_STATE_BUS_OFF:
>> +        /* bus-off state */
>> +        priv->can.state =3D CAN_STATE_BUS_OFF;
>> +        m_can_disable_all_interrupts(priv);
>> +        can_bus_off(dev);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    /* propagate the error condition to the CAN stack */
>> +    skb =3D alloc_can_err_skb(dev, &cf);
>> +    if (unlikely(!skb))
>> +        return 0;
>> +
>> +    m_can_get_berr_counter(dev, &bec);
>> +
>> +    switch (new_state) {
>> +    case CAN_STATE_ERROR_ACTIVE:
>> +        /* error warning state */
>> +        cf->can_id |=3D CAN_ERR_CRTL;
>> +        cf->data[1] =3D (bec.txerr > bec.rxerr) ?
>> +            CAN_ERR_CRTL_TX_WARNING :
>> +            CAN_ERR_CRTL_RX_WARNING;
>> +        cf->data[6] =3D bec.txerr;
>> +        cf->data[7] =3D bec.rxerr;
>> +        break;
>> +    case CAN_STATE_ERROR_PASSIVE:
>> +        /* error passive state */
>> +        cf->can_id |=3D CAN_ERR_CRTL;
>> +        ecr =3D m_can_read(priv, M_CAN_ECR);
>> +        if (ecr & ECR_RP)
>> +            cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
>> +        if (bec.txerr > 127)
>> +            cf->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
>> +        cf->data[6] =3D bec.txerr;
>> +        cf->data[7] =3D bec.rxerr;
>> +        break;
>> +    case CAN_STATE_BUS_OFF:
>> +        /* bus-off state */
>> +        cf->can_id |=3D CAN_ERR_BUSOFF;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    stats->rx_packets++;
>> +    stats->rx_bytes +=3D cf->can_dlc;
>> +    netif_receive_skb(skb);
>> +
>> +    return 1;
>> +}
>> +
>> +static int m_can_handle_state_errors(struct net_device *dev, u32 psr)=

>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    int work_done =3D 0;
>> +
>> +    if ((psr & PSR_EW) &&
>> +        (priv->can.state !=3D CAN_STATE_ERROR_WARNING)) {
>> +        netdev_dbg(dev, "entered error warning state\n");
>> +        work_done +=3D m_can_handle_state_change(dev,
>> +                CAN_STATE_ERROR_WARNING);
>=20
> Ditto
>=20
>> +    }
>> +
>> +    if ((psr & PSR_EP) &&
>> +        (priv->can.state !=3D CAN_STATE_ERROR_PASSIVE)) {
>> +        netdev_dbg(dev, "entered error warning state\n");
>> +        work_done +=3D m_can_handle_state_change(dev,
>> +                CAN_STATE_ERROR_PASSIVE);
>> +    }
>> +
>=20
> Ditto
>=20
>> +    if ((psr & PSR_BO) &&
>> +        (priv->can.state !=3D CAN_STATE_BUS_OFF)) {
>> +        netdev_dbg(dev, "entered error warning state\n");
>> +        work_done +=3D m_can_handle_state_change(dev,
>> +                CAN_STATE_BUS_OFF);
>=20
> Ditto
>=20
>> +    }
>> +
>> +    return work_done;
>> +}
>> +
>> +static void m_can_handle_other_err(struct net_device *dev, u32
>> irqstatus)
>> +{
>> +    if (irqstatus & IR_WDI)
>> +        netdev_err(dev, "Message RAM Watchdog event due to missing
>> READY\n");
>> +    if (irqstatus & IR_BEU)
>> +        netdev_err(dev, "Error Logging Overflow\n");
>> +    if (irqstatus & IR_BEU)
>> +        netdev_err(dev, "Bit Error Uncorrected\n");
>> +    if (irqstatus & IR_BEC)
>> +        netdev_err(dev, "Bit Error Corrected\n");
>> +    if (irqstatus & IR_TOO)
>> +        netdev_err(dev, "Timeout reached\n");
>> +    if (irqstatus & IR_MRAF)
>> +        netdev_err(dev, "Message RAM access failure occurred\n");
>> +}
>> +
>> +static int m_can_handle_bus_errors(struct net_device *dev, u32
>> irqstatus,
>> +                   u32 psr)
>> +{
>> +    int work_done =3D 0;
>> +
>> +    if (irqstatus & IR_RF0L)
>> +        work_done +=3D m_can_handle_lost_msg(dev);
>> +
>> +    /* handle lec errors on the bus */
>> +    if (psr & LEC_UNUSED)
>> +        work_done +=3D m_can_handle_lec_err(dev,
>> +                psr & LEC_UNUSED);
>=20
> Ditto
>=20
>> +
>> +    /* other unproccessed error interrupts */
>> +    m_can_handle_other_err(dev, irqstatus);
>> +
>> +    return work_done;
>> +}
>> +
>> +static int m_can_poll(struct napi_struct *napi, int quota)
>> +{
>> +    struct net_device *dev =3D napi->dev;
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    int work_done =3D 0;
>> +    u32 irqstatus, psr;
>> +
>> +    irqstatus =3D priv->irqstatus | m_can_read(priv, M_CAN_IR);
>> +    if (!irqstatus)
>> +        goto end;
>> +
>> +    psr =3D m_can_read(priv, M_CAN_PSR);
>> +    if (irqstatus & IR_ERR_STATE)
>> +        work_done +=3D m_can_handle_state_errors(dev, psr);
>> +
>> +    if (irqstatus & IR_ERR_BUS)
>> +        work_done +=3D m_can_handle_bus_errors(dev, irqstatus, psr);
>> +
>> +    if (irqstatus & IR_RF0N)
>> +        work_done +=3D m_can_do_rx_poll(dev, (quota - work_done));
>> +
>> +    if (work_done < quota) {
>> +        napi_complete(napi);
>> +        m_can_enable_all_interrupts(priv);
>> +    }
>> +
>> +end:
>> +    return work_done;
>> +}
>> +
>> +static irqreturn_t m_can_isr(int irq, void *dev_id)
>> +{
>> +    struct net_device *dev =3D (struct net_device *)dev_id;
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    struct net_device_stats *stats =3D &dev->stats;
>> +    u32 ir;
>> +
>> +    ir =3D m_can_read(priv, M_CAN_IR);
>> +    if (!ir)
>> +        return IRQ_NONE;
>> +
>> +    /* ACK all irqs */
>> +    if (ir & IR_ALL_INT)
>> +        m_can_write(priv, M_CAN_IR, ir);
>> +
>> +    /* schedule NAPI in case of
>> +     * - rx IRQ
>> +     * - state change IRQ
>> +     * - bus error IRQ and bus error reporting
>> +     */
>> +    if ((ir & IR_RF0N) || (ir & IR_ERR_ALL)) {
>> +        priv->irqstatus =3D ir;
>> +        m_can_disable_all_interrupts(priv);
>> +        napi_schedule(&priv->napi);
>> +    }
>> +
>> +    /* transmission complete interrupt */
>> +    if (ir & IR_TC) {
>> +        stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>> +        stats->tx_packets++;
>> +        can_led_event(dev, CAN_LED_EVENT_TX);
>> +        netif_wake_queue(dev);
>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static const struct can_bittiming_const m_can_bittiming_const =3D {
>> +    .name =3D KBUILD_MODNAME,
>> +    .tseg1_min =3D 2,        /* Time segment 1 =3D prop_seg + phase_s=
eg1 */
>> +    .tseg1_max =3D 64,
>> +    .tseg2_min =3D 1,        /* Time segment 2 =3D phase_seg2 */
>> +    .tseg2_max =3D 16,
>> +    .sjw_max =3D 16,
>> +    .brp_min =3D 1,
>> +    .brp_max =3D 1024,
>> +    .brp_inc =3D 1,
>> +};
>> +
>> +static int m_can_set_bittiming(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    const struct can_bittiming *bt =3D &priv->can.bittiming;
>> +    u16 brp, sjw, tseg1, tseg2;
>> +    u32 reg_btp;
>> +
>> +    brp =3D bt->brp - 1;
>> +    sjw =3D bt->sjw - 1;
>> +    tseg1 =3D bt->prop_seg + bt->phase_seg1 - 1;
>> +    tseg2 =3D bt->phase_seg2 - 1;
>> +    reg_btp =3D (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
>> +            (tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
>> +    m_can_write(priv, M_CAN_BTP, reg_btp);
>> +    netdev_dbg(dev, "setting BTP 0x%x\n", reg_btp);
>> +
>> +    return 0;
>> +}
>> +
>> +/* Configure M_CAN chip:
>> + * - set rx buffer/fifo element size
>> + * - configure rx fifo
>> + * - accept non-matching frame into fifo 0
>> + * - configure tx buffer
>> + * - configure mode
>> + * - setup bittiming
>> + */
>> +static void m_can_chip_config(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    u32 cccr, test;
>> +
>> +    m_can_config_endisable(priv, true);
>> +
>> +    /* RX Buffer/FIFO Element Size 8 bytes data field */
>> +    m_can_write(priv, M_CAN_RXESC, M_CAN_RXESC_8BYTES);
>> +
>> +    /* Accept Non-matching Frames Into FIFO 0 */
>> +    m_can_write(priv, M_CAN_GFC, 0x0);
>> +
>> +    /* only support one Tx Buffer currently */
>> +    m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_OFF) |
>> +            priv->mcfg[MRAM_TXB].off);
>> +
>> +    /* only support 8 bytes firstly */
>> +    m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_8BYTES);
>> +
>> +    m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_OFF) |
>> +            priv->mcfg[MRAM_TXE].off);
>> +
>> +    /* rx fifo configuration, blocking mode, fifo size 1 */
>> +    m_can_write(priv, M_CAN_RXF0C,
>> +            (priv->mcfg[MRAM_RXF0].num << RXFC_FS_OFF) |
>> +            RXFC_FWM_1 | priv->mcfg[MRAM_RXF0].off);
>> +
>> +    m_can_write(priv, M_CAN_RXF1C,
>> +            (priv->mcfg[MRAM_RXF1].num << RXFC_FS_OFF) |
>> +            RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
>> +
>> +    cccr =3D m_can_read(priv, M_CAN_CCCR);
>> +    cccr &=3D ~(CCCR_TEST | CCCR_MON);
>> +    test =3D m_can_read(priv, M_CAN_TEST);
>> +    test &=3D ~TEST_LBCK;
>> +
>> +    if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> +        cccr |=3D CCCR_MON;
>> +
>> +    if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>> +        cccr |=3D CCCR_TEST;
>> +        test |=3D TEST_LBCK;
>> +    }
>> +
>> +    m_can_write(priv, M_CAN_CCCR, cccr);
>> +    m_can_write(priv, M_CAN_TEST, test);
>> +
>> +    /* enable interrupts */
>> +    m_can_write(priv, M_CAN_IR, IR_ALL_INT);
>> +    if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>> +        m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC);
>> +    else
>> +        m_can_write(priv, M_CAN_IE, IR_ALL_INT);
>> +
>> +    /* route all interrupts to INT0 */
>> +    m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
>> +
>> +    /* set bittiming params */
>> +    m_can_set_bittiming(dev);
>> +
>> +    m_can_config_endisable(priv, false);
>> +}
>> +
>> +static void m_can_start(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +
>> +    /* basic m_can configuration */
>> +    m_can_chip_config(dev);
>> +
>> +    priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> +
>> +    m_can_enable_all_interrupts(priv);
>> +}
>> +
>> +static int m_can_set_mode(struct net_device *dev, enum can_mode mode)=

>> +{
>> +    switch (mode) {
>> +    case CAN_MODE_START:
>> +        m_can_start(dev);
>> +        netif_wake_queue(dev);
>> +        break;
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>=20
> I think for single we don't need switch case...

It's done like this in all the drivers, so let's keep it this way.

>=20
>> +    return 0;
>> +}
>> +
>> +static void free_m_can_dev(struct net_device *dev)
>> +{
>> +    free_candev(dev);
>> +}
>> +
>> +static struct net_device *alloc_m_can_dev(void)
>> +{
>> +    struct net_device *dev;
>> +    struct m_can_priv *priv;
>> +
>> +    dev =3D alloc_candev(sizeof(*priv), 1);
>> +    if (!dev)
>> +        return NULL;
>> +
>> +    priv =3D netdev_priv(dev);
>> +    netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
>> +
>> +    priv->dev =3D dev;
>> +    priv->can.bittiming_const =3D &m_can_bittiming_const;
>> +    priv->can.do_set_mode =3D m_can_set_mode;
>> +    priv->can.do_get_berr_counter =3D m_can_get_berr_counter;
>> +    priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>> +                    CAN_CTRLMODE_LISTENONLY |
>> +                    CAN_CTRLMODE_BERR_REPORTING;
>> +
>> +    return dev;
>> +}
>> +
>> +static int m_can_open(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    int err;
>> +
>> +    err =3D clk_prepare_enable(priv->hclk);
>> +    if (err)
>> +        return err;
>> +
>> +    err =3D clk_prepare_enable(priv->cclk);
>> +    if (err)
>> +        goto exit_disable_hclk;
>> +
>> +    /* open the can device */
>> +    err =3D open_candev(dev);
>> +    if (err) {
>> +        netdev_err(dev, "failed to open can device\n");
>> +        goto exit_disable_cclk;
>> +    }
>> +
>> +    /* register interrupt handler */
>> +    err =3D request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
>> +              dev);
>> +    if (err < 0) {
>> +        netdev_err(dev, "failed to request interrupt\n");
>> +        goto exit_irq_fail;
>> +    }
>> +
>> +    /* start the m_can controller */
>> +    m_can_start(dev);
>> +
>> +    can_led_event(dev, CAN_LED_EVENT_OPEN);
>> +    napi_enable(&priv->napi);
>> +    netif_start_queue(dev);
>> +
>> +    return 0;
>> +
>> +exit_irq_fail:
>> +    close_candev(dev);
>> +exit_disable_cclk:
>> +    clk_disable_unprepare(priv->cclk);
>> +exit_disable_hclk:
>> +    clk_disable_unprepare(priv->hclk);
>> +    return err;
>> +}
>> +
>> +static void m_can_stop(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +
>> +    /* disable all interrupts */
>> +    m_can_disable_all_interrupts(priv);
>> +
>> +    clk_disable_unprepare(priv->hclk);
>> +    clk_disable_unprepare(priv->cclk);
>> +
>> +    /* set the state as STOPPED */
>> +    priv->can.state =3D CAN_STATE_STOPPED;
>> +}
>> +
>> +static int m_can_close(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +
>> +    netif_stop_queue(dev);
>> +    napi_disable(&priv->napi);
>> +    m_can_stop(dev);
>> +    free_irq(dev->irq, dev);
>> +    close_candev(dev);
>> +    can_led_event(dev, CAN_LED_EVENT_STOP);
>> +
>> +    return 0;
>> +}
>> +
>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>> +                    struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    struct can_frame *cf =3D (struct can_frame *)skb->data;
>> +    u32 flags =3D 0, id;
>> +    void __iomem *fifo_addr;
>> +
>> +    if (can_dropped_invalid_skb(dev, skb))
>> +        return NETDEV_TX_OK;
>> +
>> +    netif_stop_queue(dev);
>> +
>> +    if (cf->can_id & CAN_RTR_FLAG)
>> +        flags |=3D TX_BUF_RTR;
>> +
>> +    if (cf->can_id & CAN_EFF_FLAG) {
>> +        id =3D cf->can_id & CAN_EFF_MASK;
>> +        flags |=3D TX_BUF_XTD;
>> +    } else {
>> +        id =3D ((cf->can_id & CAN_SFF_MASK) << 18);
>> +    }
>> +
>> +    /* message ram configuration */
>> +    fifo_addr =3D priv->mram_base + priv->mcfg[MRAM_TXB].off;
>> +    writel(id | flags, fifo_addr);
>> +    writel(cf->can_dlc << 16, fifo_addr + 0x4);
>> +    writel(*(u32 *)(cf->data + 0), fifo_addr + 0x8);
>> +    writel(*(u32 *)(cf->data + 4), fifo_addr + 0xc);
>> +
>> +    can_put_echo_skb(skb, dev, 0);
>> +
>> +    /* enable first TX buffer to start transfer  */
>> +    m_can_write(priv, M_CAN_TXBTIE, 0x1);
>> +    m_can_write(priv, M_CAN_TXBAR, 0x1);
>> +
>> +    return NETDEV_TX_OK;
>> +}
>> +
>> +static const struct net_device_ops m_can_netdev_ops =3D {
>> +    .ndo_open =3D m_can_open,
>> +    .ndo_stop =3D m_can_close,
>> +    .ndo_start_xmit =3D m_can_start_xmit,
>> +};
>> +
>> +static int register_m_can_dev(struct net_device *dev)
>> +{
>> +    dev->flags |=3D IFF_ECHO;    /* we support local echo */
>> +    dev->netdev_ops =3D &m_can_netdev_ops;
>> +
>> +    return register_candev(dev);
>> +}
>> +
>> +static const struct of_device_id m_can_of_table[] =3D {
>> +    { .compatible =3D "bosch,m_can", .data =3D NULL },
>> +    { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, m_can_of_table);
>> +
>=20
> Move this device ids before the platform_driver struct ...
>=20
> No need to include .data=3DNULL

As I said before, I like the fact that it actively states "no data
needed" for now.

>=20
>> +static int m_can_of_parse_mram(struct platform_device *pdev,
>> +                   struct m_can_priv *priv)
>> +{
>> +    struct device_node *np =3D pdev->dev.of_node;
>> +    struct resource *res;
>> +    void __iomem *addr;
>> +    u32 out_val[MRAM_CFG_LEN];
>> +    int ret;
>> +
>> +    /* message ram could be shared */
>> +    res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "message_ram");
>> +    if (!res)
>> +        return -ENODEV;
>> +
>> +    addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res))=
;
>> +    if (!addr)
>> +        return -ENOMEM;
>> +
>> +    /* get message ram configuration */
>> +    ret =3D of_property_read_u32_array(np, "bosch,mram-cfg",
>> +                     out_val, sizeof(out_val) / 4);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "can not get message ram configuration\n"=
);
>> +        return -ENODEV;
>> +    }
>> +
>> +    priv->mram_base =3D addr;
>> +    priv->mcfg[MRAM_SIDF].off =3D out_val[0];
>> +    priv->mcfg[MRAM_SIDF].num =3D out_val[1];
>> +    priv->mcfg[MRAM_XIDF].off =3D priv->mcfg[MRAM_SIDF].off +
>> +            priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_XIDF].num =3D out_val[2];
>> +    priv->mcfg[MRAM_RXF0].off =3D priv->mcfg[MRAM_XIDF].off +
>> +            priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF0].num =3D out_val[3] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXF1].off =3D priv->mcfg[MRAM_RXF0].off +
>> +            priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF1].num =3D out_val[4] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXB].off =3D priv->mcfg[MRAM_RXF1].off +
>> +            priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXB].num =3D out_val[5];
>> +    priv->mcfg[MRAM_TXE].off =3D priv->mcfg[MRAM_RXB].off +
>> +            priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXE].num =3D out_val[6];
>> +    priv->mcfg[MRAM_TXB].off =3D priv->mcfg[MRAM_TXE].off +
>> +            priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXB].num =3D out_val[7] & TXBC_NDTB_MASK;
>> +
>> +    dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0
>> 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>> +        priv->mram_base,
>> +        priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
>> +        priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
>> +        priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
>> +        priv->mcfg[MRAM_RXF1].off, priv->mcfg[MRAM_RXF1].num,
>> +        priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
>> +        priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
>> +        priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
>> +
>> +    return 0;
>> +}
>> +
>> +static int m_can_plat_probe(struct platform_device *pdev)
>> +{
>> +    struct net_device *dev;
>> +    struct m_can_priv *priv;
>> +    struct resource *res;
>> +    void __iomem *addr;
>> +    struct clk *hclk, *cclk;
>> +    int irq, ret;
>> +
>> +    hclk =3D devm_clk_get(&pdev->dev, "hclk");
>> +    cclk =3D devm_clk_get(&pdev->dev, "cclk");
>> +    if (IS_ERR(hclk) || IS_ERR(cclk)) {
>> +        dev_err(&pdev->dev, "no clock find\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can=
");
>> +    addr =3D devm_ioremap_resource(&pdev->dev, res);
>> +    irq =3D platform_get_irq_byname(pdev, "int0");
>> +    if (IS_ERR(addr) || irq < 0)
>> +        return -EINVAL;
>> +
>> +    /* allocate the m_can device */
>> +    dev =3D alloc_m_can_dev();
>> +    if (!dev)
>> +        return -ENOMEM;
>> +
>> +    priv =3D netdev_priv(dev);
>> +    dev->irq =3D irq;
>> +    priv->base =3D addr;
>> +    priv->device =3D &pdev->dev;
>> +    priv->hclk =3D hclk;
>> +    priv->cclk =3D cclk;
>> +    priv->can.clock.freq =3D clk_get_rate(cclk);
>> +
>> +    ret =3D m_can_of_parse_mram(pdev, priv);
>> +    if (ret)
>> +        goto failed_free_dev;
>> +
>> +    platform_set_drvdata(pdev, dev);
>> +    SET_NETDEV_DEV(dev, &pdev->dev);
>> +
>> +    ret =3D register_m_can_dev(dev);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
>> +            KBUILD_MODNAME, ret);
>> +        goto failed_free_dev;
>> +    }
>> +
>> +    devm_can_led_init(dev);
>> +
>> +    dev_info(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\=
n",
>> +         KBUILD_MODNAME, priv->base, dev->irq);
>> +
>> +    return 0;
>> +
>> +failed_free_dev:
>> +    free_m_can_dev(dev);
>> +    return ret;
>> +}
>> +
>> +static __maybe_unused int m_can_suspend(struct device *dev)
>> +{
>> +    struct net_device *ndev =3D dev_get_drvdata(dev);
>> +    struct m_can_priv *priv =3D netdev_priv(ndev);
>> +
>> +    if (netif_running(ndev)) {
>> +        netif_stop_queue(ndev);
>> +        netif_device_detach(ndev);
>> +    }
>> +
>> +    /* TODO: enter low power */
>> +
>> +    priv->can.state =3D CAN_STATE_SLEEPING;
>> +
>> +    return 0;
>> +}
>> +
>> +static __maybe_unused int m_can_resume(struct device *dev)
>> +{
>> +    struct net_device *ndev =3D dev_get_drvdata(dev);
>> +    struct m_can_priv *priv =3D netdev_priv(ndev);
>> +
>> +    /* TODO: exit low power */
>> +
>> +    priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>> +
>> +    if (netif_running(ndev)) {
>> +        netif_device_attach(ndev);
>> +        netif_start_queue(ndev);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void unregister_m_can_dev(struct net_device *dev)
>> +{
>> +    unregister_candev(dev);
>> +}
>> +
>> +static int m_can_plat_remove(struct platform_device *pdev)
>> +{
>> +    struct net_device *dev =3D platform_get_drvdata(pdev);
>> +
>> +    unregister_m_can_dev(dev);
>> +    platform_set_drvdata(pdev, NULL);
>> +
>> +    free_m_can_dev(dev);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops m_can_pmops =3D {
>> +    SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>> +};
>> +
>=20
> Give the device ids here. So that we can see the of_match_table directl=
y...
>=20
> Every driver follows the same concept...

Good point.
>=20
>> +static struct platform_driver m_can_plat_driver =3D {
>> +    .driver =3D {
>> +        .name =3D KBUILD_MODNAME,
>> +        .of_match_table =3D of_match_ptr(m_can_of_table),
>=20
> This driver will always populate through the dts files. So no need to
> use 'of_match_ptr'.
>=20
>> +        .pm     =3D &m_can_pmops,
>> +    },
>> +    .probe =3D m_can_plat_probe,
>> +    .remove =3D m_can_plat_remove,
>> +};
>> +
>> +module_platform_driver(m_can_plat_driver);
>> +
>> +MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
>=20
>=20

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rRVhhPXGUMEjdbAmKp95LHrabgQKmhSIt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPD1L8ACgkQjTAFq1RaXHOG4wCZAd9rc0hH9OauV9yQMhhbTGy0
3EcAnA2r41w2PpvA/px1F54v70aJjkRR
=0CWW
-----END PGP SIGNATURE-----

--rRVhhPXGUMEjdbAmKp95LHrabgQKmhSIt--
