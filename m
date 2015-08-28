From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Fri, 28 Aug 2015 12:11:06 +0200
Message-ID: <55E033BA.9000907@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
 <55DF0F39.10507@pengutronix.de>
 <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
 <55DF1580.3070806@pengutronix.de>
 <8a0d66b660360693b2b9b4ae7da78cd4@mail.rdts.de>
 <55DF2098.4020105@pengutronix.de>
 <4c51a680055342d2a37b3459c9cb74ed@SGPMBX1011.APAC.bosch.com>
 <55DFFDE0.1060907@pengutronix.de>
 <049dff30a92ff3b865430d8ad4327b0c@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2BKHQrdIvn9uEkeNtv3KLcpSiknAWmoal"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50526 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbH1KLS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Aug 2015 06:11:18 -0400
In-Reply-To: <049dff30a92ff3b865430d8ad4327b0c@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: "Misra Pankaj Kumar (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, linux-can-owner@vger.kernel.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2BKHQrdIvn9uEkeNtv3KLcpSiknAWmoal
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2015 11:22 AM, Gerhard Bertelsmann wrote:
> If nobody else has done it already I will refresh the existing
> sunxi-can driver and fed it to the lions (SocketCAN team) :-)

I'll give some comments first - may save some time. General remarks:

- I haven't looked closely at the reset_mode normal_mode switching, but
  this looks racy.
- there are quite some delays in the hot paths of the driver
- add proper driver model, i.e. DT bindings

> /*
> * sun7i_can.c - CAN bus controller driver for sun7i
> *
> * Copyright (c) 2013 Peter Chen
> *
> * Copyright (c) 2013 Inmotion Co,. LTD
> * All right reserved.
> *
> */

This driver is IMHO derived work from the existing sja1000 drivers,
removing the copyrights and the license not considered best practise.

>=20
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
> #include <linux/types.h>
> #include <linux/fcntl.h>
> #include <linux/interrupt.h>
> #include <linux/ptrace.h>
> #include <linux/string.h>
> #include <linux/errno.h>
> #include <linux/netdevice.h>
> #include <linux/if_arp.h>
> #include <linux/if_ether.h>
> #include <linux/skbuff.h>
> #include <linux/delay.h>
> #include <linux/clk.h>
>=20
> #include <linux/can/dev.h>
> #include <linux/can/error.h>
>=20
> #include <mach/includes.h>
> #include <plat/sys_config.h>
> #include <mach/irqs.h>
>=20
> #include "sun7i_can.h"
>=20
> #define DRV_NAME "sun7i_can"
>=20
> MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
> MODULE_LICENSE("Dual BSD/GPL");
> MODULE_DESCRIPTION(DRV_NAME "CAN netdevice driver");

move to the end.

> static struct net_device *sun7ican_dev;

not globals please

> static struct can_bittiming_const sun7i_can_bittiming_const =3D {
>         .name =3D DRV_NAME,
>         .tseg1_min =3D 1,
>         .tseg1_max =3D 16,
>         .tseg2_min =3D 1,
>         .tseg2_max =3D 8,
>         .sjw_max =3D 4,
>         .brp_min =3D 1,
>         .brp_max =3D 64,
>         .brp_inc =3D 1,
> };
>=20
> static void sun7i_can_write_cmdreg(struct sun7i_can_priv *priv, u8 val)=

> {
>         unsigned long flags;
>=20
>         /*
>          * The command register needs some locking and time to settle
>          * the write_reg() operation - especially on SMP systems.
>          */

is this true for the allwinner variant of the IP core?

>         spin_lock_irqsave(&priv->cmdreg_lock, flags);
>         writel(val, CAN_CMD_ADDR);
>         spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
> }
>=20
> static int sun7i_can_is_absent(struct sun7i_can_priv *priv)
> {
>         return ((readl(CAN_MSEL_ADDR) & 0xFF) =3D=3D 0xFF);
> }

This can be removed for a SoC internal IP core.

>=20
> static int sun7i_can_probe(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>=20
>         if (sun7i_can_is_absent(priv)) {
>                 printk(KERN_INFO "%s: probing @0x%lX failed\n",
>                  DRV_NAME, dev->base_addr);
>                 return 0;
>         }
>         return -1;

return proper error values

> }
>=20
> static void set_reset_mode(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         uint32_t status =3D readl(CAN_MSEL_ADDR);
>         int i;
>=20
>         for (i =3D 0; i < 100; i++) {
>                 /* check reset bit */
>                 if (status & RESET_MODE) {
>                         priv->can.state =3D CAN_STATE_STOPPED;
>                         return;
>                 }
>=20
>                 writel(readl(CAN_MSEL_ADDR) | RESET_MODE, CAN_MSEL_ADDR=
);        /* select reset mode */
>                 //writel(RESET_MODE, CAN_MSEL_ADDR);        /* select r=
eset mode */
>                 udelay(10);
>                 status =3D readl(CAN_MSEL_ADDR);
>         }
>=20
>         netdev_err(dev, "setting SUN7I_CAN into reset mode failed!\n");=

I think you can remove the SUN7I_CAN from the text, as netdev_* prints
all necessary information
> }
>=20
> static void set_normal_mode(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         unsigned char status =3D readl(CAN_MSEL_ADDR);
>         int i;
>=20
>         for (i =3D 0; i < 100; i++) {
>                 /* check reset bit */
>                 if ((status & RESET_MODE) =3D=3D 0) {
>                         priv->can.state =3D CAN_STATE_ERROR_ACTIVE;				=
							=09
> 					=09
> 						/* enable interrupts */
>                         if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPO=
RTING) {
> 								writel(0xFFFF, CAN_INTEN_ADDR);
> 						} else {
> 								writel(0xFFFF & ~BERR_IRQ_EN, CAN_INTEN_ADDR);
> 						}
> 										=09
> 						if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> 							/* Put device into loopback mode */
> 							writel(readl(CAN_MSEL_ADDR) | LOOPBACK_MODE, CAN_MSEL_ADDR);
> 						} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> 							/* Put device into listen-only mode */
> 							writel(readl(CAN_MSEL_ADDR) | LISTEN_ONLY_MODE, CAN_MSEL_ADDR);
> 						}
>                         return;
>                 }
Please use standard coding style.
>=20
>                 /* set chip to normal mode */
>                 writel(readl(CAN_MSEL_ADDR) & (~RESET_MODE), CAN_MSEL_A=
DDR);
>                 udelay(10);
>                 status =3D readl(CAN_MSEL_ADDR);
>         }
>=20
>         netdev_err(dev, "setting SUN7I_CAN into normal mode failed!\n")=
;
> }
>=20
>=20
> static void sun7i_can_start(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>=20
>         /* leave reset mode */
>         if (priv->can.state !=3D CAN_STATE_STOPPED)
>                 set_reset_mode(dev);
>=20
>         /* Clear error counters and error code capture */
>         writel(0x0, CAN_ERRC_ADDR);
>=20
>         /* leave reset mode */
>         set_normal_mode(dev);
> }
>=20
> static int sun7i_can_set_mode(struct net_device *dev, enum can_mode mod=
e)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>=20
>         if (!priv->open_time)
>                 return -EINVAL;
>=20
>         switch (mode) {
>         case CAN_MODE_START:
>                 sun7i_can_start(dev);
>                 if (netif_queue_stopped(dev))
>                         netif_wake_queue(dev);
>                 break;
>=20
>         default:
>                 return -EOPNOTSUPP;
>         }
>=20
>         return 0;
> }
>=20
> static int sun7i_can_set_bittiming(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         struct can_bittiming *bt =3D &priv->can.bittiming;
>         u32 cfg;
>=20
>         cfg =3D ((bt->brp - 1) & 0x3FF)
>                 | (((bt->sjw - 1) & 0x3) << 14)
>                 | (((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) << 16)
>                 | (((bt->phase_seg2 - 1) & 0x7) << 20);
please use standard coding style - move | to the end of the line
>         if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
>                 cfg |=3D 0x800000;
>=20
>         netdev_info(dev, "setting BITTIMING=3D0x%08x\n", cfg);
>=20
>         set_reset_mode(dev);                //CAN_BTIME_ADDR only writa=
ble in reset mode

no // comments
>         writel(cfg, CAN_BTIME_ADDR);
>         set_normal_mode(dev);
>=20
>         return 0;
> }
>=20
> static int sun7i_can_get_berr_counter(const struct net_device *dev,
>                                  struct can_berr_counter *bec)
> {
>         bec->txerr =3D readl(CAN_ERRC_ADDR) & 0x000F;
>         bec->rxerr =3D (readl(CAN_ERRC_ADDR) & 0x0F00) >> 16;

only read ERRC_ADDR once

>=20
>         return 0;
> }
>=20
> /*
> * initialize sun7i_can:
> * - reset chip
> * - set output mode
> * - set baudrate
> * - enable interrupts
> * - start operating mode
> */
> static void chipset_init(struct net_device *dev)
> {
>         u32 temp_irqen;
> 	=09
>         /* config pins
>          * PH20-TX, PH21-RX :4 */
>=20
> 		if (gpio_request_ex("can_para", "can_tx") =3D=3D 0 || gpio_request_ex=
("can_para", "can_rx") =3D=3D 0 ) {
> 			printk(KERN_INFO "can request gpio fail!\n");
>         }

please fix indention
>=20
>         //enable clock

>         writel(readl(0xF1C20000 + 0x6C) | (1 << 4), 0xF1C20000 + 0x6C);=

please use the common clock framework
>=20
>         //set can controller in reset mode
>         set_reset_mode(dev);
>=20
>         //enable interrupt
>         temp_irqen =3D BERR_IRQ_EN | ERR_PASSIVE_IRQ_EN
>                         | OR_IRQ_EN | RX_IRQ_EN;
>         writel(readl(CAN_INTEN_ADDR) | temp_irqen, CAN_INTEN_ADDR);
>=20
>         //return to transfer mode
>         set_normal_mode(dev);
> }
>=20
> /*
> * transmit a CAN message
> * message layout in the sk_buff should be like this:
> * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
> * [ can_id ] [flags] [len] [can data (up to 8 bytes]
> */
> static netdev_tx_t sun7i_can_start_xmit(struct sk_buff *skb,
>                                          struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         struct can_frame *cf =3D (struct can_frame *)skb->data;
>         uint8_t dlc;
>         canid_t id;
>         uint32_t temp =3D 0;
>         uint8_t i;
>        =20
>         //wait buff ready
>         while (!(readl(CAN_STA_ADDR) & TBUF_RDY));

What are we waiting for here?

>=20
>         set_reset_mode(dev);
>=20
>         writel(0xffffffff, CAN_ACPM_ADDR);
>=20
>         //enter transfer mode
>         set_normal_mode(dev);
>=20
>         if (can_dropped_invalid_skb(dev, skb))
>                 return NETDEV_TX_OK;
>=20
>         netif_stop_queue(dev);
>=20
>         dlc =3D cf->can_dlc;
>         id =3D cf->can_id;
>=20
>         temp =3D ((id >> 30) << 6) | dlc;
>         writel(temp, CAN_BUF0_ADDR);
>         if (id & CAN_EFF_FLAG) {/* extern frame */
>                 writel(0xFF & (id >> 21), CAN_BUF1_ADDR);        //id28=
~21
>                 writel(0xFF & (id >> 13), CAN_BUF2_ADDR);         //id2=
0~13
>                 writel(0xFF & (id >> 5), CAN_BUF3_ADDR);         //id12=
~5
>                 writel((id & 0x1F) << 3, CAN_BUF4_ADDR);         //id4~=
0
>                =20
>                 for (i =3D 0; i < dlc; i++) {
>                         writel(cf->data[i], CAN_BUF5_ADDR + i * 4);
>                 }
>         } else {                /* standard frame*/       =20
>                 writel(0xFF & (id >> 3), CAN_BUF1_ADDR);         //id28=
~21
>                 writel((id & 0x7) << 5, CAN_BUF2_ADDR);                =
//id20~13
>                =20
>                 for (i =3D 0; i < dlc; i++) {
>                         writel(cf->data[i], CAN_BUF3_ADDR + i * 4);
>                 }
>         }
>=20
>         can_put_echo_skb(skb, dev, 0);
>=20
>         while (!(readl(CAN_STA_ADDR) & TBUF_RDY));
What are we waiting for here?
>         sun7i_can_write_cmdreg(priv, TRANS_REQ);
>=20
>         return NETDEV_TX_OK;
> }
>=20
> static void sun7i_can_rx(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         struct net_device_stats *stats =3D &dev->stats;
>         struct can_frame *cf;
>         struct sk_buff *skb;
>         uint8_t fi;
>         canid_t id;
>         int i;
>=20
>         /* create zero'ed CAN frame buffer */
>         skb =3D alloc_can_skb(dev, &cf);
>         if (skb =3D=3D NULL)
>                 return;
>=20
>         fi =3D readl(CAN_BUF0_ADDR);
>         cf->can_dlc =3D get_can_dlc(fi & 0x0F);
>         if (fi >> 7) {
>                 /* extended frame format (EFF) */
>                 id =3D (readl(CAN_BUF1_ADDR) << 21)        //id28~21
>                  | (readl(CAN_BUF2_ADDR) << 13)        //id20~13
>                  | (readl(CAN_BUF3_ADDR) << 5)        //id12~5
>                  | ((readl(CAN_BUF4_ADDR) >> 3) & 0x1f);        //id4~0=

fix coding style
>                 id |=3D CAN_EFF_FLAG;
>=20
>                 if ((fi >> 6) & 0x1) {        /* remote transmission re=
quest */
>                 id |=3D CAN_RTR_FLAG;
>                 } else {
>                         for (i =3D 0; i < cf->can_dlc; i++)
>                                 cf->data[i] =3D readl(CAN_BUF5_ADDR + i=
 * 4);
>                 }
>         } else {
>                 /* standard frame format (SFF) */
>                 id =3D (readl(CAN_BUF1_ADDR) << 3)        //id28~21
>                  | ((readl(CAN_BUF2_ADDR) >> 5) & 0x7);        //id20~1=
8
>=20
>                 if ((fi >> 6) & 0x1) {        /* remote transmission re=
quest */
>                 id |=3D CAN_RTR_FLAG;
>                 } else {
>                         for (i =3D 0; i < cf->can_dlc; i++)
>                                 cf->data[i] =3D readl(CAN_BUF3_ADDR + i=
 * 4);
>                 }
>         }
>=20
>         cf->can_id =3D id;
>=20
>         /* release receive buffer */
>         sun7i_can_write_cmdreg(priv, RELEASE_RBUF);
>=20
>         netif_rx(skb);
>=20
>         stats->rx_packets++;
>         stats->rx_bytes +=3D cf->can_dlc;

don't touch skb after netif_rx

> }
>=20
> static int sun7i_can_err(struct net_device *dev, uint8_t isrc, uint8_t =
status)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         struct net_device_stats *stats =3D &dev->stats;
>         struct can_frame *cf;
>         struct sk_buff *skb;
>         enum can_state state =3D priv->can.state;
>         uint32_t ecc, alc;
>=20
>         skb =3D alloc_can_err_skb(dev, &cf);
>         if (skb =3D=3D NULL)
>                 return -ENOMEM;
>=20
>         if (isrc & DATA_ORUNI) {
>                 /* data overrun interrupt */
>                 netdev_dbg(dev, "data overrun interrupt\n");
>                 cf->can_id |=3D CAN_ERR_CRTL;
>                 cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>                 stats->rx_over_errors++;
>                 stats->rx_errors++;
>                 sun7i_can_write_cmdreg(priv, CLEAR_DOVERRUN);        /*=
 clear bit */
>         }
>=20
>         if (isrc & ERR_WRN) {
>                 /* error warning interrupt */
>                 netdev_dbg(dev, "error warning interrupt\n");
>=20
>                 if (status & BUS_OFF) {
>                         state =3D CAN_STATE_BUS_OFF;
>                         cf->can_id |=3D CAN_ERR_BUSOFF;
>                         can_bus_off(dev);
>                 } else if (status & ERR_STA) {
>                         state =3D CAN_STATE_ERROR_WARNING;
>                 } else
>                         state =3D CAN_STATE_ERROR_ACTIVE;
>         }
>         if (isrc & BUS_ERR) {
>                 /* bus error interrupt */
>                 priv->can.can_stats.bus_error++;
>                 stats->rx_errors++;
>=20
>                 ecc =3D readl(CAN_STA_ADDR);
>=20
>                 cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
>=20
>                 if(ecc & BIT_ERR)
>                         cf->data[2] |=3D CAN_ERR_PROT_BIT;
>                 else if (ecc & FORM_ERR)
>                         cf->data[2] |=3D CAN_ERR_PROT_FORM;
>                 else if (ecc & STUFF_ERR)
>                         cf->data[2] |=3D CAN_ERR_PROT_STUFF;
>                 else {
>                         cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
>                         cf->data[3] =3D (ecc & ERR_SEG_CODE) >> 16;
>                 }
>                 /* Error occurred during transmission? */
>                 if ((ecc & ERR_DIR) =3D=3D 0)
>                         cf->data[2] |=3D CAN_ERR_PROT_TX;
>         }
>         if (isrc & ERR_PASSIVE) {
>                 /* error passive interrupt */
>                 netdev_dbg(dev, "error passive interrupt\n");
>                 if (status & ERR_STA)
>                         state =3D CAN_STATE_ERROR_PASSIVE;
>                 else
>                         state =3D CAN_STATE_ERROR_ACTIVE;
>         }
>         if (isrc & ARB_LOST) {
>                 /* arbitration lost interrupt */
>                 netdev_dbg(dev, "arbitration lost interrupt\n");
>                 alc =3D readl(CAN_STA_ADDR);
>                 priv->can.can_stats.arbitration_lost++;
>                 stats->tx_errors++;
>                 cf->can_id |=3D CAN_ERR_LOSTARB;
>                 cf->data[0] =3D (alc & 0x1f) >> 8;
>         }
>=20
>         if (state !=3D priv->can.state && (state =3D=3D CAN_STATE_ERROR=
_WARNING ||
>                                          state =3D=3D CAN_STATE_ERROR_P=
ASSIVE)) {
>                 uint8_t rxerr =3D (readl(CAN_ERRC_ADDR) >> 16) & 0xFF;
>                 uint8_t txerr =3D readl(CAN_ERRC_ADDR) & 0xFF;
>                 cf->can_id |=3D CAN_ERR_CRTL;
>                 if (state =3D=3D CAN_STATE_ERROR_WARNING) {
>                         priv->can.can_stats.error_warning++;
>                         cf->data[1] =3D (txerr > rxerr) ?
>                                 CAN_ERR_CRTL_TX_WARNING :
>                                 CAN_ERR_CRTL_RX_WARNING;
>                 } else {
>                         priv->can.can_stats.error_passive++;
>                         cf->data[1] =3D (txerr > rxerr) ?
>                                 CAN_ERR_CRTL_TX_PASSIVE :
>                                 CAN_ERR_CRTL_RX_PASSIVE;
>                 }
>                 cf->data[6] =3D txerr;
>                 cf->data[7] =3D rxerr;
>         }
>=20
>         priv->can.state =3D state;
>=20
>         netif_rx(skb);
>=20
>         stats->rx_packets++;
>         stats->rx_bytes +=3D cf->can_dlc;
>=20
>         return 0;
> }
>=20
> irqreturn_t sun7i_can_interrupt(int irq, void *dev_id)
> {
>         struct net_device *dev =3D (struct net_device *)dev_id;
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         struct net_device_stats *stats =3D &dev->stats;
>         uint8_t isrc, status;
>         int n =3D 0;
>=20
>         printk(KERN_INFO "sun7ican: capture a interrupt\n");

please remove this message
>=20
>         /* Shared interrupts and IRQ off? */
>         if ((readl(CAN_INT_ADDR) & 0xF) =3D=3D 0x0)
>                 return IRQ_NONE;
>=20
>         while ((isrc =3D readl(CAN_INT_ADDR)) && (n < SUN7I_CAN_MAX_IRQ=
)) {
>                 n++;
>                 status =3D readl(CAN_STA_ADDR);
>                 /* check for absent controller due to hw unplug */

this is unlikely on a SoC internal core

>                 if (sun7i_can_is_absent(priv))
>                         return IRQ_NONE;
>=20
>                 if (isrc & WAKEUP)
>                         netdev_warn(dev, "wakeup interrupt\n");
>=20
>                 if (isrc & TBUF_VLD) {
>                         /* transmission complete interrupt */
>                         stats->tx_bytes +=3D readl(CAN_RBUF_RBACK_START=
_ADDR) & 0xf;
>                         stats->tx_packets++;
>                         can_get_echo_skb(dev, 0);
>                         netif_wake_queue(dev);
>                 }
>                 if (isrc & RBUF_VLD) {
>                         /* receive interrupt */
>                         while (status & RBUF_RDY) {        //RX buffer =
is not empty
>                                 sun7i_can_rx(dev);
>                                 status =3D readl(CAN_STA_ADDR);
>                                 /* check for absent controller */
>                                 if (sun7i_can_is_absent(priv))
>                                         return IRQ_NONE;
>                         }
>                 }
>                 if (isrc & (DATA_ORUNI | ERR_WRN | BUS_ERR | ERR_PASSIV=
E | ARB_LOST)) {
>                         /* error interrupt */
>                         if (sun7i_can_err(dev, isrc, status))
>                                 break;
>                 }
>=20
>                 //clear the interrupt
>                 writel(isrc, CAN_INT_ADDR);
>                 udelay(10);
Why the delay?
>         }
>=20
>         if (n >=3D SUN7I_CAN_MAX_IRQ)
>                 netdev_dbg(dev, "%d messages handled in ISR", n);
>=20
>         return (n) ? IRQ_HANDLED : IRQ_NONE;
> }
> EXPORT_SYMBOL_GPL(sun7i_can_interrupt);
why is this function exported?
>=20
> static int sun7i_can_open(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>         int err;
>=20
>         /* set chip into reset mode */
>         set_reset_mode(dev);
>=20
>         /* common open */
>         err =3D open_candev(dev);
>         if (err)
>                 return err;
>=20
>         /* register interrupt handler, if not done by the device driver=
 */
>         if (!(priv->flags & SUN7I_CAN_CUSTOM_IRQ_HANDLER)) {

As this should be a non modular drive the custon IRQ handler can be remov=
ed.

>                 err =3D request_irq(dev->irq, sun7i_can_interrupt, priv=
->irq_flags,
>                                  dev->name, (void *)dev);
>                 if (err) {
>                         close_candev(dev);
>                         printk(KERN_INFO "request_irq err:%d\n", err);
>                         return -EAGAIN;
>                 }
>         }
>=20
>         /* init and start chi */
>         sun7i_can_start(dev);
>         priv->open_time =3D jiffies;

remove open_time, too
>=20
>         netif_start_queue(dev);
>=20
>         return 0;
> }
>=20
> static int sun7i_can_close(struct net_device *dev)
> {
>         struct sun7i_can_priv *priv =3D netdev_priv(dev);
>=20
>         netif_stop_queue(dev);
>         set_reset_mode(dev);
>=20
>         if (!(priv->flags & SUN7I_CAN_CUSTOM_IRQ_HANDLER))
>                 free_irq(dev->irq, (void *)dev);
>=20
>         close_candev(dev);
>=20
>         priv->open_time =3D 0;
>=20
>         return 0;
> }
>=20
> struct net_device *alloc_sun7icandev(int sizeof_priv)
> {
>         struct net_device *dev;
>         struct sun7i_can_priv *priv;
>=20
>         dev =3D alloc_candev(sizeof(struct sun7i_can_priv) + sizeof_pri=
v,
>                 SUN7I_CAN_ECHO_SKB_MAX);
>         if (!dev)
>                 return NULL;
>=20
>         priv =3D netdev_priv(dev);
>=20
>         priv->dev =3D dev;
>         priv->can.bittiming_const =3D &sun7i_can_bittiming_const;
>         priv->can.do_set_bittiming =3D sun7i_can_set_bittiming;
>         priv->can.do_set_mode =3D sun7i_can_set_mode;
>         priv->can.do_get_berr_counter =3D sun7i_can_get_berr_counter;
>         priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>                 CAN_CTRLMODE_LISTENONLY |
>                 CAN_CTRLMODE_3_SAMPLES |
>                 CAN_CTRLMODE_BERR_REPORTING;
>=20
>         spin_lock_init(&priv->cmdreg_lock);
>=20
>         if (sizeof_priv)
>                 priv->priv =3D (void *)priv + sizeof(struct sun7i_can_p=
riv);
>=20
>         return dev;
> }
> EXPORT_SYMBOL_GPL(alloc_sun7icandev);
>=20
> void free_sun7icandev(struct net_device *dev)
> {
>         free_candev(dev);
> }
> EXPORT_SYMBOL_GPL(free_sun7icandev);
>=20
> static const struct net_device_ops sun7ican_netdev_ops =3D {
>        .ndo_open =3D sun7i_can_open,
>        .ndo_stop =3D sun7i_can_close,
>        .ndo_start_xmit =3D sun7i_can_start_xmit,
> };
>=20
> int register_sun7icandev(struct net_device *dev)
> {
>         if (!sun7i_can_probe(dev))
>                 return -ENODEV;
>=20
>         dev->flags |=3D IFF_ECHO;        /* support local echo */
>         dev->netdev_ops =3D &sun7ican_netdev_ops;
>=20
>         set_reset_mode(dev);
>        =20
>         return register_candev(dev);
> }
> EXPORT_SYMBOL_GPL(register_sun7icandev);
>=20
> void unregister_sun7icandev(struct net_device *dev)
> {
>         set_reset_mode(dev);
>         unregister_candev(dev);
> }
> EXPORT_SYMBOL_GPL(unregister_sun7icandev);
>=20
> static __init int sun7i_can_init(void)
> {
>         struct sun7i_can_priv *priv;
>         int err =3D 0;
> 		int ret =3D 0;
> 		int used =3D 0;
> 	=09
>         sun7ican_dev =3D alloc_sun7icandev(0);
>         if(!sun7ican_dev) {
>                 printk(KERN_INFO "alloc sun7icandev fail\n");
>         }
> =09
> 		ret =3D script_parser_fetch("can_para", "can_used", &used, sizeof (us=
ed));
> 		if ( ret || used =3D=3D 0) {
> 			printk(KERN_INFO "[sun7i-can] Cannot setup CANBus driver, maybe not =
configured in script.bin?");
> 			goto exit_free;
> 		}

Please add proper DT bindings for this driver.

> 	=09
>         priv =3D netdev_priv(sun7ican_dev);
>         sun7ican_dev->irq =3D SW_INT_IRQNO_CAN;
>         priv->irq_flags =3D 0;
>         priv->can.clock.freq =3D clk_get_rate(clk_get(NULL, CLK_MOD_CAN=
));
>         chipset_init(sun7ican_dev);
>         err =3D register_sun7icandev(sun7ican_dev);
>         if(err) {
>                 dev_err(&sun7ican_dev->dev, "registering %s failed (err=
=3D%d)\n", DRV_NAME, err);
>                 goto exit_free;
>         }
>=20
>         dev_info(&sun7ican_dev->dev, "%s device registered (reg_base=3D=
0x%08x, irq=3D%d)\n",
>                  DRV_NAME, CAN_BASE0, sun7ican_dev->irq);
>=20
>         printk(KERN_INFO "%s CAN netdevice driver\n", DRV_NAME);
>=20
>         return 0;
>=20
> exit_free:
>         free_sun7icandev(sun7ican_dev);
>=20
>         return err;
> }
> module_init(sun7i_can_init);
>=20
> static __exit void sun7i_can_exit(void)
> {
>         unregister_sun7icandev(sun7ican_dev);
>         free_sun7icandev(sun7ican_dev);
>=20
>         printk(KERN_INFO "%s: driver removed\n", DRV_NAME);
> }
> module_exit(sun7i_can_exit);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2BKHQrdIvn9uEkeNtv3KLcpSiknAWmoal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV4DO7AAoJEP5prqPJtc/HlbIH/2kNVRNVoVwR248nsZLAREYH
82k9IYoOs1oZawgyzW7aM0XsLDEHeFIK3Rw/TGpXSsfW0lbluDW7aqQgvP7TPkMG
pOcFkKgonYJCH3NZG9fbCJzFIilwVE1RI1+qJtb3jcTW8wu9S8ViIDG8KPrqzJeo
/QoqeJDcbYh3kGejbaAWXA470uPNxkyRiYEXIHgSAPHeoNS+OLrbvxwWCpU4wg2D
Mk7uG4/tH2LSphal+UddYuN7aLc8olqR5hCayPCwEMLZowqbBvrK3FatFcCPpBw0
cU5+tfOd68LEmq3+1XmyTpVYvr2erJ1Eaqe8MdYhQC5CVOLBZBi7/CpIAGtP6cA=
=g/bp
-----END PGP SIGNATURE-----

--2BKHQrdIvn9uEkeNtv3KLcpSiknAWmoal--
