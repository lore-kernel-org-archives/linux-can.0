From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v10 1/4] can: m_can: Create a m_can platform framework
Date: Tue, 19 Mar 2019 07:24:04 +0100
Message-ID: <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
References: <20190315170257.12847-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190315170257.12847-1-dmurphy@ti.com>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Dan,

checkpatch still reports one "line over 80 characters".

Am 15.03.19 um 18:02 schrieb Dan Murphy:
> Create a m_can platform framework that peripherial
> devices can register to and use common code and register sets.
> The peripherial devices may provide read/write and configuration
> support of the IP.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v10 - Fixed misspelled peripheral, moved index declaration, and added back stop
> queue on TX_BUSY in hard_xmit - https://lore.kernel.org/patchwork/patch/1050487/
> 
> v9 - Added back the CSR clearing as this is needed for TCAN device, fixed clean
> function to clean index for version > 30, removed extra skb free and fixed work
> handler to handle FIFO full for perpheral devices - https://lore.kernel.org/patchwork/patch/1050120/
> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
> 
>  drivers/net/can/m_can/Kconfig          |  13 +-
>  drivers/net/can/m_can/Makefile         |   1 +
>  drivers/net/can/m_can/m_can.c          | 735 +++++++++++++------------
>  drivers/net/can/m_can/m_can.h          | 110 ++++
>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>  5 files changed, 716 insertions(+), 345 deletions(-)
>  create mode 100644 drivers/net/can/m_can/m_can.h
>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
> 
> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
> index 04f20dd39007..f7119fd72df4 100644
> --- a/drivers/net/can/m_can/Kconfig
> +++ b/drivers/net/can/m_can/Kconfig
> @@ -1,5 +1,14 @@
>  config CAN_M_CAN
> +	tristate "Bosch M_CAN support"
> +	---help---
> +	  Say Y here if you want support for Bosch M_CAN controller framework.
> +	  This is common support for devices that embed the Bosch M_CAN IP.
> +
> +config CAN_M_CAN_PLATFORM
> +	tristate "Bosch M_CAN support for io-mapped devices"
>  	depends on HAS_IOMEM
> -	tristate "Bosch M_CAN devices"
> +	depends on CAN_M_CAN
>  	---help---
> -	  Say Y here if you want to support for Bosch M_CAN controller.
> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
> +	  This support is for devices that have the Bosch M_CAN controller
> +	  IP embedded into the device and the IP is IO Mapped to the processor.
> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
> index 8bbd7f24f5be..057bbcdb3c74 100644
> --- a/drivers/net/can/m_can/Makefile
> +++ b/drivers/net/can/m_can/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b449400376b..14c5879f6a5f 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1,20 +1,14 @@
> -/*
> - * CAN bus driver for Bosch M_CAN controller
> - *
> - * Copyright (C) 2014 Freescale Semiconductor, Inc.
> - *	Dong Aisheng <b29396@freescale.com>
> - *
> - * Bosch M_CAN user manual can be obtained from:
> +// SPDX-License-Identifier: GPL-2.0
> +// CAN bus driver for Bosch M_CAN controller
> +// Copyright (C) 2014 Freescale Semiconductor, Inc.
> +//      Dong Aisheng <b29396@freescale.com>
> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
> +
> +/* Bosch M_CAN user manual can be obtained from:
>   * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>   * mcan_users_manual_v302.pdf
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
> -#include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -28,11 +22,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
>  
> -/* napi related */
> -#define M_CAN_NAPI_WEIGHT	64
> -
> -/* message ram configuration data length */
> -#define MRAM_CFG_LEN	8
> +#include "m_can.h"
>  
>  /* registers definition */
>  enum m_can_reg {
> @@ -86,28 +76,11 @@ enum m_can_reg {
>  	M_CAN_TXEFA	= 0xf8,
>  };
>  
> -/* m_can lec values */
> -enum m_can_lec_type {
> -	LEC_NO_ERROR = 0,
> -	LEC_STUFF_ERROR,
> -	LEC_FORM_ERROR,
> -	LEC_ACK_ERROR,
> -	LEC_BIT1_ERROR,
> -	LEC_BIT0_ERROR,
> -	LEC_CRC_ERROR,
> -	LEC_UNUSED,
> -};
> +/* napi related */
> +#define M_CAN_NAPI_WEIGHT	64
>  
> -enum m_can_mram_cfg {
> -	MRAM_SIDF = 0,
> -	MRAM_XIDF,
> -	MRAM_RXF0,
> -	MRAM_RXF1,
> -	MRAM_RXB,
> -	MRAM_TXE,
> -	MRAM_TXB,
> -	MRAM_CFG_NUM,
> -};
> +/* message ram configuration data length */
> +#define MRAM_CFG_LEN	8
>  
>  /* Core Release Register (CREL) */
>  #define CREL_REL_SHIFT		28
> @@ -347,74 +320,86 @@ enum m_can_mram_cfg {
>  #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
>  #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
>  
> -/* address offset and element number for each FIFO/Buffer in the Message RAM */
> -struct mram_cfg {
> -	u16 off;
> -	u8  num;
> -};
> -
> -/* m_can private data structure */
> -struct m_can_priv {
> -	struct can_priv can;	/* must be the first member */
> -	struct napi_struct napi;
> -	struct net_device *dev;
> -	struct device *device;
> -	struct clk *hclk;
> -	struct clk *cclk;
> -	void __iomem *base;
> -	u32 irqstatus;
> -	int version;
> -
> -	/* message ram configuration */
> -	void __iomem *mram_base;
> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
> -};
> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
> +{
> +	if (priv->ops->read_reg)
> +		return priv->ops->read_reg(priv, reg);
> +	else
> +		return -EINVAL;
> +}
>  
> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
>  {
> -	return readl(priv->base + reg);
> +	if (priv->ops->write_reg)
> +		return priv->ops->write_reg(priv, reg, val);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline void m_can_write(const struct m_can_priv *priv,
> -			       enum m_can_reg reg, u32 val)
> +static u32 m_can_fifo_read(struct m_can_priv *priv,
> +			   u32 fgi, unsigned int offset)
>  {
> -	writel(val, priv->base + reg);
> +	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->read_fifo)
> +		return priv->ops->read_fifo(priv, addr_offset);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
> -				  u32 fgi, unsigned int offset)
> +static u32 m_can_fifo_write(struct m_can_priv *priv,
> +			    u32 fpi, unsigned int offset, u32 val)
>  {
> -	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
> -		     fgi * RXF0_ELEMENT_SIZE + offset);
> +	u32 addr_offset = priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->write_fifo)
> +		return priv->ops->write_fifo(priv, addr_offset, val);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline void m_can_fifo_write(const struct m_can_priv *priv,
> -				    u32 fpi, unsigned int offset, u32 val)
> +static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
> +				   u32 fpi, u32 val)
>  {
> -	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
> -	       fpi * TXB_ELEMENT_SIZE + offset);
> +	if (priv->ops->write_fifo)
> +		return priv->ops->write_fifo(priv, fpi, val);
> +	else
> +		return 0;
>  }
>  
> -static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
> -				      u32 fgi,
> -				      u32 offset) {
> -	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
> -			fgi * TXE_ELEMENT_SIZE + offset);
> +static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
> +{
> +	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->read_fifo)
> +		return priv->ops->read_fifo(priv, addr_offset);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
> +static inline bool m_can_tx_fifo_full(struct m_can_priv *priv)
>  {
>  		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
>  }
>  
> -static inline void m_can_config_endisable(const struct m_can_priv *priv,
> -					  bool enable)
> +void m_can_config_endisable(struct m_can_priv *priv, bool enable)
>  {
>  	u32 cccr = m_can_read(priv, M_CAN_CCCR);
>  	u32 timeout = 10;
>  	u32 val = 0;
>  
> +	/* Clear the Clock stop request if it was set */
> +	if (cccr & CCCR_CSR)
> +		cccr &= ~CCCR_CSR;
> +
>  	if (enable) {
> +		/* Clear the Clock stop request if it was set */
> +		if (cccr & CCCR_CSR)
> +			cccr &= ~CCCR_CSR;
> +
>  		/* enable m_can configuration */
>  		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>  		udelay(5);
> @@ -430,7 +415,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  
>  	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
>  		if (timeout == 0) {
> -			netdev_warn(priv->dev, "Failed to init module\n");
> +			netdev_warn(priv->net, "Failed to init module\n");
>  			return;
>  		}
>  		timeout--;
> @@ -438,17 +423,34 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  	}
>  }
>  
> -static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
> +static inline void m_can_enable_all_interrupts(struct m_can_priv *priv)
>  {
>  	/* Only interrupt line 0 is used in this driver */
>  	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
>  }
>  
> -static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> +static inline void m_can_disable_all_interrupts(struct m_can_priv *priv)
>  {
>  	m_can_write(priv, M_CAN_ILE, 0x0);
>  }
>  
> +static void m_can_clean(struct net_device *net)
> +{
> +	struct m_can_priv *priv = netdev_priv(net);
> +
> +	if (priv->tx_skb) {
> +		int putidx = 0;
> +
> +		net->stats.tx_errors++;
> +		if (priv->version > 30)
> +			putidx = ((m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
> +					  >> TXFQS_TFQPI_SHIFT);
> +
> +		can_free_echo_skb(priv->net, putidx);
> +		priv->tx_skb = NULL;
> +	}
> +}
> +
>  static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  {
>  	struct net_device_stats *stats = &dev->stats;
> @@ -633,9 +635,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  {
>  	int err;
>  
> -	err = pm_runtime_get_sync(priv->device);
> +	if (priv->pm_clock_support == 0)
> +		return 0;
> +
> +	err = pm_runtime_get_sync(priv->dev);
>  	if (err < 0) {
> -		pm_runtime_put_noidle(priv->device);
> +		pm_runtime_put_noidle(priv->dev);
>  		return err;
>  	}
>  
> @@ -644,7 +649,8 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  
>  static void m_can_clk_stop(struct m_can_priv *priv)
>  {
> -	pm_runtime_put_sync(priv->device);
> +	if (priv->pm_clock_support)
> +		pm_runtime_put_sync(priv->dev);
>  }
>  
>  static int m_can_get_berr_counter(const struct net_device *dev,
> @@ -811,9 +817,8 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
>  	return work_done;
>  }
>  
> -static int m_can_poll(struct napi_struct *napi, int quota)
> +static int m_can_rx_handler(struct net_device *dev, int quota)
>  {
> -	struct net_device *dev = napi->dev;
>  	struct m_can_priv *priv = netdev_priv(dev);
>  	int work_done = 0;
>  	u32 irqstatus, psr;
> @@ -831,13 +836,33 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>  
>  	if (irqstatus & IR_RF0N)
>  		work_done += m_can_do_rx_poll(dev, (quota - work_done));
> +end:
> +	return work_done;
> +}
> +
> +static int m_can_rx_peripheral(struct net_device *dev)
> +{
> +	struct m_can_priv *priv = netdev_priv(dev);
> +
> +	m_can_rx_handler(dev, 1);
>  
> +	m_can_enable_all_interrupts(priv);
> +
> +	return 0;
> +}
> +
> +static int m_can_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct m_can_priv *priv = netdev_priv(dev);
> +	int work_done;
> +
> +	work_done = m_can_rx_handler(dev, quota);
>  	if (work_done < quota) {
>  		napi_complete_done(napi, work_done);
>  		m_can_enable_all_interrupts(priv);
>  	}
>  
> -end:
>  	return work_done;
>  }
>  
> @@ -894,6 +919,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	if (ir & IR_ALL_INT)
>  		m_can_write(priv, M_CAN_IR, ir);
>  
> +	if (priv->ops->clear_interrupts)
> +		priv->ops->clear_interrupts(priv);
> +
>  	/* schedule NAPI in case of
>  	 * - rx IRQ
>  	 * - state change IRQ
> @@ -902,7 +930,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
>  		priv->irqstatus = ir;
>  		m_can_disable_all_interrupts(priv);
> -		napi_schedule(&priv->napi);
> +		if (!priv->is_peripheral)
> +			napi_schedule(&priv->napi);
> +		else
> +			m_can_rx_peripheral(dev);
>  	}
>  
>  	if (priv->version == 30) {
> @@ -1155,6 +1186,9 @@ static void m_can_chip_config(struct net_device *dev)
>  	m_can_set_bittiming(dev);
>  
>  	m_can_config_endisable(priv, false);
> +
> +	if (priv->ops->init)
> +		priv->ops->init(priv);
>  }
>  
>  static void m_can_start(struct net_device *dev)
> @@ -1173,6 +1207,7 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>  {
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		m_can_clean(dev);
>  		m_can_start(dev);
>  		netif_wake_queue(dev);
>  		break;
> @@ -1188,20 +1223,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>   * else it returns the release and step coded as:
>   * return value = 10 * <release> + 1 * <step>
>   */
> -static int m_can_check_core_release(void __iomem *m_can_base)
> +static int m_can_check_core_release(struct m_can_priv *priv)
>  {
>  	u32 crel_reg;
>  	u8 rel;
>  	u8 step;
>  	int res;
> -	struct m_can_priv temp_priv = {
> -		.base = m_can_base
> -	};
>  
>  	/* Read Core Release Version and split into version number
>  	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
>  	 */
> -	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
> +	crel_reg = m_can_read(priv, M_CAN_CREL);
>  	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
>  	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
>  
> @@ -1219,18 +1251,26 @@ static int m_can_check_core_release(void __iomem *m_can_base)
>  /* Selectable Non ISO support only in version 3.2.x
>   * This function checks if the bit is writable.
>   */
> -static bool m_can_niso_supported(const struct m_can_priv *priv)
> +static bool m_can_niso_supported(struct m_can_priv *priv)
>  {
> -	u32 cccr_reg, cccr_poll;
> -	int niso_timeout;
> +	u32 cccr_reg, cccr_poll = 0;
> +	int niso_timeout = -ETIMEDOUT;
> +	int i;
>  
>  	m_can_config_endisable(priv, true);
>  	cccr_reg = m_can_read(priv, M_CAN_CCCR);
>  	cccr_reg |= CCCR_NISO;
>  	m_can_write(priv, M_CAN_CCCR, cccr_reg);
>  
> -	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
> -					  (cccr_poll == cccr_reg), 0, 10);
> +	for (i = 0; i <= 10; i++) {
> +		cccr_poll = m_can_read(priv, M_CAN_CCCR);
> +		if (cccr_poll == cccr_reg) {
> +			niso_timeout = 0;
> +			break;
> +		}
> +
> +		usleep_range(1, 5);
> +	}
>  
>  	/* Clear NISO */
>  	cccr_reg &= ~(CCCR_NISO);
> @@ -1242,107 +1282,79 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
>  	return !niso_timeout;
>  }
>  
> -static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
> -			   void __iomem *addr)
> +static int m_can_dev_setup(struct m_can_priv *m_can_dev)
>  {
> -	struct m_can_priv *priv;
> +	struct net_device *dev = m_can_dev->net;
>  	int m_can_version;
>  
> -	m_can_version = m_can_check_core_release(addr);
> +	m_can_version = m_can_check_core_release(m_can_dev);
>  	/* return if unsupported version */
>  	if (!m_can_version) {
> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
>  			m_can_version);
>  		return -EINVAL;
>  	}
>  
> -	priv = netdev_priv(dev);
> -	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> +	if (!m_can_dev->is_peripheral)
> +		netif_napi_add(dev, &m_can_dev->napi,
> +			       m_can_poll, M_CAN_NAPI_WEIGHT);
>  
>  	/* Shared properties of all M_CAN versions */
> -	priv->version = m_can_version;
> -	priv->dev = dev;
> -	priv->base = addr;
> -	priv->can.do_set_mode = m_can_set_mode;
> -	priv->can.do_get_berr_counter = m_can_get_berr_counter;
> +	m_can_dev->version = m_can_version;
> +	m_can_dev->can.do_set_mode = m_can_set_mode;
> +	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
>  
>  	/* Set M_CAN supported operations */
> -	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>  					CAN_CTRLMODE_LISTENONLY |
>  					CAN_CTRLMODE_BERR_REPORTING |
>  					CAN_CTRLMODE_FD;
>  
>  	/* Set properties depending on M_CAN version */
> -	switch (priv->version) {
> +	switch (m_can_dev->version) {
>  	case 30:
>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		priv->can.bittiming_const = &m_can_bittiming_const_30X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_30X;
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_30X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_30X;
>  		break;
>  	case 31:
>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_31X;
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_31X;
>  		break;
>  	case 32:
> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_31X;
> -		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_31X;
> +
> +		m_can_dev->can.ctrlmode_supported |=
> +						(m_can_niso_supported(m_can_dev)
>  						? CAN_CTRLMODE_FD_NON_ISO
>  						: 0);
>  		break;
>  	default:
> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
> -			priv->version);
> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
> +			m_can_dev->version);
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> -}
> -
> -static int m_can_open(struct net_device *dev)
> -{
> -	struct m_can_priv *priv = netdev_priv(dev);
> -	int err;
> -
> -	err = m_can_clk_start(priv);
> -	if (err)
> -		return err;
> -
> -	/* open the can device */
> -	err = open_candev(dev);
> -	if (err) {
> -		netdev_err(dev, "failed to open can device\n");
> -		goto exit_disable_clks;
> -	}
> -
> -	/* register interrupt handler */
> -	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
> -			  dev);
> -	if (err < 0) {
> -		netdev_err(dev, "failed to request interrupt\n");
> -		goto exit_irq_fail;
> -	}
> -
> -	/* start the m_can controller */
> -	m_can_start(dev);
> -
> -	can_led_event(dev, CAN_LED_EVENT_OPEN);
> -	napi_enable(&priv->napi);
> -	netif_start_queue(dev);
> +	if (m_can_dev->ops->init)
> +		m_can_dev->ops->init(m_can_dev);
>  
>  	return 0;
> -
> -exit_irq_fail:
> -	close_candev(dev);
> -exit_disable_clks:
> -	m_can_clk_stop(priv);
> -	return err;
>  }
>  
>  static void m_can_stop(struct net_device *dev)
> @@ -1361,10 +1373,18 @@ static int m_can_close(struct net_device *dev)
>  	struct m_can_priv *priv = netdev_priv(dev);
>  
>  	netif_stop_queue(dev);
> -	napi_disable(&priv->napi);
> +	if (!priv->is_peripheral)
> +		napi_disable(&priv->napi);
>  	m_can_stop(dev);
>  	m_can_clk_stop(priv);
>  	free_irq(dev->irq, dev);
> +
> +	if (priv->is_peripheral) {
> +		priv->tx_skb = NULL;
> +		destroy_workqueue(priv->tx_wq);
> +		priv->tx_wq = NULL;
> +	}
> +
>  	close_candev(dev);
>  	can_led_event(dev, CAN_LED_EVENT_STOP);
>  
> @@ -1385,18 +1405,15 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
>  	return !!priv->can.echo_skb[next_idx];
>  }
>  
> -static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> -				    struct net_device *dev)
> +static netdev_tx_t m_can_tx_handler(struct m_can_priv *priv)
>  {
> -	struct m_can_priv *priv = netdev_priv(dev);
> -	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> +	struct canfd_frame *cf = (struct canfd_frame *)priv->tx_skb->data;
> +	struct net_device *dev = priv->net;
> +	struct sk_buff *skb = priv->tx_skb;
>  	u32 id, cccr, fdflags;
>  	int i;
>  	int putidx;
>  
> -	if (can_dropped_invalid_skb(dev, skb))
> -		return NETDEV_TX_OK;
> -
>  	/* Generate ID field for TX buffer Element */
>  	/* Common to all supported M_CAN versions */
>  	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -1451,7 +1468,13 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  			netif_stop_queue(dev);
>  			netdev_warn(dev,
>  				    "TX queue active although FIFO is full.");
> -			return NETDEV_TX_BUSY;
> +			if (priv->is_peripheral) {
> +				kfree_skb(skb);
> +				dev->stats.tx_dropped++;
> +				return NETDEV_TX_OK;
> +			} else {
> +				return NETDEV_TX_BUSY;
> +			}
>  		}
>  
>  		/* get put index for frame */
> @@ -1492,14 +1515,114 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
>  
>  		/* stop network queue if fifo full */
> -			if (m_can_tx_fifo_full(priv) ||
> -			    m_can_next_echo_skb_occupied(dev, putidx))
> -				netif_stop_queue(dev);
> +		if (m_can_tx_fifo_full(priv) ||
> +		    m_can_next_echo_skb_occupied(dev, putidx))
> +			netif_stop_queue(dev);
> +	}
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void m_can_tx_work_queue(struct work_struct *ws)
> +{
> +	struct m_can_priv *priv = container_of(ws, struct m_can_priv,
> +						tx_work);
> +	m_can_tx_handler(priv);
> +	priv->tx_skb = NULL;
> +}
> +
> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	struct m_can_priv *priv = netdev_priv(dev);
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (priv->is_peripheral) {
> +		if (priv->tx_skb) {
> +			netdev_err(dev, "hard_xmit called while tx busy\n");
> +			return NETDEV_TX_BUSY;
> +		}
> +
> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
> +			m_can_clean(dev);
> +		} else {

Could you please add a comment here about stopping the queue early. I
would also mention that an improved version may use an array of tx_skbs
 to support queueing of outgoing messages.

> +			priv->tx_skb = skb;
> +			netif_stop_queue(priv->net);
> +			queue_work(priv->tx_wq, &priv->tx_work);
> +		}
> +	} else {
> +		priv->tx_skb = skb;
> +		return m_can_tx_handler(priv);
>  	}
>  
>  	return NETDEV_TX_OK;
>  }

At the next respin, you can then add my

  Acked-by: Wolfgang Grandegger <wg@grandegger.com>

to the Patch 1/1, 1/2 and 1/4.

Thanks for your contribution and patience.

Wolfgang
