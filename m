From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 12:26:54 +0530
Message-ID: <53C4D0B6.4010302@gmail.com>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com> <1405338041-19945-2-git-send-email-b29396@freescale.com> <53C3D155.8080005@gmail.com> <20140715062712.GA9796@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34058 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675AbaGOG6O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jul 2014 02:58:14 -0400
In-Reply-To: <20140715062712.GA9796@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On 07/15/2014 11:57 AM, Dong Aisheng wrote:
> On Mon, Jul 14, 2014 at 06:17:17PM +0530, Varka Bhadram wrote:
>>
>> +/* Test Register (TEST) */
>> +#define TEST_LBCK	BIT(4)
>> +
>> +/* CC Control Register(CCCR) */
>> +#define CCCR_TEST	BIT(7)
>> +#define CCCR_MON	BIT(5)
>> +#define CCCR_CCE	BIT(1)
>> +#define CCCR_INIT	BIT(0)
>> +
>> +/* Bit Timing & Prescaler Register (BTP) */
>> +#define BTR_BRP_MASK		0x3ff
>> +#define BTR_BRP_SHIFT		16
>> +#define BTR_TSEG1_SHIFT		8
>> +#define BTR_TSEG1_MASK		(0x3f << BTR_TSEG1_SHIFT)
>> +#define BTR_TSEG2_SHIFT		4
>> +#define BTR_TSEG2_MASK		(0xf << BTR_TSEG2_SHIFT)
>> +#define BTR_SJW_SHIFT		0
>> +#define BTR_SJW_MASK		0xf
>> +
>> +/* Error Counter Register(ECR) */
>> +#define ECR_RP			BIT(15)
>> +#define ECR_REC_SHIFT		8
>> +#define ECR_REC_MASK		(0x7f << ECR_REC_SHIFT)
>> +#define ECR_TEC_SHIFT		0
>> +#define ECR_TEC_MASK		0xff
>> +
>> +/* Protocol Status Register(PSR) */
>> +#define PSR_BO		BIT(7)
>> +#define PSR_EW		BIT(6)
>> +#define PSR_EP		BIT(5)
>> +#define PSR_LEC_MASK	0x7
>> +
>> +/* Interrupt Register(IR) */
>> +#define IR_ALL_INT	0xffffffff
>> +#define IR_STE		BIT(31)
>> +#define IR_FOE		BIT(30)
>> +#define IR_ACKE		BIT(29)
>> +#define IR_BE		BIT(28)
>> +#define IR_CRCE		BIT(27)
>> +#define IR_WDI		BIT(26)
>> +#define IR_BO		BIT(25)
>> +#define IR_EW		BIT(24)
>> +#define IR_EP		BIT(23)
>> +#define IR_ELO		BIT(22)
>> +#define IR_BEU		BIT(21)
>> +#define IR_BEC		BIT(20)
>> +#define IR_DRX		BIT(19)
>> +#define IR_TOO		BIT(18)
>> +#define IR_MRAF		BIT(17)
>> +#define IR_TSW		BIT(16)
>> +#define IR_TEFL		BIT(15)
>> +#define IR_TEFF		BIT(14)
>> +#define IR_TEFW		BIT(13)
>> +#define IR_TEFN		BIT(12)
>> +#define IR_TFE		BIT(11)
>> +#define IR_TCF		BIT(10)
>> +#define IR_TC		BIT(9)
>> +#define IR_HPM		BIT(8)
>> +#define IR_RF1L		BIT(7)
>> +#define IR_RF1F		BIT(6)
>> +#define IR_RF1W		BIT(5)
>> +#define IR_RF1N		BIT(4)
>> +#define IR_RF0L		BIT(3)
>> +#define IR_RF0F		BIT(2)
>> +#define IR_RF0W		BIT(1)
>> +#define IR_RF0N		BIT(0)
>> +#define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
>> +#define IR_ERR_LEC	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
>> +#define IR_ERR_BUS	(IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | IR_BEC \
>> +			| IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L \
>> +			| IR_RF0L)
>> +#define IR_ERR_ALL	(IR_ERR_STATE | IR_ERR_BUS)
>> +
>> +/* Interrupt Line Select (ILS) */
>> +#define ILS_ALL_INT0	0x0
>> +#define ILS_ALL_INT1	0xFFFFFFFF
>> +
>> +/* Interrupt Line Enable (ILE) */
>> +#define ILE_EINT0	BIT(0)
>> +#define ILE_EINT1	BIT(1)
>> +
>> +/* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
>> +#define RXFC_FWM_OFF	24
>> +#define RXFC_FWM_MASK	0x7f
>> +#define RXFC_FWM_1	(1 << RXFC_FWM_OFF)
>> +#define RXFC_FS_OFF	16
>> +#define RXFC_FS_MASK	0x7f
>> +
>> +/* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
>> +#define RXFS_RFL	BIT(25)
>> +#define RXFS_FF		BIT(24)
>> +#define RXFS_FPI_OFF	16
>> +#define RXFS_FPI_MASK	0x3f0000
>> +#define RXFS_FGI_OFF	8
>> +#define RXFS_FGI_MASK	0x3f00
>> +#define RXFS_FFL_MASK	0x7f
>> +
>> +/* Tx Buffer Configuration(TXBC) */
>> +#define TXBC_NDTB_OFF	16
>> +#define TXBC_NDTB_MASK	0x3f
>> +
>> +/* Tx Buffer Element Size Configuration(TXESC) */
>> +#define TXESC_TBDS_8BYTES	0x0
>> +/* Tx Buffer Element */
>> +#define TX_BUF_XTD	BIT(30)
>> +#define TX_BUF_RTR	BIT(29)
>> +
>> +/* Rx Buffer Element Size Configuration(TXESC) */
>> +#define M_CAN_RXESC_8BYTES	0x0
>> +/* Tx Buffer Element */
>> +#define RX_BUF_ESI	BIT(31)
>> +#define RX_BUF_XTD	BIT(30)
>> +#define RX_BUF_RTR	BIT(29)
>> +
>> +/* Tx Event FIFO Con.guration (TXEFC) */
>> +#define TXEFC_EFS_OFF	16
>> +#define TXEFC_EFS_MASK	0x3f
>> +
>> +/* Message RAM Configuration (in bytes) */
>> +#define SIDF_ELEMENT_SIZE	4
>> +#define XIDF_ELEMENT_SIZE	8
>> +#define RXF0_ELEMENT_SIZE	16
>> +#define RXF1_ELEMENT_SIZE	16
>> +#define RXB_ELEMENT_SIZE	16
>> +#define TXE_ELEMENT_SIZE	8
>> +#define TXB_ELEMENT_SIZE	16
>> Alignment for all the includes
>>
> What do you mean?
>
I mean all the #define from top not aligned.
It would be looks good if aligned properly.

Give common tab spaces for all the #defines...

>>> +
>>> +/* address offset and element number for each FIFO/Buffer in the Message RAM */
>>> +struct mram_cfg {
>>> +	u16 off;
>>> +	u8  num;
>>> +};
>>> +
>>> +/* m_can private data structure */
>>> +struct m_can_priv {
>>> +	struct can_priv can;	/* must be the first member */
>>> +	struct napi_struct napi;
>>> +	struct net_device *dev;
>>> +	struct device *device;
>>> +	struct clk *hclk;
>>> +	struct clk *cclk;
>>> +	void __iomem *base;
>>> +	u32 irqstatus;
>>> +
>>> +	/* message ram configuration */
>>> +	void __iomem *mram_base;
>>> +	struct mram_cfg mcfg[MRAM_CFG_NUM];
>>> +};
>>> +
>>> +static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
>>> +{
>>> +	return readl(priv->base + reg);
>>> +}
>>> +
>>> +static inline void m_can_write(const struct m_can_priv *priv,
>>> +			       enum m_can_reg reg, u32 val)
>>> +{
>>> +	writel(val, priv->base + reg);
>>> +}
>>> +
>>> +static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>>> +				  u32 fgi, unsigned int offset)
>>> +{
>>> +	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>>> +				fgi * RXF0_ELEMENT_SIZE + offset);
>> Here alignment should match the open parenthesis.
>> ...
>> return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>> 	     fgi * RXF0_ELEMENT_SIZE + offset);
>>
> I've fixed all checkpatch warnings.
> I don't know why this line is not reported, as well as some other lines
> you pointed out.
>
> Do you know the reason?

I dont know the reason... May be 'Joe Perches <joe@perches.com>' can answer this question.

We can intimate this to the maintainer of checkpatch.pl

>>> +}
>>> +
>>> +static inline void m_can_config_endisable(const struct m_can_priv *priv,
>>> +					  bool enable)
>>> +{
>>> +	u32 cccr = m_can_read(priv, M_CAN_CCCR);
>>> +	u32 timeout = 10;
>>> +	u32 val = 0;
>>> +
>>> +	if (enable) {
>>> +		/* enable m_can configuration */
>>> +		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>>> +		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
>>> +		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
>>> +	} else {
>>> +		m_can_write(priv, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
>>> +	}
>>> +
>>> +	/* there's a delay for module initialization */
>>> +	if (enable)
>>> +		val = CCCR_INIT | CCCR_CCE;
>>> +
>>> +	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE))
>>> +				!= val)
>> Ditto..
>>
>>>   {
>>> +		if (timeout == 0) {
>>> +			netdev_warn(priv->dev, "Failed to init module\n");
>>> +			return;
>>> +		}
>>> +		timeout--;
>>> +		udelay(1);
>>> +	}
>>> +}
>>> +
>>> +static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
>>> +{
>>> +	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
>>> +}
>>> +
>>> +static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
>>> +{
>>> +	m_can_write(priv, M_CAN_ILE, 0x0);
>>> +}
>>> +
>>> +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
>>> +			    u32 rxfs)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	u32 flags, fgi;
>>> +
>>> +	/* calculate the fifo get index for where to read data */
>>> +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
>>> +	flags = m_can_fifo_read(priv, fgi, 0x0);
>>> +	if (flags & RX_BUF_XTD)
>>> +		cf->can_id = (flags & CAN_EFF_MASK) | CAN_EFF_FLAG;
>>> +	else
>>> +		cf->can_id = (flags >> 18) & CAN_SFF_MASK;
>>> +
>>> +	if (flags & RX_BUF_RTR) {
>>> +		cf->can_id |= CAN_RTR_FLAG;
>>> +	} else {
>>> +		flags = m_can_fifo_read(priv, fgi, 0x4);
>>> +		cf->can_dlc = get_can_dlc((flags >> 16) & 0x0F);
>>> +		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi, 0x8);
>>> +		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi, 0xC);
>>> +	}
>>> +
>>> +	/* acknowledge rx fifo 0 */
>>> +	m_can_write(priv, M_CAN_RXF0A, fgi);
>>> +}
>>> +
>>> +static int m_can_do_rx_poll(struct net_device *dev, int quota)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	struct net_device_stats *stats = &dev->stats;
>>> +	struct sk_buff *skb;
>>> +	struct can_frame *frame;
>>> +	u32 pkts = 0;
>>> +	u32 rxfs;
>>> +
>>> +	rxfs = m_can_read(priv, M_CAN_RXF0S);
>>> +	if (!(rxfs & RXFS_FFL_MASK)) {
>>> +		netdev_dbg(dev, "no messages in fifo0\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
>>> +		if (rxfs & RXFS_RFL)
>>> +			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
>>> +
>>> +		skb = alloc_can_skb(dev, &frame);
>>> +		if (!skb) {
>>> +			stats->rx_dropped++;
>>> +			return 0;
>>> +		}
>>> +
>>> +		m_can_read_fifo(dev, frame, rxfs);
>>> +
>>> +		stats->rx_packets++;
>>> +		stats->rx_bytes += frame->can_dlc;
>>> +
>>> +		netif_receive_skb(skb);
>>> +
>>> +		quota--;
>>> +		pkts++;
>>> +		rxfs = m_can_read(priv, M_CAN_RXF0S);
>>> +	};
>>> +
>>> +	if (pkts)
>>> +		can_led_event(dev, CAN_LED_EVENT_RX);
>>> +
>>> +	return pkts;
>>> +}
>>> +
>>> +static int m_can_handle_lost_msg(struct net_device *dev)
>>> +{
>>> +	struct net_device_stats *stats = &dev->stats;
>>> +	struct sk_buff *skb;
>>> +	struct can_frame *frame;
>>> +
>>> +	netdev_err(dev, "msg lost in rxf0\n");
>>> +
>>> +	stats->rx_errors++;
>>> +	stats->rx_over_errors++;
>>> +
>>> +	skb = alloc_can_err_skb(dev, &frame);
>>> +	if (unlikely(!skb))
>>> +		return 0;
>>> +
>>> +	frame->can_id |= CAN_ERR_CRTL;
>>> +	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
>>> +
>>> +	netif_receive_skb(skb);
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static int m_can_handle_lec_err(struct net_device *dev,
>>> +				enum m_can_lec_type lec_type)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	struct net_device_stats *stats = &dev->stats;
>>> +	struct can_frame *cf;
>>> +	struct sk_buff *skb;
>>> +
>>> +	/* early exit if no lec update */
>>> +	if (lec_type == LEC_UNUSED)
>>> +		return 0;
>>> +
>>> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>>> +		return 0;
>>> +
>>> +	priv->can.can_stats.bus_error++;
>>> +	stats->rx_errors++;
>>> +
>>> +	/* propagate the error condition to the CAN stack */
>>> +	skb = alloc_can_err_skb(dev, &cf);
>>> +	if (unlikely(!skb))
>>> +		return 0;
>>> +
>>> +	/* check for 'last error code' which tells us the
>>> +	 * type of the last error to occur on the CAN bus
>>> +	 */
>>> +	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
>>> +	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
>>> +
>>> +	switch (lec_type) {
>>> +	case LEC_STUFF_ERROR:
>>> +		netdev_dbg(dev, "stuff error\n");
>>> +		cf->data[2] |= CAN_ERR_PROT_STUFF;
>>> +		break;
>>> +	case LEC_FORM_ERROR:
>>> +		netdev_dbg(dev, "form error\n");
>>> +		cf->data[2] |= CAN_ERR_PROT_FORM;
>>> +		break;
>>> +	case LEC_ACK_ERROR:
>>> +		netdev_dbg(dev, "ack error\n");
>>> +		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
>>> +				CAN_ERR_PROT_LOC_ACK_DEL);
>>> +		break;
>>> +	case LEC_BIT1_ERROR:
>>> +		netdev_dbg(dev, "bit1 error\n");
>>> +		cf->data[2] |= CAN_ERR_PROT_BIT1;
>>> +		break;
>>> +	case LEC_BIT0_ERROR:
>>> +		netdev_dbg(dev, "bit0 error\n");
>>> +		cf->data[2] |= CAN_ERR_PROT_BIT0;
>>> +		break;
>>> +	case LEC_CRC_ERROR:
>>> +		netdev_dbg(dev, "CRC error\n");
>>> +		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
>>> +				CAN_ERR_PROT_LOC_CRC_DEL);
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	stats->rx_packets++;
>>> +	stats->rx_bytes += cf->can_dlc;
>>> +	netif_receive_skb(skb);
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static int m_can_get_berr_counter(const struct net_device *dev,
>>> +				  struct can_berr_counter *bec)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	unsigned int ecr;
>>> +	int err;
>>> +
>>> +	err = clk_prepare_enable(priv->hclk);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	err = clk_prepare_enable(priv->cclk);
>>> +	if (err) {
>>> +		clk_disable_unprepare(priv->hclk);
>>> +		return err;
>>> +	}
>>> +
>>> +	ecr = m_can_read(priv, M_CAN_ECR);
>>> +	bec->rxerr = (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
>>> +	bec->txerr = ecr & ECR_TEC_MASK;
>>> +
>>> +	clk_disable_unprepare(priv->cclk);
>>> +	clk_disable_unprepare(priv->hclk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int m_can_handle_state_change(struct net_device *dev,
>>> +				     enum can_state new_state)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	struct net_device_stats *stats = &dev->stats;
>>> +	struct can_frame *cf;
>>> +	struct sk_buff *skb;
>>> +	struct can_berr_counter bec;
>>> +	unsigned int ecr;
>>> +
>>> +	switch (new_state) {
>>> +	case CAN_STATE_ERROR_ACTIVE:
>>> +		/* error warning state */
>>> +		priv->can.can_stats.error_warning++;
>>> +		priv->can.state = CAN_STATE_ERROR_WARNING;
>>> +		break;
>>> +	case CAN_STATE_ERROR_PASSIVE:
>>> +		/* error passive state */
>>> +		priv->can.can_stats.error_passive++;
>>> +		priv->can.state = CAN_STATE_ERROR_PASSIVE;
>>> +		break;
>>> +	case CAN_STATE_BUS_OFF:
>>> +		/* bus-off state */
>>> +		priv->can.state = CAN_STATE_BUS_OFF;
>>> +		m_can_disable_all_interrupts(priv);
>>> +		can_bus_off(dev);
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	/* propagate the error condition to the CAN stack */
>>> +	skb = alloc_can_err_skb(dev, &cf);
>>> +	if (unlikely(!skb))
>>> +		return 0;
>>> +
>>> +	m_can_get_berr_counter(dev, &bec);
>>> +
>>> +	switch (new_state) {
>>> +	case CAN_STATE_ERROR_ACTIVE:
>>> +		/* error warning state */
>>> +		cf->can_id |= CAN_ERR_CRTL;
>>> +		cf->data[1] = (bec.txerr > bec.rxerr) ?
>>> +			CAN_ERR_CRTL_TX_WARNING :
>>> +			CAN_ERR_CRTL_RX_WARNING;
>>> +		cf->data[6] = bec.txerr;
>>> +		cf->data[7] = bec.rxerr;
>>> +		break;
>>> +	case CAN_STATE_ERROR_PASSIVE:
>>> +		/* error passive state */
>>> +		cf->can_id |= CAN_ERR_CRTL;
>>> +		ecr = m_can_read(priv, M_CAN_ECR);
>>> +		if (ecr & ECR_RP)
>>> +			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
>>> +		if (bec.txerr > 127)
>>> +			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
>>> +		cf->data[6] = bec.txerr;
>>> +		cf->data[7] = bec.rxerr;
>>> +		break;
>>> +	case CAN_STATE_BUS_OFF:
>>> +		/* bus-off state */
>>> +		cf->can_id |= CAN_ERR_BUSOFF;
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	stats->rx_packets++;
>>> +	stats->rx_bytes += cf->can_dlc;
>>> +	netif_receive_skb(skb);
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	int work_done = 0;
>>> +
>>> +	if ((psr & PSR_EW) &&
>>> +	    (priv->can.state != CAN_STATE_ERROR_WARNING)) {
>>> +		netdev_dbg(dev, "entered error warning state\n");
>>> +		work_done += m_can_handle_state_change(dev,
>>> +				CAN_STATE_ERROR_WARNING);
>> Ditto
>>
>>> +	}
>>> +
>>> +	if ((psr & PSR_EP) &&
>>> +	    (priv->can.state != CAN_STATE_ERROR_PASSIVE)) {
>>> +		netdev_dbg(dev, "entered error warning state\n");
>>> +		work_done += m_can_handle_state_change(dev,
>>> +				CAN_STATE_ERROR_PASSIVE);
>>> +	}
>>> +
>> Ditto
>>
>>> +	if ((psr & PSR_BO) &&
>>> +	    (priv->can.state != CAN_STATE_BUS_OFF)) {
>>> +		netdev_dbg(dev, "entered error warning state\n");
>>> +		work_done += m_can_handle_state_change(dev,
>>> +				CAN_STATE_BUS_OFF);
>> Ditto
>>
>>> +	}
>>> +
>>> +	return work_done;
>>> +}
>>> +
>>> +static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
>>> +{
>>> +	if (irqstatus & IR_WDI)
>>> +		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
>>> +	if (irqstatus & IR_BEU)
>>> +		netdev_err(dev, "Error Logging Overflow\n");
>>> +	if (irqstatus & IR_BEU)
>>> +		netdev_err(dev, "Bit Error Uncorrected\n");
>>> +	if (irqstatus & IR_BEC)
>>> +		netdev_err(dev, "Bit Error Corrected\n");
>>> +	if (irqstatus & IR_TOO)
>>> +		netdev_err(dev, "Timeout reached\n");
>>> +	if (irqstatus & IR_MRAF)
>>> +		netdev_err(dev, "Message RAM access failure occurred\n");
>>> +}
>>> +
>>> +static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
>>> +				   u32 psr)
>>> +{
>>> +	int work_done = 0;
>>> +
>>> +	if (irqstatus & IR_RF0L)
>>> +		work_done += m_can_handle_lost_msg(dev);
>>> +
>>> +	/* handle lec errors on the bus */
>>> +	if (psr & LEC_UNUSED)
>>> +		work_done += m_can_handle_lec_err(dev,
>>> +				psr & LEC_UNUSED);
>> Ditto
>>
> Checkpatch not report them....
>
>>> +
>>> +	/* other unproccessed error interrupts */
>>> +	m_can_handle_other_err(dev, irqstatus);
>>> +
>>> +	return work_done;
>>> +}
>>> +
>>> +static int m_can_poll(struct napi_struct *napi, int quota)
>>> +{
>>> +	struct net_device *dev = napi->dev;
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	int work_done = 0;
>>> +	u32 irqstatus, psr;
>>> +
>>> +	irqstatus = priv->irqstatus | m_can_read(priv, M_CAN_IR);
>>> +	if (!irqstatus)
>>> +		goto end;
>>> +
>>> +	psr = m_can_read(priv, M_CAN_PSR);
>>> +	if (irqstatus & IR_ERR_STATE)
>>> +		work_done += m_can_handle_state_errors(dev, psr);
>>> +
>>> +	if (irqstatus & IR_ERR_BUS)
>>> +		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
>>> +
>>> +	if (irqstatus & IR_RF0N)
>>> +		work_done += m_can_do_rx_poll(dev, (quota - work_done));
>>> +
>>> +	if (work_done < quota) {
>>> +		napi_complete(napi);
>>> +		m_can_enable_all_interrupts(priv);
>>> +	}
>>> +
>>> +end:
>>> +	return work_done;
>>> +}
>>> +
>>> +static irqreturn_t m_can_isr(int irq, void *dev_id)
>>> +{
>>> +	struct net_device *dev = (struct net_device *)dev_id;
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	struct net_device_stats *stats = &dev->stats;
>>> +	u32 ir;
>>> +
>>> +	ir = m_can_read(priv, M_CAN_IR);
>>> +	if (!ir)
>>> +		return IRQ_NONE;
>>> +
>>> +	/* ACK all irqs */
>>> +	if (ir & IR_ALL_INT)
>>> +		m_can_write(priv, M_CAN_IR, ir);
>>> +
>>> +	/* schedule NAPI in case of
>>> +	 * - rx IRQ
>>> +	 * - state change IRQ
>>> +	 * - bus error IRQ and bus error reporting
>>> +	 */
>>> +	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL)) {
>>> +		priv->irqstatus = ir;
>>> +		m_can_disable_all_interrupts(priv);
>>> +		napi_schedule(&priv->napi);
>>> +	}
>>> +
>>> +	/* transmission complete interrupt */
>>> +	if (ir & IR_TC) {
>>> +		stats->tx_bytes += can_get_echo_skb(dev, 0);
>>> +		stats->tx_packets++;
>>> +		can_led_event(dev, CAN_LED_EVENT_TX);
>>> +		netif_wake_queue(dev);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static const struct can_bittiming_const m_can_bittiming_const = {
>>> +	.name = KBUILD_MODNAME,
>>> +	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
>>> +	.tseg1_max = 64,
>>> +	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
>>> +	.tseg2_max = 16,
>>> +	.sjw_max = 16,
>>> +	.brp_min = 1,
>>> +	.brp_max = 1024,
>>> +	.brp_inc = 1,
>>> +};
>>> +
>>> +static int m_can_set_bittiming(struct net_device *dev)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	const struct can_bittiming *bt = &priv->can.bittiming;
>>> +	u16 brp, sjw, tseg1, tseg2;
>>> +	u32 reg_btp;
>>> +
>>> +	brp = bt->brp - 1;
>>> +	sjw = bt->sjw - 1;
>>> +	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
>>> +	tseg2 = bt->phase_seg2 - 1;
>>> +	reg_btp = (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
>>> +			(tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
>>> +	m_can_write(priv, M_CAN_BTP, reg_btp);
>>> +	netdev_dbg(dev, "setting BTP 0x%x\n", reg_btp);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/* Configure M_CAN chip:
>>> + * - set rx buffer/fifo element size
>>> + * - configure rx fifo
>>> + * - accept non-matching frame into fifo 0
>>> + * - configure tx buffer
>>> + * - configure mode
>>> + * - setup bittiming
>>> + */
>>> +static void m_can_chip_config(struct net_device *dev)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +	u32 cccr, test;
>>> +
>>> +	m_can_config_endisable(priv, true);
>>> +
>>> +	/* RX Buffer/FIFO Element Size 8 bytes data field */
>>> +	m_can_write(priv, M_CAN_RXESC, M_CAN_RXESC_8BYTES);
>>> +
>>> +	/* Accept Non-matching Frames Into FIFO 0 */
>>> +	m_can_write(priv, M_CAN_GFC, 0x0);
>>> +
>>> +	/* only support one Tx Buffer currently */
>>> +	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_OFF) |
>>> +			priv->mcfg[MRAM_TXB].off);
>>> +
>>> +	/* only support 8 bytes firstly */
>>> +	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_8BYTES);
>>> +
>>> +	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_OFF) |
>>> +			priv->mcfg[MRAM_TXE].off);
>>> +
>>> +	/* rx fifo configuration, blocking mode, fifo size 1 */
>>> +	m_can_write(priv, M_CAN_RXF0C,
>>> +		    (priv->mcfg[MRAM_RXF0].num << RXFC_FS_OFF) |
>>> +		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF0].off);
>>> +
>>> +	m_can_write(priv, M_CAN_RXF1C,
>>> +		    (priv->mcfg[MRAM_RXF1].num << RXFC_FS_OFF) |
>>> +		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
>>> +
>>> +	cccr = m_can_read(priv, M_CAN_CCCR);
>>> +	cccr &= ~(CCCR_TEST | CCCR_MON);
>>> +	test = m_can_read(priv, M_CAN_TEST);
>>> +	test &= ~TEST_LBCK;
>>> +
>>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>>> +		cccr |= CCCR_MON;
>>> +
>>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>>> +		cccr |= CCCR_TEST;
>>> +		test |= TEST_LBCK;
>>> +	}
>>> +
>>> +	m_can_write(priv, M_CAN_CCCR, cccr);
>>> +	m_can_write(priv, M_CAN_TEST, test);
>>> +
>>> +	/* enable interrupts */
>>> +	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
>>> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>>> +		m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC);
>>> +	else
>>> +		m_can_write(priv, M_CAN_IE, IR_ALL_INT);
>>> +
>>> +	/* route all interrupts to INT0 */
>>> +	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
>>> +
>>> +	/* set bittiming params */
>>> +	m_can_set_bittiming(dev);
>>> +
>>> +	m_can_config_endisable(priv, false);
>>> +}
>>> +
>>> +static void m_can_start(struct net_device *dev)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +
>>> +	/* basic m_can configuration */
>>> +	m_can_chip_config(dev);
>>> +
>>> +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>>> +
>>> +	m_can_enable_all_interrupts(priv);
>>> +}
>>> +
>>> +static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>>> +{
>>> +	switch (mode) {
>>> +	case CAN_MODE_START:
>>> +		m_can_start(dev);
>>> +		netif_wake_queue(dev);
>>> +		break;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>> I think for single we don't need switch case...
>>
> It's easy for extend to support other modes.
> This is also the same as other exist drivers.

If you are sure that few more modes can come in the future, its good
otherwise better to change....


-- 
Regards,
Varka Bhadram.

