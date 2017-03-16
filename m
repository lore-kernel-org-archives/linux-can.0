From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/3] can: m_can: Support M_CAN IP versions > v3.0.x
Date: Thu, 16 Mar 2017 09:41:59 +0100
Message-ID: <45aab7ca-1da9-14f4-286c-b85adc168b9e@hartkopp.net>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-3-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:15897 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdCPInH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 04:43:07 -0400
In-Reply-To: <1489154417-19669-3-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org



On 10.03.2017 15:00, Mario Huettel wrote:
> This patch includes following changes:
>
> * Renamed the register defines of the M_CAN to fit version 3.1.x and above.
> * Replaced the old defines with the new ones in the whole code.
> * Removed code that enabled interrupt line 1. The driver didn't use it.
> * Removed initialization of FIFO water marks. They were not used.
>
> Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>  drivers/net/can/m_can/m_can.c | 197 +++++++++++++++++++++++++++---------------
>  1 file changed, 129 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 7a6554e..f2656a3 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -37,17 +37,19 @@ enum m_can_reg {
>  	M_CAN_CREL	= 0x0,
>  	M_CAN_ENDN	= 0x4,
>  	M_CAN_CUST	= 0x8,
> -	M_CAN_FBTP	= 0xc,
> +	M_CAN_DBTP	= 0xc,
>  	M_CAN_TEST	= 0x10,
>  	M_CAN_RWD	= 0x14,
>  	M_CAN_CCCR	= 0x18,
> -	M_CAN_BTP	= 0x1c,
> +	M_CAN_NBTP	= 0x1c,
>  	M_CAN_TSCC	= 0x20,
>  	M_CAN_TSCV	= 0x24,
>  	M_CAN_TOCC	= 0x28,
>  	M_CAN_TOCV	= 0x2c,
>  	M_CAN_ECR	= 0x40,
>  	M_CAN_PSR	= 0x44,
> +/* TDCR Register only available for version >=3.1.x */
> +	M_CAN_TDCR	= 0x48,
>  	M_CAN_IR	= 0x50,
>  	M_CAN_IE	= 0x54,
>  	M_CAN_ILS	= 0x58,
> @@ -105,21 +107,21 @@ enum m_can_mram_cfg {
>  	MRAM_CFG_NUM,
>  };
>
> -/* Fast Bit Timing & Prescaler Register (FBTP) */
> -#define FBTR_FBRP_MASK		0x1f
> -#define FBTR_FBRP_SHIFT		16
> -#define FBTR_FTSEG1_SHIFT	8
> -#define FBTR_FTSEG1_MASK	(0xf << FBTR_FTSEG1_SHIFT)
> -#define FBTR_FTSEG2_SHIFT	4
> -#define FBTR_FTSEG2_MASK	(0x7 << FBTR_FTSEG2_SHIFT)
> -#define FBTR_FSJW_SHIFT		0
> -#define FBTR_FSJW_MASK		0x3
> +/* Data Bit Timing & Prescaler Register (DBTP) */
> +#define DBTP_TDC		BIT(23)
> +#define DBTP_DBRP_SHIFT		16
> +#define DBTP_DBRP_MASK		(0x1f << DBTP_DBRP_SHIFT)
> +#define DBTP_DTSEG1_SHIFT	8
> +#define DBTP_DTSEG1_MASK	(0x1f << DBTP_DTSEG1_SHIFT)
> +#define DBTP_DTSEG2_SHIFT	4
> +#define DBTP_DTSEG2_MASK	(0xf << DBTP_DTSEG2_SHIFT)
> +#define DBTP_DSJW_SHIFT		0
> +#define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
>
>  /* Test Register (TEST) */
> -#define TEST_LBCK	BIT(4)
> +#define TEST_LBCK		BIT(4)
>
>  /* CC Control Register(CCCR) */
> -#define CCCR_TEST		BIT(7)
>  #define CCCR_CMR_MASK		0x3
>  #define CCCR_CMR_SHIFT		10
>  #define CCCR_CMR_CANFD		0x1
> @@ -130,21 +132,32 @@ enum m_can_mram_cfg {
>  #define CCCR_CME_CAN		0
>  #define CCCR_CME_CANFD		0x1
>  #define CCCR_CME_CANFD_BRS	0x2
> +#define	CCCR_TXP		BIT(14)
>  #define CCCR_TEST		BIT(7)
>  #define CCCR_MON		BIT(5)
> +#define CCCR_CSR		BIT(4)
> +#define CCCR_CSA		BIT(3)
> +#define CCCR_ASM		BIT(2)
>  #define CCCR_CCE		BIT(1)
>  #define CCCR_INIT		BIT(0)
>  #define CCCR_CANFD		0x10
> -
> -/* Bit Timing & Prescaler Register (BTP) */
> -#define BTR_BRP_MASK		0x3ff
> -#define BTR_BRP_SHIFT		16
> -#define BTR_TSEG1_SHIFT		8
> -#define BTR_TSEG1_MASK		(0x3f << BTR_TSEG1_SHIFT)
> -#define BTR_TSEG2_SHIFT		4
> -#define BTR_TSEG2_MASK		(0xf << BTR_TSEG2_SHIFT)
> -#define BTR_SJW_SHIFT		0
> -#define BTR_SJW_MASK		0xf
> +/* for version >=3.1.x */
> +#define CCCR_EFBI		BIT(13)
> +#define CCCR_PXHD		BIT(12)
> +#define CCCR_BRSE		BIT(9)
> +#define CCCR_FDOE		BIT(8)
> +/* only for version >=3.2.x */
> +#define CCCR_NISO		BIT(15)
> +
> +/* Nominal Bit Timing & Prescaler Register (NBTP) */
> +#define NBTP_NSJW_SHIFT		25
> +#define NBTP_NSJW_MASK		(0x7f << NBTP_NSJW_SHIFT)
> +#define NBTP_NBRP_SHIFT		16
> +#define NBTP_NBRP_MASK		(0x1ff << NBTP_NBRP_SHIFT)
> +#define NBTP_NTSEG1_SHIFT	8
> +#define NBTP_NTSEG1_MASK	(0xff << NBTP_NTSEG1_SHIFT)
> +#define NBTP_NTSEG2_SHIFT	0
> +#define NBTP_NTSEG2_MASK	(0x7f << NBTP_NTSEG2_SHIFT)
>
>  /* Error Counter Register(ECR) */
>  #define ECR_RP			BIT(15)
> @@ -161,6 +174,13 @@ enum m_can_mram_cfg {
>
>  /* Interrupt Register(IR) */
>  #define IR_ALL_INT	0xffffffff
> +
> +/* Renamed bits for versions > 3.1.x */
> +#define IR_ARA		BIT(29)
> +#define IR_PED		BIT(28)
> +#define IR_PEA		BIT(27)
> +
> +/* Bits for version 3.0.x */
>  #define IR_STE		BIT(31)
>  #define IR_FOE		BIT(30)
>  #define IR_ACKE		BIT(29)
> @@ -194,33 +214,40 @@ enum m_can_mram_cfg {
>  #define IR_RF0W		BIT(1)
>  #define IR_RF0N		BIT(0)
>  #define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
> -#define IR_ERR_LEC	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
> -#define IR_ERR_BUS	(IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | \
> +
> +/* Interrupts for version 3.0.x */
> +#define IR_ERR_LEC_30X	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
> +#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_ELO | IR_BEU | \
> +			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
> +			 IR_RF1L | IR_RF0L)
> +#define IR_ERR_ALL_30X	(IR_ERR_STATE | IR_ERR_BUS_30X)
> +/* Interrupts for version >= 3.1.x */
> +#define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
> +#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_ELO | IR_BEU | \
>  			 IR_BEC | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | \
>  			 IR_RF1L | IR_RF0L)
> -#define IR_ERR_ALL	(IR_ERR_STATE | IR_ERR_BUS)
> +#define IR_ERR_ALL_31X	(IR_ERR_STATE | IR_ERR_BUS_31X)
>
>  /* Interrupt Line Select (ILS) */
>  #define ILS_ALL_INT0	0x0
>  #define ILS_ALL_INT1	0xFFFFFFFF
>
>  /* Interrupt Line Enable (ILE) */
> -#define ILE_EINT0	BIT(0)
>  #define ILE_EINT1	BIT(1)
> +#define ILE_EINT0	BIT(0)
>
>  /* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
> -#define RXFC_FWM_OFF	24
> -#define RXFC_FWM_MASK	0x7f
> -#define RXFC_FWM_1	(1 << RXFC_FWM_OFF)
> -#define RXFC_FS_OFF	16
> -#define RXFC_FS_MASK	0x7f
> +#define RXFC_FWM_SHIFT	24
> +#define RXFC_FWM_MASK	(0x7f < RXFC_FWM_SHIFT)
> +#define RXFC_FS_SHIFT	16
> +#define RXFC_FS_MASK	(0x7f << RXFC_FS_SHIFT)
>
>  /* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
>  #define RXFS_RFL	BIT(25)
>  #define RXFS_FF		BIT(24)
> -#define RXFS_FPI_OFF	16
> +#define RXFS_FPI_SHIFT	16
>  #define RXFS_FPI_MASK	0x3f0000
> -#define RXFS_FGI_OFF	8
> +#define RXFS_FGI_SHIFT	8
>  #define RXFS_FGI_MASK	0x3f00
>  #define RXFS_FFL_MASK	0x7f
>
> @@ -229,23 +256,46 @@ enum m_can_mram_cfg {
>  #define M_CAN_RXESC_64BYTES	0x777
>
>  /* Tx Buffer Configuration(TXBC) */
> -#define TXBC_NDTB_OFF		16
> -#define TXBC_NDTB_MASK		0x3f
> +#define TXBC_NDTB_SHIFT		16
> +#define TXBC_NDTB_MASK		(0x3f << TXBC_NDTB_SHIFT)
> +#define TXBC_TFQS_SHIFT		24
> +#define TXBC_TFQS_MASK		(0x3f << TXBC_TFQS_SHIFT)
> +
> +/* Tx FIFO/Queue Status (TXFQS) */
> +#define TXFQS_TFQF		BIT(21)
> +#define TXFQS_TFQPI_SHIFT	16
> +#define TXFQS_TFQPI_MASK	(0x1f << TXFQS_TFQPI_SHIFT)
> +#define TXFQS_TFGI_SHIFT	8
> +#define TXFQS_TFGI_MASK		(0x1f << TXFQS_TFGI_SHIFT)
> +#define TXFQS_TFFL_SHIFT	0
> +#define TXFQS_TFFL_MASK		(0x3f << TXFQS_TFFL_SHIFT)
>
>  /* Tx Buffer Element Size Configuration(TXESC) */
>  #define TXESC_TBDS_8BYTES	0x0
>  #define TXESC_TBDS_64BYTES	0x7
>
> -/* Tx Event FIFO Con.guration (TXEFC) */
> -#define TXEFC_EFS_OFF		16
> -#define TXEFC_EFS_MASK		0x3f
> +/* Tx Event FIFO Configuration (TXEFC) */
> +#define TXEFC_EFS_SHIFT		16
> +#define TXEFC_EFS_MASK		(0x3f << TXEFC_EFS_SHIFT)
> +
> +/* Tx Event FIFO Status (TXEFS) */
> +#define TXEFS_TEFL		BIT(25)
> +#define TXEFS_EFF		BIT(24)
> +#define TXEFS_EFGI_SHIFT	8
> +#define	TXEFS_EFGI_MASK		(0x1f << TXEFS_EFGI_SHIFT)
> +#define TXEFS_EFFL_SHIFT	0
> +#define TXEFS_EFFL_MASK		(0x3f << TXEFS_EFFL_SHIFT)
> +
> +/* Tx Event FIFO Acknowledge (TXEFA) */
> +#define TXEFA_EFAI_SHIFT	0
> +#define TXEFA_EFAI_MASK		(0x1f << TXEFA_EFAI_SHIFT)
>
>  /* Message RAM Configuration (in bytes) */
>  #define SIDF_ELEMENT_SIZE	4
>  #define XIDF_ELEMENT_SIZE	8
>  #define RXF0_ELEMENT_SIZE	72
>  #define RXF1_ELEMENT_SIZE	72
> -#define RXB_ELEMENT_SIZE	16
> +#define RXB_ELEMENT_SIZE	72
>  #define TXE_ELEMENT_SIZE	8
>  #define TXB_ELEMENT_SIZE	72
>
> @@ -261,13 +311,20 @@ enum m_can_mram_cfg {
>  #define RX_BUF_RTR		BIT(29)
>  /* R1 */
>  #define RX_BUF_ANMF		BIT(31)
> -#define RX_BUF_EDL		BIT(21)
> +#define RX_BUF_FDF		BIT(21)
>  #define RX_BUF_BRS		BIT(20)
>
>  /* Tx Buffer Element */
> -/* R0 */
> +/* T0 */
> +#define TX_BUF_ESI		BIT(31)
>  #define TX_BUF_XTD		BIT(30)
>  #define TX_BUF_RTR		BIT(29)
> +/* T1 */
> +#define TX_BUF_EFC		BIT(23)
> +#define TX_BUF_FDF		BIT(21)
> +#define TX_BUF_BRS		BIT(20)
> +#define TX_BUF_MM_SHIFT		24
> +#define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
>
>  /* address offset and element number for each FIFO/Buffer in the Message RAM */
>  struct mram_cfg {
> @@ -349,7 +406,8 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>
>  static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
>  {
> -	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
> +	/* Only interrupt line 0 is used in this driver */
> +	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
>  }
>
>  static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> @@ -367,9 +425,9 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  	int i;
>
>  	/* calculate the fifo get index for where to read data */
> -	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_SHIFT;
>  	dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> -	if (dlc & RX_BUF_EDL)
> +	if (dlc & RX_BUF_FDF)
>  		skb = alloc_canfd_skb(dev, &cf);
>  	else
>  		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
> @@ -378,7 +436,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  		return;
>  	}
>
> -	if (dlc & RX_BUF_EDL)
> +	if (dlc & RX_BUF_FDF)
>  		cf->len = can_dlc2len((dlc >> 16) & 0x0F);
>  	else
>  		cf->len = get_can_dlc((dlc >> 16) & 0x0F);
> @@ -394,7 +452,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  		netdev_dbg(dev, "ESI Error\n");
>  	}
>
> -	if (!(dlc & RX_BUF_EDL) && (id & RX_BUF_RTR)) {
> +	if (!(dlc & RX_BUF_FDF) && (id & RX_BUF_RTR)) {
>  		cf->can_id |= CAN_RTR_FLAG;
>  	} else {
>  		if (dlc & RX_BUF_BRS)
> @@ -532,7 +590,7 @@ static int __m_can_get_berr_counter(const struct net_device *dev,
>
>  	ecr = m_can_read(priv, M_CAN_ECR);
>  	bec->rxerr = (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
> -	bec->txerr = ecr & ECR_TEC_MASK;
> +	bec->txerr = (ecr & ECR_TEC_MASK) >> ECR_TEC_SHIFT;
>
>  	return 0;
>  }
> @@ -723,7 +781,7 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>  	if (irqstatus & IR_ERR_STATE)
>  		work_done += m_can_handle_state_errors(dev, psr);
>
> -	if (irqstatus & IR_ERR_BUS)
> +	if (irqstatus & IR_ERR_BUS_30X)
>  		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
>
>  	if (irqstatus & IR_RF0N)
> @@ -758,7 +816,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	 * - state change IRQ
>  	 * - bus error IRQ and bus error reporting
>  	 */
> -	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL)) {
> +	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
>  		priv->irqstatus = ir;
>  		m_can_disable_all_interrupts(priv);
>  		napi_schedule(&priv->napi);
> @@ -811,19 +869,19 @@ static int m_can_set_bittiming(struct net_device *dev)
>  	sjw = bt->sjw - 1;
>  	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
>  	tseg2 = bt->phase_seg2 - 1;
> -	reg_btp = (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
> -			(tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
> -	m_can_write(priv, M_CAN_BTP, reg_btp);
> +	reg_btp = (brp << NBTP_NBRP_SHIFT) | (sjw << NBTP_NSJW_SHIFT) |
> +		(tseg1 << NBTP_NTSEG1_SHIFT) | (tseg2 << NBTP_NTSEG2_SHIFT);
> +	m_can_write(priv, M_CAN_NBTP, reg_btp);
>
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
>  		brp = dbt->brp - 1;
>  		sjw = dbt->sjw - 1;
>  		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
>  		tseg2 = dbt->phase_seg2 - 1;
> -		reg_btp = (brp << FBTR_FBRP_SHIFT) | (sjw << FBTR_FSJW_SHIFT) |
> -				(tseg1 << FBTR_FTSEG1_SHIFT) |
> -				(tseg2 << FBTR_FTSEG2_SHIFT);
> -		m_can_write(priv, M_CAN_FBTP, reg_btp);
> +		reg_btp = (brp << DBTP_DBRP_SHIFT) | (sjw << DBTP_DSJW_SHIFT) |
> +			(tseg1 << DBTP_DTSEG1_SHIFT) |
> +			(tseg2 << DBTP_DTSEG2_SHIFT);
> +		m_can_write(priv, M_CAN_DBTP, reg_btp);
>  	}
>
>  	return 0;
> @@ -851,23 +909,23 @@ static void m_can_chip_config(struct net_device *dev)
>  	m_can_write(priv, M_CAN_GFC, 0x0);
>
>  	/* only support one Tx Buffer currently */
> -	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_OFF) |
> +	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_SHIFT) |
>  		    priv->mcfg[MRAM_TXB].off);
>
>  	/* support 64 bytes payload */
>  	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_64BYTES);
>
> -	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_OFF) |
> +	m_can_write(priv, M_CAN_TXEFC, (1 << TXEFC_EFS_SHIFT) |
>  		    priv->mcfg[MRAM_TXE].off);
>
>  	/* rx fifo configuration, blocking mode, fifo size 1 */
>  	m_can_write(priv, M_CAN_RXF0C,
> -		    (priv->mcfg[MRAM_RXF0].num << RXFC_FS_OFF) |
> -		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF0].off);
> +		    (priv->mcfg[MRAM_RXF0].num << RXFC_FS_SHIFT) |
> +		     priv->mcfg[MRAM_RXF0].off);
>
>  	m_can_write(priv, M_CAN_RXF1C,
> -		    (priv->mcfg[MRAM_RXF1].num << RXFC_FS_OFF) |
> -		    RXFC_FWM_1 | priv->mcfg[MRAM_RXF1].off);
> +		    (priv->mcfg[MRAM_RXF1].num << RXFC_FS_SHIFT) |
> +		     priv->mcfg[MRAM_RXF1].off);
>
>  	cccr = m_can_read(priv, M_CAN_CCCR);
>  	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
> @@ -892,7 +950,7 @@ static void m_can_chip_config(struct net_device *dev)
>  	/* enable interrupts */
>  	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
>  	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> -		m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC);
> +		m_can_write(priv, M_CAN_IE, IR_ALL_INT & ~IR_ERR_LEC_30X);
>  	else
>  		m_can_write(priv, M_CAN_IE, IR_ALL_INT);
>
> @@ -1143,10 +1201,12 @@ static int m_can_of_parse_mram(struct platform_device *pdev,
>  	priv->mcfg[MRAM_XIDF].num = out_val[2];
>  	priv->mcfg[MRAM_RXF0].off = priv->mcfg[MRAM_XIDF].off +
>  			priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_RXF0].num = out_val[3] & RXFC_FS_MASK;
> +	priv->mcfg[MRAM_RXF0].num = out_val[3] &
> +			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
>  	priv->mcfg[MRAM_RXF1].off = priv->mcfg[MRAM_RXF0].off +
>  			priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_RXF1].num = out_val[4] & RXFC_FS_MASK;
> +	priv->mcfg[MRAM_RXF1].num = out_val[4] &
> +			(RXFC_FS_MASK >> RXFC_FS_SHIFT);
>  	priv->mcfg[MRAM_RXB].off = priv->mcfg[MRAM_RXF1].off +
>  			priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
>  	priv->mcfg[MRAM_RXB].num = out_val[5];
> @@ -1155,7 +1215,8 @@ static int m_can_of_parse_mram(struct platform_device *pdev,
>  	priv->mcfg[MRAM_TXE].num = out_val[6];
>  	priv->mcfg[MRAM_TXB].off = priv->mcfg[MRAM_TXE].off +
>  			priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
> -	priv->mcfg[MRAM_TXB].num = out_val[7] & TXBC_NDTB_MASK;
> +	priv->mcfg[MRAM_TXB].num = out_val[7] &
> +			(TXBC_NDTB_MASK >> TXBC_NDTB_SHIFT);
>
>  	dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>  		priv->mram_base,
> @@ -1191,7 +1252,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	hclk = devm_clk_get(&pdev->dev, "hclk");
>  	cclk = devm_clk_get(&pdev->dev, "cclk");
>  	if (IS_ERR(hclk) || IS_ERR(cclk)) {
> -		dev_err(&pdev->dev, "no clock find\n");
> +		dev_err(&pdev->dev, "no clock found\n");
>  		return -ENODEV;
>  	}
>
>
