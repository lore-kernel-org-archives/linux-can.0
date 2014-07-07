From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
Date: Mon, 7 Jul 2014 15:10:43 +0800
Message-ID: <20140707071040.GA18505@shlinux1.ap.freescale.net>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com>
 <53B69C55.8010901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53B69C55.8010901@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: socketcan@hartkopp.net, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wg@grandegger.com, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Fri, Jul 04, 2014 at 02:21:41PM +0200, Marc Kleine-Budde wrote:
> On 07/04/2014 01:53 PM, Dong Aisheng wrote:
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
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> Looks quite god, comments inline.
> Marc
> > ---
> > Changes since v1:
> > Addressed all comments from Mark Rutland, Hartkopp and Marc Kleine-Budde
> > - merge three patches into one
> > - create directory drivers/net/can/m_can
> > - improve binding doc
> > - make sure using valid pointer before netif_receive_skb(skb)
> > - remove debug info a bit
> > - let the stats are updated even if alloc_can_err_skb() fails
> > - other small fixes
> > 
> > Test result:
> > Passed over night can-utils/canfdtest stress test on iMX6SX SDB board.
> > 
> > ---
> >  .../devicetree/bindings/net/can/m_can.txt          |   65 ++
> 
> Please put the DT binding doc into a separate patch.
> 

Okay

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
> > diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> > new file mode 100644
> > index 0000000..3422790
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> > @@ -0,0 +1,65 @@
> > +Bosch MCAN controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible		: Should be "bosch,m_can" for M_CAN controllers
> > +- reg			: physical base address and size of the M_CAN
> > +			  registers map and Message RAM
> > +- reg-names		: Should be "m_can" and "message_ram"
> > +- interrupts		: Should be the interrupt number of M_CAN interrupt
> > +			  line 0 and line 1, could be same if sharing
> > +			  the same interrupt.
> > +- interrupt-names	: Should contain "int0" and "int1"
> 
> You make only use of one interupt in the driver.
> 

Yes, that's the purpose.
In driver, we will route all interrupts to INT0.
So not need parse INT1 currently.
However, we still define two interrupts in device tree binding
according to hw capability.
It could be helpful if anyone want to implement features like
separate different type of interrupts to different interrupt line
in the future.

> > +- clocks		: Clocks used by controller, should be host clock
> > +			  and CAN clock.
> > +- clock-names		: Should contain "hclk" and "cclk"
> > +- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> > +- pinctrl-names		: Names corresponding to the numbered pinctrl states
> 
> is pinctrl really required?
> 

AFAIK yes.
Is there an exception?

> > +- mram-cfg		: Message RAM configuration data.
> > +  Multiple M_CAN instances can share the same Message RAM and each element(e.g
> > +  Rx FIFO or Tx Buffer and etc) number in Message RAM is also configurable,
> > +  so this property is telling driver how the shared or private Message RAM
> > +  are used by this M_CAN controller.
> > +
> > +  The format should be as follows:
> > +  <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems
> > +   txe_elems txb_elems>
> > +  The 'offset' is an address offset of the Message RAM where the following
> > +  elements start from. This is usually set to 0x0 if you're using a private
> > +  Message RAM. The remain cells are used to specify how many elements are used
> > +  for each FIFO/Buffer.
> > +
> > +M_CAN includes the following elements according to user manual:
> > +11-bit Filter	0-128 elements / 0-128 words
> > +29-bit Filter	0-64 elements / 0-128 words
> > +Rx FIFO 0	0-64 elements / 0-1152 words
> > +Rx FIFO 1	0-64 elements / 0-1152 words
> > +Rx Buffers	0-64 elements / 0-1152 words
> > +Tx Event FIFO	0-32 elements / 0-64 words
> > +Tx Buffers	0-32 elements / 0-576 words
> > +
> > +Please refer to 2.4.1 Message RAM Configuration in Bosch M_CAN user manual
> > +for details.
> > +
> > +Example:
> > +SoC dtsi:
> > +m_can1: can@020e8000 {
> > +	compatible = "bosch,m_can";
> > +	reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
> > +	reg-names = "m_can", "message_ram";
> > +	interrupts = <0 114 0x04>,
> > +		     <0 114 0x04>;
> > +	interrupt-names = "int0", "int1";
> > +	clocks = <&clks IMX6SX_CLK_CANFD>,
> > +		 <&clks IMX6SX_CLK_CANFD>;
> > +	clock-names = "hclk", "cclk";
> > +	mram-cfg = <0x0 0 0 32 32 32 0 1>;
> 
> Why are you allocating rc fifo1 and rx buffers if you don't use them.
> 

That is just an example.
But i think yes, i could change to the real case currently used by driver.

> > +	status = "disabled";
> > +};
> > +
> > +Board dtsi:
> > +&m_can1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_m_can1>;
> > +	status = "enabled";
> > +};
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index 4168822..e78d6b3 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -143,6 +143,8 @@ source "drivers/net/can/sja1000/Kconfig"
> >  
> >  source "drivers/net/can/c_can/Kconfig"
> >  
> > +source "drivers/net/can/m_can/Kconfig"
> > +
> >  source "drivers/net/can/cc770/Kconfig"
> >  
> >  source "drivers/net/can/spi/Kconfig"
> > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > index 1697f22..1b4b6eb 100644
> > --- a/drivers/net/can/Makefile
> > +++ b/drivers/net/can/Makefile
> > @@ -17,6 +17,7 @@ obj-y				+= softing/
> >  obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
> >  obj-$(CONFIG_CAN_MSCAN)		+= mscan/
> >  obj-$(CONFIG_CAN_C_CAN)		+= c_can/
> > +obj-$(CONFIG_CAN_M_CAN)		+= m_can/
> >  obj-$(CONFIG_CAN_CC770)		+= cc770/
> >  obj-$(CONFIG_CAN_AT91)		+= at91_can.o
> >  obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
> > diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
> > new file mode 100644
> > index 0000000..fca5482
> > --- /dev/null
> > +++ b/drivers/net/can/m_can/Kconfig
> > @@ -0,0 +1,4 @@
> > +config CAN_M_CAN
> > +	tristate "Bosch M_CAN devices"
> > +	---help---
> > +	  Say Y here if you want to support for Bosch M_CAN controller.
> > diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
> > new file mode 100644
> > index 0000000..a6aae67
> > --- /dev/null
> > +++ b/drivers/net/can/m_can/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +#  Makefile for the Bosch M_CAN controller drivers.
> > +#
> > +
> > +obj-$(CONFIG_CAN_M_CAN) += m_can.o
> > +
> > +ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > new file mode 100644
> > index 0000000..7bb3c05
> > --- /dev/null
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -0,0 +1,1136 @@
> > +/*
> > + * CAN bus driver for Bosch M_CAN controller
> > + *
> > + * Copyright (C) 2014 Freescale Semiconductor, Inc.
> > + *	Dong Aisheng <b29396@freescale.com>
> > + *
> > + * Bosch M_CAN user manual can be obtained from:
> > + * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
> > + * mcan_users_manual_v302.pdf
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <linux/can/dev.h>
> > +
> > +/* napi related */
> > +#define M_CAN_NAPI_WEIGHT	64
> > +
> > +/* message ram configuration data length */
> > +#define MRAM_CFG_LEN	8
> > +
> > +/* registers definition */
> > +enum m_can_reg {
> > +	M_CAN_CREL	= 0x0,
> > +	M_CAN_ENDN	= 0x4,
> > +	M_CAN_CUST	= 0x8,
> > +	M_CAN_FBTP	= 0xc,
> > +	M_CAN_TEST	= 0x10,
> > +	M_CAN_RWD	= 0x14,
> > +	M_CAN_CCCR	= 0x18,
> > +	M_CAN_BTP	= 0x1c,
> > +	M_CAN_TSCC	= 0x20,
> > +	M_CAN_TSCV	= 0x24,
> > +	M_CAN_TOCC	= 0x28,
> > +	M_CAN_TOCV	= 0x2c,
> > +	M_CAN_ECR	= 0x40,
> > +	M_CAN_PSR	= 0x44,
> > +	M_CAN_IR	= 0x50,
> > +	M_CAN_IE	= 0x54,
> > +	M_CAN_ILS	= 0x58,
> > +	M_CAN_ILE	= 0x5c,
> > +	M_CAN_GFC	= 0x80,
> > +	M_CAN_SIDFC	= 0x84,
> > +	M_CAN_XIDFC	= 0x88,
> > +	M_CAN_XIDAM	= 0x90,
> > +	M_CAN_HPMS	= 0x94,
> > +	M_CAN_NDAT1	= 0x98,
> > +	M_CAN_NDAT2	= 0x9c,
> > +	M_CAN_RXF0C	= 0xa0,
> > +	M_CAN_RXF0S	= 0xa4,
> > +	M_CAN_RXF0A	= 0xa8,
> > +	M_CAN_RXBC	= 0xac,
> > +	M_CAN_RXF1C	= 0xb0,
> > +	M_CAN_RXF1S	= 0xb4,
> > +	M_CAN_RXF1A	= 0xb8,
> > +	M_CAN_RXESC	= 0xbc,
> > +	M_CAN_TXBC	= 0xc0,
> > +	M_CAN_TXFQS	= 0xc4,
> > +	M_CAN_TXESC	= 0xc8,
> > +	M_CAN_TXBRP	= 0xcc,
> > +	M_CAN_TXBAR	= 0xd0,
> > +	M_CAN_TXBCR	= 0xd4,
> > +	M_CAN_TXBTO	= 0xd8,
> > +	M_CAN_TXBCF	= 0xdc,
> > +	M_CAN_TXBTIE	= 0xe0,
> > +	M_CAN_TXBCIE	= 0xe4,
> > +	M_CAN_TXEFC	= 0xf0,
> > +	M_CAN_TXEFS	= 0xf4,
> > +	M_CAN_TXEFA	= 0xf8,
> > +};
> > +
> > +/* m_can lec values */
> > +enum m_can_lec_type {
> > +	LEC_NO_ERROR = 0,
> > +	LEC_STUFF_ERROR,
> > +	LEC_FORM_ERROR,
> > +	LEC_ACK_ERROR,
> > +	LEC_BIT1_ERROR,
> > +	LEC_BIT0_ERROR,
> > +	LEC_CRC_ERROR,
> > +	LEC_UNUSED,
> > +};
> > +
> > +/* Test Register (TEST) */
> > +#define TEST_LBCK	BIT(4)
> > +
> > +/* CC Control Register(CCCR) */
> > +#define CCCR_TEST	BIT(7)
> > +#define CCCR_MON	BIT(5)
> > +#define CCCR_CCE	BIT(1)
> > +#define CCCR_INIT	BIT(0)
> > +
> > +/* Bit Timing & Prescaler Register (BTP) */
> > +#define BTR_BRP_MASK		0x3ff
> > +#define BTR_BRP_SHIFT		16
> > +#define BTR_TSEG1_SHIFT		8
> > +#define BTR_TSEG1_MASK		(0x3f << BTR_TSEG1_SHIFT)
> > +#define BTR_TSEG2_SHIFT		4
> > +#define BTR_TSEG2_MASK		(0xf << BTR_TSEG2_SHIFT)
> > +#define BTR_SJW_SHIFT		0
> > +#define BTR_SJW_MASK		0xf
> > +
> > +/* Error Counter Register(ECR) */
> > +#define ECR_RP			BIT(15)
> > +#define ECR_REC_SHIFT		8
> > +#define ECR_REC_MASK		(0x7f << ECR_REC_SHIFT)
> > +#define ECR_TEC_SHIFT		0
> > +#define ECR_TEC_MASK		0xff
> > +
> > +/* Protocol Status Register(PSR) */
> > +#define PSR_BO		BIT(7)
> > +#define PSR_EW		BIT(6)
> > +#define PSR_EP		BIT(5)
> > +#define PSR_LEC_MASK	0x7
> > +
> > +/* Interrupt Register(IR) */
> > +#define IR_ALL_INT	0xffffffff
> > +#define IR_STE		BIT(31)
> > +#define IR_FOE		BIT(30)
> > +#define IR_ACKE		BIT(29)
> > +#define IR_BE		BIT(28)
> > +#define IR_CRCE		BIT(27)
> > +#define IR_WDI		BIT(26)
> > +#define IR_BO		BIT(25)
> > +#define IR_EW		BIT(24)
> > +#define IR_EP		BIT(23)
> > +#define IR_ELO		BIT(22)
> > +#define IR_BEU		BIT(21)
> > +#define IR_BEC		BIT(20)
> > +#define IR_DRX		BIT(19)
> > +#define IR_TOO		BIT(18)
> > +#define IR_MRAF		BIT(17)
> > +#define IR_TSW		BIT(16)
> > +#define IR_TEFL		BIT(15)
> > +#define IR_TEFF		BIT(14)
> > +#define IR_TEFW		BIT(13)
> > +#define IR_TEFN		BIT(12)
> > +#define IR_TFE		BIT(11)
> > +#define IR_TCF		BIT(10)
> > +#define IR_TC		BIT(9)
> > +#define IR_HPM		BIT(8)
> > +#define IR_RF1L		BIT(7)
> > +#define IR_RF1F		BIT(6)
> > +#define IR_RF1W		BIT(5)
> > +#define IR_RF1N		BIT(4)
> > +#define IR_RF0L		BIT(3)
> > +#define IR_RF0F		BIT(2)
> > +#define IR_RF0W		BIT(1)
> > +#define IR_RF0N		BIT(0)
> > +#define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
> > +#define IR_ERR_BUS	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE | \
> > +		IR_WDI | IR_ELO | IR_BEU | IR_BEC | IR_TOO | IR_MRAF | \
> > +		IR_TSW | IR_TEFL | IR_RF1L | IR_RF0L)
> > +#define IR_ERR_ALL	(IR_ERR_STATE | IR_ERR_BUS)
> > +
> > +/* Interrupt Line Select (ILS) */
> > +#define ILS_ALL_INT0	0x0
> > +#define ILS_ALL_INT1	0xFFFFFFFF
> > +
> > +/* Interrupt Line Enable (ILE) */
> > +#define ILE_EINT0	BIT(0)
> > +#define ILE_EINT1	BIT(1)
> > +
> > +/* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
> > +#define RXFC_FWM_OFF	24
> > +#define RXFC_FWM_MASK	0x7f
> > +#define RXFC_FWM_1	(1 << RXFC_FWM_OFF)
> > +#define RXFC_FS_OFF	16
> > +#define RXFC_FS_MASK	0x7f
> > +
> > +/* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
> > +#define RXFS_RFL	BIT(25)
> > +#define RXFS_FF		BIT(24)
> > +#define RXFS_FPI_OFF	16
> > +#define RXFS_FPI_MASK	0x3f0000
> > +#define RXFS_FGI_OFF	8
> > +#define RXFS_FGI_MASK	0x3f00
> > +#define RXFS_FFL_MASK	0x7f
> > +
> > +/* Tx Buffer Configuration(TXBC) */
> > +#define TXBC_NDTB_OFF	16
> > +#define TXBC_NDTB_MASK	0x3f
> > +
> > +/* Tx Buffer Element Size Configuration(TXESC) */
> > +#define TXESC_TBDS_8BYTES	0x0
> > +/* Tx Buffer Element */
> > +#define TX_BUF_XTD	BIT(30)
> > +#define TX_BUF_RTR	BIT(29)
> > +
> > +/* Rx Buffer Element Size Configuration(TXESC) */
> > +#define M_CAN_RXESC_8BYTES	0x0
> > +/* Tx Buffer Element */
> > +#define RX_BUF_ESI	BIT(31)
> > +#define RX_BUF_XTD	BIT(30)
> > +#define RX_BUF_RTR	BIT(29)
> > +
> > +/* Message RAM Configuration (in bytes) */
> > +#define SIDF_ELEMENT_SIZE	4
> > +#define XIDF_ELEMENT_SIZE	8
> > +#define RXF0_ELEMENT_SIZE	16
> > +#define RXF1_ELEMENT_SIZE	16
> > +#define RXB_ELEMENT_SIZE	16
> > +#define TXE_ELEMENT_SIZE	8
> > +#define TXB_ELEMENT_SIZE	16
> > +
> > +/* m_can private data structure */
> > +struct m_can_priv {
> > +	struct can_priv can;	/* must be the first member */
> > +	struct napi_struct napi;
> > +	struct net_device *dev;
> > +	struct device *device;
> > +	struct clk *hclk;
> > +	struct clk *cclk;
> > +	void __iomem *base;
> > +	u32 irqstatus;
> > +
> > +	/* message ram configuration */
> > +	void __iomem *mram_base;
> > +	u32 mram_off;
> > +	u32 sidf_elems;
> > +	u32 sidf_off;
> > +	u32 xidf_elems;
> > +	u32 xidf_off;
> > +	u32 rxf0_elems;
> > +	u32 rxf0_off;
> > +	u32 rxf1_elems;
> > +	u32 rxf1_off;
> > +	u32 rxb_elems;
> > +	u32 rxb_off;
> > +	u32 txe_elems;
> > +	u32 txe_off;
> > +	u32 txb_elems;
> > +	u32 txb_off;
> > +};
> > +
> > +static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
> > +{
> > +	return readl(priv->base + reg);
> > +}
> > +
> > +static inline void m_can_write(const struct m_can_priv *priv,
> > +				enum m_can_reg reg, u32 val)
> > +{
> > +	writel(val, priv->base + reg);
> > +}
> > +
> > +static inline void m_can_config_endisable(const struct m_can_priv *priv,
> > +				bool enable)
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
> > +static void m_can_enable_all_interrupts(const struct m_can_priv *priv)
> 
> ...inline...
> 
> > +{
> > +	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
> > +}
> > +
> > +static void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> 
> ...inline...
> 

Got it.

> > +{
> > +	m_can_write(priv, M_CAN_ILE, 0x0);
> > +}
> > +
> > +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> > +				u32 rxfs)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	u32 flags, fgi;
> > +	void __iomem *fifo_addr;
> > +
> > +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> 
> Just for curiosity, what do the fgi bits tell us?
> 

It is FIFO Get index.
See the following spec definition:
Bit 21:16 F0PI[5:0]: Rx FIFO 0 Put Index
Rx FIFO 0 write index pointer, range 0 to 63.
Bit 13:8 F0GI[5:0]: Rx FIFO 0 Get Index
Rx FIFO 0 read index pointer, range 0 to 63.

It tells us the current element index to be read in the FIFO.

When reading from an Rx FIFO, Rx FIFO Get Index RXFnS.FnGI * FIFO Element
Size has to be added to the corresponding Rx FIFO start address RXFnC.FnSA.

> > +	fifo_addr = priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT_SIZE;
> > +	flags = readl(fifo_addr);
> 
> What about a function introducing a function?
> static inline u32 m_can_fifo_read(const struct m_can_priv *priv priv,
> u32 fgi, unsgined int offset)
> 

If do that, this function mostly does the same thing as m_can_read_fifo
(we also need pass the cf to it to handle can frame),
i'm not sure what obvious benefit we can get.
Maybe we could re-range function later when adding FIFO 1 & CANFD Frame
support, then we know clear about what we need to do.

> > +	if (flags & RX_BUF_XTD)
> > +		cf->can_id = (flags & CAN_EFF_MASK) | CAN_EFF_FLAG;
> > +	else
> > +		cf->can_id = (flags >> 18) & CAN_SFF_MASK;
> > +
> > +	if (flags & RX_BUF_RTR) {
> > +		cf->can_id |= CAN_RTR_FLAG;
> > +	} else {
> > +		flags = readl(fifo_addr + 0x4);
> > +		cf->can_dlc = get_can_dlc((flags >> 16) & 0x0F);
> > +		*(u32 *)(cf->data + 0) = readl(fifo_addr + 0x8);
> > +		*(u32 *)(cf->data + 4) = readl(fifo_addr + 0xC);
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
> > +	u32 num_rx_pkts = 0;
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
> > +		num_rx_pkts++;
> > +		rxfs = m_can_read(priv, M_CAN_RXF0S);
> > +	};
> > +
> > +	can_led_event(dev, CAN_LED_EVENT_RX);
> > +
> > +	return num_rx_pkts;
> > +}
> > +
> > +static int m_can_handle_lost_msg(struct net_device *dev)
> > +{
> > +	struct net_device_stats *stats = &dev->stats;
> > +	struct sk_buff *skb;
> > +	struct can_frame *frame;
> > +
> > +	netdev_err(dev, "msg lost in rxf0\n");
> > +
> > +	stats->rx_errors++;
> > +	stats->rx_over_errors++;
> > +
> > +	skb = alloc_can_err_skb(dev, &frame);
> > +	if (unlikely(!skb))
> > +		return 0;
> > +
> > +	frame->can_id |= CAN_ERR_CRTL;
> > +	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> > +
> > +	netif_receive_skb(skb);
> > +
> > +	return 1;
> > +}
> > +
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
> > +
> > +	priv->can.can_stats.bus_error++;
> > +	stats->rx_errors++;
> > +
> > +	/* propagate the error condition to the CAN stack */
> > +	skb = alloc_can_err_skb(dev, &cf);
> > +	if (unlikely(!skb))
> > +		return 0;
> > +
> > +	/*
> > +	 * check for 'last error code' which tells us the
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
> > +static int m_can_get_berr_counter(const struct net_device *dev,
> > +				  struct can_berr_counter *bec)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	unsigned int ecr;
> > +
> > +	clk_prepare_enable(priv->hclk);
> > +	clk_prepare_enable(priv->cclk);
> 
> Please check the return values of clk_prepare_enable()
> 

Yes.

> > +
> > +	ecr = m_can_read(priv, M_CAN_ECR);
> > +	bec->rxerr = (ecr & ECR_REC_MASK) >> ECR_REC_SHIFT;
> > +	bec->txerr = ecr & ECR_TEC_MASK;
> > +
> > +	clk_disable_unprepare(priv->hclk);
> > +	clk_disable_unprepare(priv->cclk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int m_can_handle_state_change(struct net_device *dev,
> > +				enum can_state new_state)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	struct net_device_stats *stats = &dev->stats;
> > +	struct can_frame *cf;
> > +	struct sk_buff *skb;
> > +	struct can_berr_counter bec;
> > +	unsigned int ecr;
> > +
> > +	switch (new_state) {
> > +	case CAN_STATE_ERROR_ACTIVE:
> > +		/* error warning state */
> > +		priv->can.can_stats.error_warning++;
> > +		priv->can.state = CAN_STATE_ERROR_WARNING;
> > +		break;
> > +	case CAN_STATE_ERROR_PASSIVE:
> > +		/* error passive state */
> > +		priv->can.can_stats.error_passive++;
> > +		priv->can.state = CAN_STATE_ERROR_PASSIVE;
> > +		break;
> > +	case CAN_STATE_BUS_OFF:
> > +		/* bus-off state */
> > +		priv->can.state = CAN_STATE_BUS_OFF;
> > +		m_can_disable_all_interrupts(priv);
> > +		can_bus_off(dev);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/* propagate the error condition to the CAN stack */
> > +	skb = alloc_can_err_skb(dev, &cf);
> > +	if (unlikely(!skb))
> > +		return 0;
> > +
> > +	m_can_get_berr_counter(dev, &bec);
> > +
> > +	switch (new_state) {
> > +	case CAN_STATE_ERROR_ACTIVE:
> > +		/* error warning state */
> > +		cf->can_id |= CAN_ERR_CRTL;
> > +		cf->data[1] = (bec.txerr > bec.rxerr) ?
> > +			CAN_ERR_CRTL_TX_WARNING :
> > +			CAN_ERR_CRTL_RX_WARNING;
> > +		cf->data[6] = bec.txerr;
> > +		cf->data[7] = bec.rxerr;
> > +		break;
> > +	case CAN_STATE_ERROR_PASSIVE:
> > +		/* error passive state */
> > +		cf->can_id |= CAN_ERR_CRTL;
> > +		ecr = m_can_read(priv, M_CAN_ECR);
> > +		if (ecr & ECR_RP)
> > +			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
> > +		if (bec.txerr > 127)
> > +			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
> > +		cf->data[6] = bec.txerr;
> > +		cf->data[7] = bec.rxerr;
> > +		break;
> > +	case CAN_STATE_BUS_OFF:
> > +		/* bus-off state */
> > +		cf->can_id |= CAN_ERR_BUSOFF;
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
> > +static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	int work_done = 0;
> > +
> > +	if ((psr & PSR_EW) &&
> > +		(priv->can.state != CAN_STATE_ERROR_WARNING)) {
> > +		netdev_dbg(dev, "entered error warning state\n");
> > +		work_done += m_can_handle_state_change(dev,
> > +				CAN_STATE_ERROR_WARNING);
> > +	}
> > +
> > +	if ((psr & PSR_EP) &&
> > +		(priv->can.state != CAN_STATE_ERROR_PASSIVE)) {
> > +		netdev_dbg(dev, "entered error warning state\n");
> > +		work_done += m_can_handle_state_change(dev,
> > +				CAN_STATE_ERROR_PASSIVE);
> > +	}
> > +
> > +	if ((psr & PSR_BO) &&
> > +		(priv->can.state != CAN_STATE_BUS_OFF)) {
> > +		netdev_dbg(dev, "entered error warning state\n");
> > +		work_done += m_can_handle_state_change(dev,
> > +				CAN_STATE_BUS_OFF);
> > +	}
> > +
> > +	return work_done;
> > +}
> > +
> > +static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
> > +							u32 psr)
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
> > +	if (irqstatus & IR_WDI)
> > +		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
> > +	if (irqstatus & IR_TOO)
> > +		netdev_err(dev, "Timeout reached\n");
> > +	if (irqstatus & IR_MRAF)
> > +		netdev_err(dev, "Message RAM access failure occurred\n");
> > +
> > +	return work_done;
> > +}
> > +
> > +static int m_can_poll(struct napi_struct *napi, int quota)
> > +{
> > +	struct net_device *dev = napi->dev;
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	int work_done = 0;
> > +	u32 irqstatus, psr;
> > +
> > +	irqstatus = priv->irqstatus | m_can_read(priv, M_CAN_IR);
> > +	if (!irqstatus)
> > +		goto end;
> > +
> > +	psr = m_can_read(priv, M_CAN_PSR);
> > +	if (irqstatus & IR_ERR_STATE)
> > +		work_done += m_can_handle_state_errors(dev, psr);
> > +
> > +	if (irqstatus & IR_ERR_BUS)
> > +		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
> > +
> > +	if (irqstatus & IR_RF0N)
> > +		/* handle events corresponding to receive message objects */
> > +		work_done += m_can_do_rx_poll(dev, (quota - work_done));
> > +
> > +	if (work_done < quota) {
> > +		napi_complete(napi);
> > +		m_can_enable_all_interrupts(priv);
> > +	}
> > +
> > +end:
> > +	return work_done;
> > +}
> > +
> > +static irqreturn_t m_can_isr(int irq, void *dev_id)
> > +{
> > +	struct net_device *dev = (struct net_device *)dev_id;
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	struct net_device_stats *stats = &dev->stats;
> > +	u32 ir;
> > +
> > +	ir = m_can_read(priv, M_CAN_IR);
> > +	if (!ir)
> > +		return IRQ_NONE;
> > +
> > +	/* ACK all irqs */
> > +	if (ir & IR_ALL_INT)
> > +		m_can_write(priv, M_CAN_IR, ir);
> > +
> > +	/*
> > +	 * schedule NAPI in case of
> > +	 * - rx IRQ
> > +	 * - state change IRQ
> > +	 * - bus error IRQ and bus error reporting
> > +	 */
> > +	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL)) {
> > +		priv->irqstatus = ir;
> > +		m_can_disable_all_interrupts(priv);
> > +		napi_schedule(&priv->napi);
> > +	}
> > +
> > +	/* transmission complete interrupt */
> > +	if (ir & IR_TC) {
> > +		stats->tx_bytes += can_get_echo_skb(dev, 0);
> > +		stats->tx_packets++;
> > +		can_led_event(dev, CAN_LED_EVENT_TX);
> > +		netif_wake_queue(dev);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct can_bittiming_const m_can_bittiming_const = {
> > +	.name = KBUILD_MODNAME,
> > +	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
> > +	.tseg1_max = 64,
> > +	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
> > +	.tseg2_max = 16,
> > +	.sjw_max = 16,
> > +	.brp_min = 1,
> > +	.brp_max = 1024,
> > +	.brp_inc = 1,
> > +};
> > +
> > +static int m_can_set_bittiming(struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	const struct can_bittiming *bt = &priv->can.bittiming;
> > +	u16 brp, sjw, tseg1, tseg2;
> > +	u32 reg_btp;
> > +
> > +	brp = bt->brp - 1;
> > +	sjw = bt->sjw - 1;
> > +	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
> > +	tseg2 = bt->phase_seg2 - 1;
> > +	reg_btp = (brp << BTR_BRP_SHIFT) | (sjw << BTR_SJW_SHIFT) |
> > +			(tseg1 << BTR_TSEG1_SHIFT) | (tseg2 << BTR_TSEG2_SHIFT);
> > +	m_can_write(priv, M_CAN_BTP, reg_btp);
> > +	netdev_dbg(dev, "setting BTP 0x%x\n", reg_btp);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Configure M_CAN chip:
> > + * - set rx buffer/fifo element size
> > + * - configure rx fifo
> > + * - accept non-matching frame into fifo 0
> > + * - configure tx buffer
> > + * - configure mode
> > + * - setup bittiming
> > + */
> > +static void m_can_chip_config(struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	u32 cccr, test;
> > +
> > +	m_can_config_endisable(priv, true);
> > +
> > +	/* RX Buffer/FIFO Element Size 8 bytes data field */
> > +	m_can_write(priv, M_CAN_RXESC, M_CAN_RXESC_8BYTES);
> > +
> > +	/* Accept Non-matching Frames Into FIFO 0 */
> > +	m_can_write(priv, M_CAN_GFC, 0x0);
> > +
> > +	/* only support one Tx Buffer currently */
> > +	m_can_write(priv, M_CAN_TXBC, (1 << TXBC_NDTB_OFF) |
> > +		(priv->mram_off + priv->txb_off));
> > +
> > +	/* only support 8 bytes firstly */
> > +	m_can_write(priv, M_CAN_TXESC, TXESC_TBDS_8BYTES);
> > +
> > +	m_can_write(priv, M_CAN_TXEFC, 0x00010000 |
> > +		(priv->mram_off + priv->txe_off));
> > +
> > +	/* rx fifo configuration, blocking mode, fifo size 1 */
> > +	m_can_write(priv, M_CAN_RXF0C, (priv->rxf0_elems << RXFC_FS_OFF) |
> > +		RXFC_FWM_1 | (priv->mram_off + priv->rxf0_off));
> > +
> > +	m_can_write(priv, M_CAN_RXF1C, (priv->rxf1_elems << RXFC_FS_OFF) |
> > +		RXFC_FWM_1 | (priv->mram_off + priv->rxf1_off));
> > +
> > +	cccr = m_can_read(priv, M_CAN_CCCR);
> > +	cccr &= ~(CCCR_TEST | CCCR_MON);
> > +	test = m_can_read(priv, M_CAN_TEST);
> > +	test &= ~TEST_LBCK;
> > +
> > +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +		cccr |= CCCR_MON;
> > +
> > +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> > +		cccr |= CCCR_TEST;
> > +		test |= TEST_LBCK;
> > +	}
> > +
> > +	m_can_write(priv, M_CAN_CCCR, cccr);
> > +	m_can_write(priv, M_CAN_TEST, test);
> > +
> > +	/* enable all interrupts */
> > +	m_can_write(priv, M_CAN_IR, IR_ALL_INT);
> > +	m_can_write(priv, M_CAN_IE, IR_ALL_INT);
> > +	/* route all interrupts to INT0 */
> > +	m_can_write(priv, M_CAN_ILS, ILS_ALL_INT0);
> > +
> > +	/* set bittiming params */
> > +	m_can_set_bittiming(dev);
> > +
> > +	m_can_config_endisable(priv, false);
> > +}
> > +
> > +static void m_can_start(struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +
> > +	/* basic m_can configuration */
> > +	m_can_chip_config(dev);
> > +
> > +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > +
> > +	m_can_enable_all_interrupts(priv);
> > +}
> > +
> > +static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
> > +{
> > +	switch (mode) {
> > +	case CAN_MODE_START:
> > +		m_can_start(dev);
> > +		netif_wake_queue(dev);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void free_m_can_dev(struct net_device *dev)
> > +{
> > +	free_candev(dev);
> > +}
> > +
> > +static struct net_device *alloc_m_can_dev(void)
> > +{
> > +	struct net_device *dev;
> > +	struct m_can_priv *priv;
> > +
> > +	dev = alloc_candev(sizeof(struct m_can_priv), 1);
> > +	if (!dev)
> > +		return NULL;
> > +
> > +	priv = netdev_priv(dev);
> > +	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> > +
> > +	priv->dev = dev;
> > +	priv->can.bittiming_const = &m_can_bittiming_const;
> > +	priv->can.do_set_mode = m_can_set_mode;
> > +	priv->can.do_get_berr_counter = m_can_get_berr_counter;
> > +	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> > +					CAN_CTRLMODE_LISTENONLY |
> > +					CAN_CTRLMODE_BERR_REPORTING;
> 
> Please take care of CAN_CTRLMODE_BERR_REPORTING, i.e. only enable bus
> the bus error interrupt if this bit is set.
> 

Okay, BTW, does BERR_REPROTING includes lost message error?

> > +
> > +	return dev;
> > +}
> > +
> > +static int m_can_open(struct net_device *dev)
> > +{
> > +	int err;
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +
> > +	clk_prepare_enable(priv->hclk);
> > +	clk_prepare_enable(priv->cclk);
> 
> please check return value
> 

Got it.

> > +
> > +	/* open the can device */
> > +	err = open_candev(dev);
> > +	if (err) {
> > +		netdev_err(dev, "failed to open can device\n");
> > +		goto exit_open_fail;
> > +	}
> > +
> > +	/* register interrupt handler */
> > +	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
> > +				dev);
> > +	if (err < 0) {
> > +		netdev_err(dev, "failed to request interrupt\n");
> > +		goto exit_irq_fail;
> > +	}
> > +
> > +	/* start the m_can controller */
> > +	m_can_start(dev);
> > +
> > +	can_led_event(dev, CAN_LED_EVENT_OPEN);
> > +	napi_enable(&priv->napi);
> > +	netif_start_queue(dev);
> > +
> > +	return 0;
> > +
> > +exit_irq_fail:
> > +	close_candev(dev);
> > +exit_open_fail:
> > +	clk_disable_unprepare(priv->hclk);
> > +	clk_disable_unprepare(priv->cclk);
> > +	return err;
> > +}
> > +
> > +static void m_can_stop(struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +
> > +	/* disable all interrupts */
> > +	m_can_disable_all_interrupts(priv);
> > +
> > +	clk_disable_unprepare(priv->hclk);
> > +	clk_disable_unprepare(priv->cclk);
> > +
> > +	/* set the state as STOPPED */
> > +	priv->can.state = CAN_STATE_STOPPED;
> > +}
> > +
> > +static int m_can_close(struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +
> > +	netif_stop_queue(dev);
> > +	napi_disable(&priv->napi);
> > +	m_can_stop(dev);
> > +	free_irq(dev->irq, dev);
> > +	close_candev(dev);
> > +	can_led_event(dev, CAN_LED_EVENT_STOP);
> > +
> > +	return 0;
> > +}
> > +
> > +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> > +					struct net_device *dev)
> > +{
> > +	struct m_can_priv *priv = netdev_priv(dev);
> > +	struct can_frame *cf = (struct can_frame *)skb->data;
> > +	u32 flags = 0, id;
> > +	void __iomem *fifo_addr;
> > +
> > +	if (can_dropped_invalid_skb(dev, skb))
> > +		return NETDEV_TX_OK;
> > +
> > +	netif_stop_queue(dev);
> > +
> > +	if (cf->can_id & CAN_RTR_FLAG)
> > +		flags |= TX_BUF_RTR;
> > +
> > +	if (cf->can_id & CAN_EFF_FLAG) {
> > +		id = cf->can_id & CAN_EFF_MASK;
> > +		flags |= TX_BUF_XTD;
> > +	} else {
> > +		id = ((cf->can_id & CAN_SFF_MASK) << 18);
> > +	}
> > +
> > +	/* message ram configuration */
> > +	fifo_addr = priv->mram_base + priv->mram_off + priv->txb_off;
> > +	writel(id | flags, fifo_addr);
> > +	writel(cf->can_dlc << 16, fifo_addr + 0x4);
> > +	writel(*(u32 *)(cf->data + 0), fifo_addr + 0x8);
> > +	writel(*(u32 *)(cf->data + 4), fifo_addr + 0xc);
> > +
> > +	can_put_echo_skb(skb, dev, 0);
> > +
> > +	/* enable first TX buffer to start transfer  */
> > +	m_can_write(priv, M_CAN_TXBTIE, 0x1);
> > +	m_can_write(priv, M_CAN_TXBAR, 0x1);
> > +
> > +	return NETDEV_TX_OK;
> > +}
> > +
> > +static const struct net_device_ops m_can_netdev_ops = {
> > +	.ndo_open = m_can_open,
> > +	.ndo_stop = m_can_close,
> > +	.ndo_start_xmit = m_can_start_xmit,
> > +};
> > +
> > +static int register_m_can_dev(struct net_device *dev)
> > +{
> > +	dev->flags |= IFF_ECHO;	/* we support local echo */
> > +	dev->netdev_ops = &m_can_netdev_ops;
> > +
> > +	return register_candev(dev);
> > +}
> > +
> > +static const struct of_device_id m_can_of_table[] = {
> > +	{ .compatible = "bosch,m_can", .data = NULL },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, m_can_of_table);
> > +
> > +static int m_can_of_parse_mram(struct platform_device *pdev,
> > +				struct m_can_priv *priv)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct resource *res;
> > +	void __iomem *addr;
> > +	u32 out_val[MRAM_CFG_LEN];
> > +	int ret;
> > +
> > +	/* message ram could be shared */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
> > +	if (!res)
> > +		return -ENODEV;
> > +
> > +	addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> > +	if (!addr)
> > +		return -ENODEV;
> > +
> > +	/* get message ram configuration */
> > +	ret = of_property_read_u32_array(np, "mram-cfg",
> > +				out_val, sizeof(out_val) / 4);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "can not get message ram configuration\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	priv->mram_base = addr;
> > +	priv->mram_off = out_val[0];
> > +	priv->sidf_elems = out_val[1];
> > +	priv->sidf_off = priv->mram_off;
> > +	priv->xidf_elems = out_val[2];
> > +	priv->xidf_off = priv->sidf_off + priv->sidf_elems * SIDF_ELEMENT_SIZE;
> > +	priv->rxf0_elems = out_val[3] & RXFC_FS_MASK;
> > +	priv->rxf0_off = priv->xidf_off + priv->xidf_elems * XIDF_ELEMENT_SIZE;
> > +	priv->rxf1_elems = out_val[4] & RXFC_FS_MASK;
> > +	priv->rxf1_off = priv->rxf0_off + priv->rxf0_elems * RXF0_ELEMENT_SIZE;
> > +	priv->rxb_elems = out_val[5];
> > +	priv->rxb_off = priv->rxf1_off + priv->rxf1_elems * RXF1_ELEMENT_SIZE;
> > +	priv->txe_elems = out_val[6];
> > +	priv->txe_off = priv->rxb_off + priv->rxb_elems * RXB_ELEMENT_SIZE;
> > +	priv->txb_elems = out_val[7] & TXBC_NDTB_MASK;
> > +	priv->txb_off = priv->txe_off + priv->txe_elems * TXE_ELEMENT_SIZE;
> > +
> > +	dev_dbg(&pdev->dev, "mram_base =%p mram_off =0x%x "
> > +		"sidf %d xidf %d rxf0 %d rxf1 %d rxb %d txe %d txb %d\n",
> > +		priv->mram_base, priv->mram_off, priv->sidf_elems,
> > +		priv->xidf_elems, priv->rxf0_elems, priv->rxf1_elems,
> > +		priv->rxb_elems, priv->txe_elems, priv->txb_elems);
> > +
> > +	return 0;
> > +}
> > +
> > +static int m_can_plat_probe(struct platform_device *pdev)
> > +{
> > +	struct net_device *dev;
> > +	struct m_can_priv *priv;
> > +	struct resource *res;
> > +	void __iomem *addr;
> > +	struct clk *hclk, *cclk;
> > +	int irq, ret;
> > +
> > +	hclk = devm_clk_get(&pdev->dev, "hclk");
> > +	cclk = devm_clk_get(&pdev->dev, "cclk");
> > +	if (IS_ERR(hclk) || IS_ERR(cclk)) {
> > +		dev_err(&pdev->dev, "no clock find\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
> > +	addr = devm_ioremap_resource(&pdev->dev, res);
> > +	irq = platform_get_irq_byname(pdev, "int0");
> > +	if (IS_ERR(addr) || irq < 0)
> > +		return -EINVAL;
> > +
> > +	/* allocate the m_can device */
> > +	dev = alloc_m_can_dev();
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	priv = netdev_priv(dev);
> > +	dev->irq = irq;
> > +	priv->base = addr;
> > +	priv->device = &pdev->dev;
> > +	priv->hclk = hclk;
> > +	priv->cclk = cclk;
> > +	priv->can.clock.freq = clk_get_rate(cclk);
> > +
> > +	ret = m_can_of_parse_mram(pdev, priv);
> > +	if (ret)
> > +		goto failed_free_dev;
> > +
> > +	platform_set_drvdata(pdev, dev);
> > +	SET_NETDEV_DEV(dev, &pdev->dev);
> > +
> > +	ret = register_m_can_dev(dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
> > +			KBUILD_MODNAME, ret);
> > +		goto failed_free_dev;
> > +	}
> > +
> > +	devm_can_led_init(dev);
> > +
> > +	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
> > +		 KBUILD_MODNAME, priv->base, dev->irq);
> > +
> > +	return 0;
> > +
> > +failed_free_dev:
> > +	free_m_can_dev(dev);
> > +	return ret;
> > +}
> > +
> > +static __maybe_unused int m_can_suspend(struct device *dev)
> > +{
> > +	struct net_device *ndev = dev_get_drvdata(dev);
> > +	struct m_can_priv *priv = netdev_priv(ndev);
> > +
> > +	if (netif_running(ndev)) {
> > +		netif_stop_queue(ndev);
> > +		netif_device_detach(ndev);
> > +	}
> > +
> > +	/* TODO: enter low power */
> > +
> > +	priv->can.state = CAN_STATE_SLEEPING;
> > +
> > +	return 0;
> > +}
> > +
> > +static __maybe_unused int m_can_resume(struct device *dev)
> > +{
> > +	struct net_device *ndev = dev_get_drvdata(dev);
> > +	struct m_can_priv *priv = netdev_priv(ndev);
> > +
> > +	/* TODO: exit low power */
> > +
> > +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > +
> > +	if (netif_running(ndev)) {
> > +		netif_device_attach(ndev);
> > +		netif_start_queue(ndev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void unregister_m_can_dev(struct net_device *dev)
> > +{
> > +	unregister_candev(dev);
> > +}
> > +
> > +static int m_can_plat_remove(struct platform_device *pdev)
> > +{
> > +	struct net_device *dev = platform_get_drvdata(pdev);
> > +
> > +	unregister_m_can_dev(dev);
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	free_m_can_dev(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops m_can_pmops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
> > +};
> > +
> > +static struct platform_driver m_can_plat_driver = {
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = of_match_ptr(m_can_of_table),
> > +		.pm     = &m_can_pmops,
> > +	},
> > +	.probe = m_can_plat_probe,
> > +	.remove = m_can_plat_remove,
> > +};
> > +
> > +module_platform_driver(m_can_plat_driver);
> > +
> > +MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
> > 
> 
> Marc
> 

Regards
Dong Aisheng
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
