From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 11:33:25 +0800
Message-ID: <20140715033324.GC21584@shlinux1.ap.freescale.net>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com>
 <1405338041-19945-2-git-send-email-b29396@freescale.com>
 <53C3C97A.7080102@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:29327
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753577AbaGODiU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Jul 2014 23:38:20 -0400
Content-Disposition: inline
In-Reply-To: <53C3C97A.7080102@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com

On Mon, Jul 14, 2014 at 02:13:46PM +0200, Marc Kleine-Budde wrote:
> On 07/14/2014 01:40 PM, Dong Aisheng wrote:
> > The patch adds the basic CAN TX/RX function support for Bosch M_CAN controller.
> > For TX, only one dedicated tx buffer is used for sending data.
> > For RX, RXFIFO 0 is used for receiving data to avoid overflow.
> > Rx FIFO 1 and Rx Buffers are not used currently, as well as Tx Event FIFO.
> > 
> > Due to the message ram can be shared by multi m_can instances
> > and the fifo element is configurable which is SoC dependant,
> > the design is to parse the message ram related configuration data from device
> > tree rather than hardcode define it in driver which can make the message
> > ram sharing fully transparent to M_CAN controller driver,
> > then we can gain better driver maintainability and future features upgrade.
> > 
> > M_CAN also supports CANFD protocol features like data payload up to 64 bytes
> > and bitrate switch at runtime, however, this patch still does not add the
> > support for these features.
> > 
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> > Cc: Varka Bhadram <varkabhadram@gmail.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> [...]
> 
> > +static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
> > +				  u32 fgi, unsigned int offset)
> > +{
> > +	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
> > +				fgi * RXF0_ELEMENT_SIZE + offset);
> > +}
> 
> Can you add a similar function for fifo_write, please?

Unlike fifo_read, we only use one tx buffer for tx function,
fpi, correspding to fgi, is always 0.
So i planned to add it later when adding using multi tx buffers before.
If you like it, i could add it now.
It could be:
+static inline void m_can_fifo_write(const struct m_can_priv *priv,
+                                 u32 fpi, unsigned int offset, u32 val)
+{
+       return writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
+                               fpi * TXB_ELEMENT_SIZE + offset);
+}
+
 static inline void m_can_config_endisable(const struct m_can_priv *priv,
                                          bool enable)
 {
@@ -973,12 +980,10 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
        }

        /* message ram configuration */
-       fifo_addr = priv->mram_base + priv->mcfg[MRAM_TXB].off;
-       writel(id | flags, fifo_addr);
-       writel(cf->can_dlc << 16, fifo_addr + 0x4);
-       writel(*(u32 *)(cf->data + 0), fifo_addr + 0x8);
-       writel(*(u32 *)(cf->data + 4), fifo_addr + 0xc);
-
+       m_can_fifo_write(priv, 0, 0x0, id | flags);
+       m_can_fifo_write(priv, 0, 0x4, cf->can_dlc << 16);
+       m_can_fifo_write(priv, 0, 0x8, *(u32 *)(cf->data + 0));
+       m_can_fifo_write(priv, 0, 0xc, *(u32 *)(cf->data + 4));
        can_put_echo_skb(skb, dev, 0);

        /* enable first TX buffer to start transfer  */

The '0' parameter may cause a bit misleading now, do you think it's ok?

> > +
> > +static inline void m_can_config_endisable(const struct m_can_priv *priv,
> > +					  bool enable)
> > +{
> > +	u32 cccr = m_can_read(priv, M_CAN_CCCR);
> > +	u32 timeout = 10;
> > +	u32 val = 0;
> > +
> > +	if (enable) {
> > +		/* enable m_can configuration */
> > +		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
> > +		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
> > +		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
> > +	} else {
> > +		m_can_write(priv, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
> > +	}
> > +
> > +	/* there's a delay for module initialization */
> > +	if (enable)
> > +		val = CCCR_INIT | CCCR_CCE;
> > +
> > +	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE))
> > +				!= val) {
> > +		if (timeout == 0) {
> > +			netdev_warn(priv->dev, "Failed to init module\n");
> > +			return;
> > +		}
> > +		timeout--;
> > +		udelay(1);
> > +	}
> > +}
> > +
> > +static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
> > +{
> > +	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
> > +}
> > +
> > +static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> > +{
> > +	m_can_write(priv, M_CAN_ILE, 0x0);
> > +}
> > +
> > +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> > +			    u32 rxfs)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	u32 flags, fgi;
> > +
> > +	/* calculate the fifo get index for where to read data */
> > +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> > +	flags = m_can_fifo_read(priv, fgi, 0x0);
>                                            ^^^
> 
> Can you introduce an enum for the offsets, please adjust the signature
> of m_can_fifo_read() accordingly.
> 

I wonder enum may not be suitable.
The Rx Buffer and FIFO Element is as follows:
   31 24 23 16 15 8 7 0
R0 ESI XTD RTR ID[28:0]
R1 ANMF FIDX[6:0] res EDL BRS DLC[3:0] RXTS[15:0]
R2 DB3[7:0] DB2[7:0] DB1[7:0] DB0[7:0]
R3 DB7[7:0] DB6[7:0] DB5[7:0] DB4[7:0]
... ... ... ... ...
Rn DBm[7:0] DBm-1[7:0] DBm-2[7:0] DBm-3[7:0]
Maybe #define a macro for it is better, like:
#define RX_BUFFER_Rn(n)	(n * 0x4)
#define TX_BUFFER_Tn(n)	(n * 0x4)
#define TXE_BUFFER_En(n)(n * 0x4)
But i'm not sure if it's worthy to do that now.
I also planed to update it later when adding canfd format support before.

> > +	if (flags & RX_BUF_XTD)
> > +		cf->can_id = (flags & CAN_EFF_MASK) | CAN_EFF_FLAG;
> > +	else
> > +		cf->can_id = (flags >> 18) & CAN_SFF_MASK;
> > +
> > +	if (flags & RX_BUF_RTR) {
> > +		cf->can_id |= CAN_RTR_FLAG;
> > +	} else {
> > +		flags = m_can_fifo_read(priv, fgi, 0x4);
> > +		cf->can_dlc = get_can_dlc((flags >> 16) & 0x0F);
> > +		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi, 0x8);
> > +		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi, 0xC);
> > +	}
> > +
> > +	/* acknowledge rx fifo 0 */
> > +	m_can_write(priv, M_CAN_RXF0A, fgi);
> > +}
> > +
> > +static int m_can_do_rx_poll(struct net_device *dev, int quota)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	struct net_device_stats *stats = &dev->stats;
> > +	struct sk_buff *skb;
> > +	struct can_frame *frame;
> > +	u32 pkts = 0;
> > +	u32 rxfs;
> > +
> > +	rxfs = m_can_read(priv, M_CAN_RXF0S);
> > +	if (!(rxfs & RXFS_FFL_MASK)) {
> > +		netdev_dbg(dev, "no messages in fifo0\n");
> > +		return 0;
> > +	}
> > +
> > +	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
> > +		if (rxfs & RXFS_RFL)
> > +			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
> > +
> > +		skb = alloc_can_skb(dev, &frame);
> > +		if (!skb) {
> > +			stats->rx_dropped++;
> > +			return 0;
> 
> return pkts;
>  - or -
> goto out;
> 

Good catch. Will update it.

> > +		}
> > +
> > +		m_can_read_fifo(dev, frame, rxfs);
> > +
> > +		stats->rx_packets++;
> > +		stats->rx_bytes += frame->can_dlc;
> > +
> > +		netif_receive_skb(skb);
> > +
> > +		quota--;
> > +		pkts++;
> > +		rxfs = m_can_read(priv, M_CAN_RXF0S);
> > +	};
> > +
> 
> out:
> > +	if (pkts)
> > +		can_led_event(dev, CAN_LED_EVENT_RX);
> > +
> > +	return pkts;
> > +}
> > +
> 
> [...]
> 
> > +static int m_can_handle_lec_err(struct net_device *dev,
> > +				enum m_can_lec_type lec_type)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	struct net_device_stats *stats = &dev->stats;
> > +	struct can_frame *cf;
> > +	struct sk_buff *skb;
> > +
> > +	/* early exit if no lec update */
> > +	if (lec_type == LEC_UNUSED)
> > +		return 0;
> 
> I think this is not needed, as checked by the only caller.

You mean move it to caller as follows?
        /* handle lec errors on the bus */
        if ((psr & LEC_UNUSED) && ((psr & LEC_UNUSED)!= LEC_UNUSED) &&
                (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
                work_done += m_can_handle_lec_err(dev,
                                psr & LEC_UNUSED);
It seems not look good.

How about keep it here and move the later one to caller like:
        /* handle lec errors on the bus */
        if ((psr & LEC_UNUSED) &&
                (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
                work_done += m_can_handle_lec_err(dev,
                                psr & LEC_UNUSED);

> > +
> > +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> > +		return 0;
> 
> Can you move this to the caller, too?
> 
> > +
> > +	priv->can.can_stats.bus_error++;
> > +	stats->rx_errors++;
> > +
> > +	/* propagate the error condition to the CAN stack */
> > +	skb = alloc_can_err_skb(dev, &cf);
> > +	if (unlikely(!skb))
> > +		return 0;
> > +
> > +	/* check for 'last error code' which tells us the
> > +	 * type of the last error to occur on the CAN bus
> > +	 */
> > +	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> > +	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
> > +
> > +	switch (lec_type) {
> > +	case LEC_STUFF_ERROR:
> > +		netdev_dbg(dev, "stuff error\n");
> > +		cf->data[2] |= CAN_ERR_PROT_STUFF;
> > +		break;
> > +	case LEC_FORM_ERROR:
> > +		netdev_dbg(dev, "form error\n");
> > +		cf->data[2] |= CAN_ERR_PROT_FORM;
> > +		break;
> > +	case LEC_ACK_ERROR:
> > +		netdev_dbg(dev, "ack error\n");
> > +		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
> > +				CAN_ERR_PROT_LOC_ACK_DEL);
> > +		break;
> > +	case LEC_BIT1_ERROR:
> > +		netdev_dbg(dev, "bit1 error\n");
> > +		cf->data[2] |= CAN_ERR_PROT_BIT1;
> > +		break;
> > +	case LEC_BIT0_ERROR:
> > +		netdev_dbg(dev, "bit0 error\n");
> > +		cf->data[2] |= CAN_ERR_PROT_BIT0;
> > +		break;
> > +	case LEC_CRC_ERROR:
> > +		netdev_dbg(dev, "CRC error\n");
> > +		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
> > +				CAN_ERR_PROT_LOC_CRC_DEL);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	stats->rx_packets++;
> > +	stats->rx_bytes += cf->can_dlc;
> > +	netif_receive_skb(skb);
> > +
> > +	return 1;
> > +}
> > +
> 
> [...]
> 
> > +static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
> > +{
> > +	if (irqstatus & IR_WDI)
> > +		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
> > +	if (irqstatus & IR_BEU)
> > +		netdev_err(dev, "Error Logging Overflow\n");
> > +	if (irqstatus & IR_BEU)
> > +		netdev_err(dev, "Bit Error Uncorrected\n");
> > +	if (irqstatus & IR_BEC)
> > +		netdev_err(dev, "Bit Error Corrected\n");
> > +	if (irqstatus & IR_TOO)
> > +		netdev_err(dev, "Timeout reached\n");
> > +	if (irqstatus & IR_MRAF)
> > +		netdev_err(dev, "Message RAM access failure occurred\n");
> > +}
> 
> Have you ever seen these error messages? Better rate limit these, though.
> 

Normally we will not see those errors.
It just for telling the user if something errors happened.
Still not sure about the rate.
Could it be improved later when we meet the real issue?

> > +
> > +static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
> > +				   u32 psr)
> > +{
> > +	int work_done = 0;
> > +
> > +	if (irqstatus & IR_RF0L)
> > +		work_done += m_can_handle_lost_msg(dev);
> > +
> > +	/* handle lec errors on the bus */
> > +	if (psr & LEC_UNUSED)
> > +		work_done += m_can_handle_lec_err(dev,
> > +				psr & LEC_UNUSED);
> > +
> > +	/* other unproccessed error interrupts */
> > +	m_can_handle_other_err(dev, irqstatus);
> > +
> > +	return work_done;
> > +}
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 

Regards
Dong Aisheng
