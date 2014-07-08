From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
Date: Tue, 8 Jul 2014 18:33:12 +0800
Message-ID: <20140708103311.GB21754@shlinux1.ap.freescale.net>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com>
 <53B6A3B0.4020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:18427
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753645AbaGHKf6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 Jul 2014 06:35:58 -0400
Content-Disposition: inline
In-Reply-To: <53B6A3B0.4020509@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, Jul 04, 2014 at 06:23:04PM +0530, Varka Bhadram wrote:
> On 07/04/2014 05:23 PM, Dong Aisheng wrote:
> >The patch adds the basic CAN TX/RX function support for Bosch M_CAN controller.
> >For TX, only one dedicated tx buffer is used for sending data.
> >For RX, RXFIFO 0 is used for receiving data to avoid overflow.
> >Rx FIFO 1 and Rx Buffers are not used currently, as well as Tx Event FIFO.
> >
> >Due to the message ram can be shared by multi m_can instances
> >and the fifo element is configurable which is SoC dependant,
> >the design is to parse the message ram related configuration data from device
> >tree rather than hardcode define it in driver which can make the message
> >ram sharing fully transparent to M_CAN controller driver,
> >then we can gain better driver maintainability and future features upgrade.
> >
> >M_CAN also supports CANFD protocol features like data payload up to 64 bytes
> >and bitrate switch at runtime, however, this patch still does not add the
> >support for these features.
> >
> >Signed-off-by: Dong Aisheng <b29396@freescale.com>
> >---
> >Changes since v1:
> >Addressed all comments from Mark Rutland, Hartkopp and Marc Kleine-Budde
> >- merge three patches into one
> >- create directory drivers/net/can/m_can
> >- improve binding doc
> >- make sure using valid pointer before netif_receive_skb(skb)
> >- remove debug info a bit
> >- let the stats are updated even if alloc_can_err_skb() fails
> >- other small fixes
> >
> >Test result:
> >Passed over night can-utils/canfdtest stress test on iMX6SX SDB board.
> >
> >---
> >  .../devicetree/bindings/net/can/m_can.txt          |   65 ++
> >  drivers/net/can/Kconfig                            |    2 +
> >  drivers/net/can/Makefile                           |    1 +
> >  drivers/net/can/m_can/Kconfig                      |    4 +
> >  drivers/net/can/m_can/Makefile                     |    7 +
> >  drivers/net/can/m_can/m_can.c                      | 1136 ++++++++++++++++++++
> >  6 files changed, 1215 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> >  create mode 100644 drivers/net/can/m_can/Kconfig
> >  create mode 100644 drivers/net/can/m_can/Makefile
> >  create mode 100644 drivers/net/can/m_can/m_can.c
> >
> [...]
> 
> >+static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
> >+{
> >+	return readl(priv->base + reg);
> >+}
> >+
> >+static inline void m_can_write(const struct m_can_priv *priv,
> >+				enum m_can_reg reg, u32 val)
> 
> Alignment should match open parenthesis....  :-)
> 
[...]
> >+	/* propagate the error condition to the CAN stack */
> >+	skb = alloc_can_err_skb(dev, &cf);
> >+	if (unlikely(!skb))
> >+		return 0;
> >+
> >+	/*
> >+	 * check for 'last error code' which tells us the
> >+	 * type of the last error to occur on the CAN bus
> >+	 */
> 
> networking block comments don't use an empty /* line, use /* Comment
> 

I noticed there's a lot exist driver does not following this rule.
But i think it's fine for me to address them for this new driver.
So, will fix them all!
Thanks for reminder.

Regards
Dong Aisheng


> >+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> >+	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
> >+
> >+	switch (lec_type) {
> >+	case LEC_STUFF_ERROR:
> >+		netdev_dbg(dev, "stuff error\n");
> >+		cf->data[2] |= CAN_ERR_PROT_STUFF;
> >+		break;
> >+	case LEC_FORM_ERROR:
> >+		netdev_dbg(dev, "form error\n");
> >+		cf->data[2] |= CAN_ERR_PROT_FORM;
> >+		break;
> >+	case LEC_ACK_ERROR:
> >+		netdev_dbg(dev, "ack error\n");
> >+		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
> >+				CAN_ERR_PROT_LOC_ACK_DEL);
> >+		break;
> >+	case LEC_BIT1_ERROR:
> >+		netdev_dbg(dev, "bit1 error\n");
> >+		cf->data[2] |= CAN_ERR_PROT_BIT1;
> >+		break;
> >+	case LEC_BIT0_ERROR:
> >+		netdev_dbg(dev, "bit0 error\n");
> >+		cf->data[2] |= CAN_ERR_PROT_BIT0;
> >+		break;
> >+	case LEC_CRC_ERROR:
> >+		netdev_dbg(dev, "CRC error\n");
> >+		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
> >+				CAN_ERR_PROT_LOC_CRC_DEL);
> >+		break;
> >+	default:
> >+		break;
> >+	}
> >+
> >+	stats->rx_packets++;
> >+	stats->rx_bytes += cf->can_dlc;
> >+	netif_receive_skb(skb);
> >+
> >+	return 1;
> >+}
> >+
> >+static int m_can_get_berr_counter(const struct net_device *dev,
> >+				  struct can_berr_counter *bec)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	unsigned int ecr;
> >+
> >+	clk_prepare_enable(priv->hclk);
> >+	clk_prepare_enable(priv->cclk);
> >+
> >+	ecr = m_can_read(priv, M_CAN_ECR);
> >+	bec->rxerr = (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
> >+	bec->txerr = ecr & ECR_TEC_MASK;
> >+
> >+	clk_disable_unprepare(priv->hclk);
> >+	clk_disable_unprepare(priv->cclk);
> >+
> >+	return 0;
> >+}
> >+
> >+static int m_can_handle_state_change(struct net_device *dev,
> >+				enum can_state new_state)
> 
> Alignment should match open parenthesis
> 
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	struct net_device_stats *stats = &dev->stats;
> >+	struct can_frame *cf;
> >+	struct sk_buff *skb;
> >+	struct can_berr_counter bec;
> >+	unsigned int ecr;
> >+
> >+	switch (new_state) {
> >+	case CAN_STATE_ERROR_ACTIVE:
> >+		/* error warning state */
> >+		priv->can.can_stats.error_warning++;
> >+		priv->can.state = CAN_STATE_ERROR_WARNING;
> >+		break;
> >+	case CAN_STATE_ERROR_PASSIVE:
> >+		/* error passive state */
> >+		priv->can.can_stats.error_passive++;
> >+		priv->can.state = CAN_STATE_ERROR_PASSIVE;
> >+		break;
> >+	case CAN_STATE_BUS_OFF:
> >+		/* bus-off state */
> >+		priv->can.state = CAN_STATE_BUS_OFF;
> >+		m_can_disable_all_interrupts(priv);
> >+		can_bus_off(dev);
> >+		break;
> >+	default:
> >+		break;
> >+	}
> >+
> >+	/* propagate the error condition to the CAN stack */
> >+	skb = alloc_can_err_skb(dev, &cf);
> >+	if (unlikely(!skb))
> >+		return 0;
> >+
> >+	m_can_get_berr_counter(dev, &bec);
> >+
> >+	switch (new_state) {
> >+	case CAN_STATE_ERROR_ACTIVE:
> >+		/* error warning state */
> >+		cf->can_id |= CAN_ERR_CRTL;
> >+		cf->data[1] = (bec.txerr > bec.rxerr) ?
> >+			CAN_ERR_CRTL_TX_WARNING :
> >+			CAN_ERR_CRTL_RX_WARNING;
> >+		cf->data[6] = bec.txerr;
> >+		cf->data[7] = bec.rxerr;
> >+		break;
> >+	case CAN_STATE_ERROR_PASSIVE:
> >+		/* error passive state */
> >+		cf->can_id |= CAN_ERR_CRTL;
> >+		ecr = m_can_read(priv, M_CAN_ECR);
> >+		if (ecr & ECR_RP)
> >+			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
> >+		if (bec.txerr > 127)
> >+			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
> >+		cf->data[6] = bec.txerr;
> >+		cf->data[7] = bec.rxerr;
> >+		break;
> >+	case CAN_STATE_BUS_OFF:
> >+		/* bus-off state */
> >+		cf->can_id |= CAN_ERR_BUSOFF;
> >+		break;
> >+	default:
> >+		break;
> >+	}
> >+
> >+	stats->rx_packets++;
> >+	stats->rx_bytes += cf->can_dlc;
> >+	netif_receive_skb(skb);
> >+
> >+	return 1;
> >+}
> >+
> >+static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	int work_done = 0;
> >+
> >+	if ((psr & PSR_EW) &&
> >+		(priv->can.state != CAN_STATE_ERROR_WARNING))
> 
> Alignment should match open parenthesis
> 
> >  {
> >+		netdev_dbg(dev, "entered error warning state\n");
> >+		work_done += m_can_handle_state_change(dev,
> >+				CAN_STATE_ERROR_WARNING);
> >+	}
> >+
> >+	if ((psr & PSR_EP) &&
> >+		(priv->can.state != CAN_STATE_ERROR_PASSIVE))
> 
> Alignment should match open parenthesis
> 
> >  {
> >+		netdev_dbg(dev, "entered error warning state\n");
> >+		work_done += m_can_handle_state_change(dev,
> >+				CAN_STATE_ERROR_PASSIVE);
> >+	}
> >+
> >+	if ((psr & PSR_BO) &&
> >+		(priv->can.state != CAN_STATE_BUS_OFF))
> 
> Alignment should match open parenthesis
> 
> >  {
> >+		netdev_dbg(dev, "entered error warning state\n");
> >+		work_done += m_can_handle_state_change(dev,
> >+				CAN_STATE_BUS_OFF);
> >+	}
> >+
> >+	return work_done;
> >+}
> >+
> >+static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
> >+							u32 psr)
> 
> Alignment should match open parenthesis
> 
> >+{
> >+	int work_done = 0;
> >+
> >+	if (irqstatus & IR_RF0L)
> >+		work_done += m_can_handle_lost_msg(dev);
> >+
> >+	/* handle lec errors on the bus */
> >+	if (psr & LEC_UNUSED)
> >+		work_done += m_can_handle_lec_err(dev,
> >+				psr & LEC_UNUSED);
> >+
> >+	/* other unproccessed error interrupts */
> >+	if (irqstatus & IR_WDI)
> >+		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
> >+	if (irqstatus & IR_TOO)
> >+		netdev_err(dev, "Timeout reached\n");
> >+	if (irqstatus & IR_MRAF)
> >+		netdev_err(dev, "Message RAM access failure occurred\n");
> >+
> >+	return work_done;
> >+}
> >+
> >+static int m_can_poll(struct napi_struct *napi, int quota)
> >+{
> >+	struct net_device *dev = napi->dev;
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	int work_done = 0;
> >+	u32 irqstatus, psr;
> >+
> >+	irqstatus = priv->irqstatus | m_can_read(priv, M_CAN_IR);
> >+	if (!irqstatus)
> >+		goto end;
> >+
> >+	psr = m_can_read(priv, M_CAN_PSR);
> >+	if (irqstatus & IR_ERR_STATE)
> >+		work_done += m_can_handle_state_errors(dev, psr);
> >+
> >+	if (irqstatus & IR_ERR_BUS)
> >+		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
> >+
> >+	if (irqstatus & IR_RF0N)
> >+		/* handle events corresponding to receive message objects */
> >+		work_done += m_can_do_rx_poll(dev, (quota - work_done));
> >+
> >+	if (work_done < quota) {
> >+		napi_complete(napi);
> >+		m_can_enable_all_interrupts(priv);
> >+	}
> >+
> >+end:
> >+	return work_done;
> >+}
> >+
> >+static irqreturn_t m_can_isr(int irq, void *dev_id)
> >+{
> >+	struct net_device *dev = (struct net_device *)dev_id;
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	struct net_device_stats *stats = &dev->stats;
> >+	u32 ir;
> >+
> >+	ir = m_can_read(priv, M_CAN_IR);
> >+	if (!ir)
> >+		return IRQ_NONE;
> >+
> >+	/* ACK all irqs */
> >+	if (ir & IR_ALL_INT)
> >+		m_can_write(priv, M_CAN_IR, ir);
> >+
> >+	/*
> >+	 * schedule NAPI in case of
> >+	 * - rx IRQ
> >+	 * - state change IRQ
> >+	 * - bus error IRQ and bus error reporting
> >+	 */
> 
> networking block comments don't use an empty /* line, use /* Comment
> 
> >+	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL)) {
> >+		priv->irqstatus = ir;
> >+		m_can_disable_all_interrupts(priv);
> >+		napi_schedule(&priv->napi);
> >+	}
> >+
> >+	/* transmission complete interrupt */
> >+	if (ir & IR_TC) {
> >+		stats->tx_bytes += can_get_echo_skb(dev, 0);
> >+		stats->tx_packets++;
> >+		can_led_event(dev, CAN_LED_EVENT_TX);
> >+		netif_wake_queue(dev);
> >+	}
> >+
> >+	return IRQ_HANDLED;
> >+}
> >+
> >+static const struct can_bittiming_const m_can_bittiming_const = {
> >+	.name = KBUILD_MODNAME,
> >+	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
> >+	.tseg1_max = 64,
> >+	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
> >+	.tseg2_max = 16,
> >+	.sjw_max = 16,
> >+	.brp_min = 1,
> >+	.brp_max = 1024,
> >+	.brp_inc = 1,
> >+};
> >+
> >+static int m_can_set_bittiming(struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	const struct can_bittiming *bt = &priv->can.bittiming;
> >+	u16 brp, sjw, tseg1, tseg2;
> >+	u32 reg_btp;
> >+
> >+	brp = bt->brp - 1;
> >+	sjw = bt->sjw - 1;
> >+	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
> >+	tseg2 = bt->phase_seg2 - 1;
> >+	reg_btp = (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
> >+			(tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
> >+	m_can_write(priv, M_CAN_BTP, reg_btp);
> >+	netdev_dbg(dev, "setting BTP 0x%x\n", reg_btp);
> >+
> >+	return 0;
> >+}
> >+
> >+/*
> >+ * Configure M_CAN chip:
> >+ * - set rx buffer/fifo element size
> >+ * - configure rx fifo
> >+ * - accept non-matching frame into fifo 0
> >+ * - configure tx buffer
> >+ * - configure mode
> >+ * - setup bittiming
> >+ */
> 
> networking block comments don't use an empty /* line, use /* Comment
> 
> >+static void m_can_chip_config(struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	u32 cccr, test;
> >+
> >+	m_can_config_endisable(priv, true);
> >+
> >+	/* RX Buffer/FIFO Element Size 8 bytes data field */
> >+	m_can_write(priv, M_CAN_RXESC, M_CAN_RXESC_8BYTES);
> >+
> >+	/* Accept Non-matching Frames Into FIFO 0 */
> >+	m_can_write(priv, M_CAN_GFC, 0x0);
> >+
> >+	/* only support one Tx Buffer currently */
> >+	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_OFF) |
> >+		(priv->mram_off + priv->txb_off));
> >+
> >+	/* only support 8 bytes firstly */
> >+	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_8BYTES);
> >+
> >+	m_can_write(priv, M_CAN_TXEFC, 0x00010000 |
> >+		(priv->mram_off + priv->txe_off));
> >+
> >+	/* rx fifo configuration, blocking mode, fifo size 1 */
> >+	m_can_write(priv, M_CAN_RXF0C, (priv->rxf0_elems << RXFC_FS_OFF) |
> >+		RXFC_FWM_1 | (priv->mram_off + priv->rxf0_off));
> >+
> >+	m_can_write(priv, M_CAN_RXF1C, (priv->rxf1_elems << RXFC_FS_OFF) |
> >+		RXFC_FWM_1 | (priv->mram_off + priv->rxf1_off));
> >+
> >+	cccr = m_can_read(priv, M_CAN_CCCR);
> >+	cccr &= ~(CCCR_TEST | CCCR_MON);
> >+	test = m_can_read(priv, M_CAN_TEST);
> >+	test &= ~TEST_LBCK;
> >+
> >+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> >+		cccr |= CCCR_MON;
> >+
> >+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> >+		cccr |= CCCR_TEST;
> >+		test |= TEST_LBCK;
> >+	}
> >+
> >+	m_can_write(priv, M_CAN_CCCR, cccr);
> >+	m_can_write(priv, M_CAN_TEST, test);
> >+
> >+	/* enable all interrupts */
> >+	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
> >+	m_can_write(priv, M_CAN_IE, IR_ALL_INT);
> >+	/* route all interrupts to INT0 */
> >+	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
> >+
> >+	/* set bittiming params */
> >+	m_can_set_bittiming(dev);
> >+
> >+	m_can_config_endisable(priv, false);
> >+}
> >+
> >+static void m_can_start(struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+
> >+	/* basic m_can configuration */
> >+	m_can_chip_config(dev);
> >+
> >+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> >+
> >+	m_can_enable_all_interrupts(priv);
> >+}
> >+
> >+static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
> >+{
> >+	switch (mode) {
> >+	case CAN_MODE_START:
> >+		m_can_start(dev);
> >+		netif_wake_queue(dev);
> >+		break;
> >+	default:
> >+		return -EOPNOTSUPP;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static void free_m_can_dev(struct net_device *dev)
> >+{
> >+	free_candev(dev);
> >+}
> >+
> >+static struct net_device *alloc_m_can_dev(void)
> >+{
> >+	struct net_device *dev;
> >+	struct m_can_priv *priv;
> >+
> >+	dev = alloc_candev(sizeof(struct m_can_priv), 1);
> >+	if (!dev)
> >+		return NULL;
> >+
> >+	priv = netdev_priv(dev);
> >+	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> >+
> >+	priv->dev = dev;
> >+	priv->can.bittiming_const = &m_can_bittiming_const;
> >+	priv->can.do_set_mode = m_can_set_mode;
> >+	priv->can.do_get_berr_counter = m_can_get_berr_counter;
> >+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> >+					CAN_CTRLMODE_LISTENONLY |
> >+					CAN_CTRLMODE_BERR_REPORTING;
> >+
> >+	return dev;
> >+}
> >+
> >+static int m_can_open(struct net_device *dev)
> >+{
> >+	int err;
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+
> >+	clk_prepare_enable(priv->hclk);
> >+	clk_prepare_enable(priv->cclk);
> >+
> >+	/* open the can device */
> >+	err = open_candev(dev);
> >+	if (err) {
> >+		netdev_err(dev, "failed to open can device\n");
> >+		goto exit_open_fail;
> >+	}
> >+
> >+	/* register interrupt handler */
> >+	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
> >+				dev);
> 
> Alignment should match open parenthesis
> 
> >+	if (err < 0) {
> >+		netdev_err(dev, "failed to request interrupt\n");
> >+		goto exit_irq_fail;
> >+	}
> >+
> >+	/* start the m_can controller */
> >+	m_can_start(dev);
> >+
> >+	can_led_event(dev, CAN_LED_EVENT_OPEN);
> >+	napi_enable(&priv->napi);
> >+	netif_start_queue(dev);
> >+
> >+	return 0;
> >+
> >+exit_irq_fail:
> >+	close_candev(dev);
> >+exit_open_fail:
> >+	clk_disable_unprepare(priv->hclk);
> >+	clk_disable_unprepare(priv->cclk);
> >+	return err;
> >+}
> >+
> >+static void m_can_stop(struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+
> >+	/* disable all interrupts */
> >+	m_can_disable_all_interrupts(priv);
> >+
> >+	clk_disable_unprepare(priv->hclk);
> >+	clk_disable_unprepare(priv->cclk);
> >+
> >+	/* set the state as STOPPED */
> >+	priv->can.state = CAN_STATE_STOPPED;
> >+}
> >+
> >+static int m_can_close(struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+
> >+	netif_stop_queue(dev);
> >+	napi_disable(&priv->napi);
> >+	m_can_stop(dev);
> >+	free_irq(dev->irq, dev);
> >+	close_candev(dev);
> >+	can_led_event(dev, CAN_LED_EVENT_STOP);
> >+
> >+	return 0;
> >+}
> >+
> >+static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> >+					struct net_device *dev)
> >+{
> >+	struct m_can_priv *priv = netdev_priv(dev);
> >+	struct can_frame *cf = (struct can_frame *)skb->data;
> >+	u32 flags = 0, id;
> >+	void __iomem *fifo_addr;
> >+
> >+	if (can_dropped_invalid_skb(dev, skb))
> >+		return NETDEV_TX_OK;
> >+
> >+	netif_stop_queue(dev);
> >+
> >+	if (cf->can_id & CAN_RTR_FLAG)
> >+		flags |= TX_BUF_RTR;
> >+
> >+	if (cf->can_id & CAN_EFF_FLAG) {
> >+		id = cf->can_id & CAN_EFF_MASK;
> >+		flags |= TX_BUF_XTD;
> >+	} else {
> >+		id = ((cf->can_id & CAN_SFF_MASK) << 18);
> >+	}
> >+
> >+	/* message ram configuration */
> >+	fifo_addr = priv->mram_base + priv->mram_off + priv->txb_off;
> >+	writel(id | flags, fifo_addr);
> >+	writel(cf->can_dlc << 16, fifo_addr + 0x4);
> >+	writel(*(u32 *)(cf->data + 0), fifo_addr + 0x8);
> >+	writel(*(u32 *)(cf->data + 4), fifo_addr + 0xc);
> >+
> >+	can_put_echo_skb(skb, dev, 0);
> >+
> >+	/* enable first TX buffer to start transfer  */
> >+	m_can_write(priv, M_CAN_TXBTIE, 0x1);
> >+	m_can_write(priv, M_CAN_TXBAR, 0x1);
> >+
> >+	return NETDEV_TX_OK;
> >+}
> >+
> >+static const struct net_device_ops m_can_netdev_ops = {
> >+	.ndo_open = m_can_open,
> >+	.ndo_stop = m_can_close,
> >+	.ndo_start_xmit = m_can_start_xmit,
> >+};
> >+
> >+static int register_m_can_dev(struct net_device *dev)
> >+{
> >+	dev->flags |= IFF_ECHO;	/* we support local echo */
> >+	dev->netdev_ops = &m_can_netdev_ops;
> >+
> >+	return register_candev(dev);
> >+}
> >+
> >+static const struct of_device_id m_can_of_table[] = {
> >+	{ .compatible = "bosch,m_can", .data = NULL },
> >+	{ /* sentinel */ },
> >+};
> >+MODULE_DEVICE_TABLE(of, m_can_of_table);
> >+
> >+static int m_can_of_parse_mram(struct platform_device *pdev,
> >+				struct m_can_priv *priv)
> 
> Alignment should match open parenthesis
> 
> >+{
> >+	struct device_node *np = pdev->dev.of_node;
> >+	struct resource *res;
> >+	void __iomem *addr;
> >+	u32 out_val[MRAM_CFG_LEN];
> >+	int ret;
> >+
> >+	/* message ram could be shared */
> >+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
> >+	if (!res)
> >+		return -ENODEV;
> >+
> >+	addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> >+	if (!addr)
> >+		return -ENODEV;
> >+
> >+	/* get message ram configuration */
> >+	ret = of_property_read_u32_array(np, "mram-cfg",
> >+				out_val, sizeof(out_val) / 4);
> 
> Alignment should match open parenthesis
> 
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "can not get message ram configuration\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	priv->mram_base = addr;
> >+	priv->mram_off = out_val[0];
> >+	priv->sidf_elems = out_val[1];
> >+	priv->sidf_off = priv->mram_off;
> >+	priv->xidf_elems = out_val[2];
> >+	priv->xidf_off = priv->sidf_off + priv->sidf_elems * SIDF_ELEMENT_SIZE;
> >+	priv->rxf0_elems = out_val[3] & RXFC_FS_MASK;
> >+	priv->rxf0_off = priv->xidf_off + priv->xidf_elems * XIDF_ELEMENT_SIZE;
> >+	priv->rxf1_elems = out_val[4] & RXFC_FS_MASK;
> >+	priv->rxf1_off = priv->rxf0_off + priv->rxf0_elems * RXF0_ELEMENT_SIZE;
> >+	priv->rxb_elems = out_val[5];
> >+	priv->rxb_off = priv->rxf1_off + priv->rxf1_elems * RXF1_ELEMENT_SIZE;
> >+	priv->txe_elems = out_val[6];
> >+	priv->txe_off = priv->rxb_off + priv->rxb_elems * RXB_ELEMENT_SIZE;
> >+	priv->txb_elems = out_val[7] & TXBC_NDTB_MASK;
> >+	priv->txb_off = priv->txe_off + priv->txe_elems * TXE_ELEMENT_SIZE;
> >+
> >+	dev_dbg(&pdev->dev, "mram_base =%p mram_off =0x%x "
> >+		"sidf %d xidf %d rxf0 %d rxf1 %d rxb %d txe %d txb %d\n",
> >+		priv->mram_base, priv->mram_off, priv->sidf_elems,
> >+		priv->xidf_elems, priv->rxf0_elems, priv->rxf1_elems,
> >+		priv->rxb_elems, priv->txe_elems, priv->txb_elems);
> 
> quoted string split across lines...
> 
> -- 
> Cheers,
> Varka Bhadram.
> 
