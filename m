From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Tue, 10 Jan 2012 14:41:52 +0100
Message-ID: <4F0C4020.8010304@grandegger.com>
References: <691329.168246256-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50541 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab2AJNl4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 08:41:56 -0500
In-Reply-To: <691329.168246256-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

please send a patch using a proper subject line and commit message. Also
add a CC to the pcmcia linux mailing list. Thanks.

On 01/09/2012 03:51 PM, Stephane Grosjean wrote:
> Hi,
> 
> Please find below a new patch which goal is to include the support of the
> PEAK-System PCMCIA board PCAN-PC Card. This board is SJA1000 based and is 
> available as a single or dual CAN channel version.

Nice, I have such a pcmcia card...

> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
> index 36e9d59..3c1e474 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -43,6 +43,13 @@ config CAN_EMS_PCI
>  	  CPC-PCIe and CPC-104P cards from EMS Dr. Thomas Wuensche
>  	  (http://www.ems-wuensche.de).
>  
> +config CAN_PEAK_PCMCIA
> +	tristate "PEAK PCAN PC-CARD Card"
> +	depends on PCMCIA
> +	---help---
> +	  This driver is for the PCAN PC-CARD PCMCIA card with 1 or 2 channels
> +	  from PEAK Systems (http://www.peak-system.com).
> +
>  config CAN_PEAK_PCI
>  	tristate "PEAK PCAN PCI/PCIe Cards"
>  	depends on PCI
> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000/Makefile
> index 0604f24..b3d05cb 100644
> --- a/drivers/net/can/sja1000/Makefile
> +++ b/drivers/net/can/sja1000/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) += sja1000_of_platform.o
>  obj-$(CONFIG_CAN_EMS_PCMCIA) += ems_pcmcia.o
>  obj-$(CONFIG_CAN_EMS_PCI) += ems_pci.o
>  obj-$(CONFIG_CAN_KVASER_PCI) += kvaser_pci.o
> +obj-$(CONFIG_CAN_PEAK_PCMCIA) += peak_pcmcia.o
>  obj-$(CONFIG_CAN_PEAK_PCI) += peak_pci.o
>  obj-$(CONFIG_CAN_PLX_PCI) += plx_pci.o
>  obj-$(CONFIG_CAN_TSCAN1) += tscan1.o
> diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
> new file mode 100644
> index 0000000..e409a8b
> --- /dev/null
> +++ b/drivers/net/can/sja1000/peak_pcmcia.c
> @@ -0,0 +1,707 @@
> +/*
> + * CAN driver for PEAK-System PCAN-PCARD
> + * Derived from the PCAN project file driver/src/pcan_pccard.c
> + *
> + * Copyright (C) 2006-2009 PEAK System-Technik GmbH
> + * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the version 2 of the GNU General Public License
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundation,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/netdevice.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/io.h>
> +#include <pcmcia/cistpl.h>
> +#include <pcmcia/ds.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/stringify.h>
> +#include "sja1000.h"
> +
> +/* PEAK-System PCMCIA driver name */
> +#define DRV_NAME "peak_pccard"

I find the mix of "peak_pcmcia" and "peak_pccard" and "pcan_pccard" for
the same hardware confusing. Please use just one name and prefix.

> +
> +/* PEAK-System PCMCIA driver version */
> +#define DRV_VERSION_MAJOR	0
> +#define DRV_VERSION_MINOR	2
> +#define DRV_VERSION_SUBMINOR	0
> +
> +#define DRV_VERSION_STRING __stringify(DRV_VERSION_MAJOR)"."\
> +	__stringify(DRV_VERSION_MINOR)"."\
> +	__stringify(DRV_VERSION_SUBMINOR)

As for the USB driver, I would remove this redundant versioning stuff.
Also version 0.2.0 does not really sound like like a stable piece of
software.

> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
> +MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
> +MODULE_LICENSE("GPL v2");
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");
> +MODULE_VERSION(DRV_VERSION_STRING);
> +
> +#define DRV_CHAN_MAX 2
> +
> +#define DRV_CAN_CLOCK (16000000 / 2)

Hm, the prefix DRV_ here and below does not really make sense. But well,
it's a minor issue.

> +#define DRV_MANF_ID	0x0377
> +#define DRV_CARD_ID	0x0001
> +
> +#define DRV_CHAN_SIZE	0x20
> +#define DRV_CHAN_OFF(c)	((c)*DRV_CHAN_SIZE)

Spaces around "*"

> +#define DRV_COMN_OFF	(DRV_CHAN_OFF(DRV_CHAN_MAX))

Please align with tabs and remove "()".

> +#define DRV_COMN_SIZE	0x40
> +
> +/* common area registers */
> +#define DRV_CCR	0x00
> +#define DRV_CSR	0x02
> +#define DRV_CPR	0x04

Add tabs for the 3 lines above.

> +#define DRV_SPI_DIR	0x06
> +#define DRV_SPI_DOR	0x08
> +#define DRV_SPI_ADR	0x0a
> +#define DRV_SPI_INR	0x0c
> +#define DRV_FW_MAJOR	0x10
> +#define DRV_FW_MINOR	0x12
> +
> +/* CCR bits */
> +#define DRV_CCR_CLK_16	0x00
> +#define DRV_CCR_CLK_10	0x01
> +#define DRV_CCR_CLK_21	0x02
> +#define DRV_CCR_CLK_8	0x03
> +#define DRV_CCR_CLK_MASK	DRV_CCR_CLK_8
> +
> +#define DRV_CCR_RST_CHAN(c)	(0x01 << ((c) + 2))
> +#define DRV_CCR_RST_ALL	(DRV_CCR_RST_CHAN(0) | DRV_CCR_RST_CHAN(1))
> +#define DRV_CCR_RST_MASK	DRV_CCR_RST_ALL
> +
> +/* led selection bits */
> +#define DRV_LED(c)	(1 << (c))

Tabs?

> +#define DRV_LED_ALL		(DRV_LED(0) | DRV_LED(1))
> +
> +/* led state value */
> +#define DRV_LED_ON	0x00
> +#define DRV_LED_FAST	0x01
> +#define DRV_LED_SLOW	0x02
> +#define DRV_LED_OFF	0x03

Please align as all other #defines.

> +#define DRV_CCR_LED_CHAN(s, c)	((s) << (((c) + 2) << 1))
> +
> +#define DRV_CCR_LED_ON_CHAN(c)	DRV_CCR_LED_CHAN(DRV_LED_ON, c)
> +#define DRV_CCR_LED_FAST_CHAN(c)	DRV_CCR_LED_CHAN(DRV_LED_FAST, c)
> +#define DRV_CCR_LED_SLOW_CHAN(c)	DRV_CCR_LED_CHAN(DRV_LED_SLOW, c)
> +#define DRV_CCR_LED_OFF_CHAN(c)	DRV_CCR_LED_CHAN(DRV_LED_OFF, c)
> +#define DRV_CCR_LED_MASK_CHAN(c)	DRV_CCR_LED_OFF_CHAN(c)
> +#define DRV_CCR_LED_OFF_ALL	(DRV_CCR_LED_OFF_CHAN(0) | \
> +				 DRV_CCR_LED_OFF_CHAN(1))
> +#define DRV_CCR_LED_MASK	DRV_CCR_LED_OFF_ALL

Ditto.

> +#define DRV_CCR_INIT	(DRV_CCR_CLK_16 | DRV_CCR_RST_ALL | DRV_CCR_LED_OFF_ALL)

Ditto

> +#define DRV_CSR_SPI_BUSY	0x04
> +#define DRV_SPI_MAX_WAIT_LOOP	100
> +#define DRV_WRITE_MAX_LOOP	1000

Ditto

> +/*
> + * The board configuration is probably following:
> + * RX1 is connected to ground.
> + * TX1 is not connected.
> + * CLKO is not connected.
> + * Setting the OCR register to 0xDA is a good idea.
> + * This means normal output mode, push-pull and the correct polarity.
> + */
> +#define DRV_OCR (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)

Ditto

> +
> +/*
> + * In the CDR register, you should set CBP to 1.
> + * You will probably also want to set the clock divider value to 7
> + * (meaning direct oscillator output) because the second SJA1000 chip
> + * is driven by the first one CLKOUT output.
> + */
> +#define DRV_CDR (CDR_CBP | CDR_CLKOUT_MASK)

Ditto

> +
> +struct pcan_channel {
> +	struct net_device *netdev;
> +	unsigned long prev_rx_bytes;
> +	unsigned long prev_tx_bytes;
> +};
> +
> +/* PCAN-PC Card private structure */
> +struct pcan_pccard {
> +	struct pcmcia_device *dev;
> +	int chan_count;
> +	struct pcan_channel channel[DRV_CHAN_MAX];
> +	u8 ccr;
> +	void __iomem *ioport_addr;
> +	struct timer_list led_timer;
> +};
> +
> +static struct pcmcia_device_id pcan_table[] = {
> +	PCMCIA_DEVICE_MANF_CARD(DRV_MANF_ID, DRV_CARD_ID),
> +	PCMCIA_DEVICE_NULL,
> +};
> +
> +MODULE_DEVICE_TABLE(pcmcia, pcan_table);
> +
> +static void pcan_set_leds(struct pcan_pccard *card, u8 mask, u8 state);
> +
> +/*
> + * start timer which controls leds state
> + */
> +static void pcan_start_led_timer(struct pcan_pccard *card)
> +{
> +	if (!timer_pending(&card->led_timer))
> +		mod_timer(&card->led_timer, jiffies + HZ);
> +}
> +
> +/*
> + * stop the timer which controls leds state
> + */
> +static void pcan_stop_led_timer(struct pcan_pccard *card)
> +{
> +	del_timer_sync(&card->led_timer);
> +}
> +
> +/*
> + * read a sja1000 register
> + */
> +static u8 pcan_read_canreg(const struct sja1000_priv *priv, int port)
> +{
> +	return ioread8(priv->reg_base + port);
> +}
> +
> +/*
> + * write a sja1000 register
> + */
> +static void pcan_write_canreg(const struct sja1000_priv *priv, int port, u8 v)
> +{
> +	struct pcan_pccard *card = priv->priv;
> +	int c = (priv->reg_base - card->ioport_addr) / DRV_CHAN_SIZE;
> +
> +	/* sja1000 register changes control the leds state */
> +	switch (port) {
> +	case REG_MOD:
> +		switch (v) {
> +		case MOD_RM:
> +			/* Reset Mode: set led on */
> +			pcan_set_leds(card, DRV_LED(c), DRV_LED_ON);
> +			break;
> +		case 0x00:
> +			/* Normal Mode: led slow blinking and start led timer */
> +			pcan_set_leds(card, DRV_LED(c), DRV_LED_SLOW);
> +			pcan_start_led_timer(card);
> +			break;
> +		}
> +		break;
> +	}
> +	iowrite8(v, priv->reg_base + port);
> +}
> +
> +/*
> + * read a register from the common area
> + */
> +static u8 pcan_read_reg(struct pcan_pccard *card, u8 port)
> +{
> +	return ioread8(card->ioport_addr + DRV_COMN_OFF + port);
> +}
> +
> +/*
> + * write a register into the common area
> + */
> +static void pcan_write_reg(struct pcan_pccard *card, u8 port, u8 v)
> +{
> +	/* cache ccr value */
> +	if (port == DRV_CCR) {
> +		if (card->ccr == v)
> +			return;
> +		card->ccr = v;
> +	}
> +
> +	iowrite8(v, card->ioport_addr + DRV_COMN_OFF + port);
> +}
> +
> +/*
> + * wait for SPI engine while it is busy
> + */
> +static int pcan_wait_spi_busy(struct pcan_pccard *card)
> +{
> +	int i;
> +
> +	for (i = 0; i < DRV_SPI_MAX_WAIT_LOOP; i++) {
> +		if (!(pcan_read_reg(card, DRV_CSR) & DRV_CSR_SPI_BUSY))
> +			break;
> +		schedule();
> +	}
> +
> +	if (i >= DRV_SPI_MAX_WAIT_LOOP) {
> +		dev_err(&card->dev->dev, "failure: spi engine busy\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * write data in device eeprom
> + */
> +static int pcan_write_eeprom(struct pcan_pccard *card, u16 addr, u8 v)
> +{
> +	u8 status;
> +	int err, i;
> +
> +	/* write instruction */
> +	pcan_write_reg(card, DRV_SPI_INR, 0x06);

Macro definitons would be nice.

> +	err = pcan_wait_spi_busy(card);
> +	if (err)
> +		goto write_eeprom_err;
> +
> +	/* wait until write enable */
> +	for (i = 0; i < DRV_WRITE_MAX_LOOP; i++) {
> +		/* RDSR */

This comment does not tell me anything.

> +		pcan_write_reg(card, DRV_SPI_INR, 0x05);
> +		err = pcan_wait_spi_busy(card);
> +		if (err)
> +			goto write_eeprom_err;
> +		/* WEL */

Ditto.

> +		status = pcan_read_reg(card, DRV_SPI_DIR);
> +		if (status & 0x02)

Macro definitions would be nice here and in other places to better
understand the code.

> +			break;
> +	}
> +
> +	if (i >= DRV_WRITE_MAX_LOOP) {
> +		err = -EIO;
> +		goto write_eeprom_err;
> +	}
> +
> +	/* set address and data */
> +	pcan_write_reg(card, DRV_SPI_ADR, addr & 0xff);
> +	pcan_write_reg(card, DRV_SPI_DOR, v);
> +
> +	/* write instruction with bit3 set accoridng to address */
> +	pcan_write_reg(card, DRV_SPI_INR, ((addr & 0x100) ? 8 : 0) | 0x02);

Ditto.

> +	err = pcan_wait_spi_busy(card);
> +	if (err)
> +		goto write_eeprom_err;
> +
> +	/* wait while write in progress */
> +	for (i = 0; i < DRV_WRITE_MAX_LOOP; i++) {
> +		/* RDSR */
> +		pcan_write_reg(card, DRV_SPI_INR, 0x05);
> +		err = pcan_wait_spi_busy(card);
> +		if (err)
> +			goto write_eeprom_err;
> +
> +		status = pcan_read_reg(card, DRV_SPI_DIR);
> +		if (!(status & 0x01))

Ditto.

> +			break;
> +	}
> +
> +	if (i >= DRV_WRITE_MAX_LOOP) {
> +		err = -EIO;
> +		goto write_eeprom_err;
> +	}
> +
> +	return 0;
> +
> +write_eeprom_err:
> +	dev_info(&card->dev->dev,
> +		"writing 0x%x in eeprom @0x%x failed (err %d)\n",
> +		v, addr, err);

Info or error. Can this happen? If yes, how often?

> +	return err;
> +}
> +
> +/*
> + * control the leds
> + * @led_mask: should be an or made of DRV_LED(x)
> + * @state: DRV_LED_ON, DRV_LED_OFF, DRV_LED_SLOW or DRV_LED_FAST
> + */

Please remove the docbook tags.

> +static void pcan_set_leds(struct pcan_pccard *card, u8 led_mask, u8 state)
> +{
> +	u8 ccr = card->ccr;
> +	int i;
> +
> +	for (i = 0; i < card->chan_count; i++)
> +		if (led_mask & DRV_LED(i)) {
> +			/* clear corresponding led bits in ccr */
> +			ccr &= ~DRV_CCR_LED_MASK_CHAN(i);
> +			/* then set new bits */
> +			ccr |= DRV_CCR_LED_CHAN(state, i);
> +		}
> +
> +	/* real write only if something has changed in ccr */
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +}
> +
> +/*
> + * enable/disable CAN connector power
> + */
> +static inline void pcan_set_can_power(struct pcan_pccard *card, int onoff)
> +{
> +	pcan_write_eeprom(card, 0, (onoff) ? 1 : 0);
> +}
> +
> +/*
> + * set leds state according to channel activity
> + */
> +static void pcan_led_timer(unsigned long arg)
> +{
> +	struct pcan_pccard *card = (struct pcan_pccard *)arg;
> +	struct net_device *netdev;
> +	u8 ccr = card->ccr;
> +	int i, up_count;
> +
> +	for (i = up_count = 0; i < card->chan_count; i++) {
> +		/* default is: not configured */
> +		ccr &= ~DRV_CCR_LED_MASK_CHAN(i);
> +		ccr |= DRV_CCR_LED_ON_CHAN(i);
> +
> +		netdev = card->channel[i].netdev;
> +		if (!netdev || !(netdev->flags & IFF_UP))
> +			continue;
> +
> +		up_count++;
> +
> +		/* no activity (but configured) */
> +		ccr &= ~DRV_CCR_LED_MASK_CHAN(i);
> +		ccr |= DRV_CCR_LED_SLOW_CHAN(i);
> +
> +		/* if bytes counters changed, set fast blinking led */
> +		if (netdev->stats.rx_bytes != card->channel[i].prev_rx_bytes) {
> +			card->channel[i].prev_rx_bytes = netdev->stats.rx_bytes;
> +			ccr &= ~DRV_CCR_LED_MASK_CHAN(i);
> +			ccr |= DRV_CCR_LED_FAST_CHAN(i);
> +		}
> +		if (netdev->stats.tx_bytes != card->channel[i].prev_tx_bytes) {
> +			card->channel[i].prev_tx_bytes = netdev->stats.tx_bytes;
> +			ccr &= ~DRV_CCR_LED_MASK_CHAN(i);
> +			ccr |= DRV_CCR_LED_FAST_CHAN(i);
> +		}
> +	}
> +
> +	/* write the new leds state */
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +
> +	/* restart timer (except if no more configured channels) */
> +	if (up_count)
> +		mod_timer(&card->led_timer, jiffies + HZ);
> +}
> +
> +/*
> + * interrupt service routine
> + */
> +static irqreturn_t pcan_isr(int irq, void *dev_id)
> +{
> +	struct pcan_pccard *card = dev_id;
> +	struct net_device *netdev;
> +	irqreturn_t retval = IRQ_NONE;
> +	int i, again;
> +
> +	do {
> +		again = 0;
> +
> +		/* Check interrupt for each channel */
> +		for (i = 0; i < card->chan_count; i++) {
> +			netdev = card->channel[i].netdev;
> +			if (!netdev)
> +				continue;
> +
> +			if (sja1000_interrupt(irq, netdev) == IRQ_HANDLED)
> +				again = 1;
> +		}
> +
> +		/* At least one channel handled the interrupt */
> +		if (again)
> +			retval = IRQ_HANDLED;
> +
> +	} while (again);

I wonder if it makes sense to limit the loop count.

> +	return retval;
> +}
> +
> +/*
> + * free all resources used by the channels and switch off leds and can power
> + */
> +static void pcan_free_channels(struct pcan_pccard *card)
> +{
> +	int i;
> +	u8 led_mask = 0;
> +
> +	for (i = 0; i < card->chan_count; i++) {
> +		struct net_device *netdev;
> +		char name[IFNAMSIZ];
> +
> +		led_mask |= DRV_LED(i);
> +
> +		netdev = card->channel[i].netdev;
> +		if (!netdev)
> +			continue;
> +
> +		strncpy(name, netdev->name, IFNAMSIZ);
> +		unregister_sja1000dev(netdev);
> +		free_sja1000dev(netdev);
> +
> +		dev_info(&card->dev->dev, "%s removed\n", name);
> +	}
> +
> +	if (pcmcia_dev_present(card->dev)) {
> +		pcan_set_leds(card, led_mask, DRV_LED_OFF);
> +		pcan_set_can_power(card, 0);
> +	}
> +
> +	ioport_unmap(card->ioport_addr);
> +}
> +
> +/*
> + * check if a CAN controller is present at the specified location
> + */
> +static inline int pcan_check_channel(struct sja1000_priv *priv)
> +{
> +	/* make sure SJA1000 is in reset mode */
> +	pcan_write_canreg(priv, REG_MOD, 1);
> +	pcan_write_canreg(priv, REG_CDR, CDR_PELICAN);
> +
> +	/* read reset-values */
> +	if (pcan_read_canreg(priv, REG_CDR) == CDR_PELICAN)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int pcan_add_channels(struct pcan_pccard *card)
> +{
> +	struct pcmcia_device *dev = card->dev;
> +	int i, err;
> +	u8 ccr = DRV_CCR_INIT;
> +	unsigned long rst_time;
> +
> +	/* init common registers (reset channels and leds off) */
> +	card->ccr = ~ccr;
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +	rst_time = jiffies;
> +
> +	/* wait 2ms before unresetting channels */
> +	mdelay(2);
> +
> +	ccr &= ~DRV_CCR_RST_ALL;
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +
> +	/* create one network device per channel detected */
> +	for (i = 0; i < DRV_CHAN_MAX; i++) {
> +		struct net_device *netdev;
> +		struct sja1000_priv *priv;
> +
> +		netdev = alloc_sja1000dev(0);
> +		if (!netdev) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		/* update linkages */
> +		priv = netdev_priv(netdev);
> +		priv->priv = card;
> +		SET_NETDEV_DEV(netdev, &dev->dev);
> +
> +		priv->irq_flags = IRQF_SHARED;
> +		netdev->irq = dev->irq;
> +		priv->reg_base = card->ioport_addr + DRV_CHAN_OFF(i);
> +
> +		/* check if channel is present */
> +		if (!pcan_check_channel(priv)) {
> +			dev_err(&dev->dev, "channel %d not present\n", i);
> +			free_sja1000dev(netdev);
> +			continue;
> +		}
> +
> +		priv->read_reg  = pcan_read_canreg;
> +		priv->write_reg = pcan_write_canreg;
> +		priv->can.clock.freq = DRV_CAN_CLOCK;
> +		priv->ocr = DRV_OCR;
> +		priv->cdr = DRV_CDR;
> +		priv->flags |= SJA1000_CUSTOM_IRQ_HANDLER;
> +
> +		/* register SJA1000 device */
> +		err = register_sja1000dev(netdev);
> +		if (err) {
> +			free_sja1000dev(netdev);
> +			continue;
> +		}
> +
> +		card->channel[i].netdev = netdev;
> +		card->chan_count++;
> +
> +		/* set corresponding led on in the new ccr */
> +		ccr &= ~DRV_CCR_LED_OFF_CHAN(i);
> +
> +		dev_info(&dev->dev,
> +			"registered %s on channel %d at 0x%p irq %d\n",
> +			netdev->name, i, priv->reg_base, dev->irq);
> +	}
> +
> +	/* write new ccr (change leds state) */
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +
> +	return err;
> +}
> +
> +static int pcan_conf_check(struct pcmcia_device *dev, void *priv_data)
> +{
> +	dev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
> +	dev->resource[0]->flags |= IO_DATA_PATH_WIDTH_8; /* only */
> +	dev->io_lines = 10;
> +
> +	/* This reserves IO space but doesn't actually enable it */
> +	return pcmcia_request_io(dev);
> +}
> +
> +/*
> + * free all resources used by the device
> + */
> +static void pcan_free(struct pcmcia_device *dev)
> +{
> +	if (!dev->priv)
> +		return;
> +
> +	pcan_stop_led_timer(dev->priv);
> +	free_irq(dev->irq, dev->priv);
> +	pcan_free_channels(dev->priv);
> +
> +	kfree(dev->priv);
> +	dev->priv = NULL;
> +}
> +
> +/*
> + * setup PCMCIA socket and probe for PEAK-System PC-CARD
> + */
> +static int __devinit pcan_probe(struct pcmcia_device *dev)
> +{
> +	struct pcan_pccard *card;
> +	int err;
> +
> +	dev->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
> +
> +	err = pcmcia_loop_config(dev, pcan_conf_check, NULL);
> +	if (err) {
> +		dev_err(&dev->dev, "pcmcia_loop_config() error %d\n", err);
> +		goto probe_err_1;
> +	}
> +
> +	dev_info(&dev->dev, "new PEAK-System pcmcia card detected:\n");
> +
> +	dev_info(&dev->dev, "%s %s\n",
> +		dev->prod_id[0] ? dev->prod_id[0] : "PEAK-System",
> +		dev->prod_id[1] ? dev->prod_id[1] : "PCAN-PC Card");

One line (dev_info) should be enough. Also "dev->dev" is not really
readable. "dev->p[cmcia_]dev" would be much better.

> +
> +	/*
> +	 * Note:
> +	 * base_port = ioport_addr = dev->resource[0]->start
> +	 * port_count = dev->resource[0]->end
> +	 */
> +
> +	if (!dev->irq) {
> +		dev_err(&dev->dev, "no irq assigned\n");
> +		err = -ENODEV;
> +		goto probe_err_1;
> +	}
> +
> +	err = pcmcia_enable_device(dev);
> +	if (err) {
> +		dev_err(&dev->dev, "pcmcia_enable_device failed err=%d\n",
> +			err);
> +		goto probe_err_1;
> +	}
> +
> +	card = kzalloc(sizeof(struct pcan_pccard), GFP_KERNEL);
> +	if (!card) {
> +		dev_err(&dev->dev, "kzalloc() failure\n");

Please be more specific, e.g.: "couldn't allocated card memory".

> +		err = -ENOMEM;
> +		goto probe_err_2;
> +	}
> +
> +	card->dev = dev;
> +	dev->priv = card;
> +
> +	/* sja1000 api uses iomem */
> +	card->ioport_addr = ioport_map(dev->resource[0]->start,
> +					resource_size(dev->resource[0]));
> +	if (!card->ioport_addr) {
> +		err = -ENOMEM;
> +		goto probe_err_3;
> +	}
> +
> +	/* display firware version */
> +	dev_info(&dev->dev, "firmware %d.%d\n",
> +		pcan_read_reg(card, DRV_FW_MAJOR),
> +		pcan_read_reg(card, DRV_FW_MINOR));
> +
> +	/* detect available channels */
> +	pcan_add_channels(card);
> +	if (!card->chan_count)
> +		goto probe_err_3;
> +
> +	/* init the timer which controls the leds */
> +	init_timer(&card->led_timer);
> +	card->led_timer.function = pcan_led_timer;
> +	card->led_timer.data = (unsigned long)card;
> +
> +	/* request the given irq */
> +	err = request_irq(dev->irq, &pcan_isr, IRQF_SHARED, DRV_NAME, card);
> +	if (err)
> +		goto probe_err_4;
> +
> +	/* power on the connectors */
> +	pcan_set_can_power(card, 1);
> +
> +	return 0;
> +
> +probe_err_4:
> +	/* unregister can devices from network */
> +	pcan_free_channels(card);
> +
> +probe_err_3:
> +	kfree(card);
> +	dev->priv = NULL;
> +
> +probe_err_2:
> +	pcmcia_disable_device(dev);
> +
> +probe_err_1:
> +	return err;

I'm missing ioport_unmap()!

> +}
> +
> +/*
> + * release claimed resources
> + */
> +static void pcan_remove(struct pcmcia_device *dev)
> +{
> +	pcan_free(dev);
> +	pcmcia_disable_device(dev);
> +}
> +
> +static struct pcmcia_driver pcan_driver = {
> +	.name = DRV_NAME,
> +	.probe = pcan_probe,
> +	.remove = pcan_remove,
> +	.id_table = pcan_table,
> +};
> +
> +static int __init pcan_init(void)
> +{
> +	return pcmcia_register_driver(&pcan_driver);
> +}
> +module_init(pcan_init);
> +
> +static void __exit pcan_exit(void)
> +{
> +	pcmcia_unregister_driver(&pcan_driver);
> +}
> +module_exit(pcan_exit);

Thanks for your contribution.

Wolfgang.

