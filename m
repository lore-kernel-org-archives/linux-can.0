From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Tue, 10 Jan 2012 00:23:43 +0100
Message-ID: <4F0B76FF.3060107@pengutronix.de>
References: <691329.168246256-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C954A913A08C1888C32249E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209Ab2AIXXs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2012 18:23:48 -0500
In-Reply-To: <691329.168246256-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C954A913A08C1888C32249E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 01/09/2012 03:51 PM, Stephane Grosjean wrote:
> Please find below a new patch which goal is to include the support of t=
he
> PEAK-System PCMCIA board PCAN-PC Card. This board is SJA1000 based and =
is=20
> available as a single or dual CAN channel version.

The driver looks good, I cannot comment on the PCMCIA stuff though., see
comments inline.

Pleae use git send-mail to send your patches, please don't forget the
S-o-b line in the patch description.

> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 36e9d59..3c1e474 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -43,6 +43,13 @@ config CAN_EMS_PCI
>  	  CPC-PCIe and CPC-104P cards from EMS Dr. Thomas Wuensche
>  	  (http://www.ems-wuensche.de).
> =20
> +config CAN_PEAK_PCMCIA
> +	tristate "PEAK PCAN PC-CARD Card"
> +	depends on PCMCIA
> +	---help---
> +	  This driver is for the PCAN PC-CARD PCMCIA card with 1 or 2 channel=
s
> +	  from PEAK Systems (http://www.peak-system.com).
> +
>  config CAN_PEAK_PCI
>  	tristate "PEAK PCAN PCI/PCIe Cards"
>  	depends on PCI
> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000=
/Makefile
> index 0604f24..b3d05cb 100644
> --- a/drivers/net/can/sja1000/Makefile
> +++ b/drivers/net/can/sja1000/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) +=3D sja1000_of_p=
latform.o
>  obj-$(CONFIG_CAN_EMS_PCMCIA) +=3D ems_pcmcia.o
>  obj-$(CONFIG_CAN_EMS_PCI) +=3D ems_pci.o
>  obj-$(CONFIG_CAN_KVASER_PCI) +=3D kvaser_pci.o
> +obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o
>  obj-$(CONFIG_CAN_PEAK_PCI) +=3D peak_pci.o
>  obj-$(CONFIG_CAN_PLX_PCI) +=3D plx_pci.o
>  obj-$(CONFIG_CAN_TSCAN1) +=3D tscan1.o
> diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sj=
a1000/peak_pcmcia.c
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
> + * Copyright (C) 2010-2012 Stephane Grosjean <s.grosjean@peak-system.c=
om>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundat=
ion,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

Please remove the address. The FSF sometimes relocates it's office.

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

Can you use the same name for the driver and the .c file?

> +
> +/* PEAK-System PCMCIA driver version */
> +#define DRV_VERSION_MAJOR	0
> +#define DRV_VERSION_MINOR	2
> +#define DRV_VERSION_SUBMINOR	0
> +
> +#define DRV_VERSION_STRING __stringify(DRV_VERSION_MAJOR)"."\
> +	__stringify(DRV_VERSION_MINOR)"."\
> +	__stringify(DRV_VERSION_SUBMINOR)

please add whitespace before "\"

> +
> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
> +MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
> +MODULE_LICENSE("GPL v2");
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");
> +MODULE_VERSION(DRV_VERSION_STRING);
> +
> +#define DRV_CHAN_MAX 2
> +
> +#define DRV_CAN_CLOCK (16000000 / 2)
> +
> +#define DRV_MANF_ID	0x0377
> +#define DRV_CARD_ID	0x0001
> +
> +#define DRV_CHAN_SIZE	0x20
> +#define DRV_CHAN_OFF(c)	((c)*DRV_CHAN_SIZE)

please add whitespace before and after "*"

> +#define DRV_COMN_OFF	(DRV_CHAN_OFF(DRV_CHAN_MAX))
> +#define DRV_COMN_SIZE	0x40
> +
> +/* common area registers */
> +#define DRV_CCR	0x00
> +#define DRV_CSR	0x02
> +#define DRV_CPR	0x04
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
> +#define DRV_LED_ALL		(DRV_LED(0) | DRV_LED(1))
> +
> +/* led state value */
> +#define DRV_LED_ON	0x00
> +#define DRV_LED_FAST	0x01
> +#define DRV_LED_SLOW	0x02
> +#define DRV_LED_OFF	0x03
> +
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
> +
> +#define DRV_CCR_INIT	(DRV_CCR_CLK_16 | DRV_CCR_RST_ALL | DRV_CCR_LED_O=
FF_ALL)
> +
> +#define DRV_CSR_SPI_BUSY	0x04
> +#define DRV_SPI_MAX_WAIT_LOOP	100
> +#define DRV_WRITE_MAX_LOOP	1000
> +
> +/*
> + * The board configuration is probably following:
> + * RX1 is connected to ground.
> + * TX1 is not connected.
> + * CLKO is not connected.
> + * Setting the OCR register to 0xDA is a good idea.
> + * This means normal output mode, push-pull and the correct polarity.
> + */
> +#define DRV_OCR (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
> +
> +/*
> + * In the CDR register, you should set CBP to 1.
> + * You will probably also want to set the clock divider value to 7
> + * (meaning direct oscillator output) because the second SJA1000 chip
> + * is driven by the first one CLKOUT output.
> + */
> +#define DRV_CDR (CDR_CBP | CDR_CLKOUT_MASK)

Can you please properly align all the defines above (or don't align at
all). I personally prefer a common prefix for all functions and defines
used in a driver, maybe use PCAN_ instead of DRV_

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
> +static struct pcmcia_device_id pcan_table[] =3D {
> +	PCMCIA_DEVICE_MANF_CARD(DRV_MANF_ID, DRV_CARD_ID),
> +	PCMCIA_DEVICE_NULL,
> +};
> +
> +MODULE_DEVICE_TABLE(pcmcia, pcan_table);
> +
> +static void pcan_set_leds(struct pcan_pccard *card, u8 mask, u8 state)=
;
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
> +static void pcan_write_canreg(const struct sja1000_priv *priv, int por=
t, u8 v)

In the functions below port is always u8, here an int.

> +{
> +	struct pcan_pccard *card =3D priv->priv;
> +	int c =3D (priv->reg_base - card->ioport_addr) / DRV_CHAN_SIZE;
> +
> +	/* sja1000 register changes control the leds state */
> +	switch (port) {
> +	case REG_MOD:

I would use:
if (port =3D=3D REG_MOD), instead of the outer switch.

> +		switch (v) {
> +		case MOD_RM:
> +			/* Reset Mode: set led on */
> +			pcan_set_leds(card, DRV_LED(c), DRV_LED_ON);
> +			break;
> +		case 0x00:

is there a defefine for 0x0, too?

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
> +	if (port =3D=3D DRV_CCR) {
> +		if (card->ccr =3D=3D v)
> +			return;
> +		card->ccr =3D v;
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
> +	for (i =3D 0; i < DRV_SPI_MAX_WAIT_LOOP; i++) {
> +		if (!(pcan_read_reg(card, DRV_CSR) & DRV_CSR_SPI_BUSY))
> +			break;
> +		schedule();

How long does it take? Can you use msleep or usleep_range here?

> +	}
> +
> +	if (i >=3D DRV_SPI_MAX_WAIT_LOOP) {
> +		dev_err(&card->dev->dev, "failure: spi engine busy\n");

please use netdev_err()

> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * write data in device eeprom
> + */
> +static int pcan_write_eeprom(struct pcan_pccard *card, u16 addr, u8 v)=

> +{
> +	u8 status;
> +	int err, i;
> +
> +	/* write instruction */
> +	pcan_write_reg(card, DRV_SPI_INR, 0x06);

Can you define some macros for this and the following constants?

> +	err =3D pcan_wait_spi_busy(card);
> +	if (err)
> +		goto write_eeprom_err;
> +
> +	/* wait until write enable */
> +	for (i =3D 0; i < DRV_WRITE_MAX_LOOP; i++) {
> +		/* RDSR */
> +		pcan_write_reg(card, DRV_SPI_INR, 0x05);
> +		err =3D pcan_wait_spi_busy(card);
> +		if (err)
> +			goto write_eeprom_err;
> +		/* WEL */
> +		status =3D pcan_read_reg(card, DRV_SPI_DIR);
> +		if (status & 0x02)
> +			break;
> +	}
> +
> +	if (i >=3D DRV_WRITE_MAX_LOOP) {
> +		err =3D -EIO;
> +		goto write_eeprom_err;
> +	}
> +
> +	/* set address and data */
> +	pcan_write_reg(card, DRV_SPI_ADR, addr & 0xff);

The 3rd argument of pcan_write_reg() is u8, so the 0xff is not needed.

> +	pcan_write_reg(card, DRV_SPI_DOR, v);
> +
> +	/* write instruction with bit3 set accoridng to address */
> +	pcan_write_reg(card, DRV_SPI_INR, ((addr & 0x100) ? 8 : 0) | 0x02);
> +	err =3D pcan_wait_spi_busy(card);
> +	if (err)
> +		goto write_eeprom_err;
> +
> +	/* wait while write in progress */
> +	for (i =3D 0; i < DRV_WRITE_MAX_LOOP; i++) {
> +		/* RDSR */
> +		pcan_write_reg(card, DRV_SPI_INR, 0x05);
> +		err =3D pcan_wait_spi_busy(card);
> +		if (err)
> +			goto write_eeprom_err;
> +
> +		status =3D pcan_read_reg(card, DRV_SPI_DIR);
> +		if (!(status & 0x01))
> +			break;
> +	}
> +
> +	if (i >=3D DRV_WRITE_MAX_LOOP) {
> +		err =3D -EIO;
> +		goto write_eeprom_err;
> +	}
> +
> +	return 0;
> +
> +write_eeprom_err:
> +	dev_info(&card->dev->dev,
> +		"writing 0x%x in eeprom @0x%x failed (err %d)\n",
> +		v, addr, err);
netdev_info()
> +
> +	return err;
> +}
> +
> +/*
> + * control the leds
> + * @led_mask: should be an or made of DRV_LED(x)
> + * @state: DRV_LED_ON, DRV_LED_OFF, DRV_LED_SLOW or DRV_LED_FAST
> + */
> +static void pcan_set_leds(struct pcan_pccard *card, u8 led_mask, u8 st=
ate)
> +{
> +	u8 ccr =3D card->ccr;
> +	int i;
> +
> +	for (i =3D 0; i < card->chan_count; i++)
> +		if (led_mask & DRV_LED(i)) {
> +			/* clear corresponding led bits in ccr */
> +			ccr &=3D ~DRV_CCR_LED_MASK_CHAN(i);
> +			/* then set new bits */
> +			ccr |=3D DRV_CCR_LED_CHAN(state, i);
> +		}
> +
> +	/* real write only if something has changed in ccr */
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +}
> +
> +/*
> + * enable/disable CAN connector power
> + */
> +static inline void pcan_set_can_power(struct pcan_pccard *card, int on=
off)
> +{
> +	pcan_write_eeprom(card, 0, (onoff) ? 1 : 0);
> +}
> +
> +/*
> + * set leds state according to channel activity
> + */
> +static void pcan_led_timer(unsigned long arg)
> +{
> +	struct pcan_pccard *card =3D (struct pcan_pccard *)arg;
> +	struct net_device *netdev;
> +	u8 ccr =3D card->ccr;
> +	int i, up_count;
> +
> +	for (i =3D up_count =3D 0; i < card->chan_count; i++) {

Personally I would not initialize up_count in the for() loop, as it is
unrelated to it.

> +		/* default is: not configured */
> +		ccr &=3D ~DRV_CCR_LED_MASK_CHAN(i);
> +		ccr |=3D DRV_CCR_LED_ON_CHAN(i);
> +
> +		netdev =3D card->channel[i].netdev;
> +		if (!netdev || !(netdev->flags & IFF_UP))
> +			continue;
> +
> +		up_count++;
> +
> +		/* no activity (but configured) */
> +		ccr &=3D ~DRV_CCR_LED_MASK_CHAN(i);
> +		ccr |=3D DRV_CCR_LED_SLOW_CHAN(i);
> +
> +		/* if bytes counters changed, set fast blinking led */
> +		if (netdev->stats.rx_bytes !=3D card->channel[i].prev_rx_bytes) {
> +			card->channel[i].prev_rx_bytes =3D netdev->stats.rx_bytes;
> +			ccr &=3D ~DRV_CCR_LED_MASK_CHAN(i);
> +			ccr |=3D DRV_CCR_LED_FAST_CHAN(i);
> +		}
> +		if (netdev->stats.tx_bytes !=3D card->channel[i].prev_tx_bytes) {
> +			card->channel[i].prev_tx_bytes =3D netdev->stats.tx_bytes;
> +			ccr &=3D ~DRV_CCR_LED_MASK_CHAN(i);
> +			ccr |=3D DRV_CCR_LED_FAST_CHAN(i);
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
> +	struct pcan_pccard *card =3D dev_id;
> +	struct net_device *netdev;
> +	irqreturn_t retval =3D IRQ_NONE;
> +	int i, again;
> +
> +	do {
> +		again =3D 0;
> +
> +		/* Check interrupt for each channel */
> +		for (i =3D 0; i < card->chan_count; i++) {
> +			netdev =3D card->channel[i].netdev;
> +			if (!netdev)
> +				continue;
> +
> +			if (sja1000_interrupt(irq, netdev) =3D=3D IRQ_HANDLED)
> +				again =3D 1;
> +		}
> +
> +		/* At least one channel handled the interrupt */
> +		if (again)
> +			retval =3D IRQ_HANDLED;
> +
> +	} while (again);
> +
> +	return retval;
> +}
> +
> +/*
> + * free all resources used by the channels and switch off leds and can=
 power
> + */
> +static void pcan_free_channels(struct pcan_pccard *card)
> +{
> +	int i;
> +	u8 led_mask =3D 0;
> +
> +	for (i =3D 0; i < card->chan_count; i++) {
> +		struct net_device *netdev;
> +		char name[IFNAMSIZ];
> +
> +		led_mask |=3D DRV_LED(i);
> +
> +		netdev =3D card->channel[i].netdev;
> +		if (!netdev)
> +			continue;
> +
> +		strncpy(name, netdev->name, IFNAMSIZ);
> +		unregister_sja1000dev(netdev);
> +		free_sja1000dev(netdev);
> +
> +		dev_info(&card->dev->dev, "%s removed\n", name);
netdev_info()...maybe remove altogether
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
> +	if (pcan_read_canreg(priv, REG_CDR) =3D=3D CDR_PELICAN)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int pcan_add_channels(struct pcan_pccard *card)
> +{
> +	struct pcmcia_device *dev =3D card->dev;
> +	int i, err;
> +	u8 ccr =3D DRV_CCR_INIT;
> +	unsigned long rst_time;
                      ^^^^^^^^

this var is used write only, please remove.

> +
> +	/* init common registers (reset channels and leds off) */
> +	card->ccr =3D ~ccr;
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +	rst_time =3D jiffies;
> +
> +	/* wait 2ms before unresetting channels */
> +	mdelay(2);
> +
> +	ccr &=3D ~DRV_CCR_RST_ALL;
> +	pcan_write_reg(card, DRV_CCR, ccr);
> +
> +	/* create one network device per channel detected */
> +	for (i =3D 0; i < DRV_CHAN_MAX; i++) {

For documentation reasons I suggest to use
ARRAY_SIZE(card->channel) instead of DRV_CHAN_MAX.

> +		struct net_device *netdev;
> +		struct sja1000_priv *priv;
> +
> +		netdev =3D alloc_sja1000dev(0);
> +		if (!netdev) {
> +			err =3D -ENOMEM;
> +			break;

please do a proper cleanup if this fails with i !=3D 0.

> +		}
> +
> +		/* update linkages */
> +		priv =3D netdev_priv(netdev);
> +		priv->priv =3D card;
> +		SET_NETDEV_DEV(netdev, &dev->dev);
> +
> +		priv->irq_flags =3D IRQF_SHARED;
> +		netdev->irq =3D dev->irq;
> +		priv->reg_base =3D card->ioport_addr + DRV_CHAN_OFF(i);
> +
> +		/* check if channel is present */
> +		if (!pcan_check_channel(priv)) {
> +			dev_err(&dev->dev, "channel %d not present\n", i);
> +			free_sja1000dev(netdev);

same here
> +			continue;
> +		}
> +
> +		priv->read_reg  =3D pcan_read_canreg;
> +		priv->write_reg =3D pcan_write_canreg;
> +		priv->can.clock.freq =3D DRV_CAN_CLOCK;
> +		priv->ocr =3D DRV_OCR;
> +		priv->cdr =3D DRV_CDR;
> +		priv->flags |=3D SJA1000_CUSTOM_IRQ_HANDLER;
> +
> +		/* register SJA1000 device */
> +		err =3D register_sja1000dev(netdev);
> +		if (err) {
> +			free_sja1000dev(netdev);

dito

> +			continue;
> +		}
> +
> +		card->channel[i].netdev =3D netdev;
> +		card->chan_count++;
> +
> +		/* set corresponding led on in the new ccr */
> +		ccr &=3D ~DRV_CCR_LED_OFF_CHAN(i);
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
> +static int pcan_conf_check(struct pcmcia_device *dev, void *priv_data)=

> +{
> +	dev->resource[0]->flags &=3D ~IO_DATA_PATH_WIDTH;
> +	dev->resource[0]->flags |=3D IO_DATA_PATH_WIDTH_8; /* only */
> +	dev->io_lines =3D 10;
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

Can this happen?

> +
> +	pcan_stop_led_timer(dev->priv);
> +	free_irq(dev->irq, dev->priv);
> +	pcan_free_channels(dev->priv);
> +
> +	kfree(dev->priv);
> +	dev->priv =3D NULL;
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
> +	dev->config_flags |=3D CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
> +
> +	err =3D pcmcia_loop_config(dev, pcan_conf_check, NULL);
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

better make it only one dev_info(); there might be other printks
interfering...

> +
> +	/*
> +	 * Note:
> +	 * base_port =3D ioport_addr =3D dev->resource[0]->start
> +	 * port_count =3D dev->resource[0]->end
> +	 */
> +
> +	if (!dev->irq) {
> +		dev_err(&dev->dev, "no irq assigned\n");
> +		err =3D -ENODEV;
> +		goto probe_err_1;
> +	}
> +
> +	err =3D pcmcia_enable_device(dev);
> +	if (err) {
> +		dev_err(&dev->dev, "pcmcia_enable_device failed err=3D%d\n",
> +			err);
> +		goto probe_err_1;
> +	}
> +
> +	card =3D kzalloc(sizeof(struct pcan_pccard), GFP_KERNEL);
> +	if (!card) {
> +		dev_err(&dev->dev, "kzalloc() failure\n");
> +		err =3D -ENOMEM;
> +		goto probe_err_2;
> +	}
> +
> +	card->dev =3D dev;
> +	dev->priv =3D card;
> +
> +	/* sja1000 api uses iomem */
> +	card->ioport_addr =3D ioport_map(dev->resource[0]->start,
> +					resource_size(dev->resource[0]));
> +	if (!card->ioport_addr) {
> +		err =3D -ENOMEM;
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
> +	card->led_timer.function =3D pcan_led_timer;
> +	card->led_timer.data =3D (unsigned long)card;
> +
> +	/* request the given irq */
> +	err =3D request_irq(dev->irq, &pcan_isr, IRQF_SHARED, DRV_NAME, card)=
;
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
> +	dev->priv =3D NULL;
> +
> +probe_err_2:
> +	pcmcia_disable_device(dev);
> +
> +probe_err_1:
> +	return err;
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
> +static struct pcmcia_driver pcan_driver =3D {
> +	.name =3D DRV_NAME,
> +	.probe =3D pcan_probe,
> +	.remove =3D pcan_remove,
> +	.id_table =3D pcan_table,
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
>=20
cheers, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5C954A913A08C1888C32249E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8LdwEACgkQjTAFq1RaXHPdkwCfQ7cQzf+XN04AjZ4rjAl4rwUc
NQgAoIFL0Jl4X8GKzeI9chAbIf+cv8YB
=ASKf
-----END PGP SIGNATURE-----

--------------enig5C954A913A08C1888C32249E--
