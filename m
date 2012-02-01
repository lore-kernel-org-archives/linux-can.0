From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 16:21:09 +0100
Message-ID: <4F295865.2040304@pengutronix.de>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D32BFB3A8706687D25470CE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47848 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab2BAPVR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 10:21:17 -0500
In-Reply-To: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D32BFB3A8706687D25470CE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 03:57 PM, Stephane Grosjean wrote:
> This patch adds the support for the following 3x sja1000 based PCI card=
s
> from PEAK-System Technik (www.peak-system.com):
>=20
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
>=20
> LEDs managemement on the PCAN-ExpressCard depends on I2C bit-banging ke=
rnel
> configuration option.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/Kconfig    |   10 +-
>  drivers/net/can/sja1000/peak_pci.c |  534 ++++++++++++++++++++++++++++=
++++++--
>  2 files changed, 512 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 36e9d59..724cf83 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -44,11 +44,15 @@ config CAN_EMS_PCI
>  	  (http://www.ems-wuensche.de).
> =20
>  config CAN_PEAK_PCI
> -	tristate "PEAK PCAN PCI/PCIe Cards"
> +	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>  	depends on PCI
>  	---help---
> -	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> -	  from PEAK Systems (http://www.peak-system.com).
> +	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
> +	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> +	  (http://www.peak-system.com).
> +
> +	  The I2C bit-banging algorithm should be selected to enable
> +	  correct LEDs management on the PCAN-ExpressCard (PCIeC) card.
> =20
>  config CAN_KVASER_PCI
>  	tristate "Kvaser PCIcanx and Kvaser PCIcan PCI Cards"
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja10=
00/peak_pci.c
> index 2147959..1577bfb 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -1,9 +1,10 @@
>  /*
nitpick about the copyright:

you should add your copyright...

>   * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>

=2E...here ^^^ ....

>   *
> - * Derived from the PCAN project file driver/src/pcan_pci.c:
> + * Derived from the PCAN project files driver/src/pcan_pci.c:
>   *
>   * Copyright (C) 2001-2006  PEAK System-Technik GmbH
> + * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>

and leave these lines as they are.

>   *
>   * This program is free software; you can redistribute it and/or modif=
y
>   * it under the terms of the version 2 of the GNU General Public Licen=
se
> @@ -13,12 +14,7 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software Foundat=
ion,
> - * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>   */
> -
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> @@ -26,46 +22,128 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> -
>  #include "sja1000.h"
> =20
>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
> -MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI/PCIe cards");
> -MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe CAN card");
> +MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards")=
;
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");=

>  MODULE_LICENSE("GPL v2");
> =20
> -#define DRV_NAME  "peak_pci"
> -
> -struct peak_pci_chan {
> -	void __iomem *cfg_base;		/* Common for all channels */
> -	struct net_device *prev_dev;	/* Chain of network devices */
> -	u16 icr_mask;			/* Interrupt mask for fast ack */
> -};
> +#define PEAK_PCI_DRV_NAME	"peak_pci"
> +#define PEAK_PCI_CHAN_MAX	4
> =20
>  #define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
> =20
>  #define PEAK_PCI_CDR		(CDR_CBP | CDR_CLKOUT_MASK)
>  #define PEAK_PCI_OCR		OCR_TX0_PUSHPULL
> =20
> -/*
> - * Important PITA registers
> - */
> +/* PITA registers */
>  #define PITA_ICR		0x00	/* Interrupt control register */
>  #define PITA_GPIOICR		0x18	/* GPIO interface control register */
>  #define PITA_MISC		0x1C	/* Miscellaneous register */
> =20
> +/* PCIeC leds management needs I2C algobit */
> +#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
> +#define PEAK_CONFIG_PCIEC_LEDS
> +#endif

ifdefs in the .c file are not welcome in general. What about something
like this:

#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
#define peak_pci_support_pcie()	(1)
#else
#define peak_pci_support_pcie()	(0)
#endif

In the probe function you can write:

probe() {
	...

	if (peak_pci_support_pcie() &&
	    pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
		...
	}
}

There should be no ifdefs left in the code. One question remains, is the
i2c core clever enough to define no-ops if the i2c subsystem is switched
off?

> +
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +
> +/* GPIOICR byte access offsets */
> +#define PITA_GPOUT		0x18	/* GPx output value */
> +#define PITA_GPIN		0x19	/* GPx input value */
> +#define PITA_GPOEN		0x1A	/* configure GPx as ouput pin */
> +
> +/* I2C GP bits */
> +#define PITA_GPIN_SCL		0x01	/* Serial Clock Line */
> +#define PITA_GPIN_SDA		0x04	/* Serial DAta line */
> +
> +/* LEDs control */
> +#define PCA9553_1_SLAVEADDR	(0xC4 >> 1)
> +
> +/* PCA9553 LS0 fields values */
> +enum {
> +	PCA9553_LOW,
> +	PCA9553_HIGHZ,
> +	PCA9553_PWM0,
> +	PCA9553_PWM1
> +};
> +
> +#define PCA9553_ON		PCA9553_LOW
> +#define PCA9553_OFF		PCA9553_HIGHZ
> +#define PCA9553_SLOW		PCA9553_PWM0
> +#define PCA9553_FAST		PCA9553_PWM1
> +
> +#define PCA9553_LED(c)		(1 << (c))
> +#define PCA9553_LED_STATE(s, c)	((s) << ((c) << 1))
> +
> +#define PCA9553_LED_ON(c)	PCA9553_LED_STATE(PCA9553_ON, c)
> +#define PCA9553_LED_OFF(c)	PCA9553_LED_STATE(PCA9553_OFF, c)
> +#define PCA9553_LED_SLOW(c)	PCA9553_LED_STATE(PCA9553_SLOW, c)
> +#define PCA9553_LED_FAST(c)	PCA9553_LED_STATE(PCA9553_FAST, c)
> +#define PCA9553_LED_MASK(c)	PCA9553_LED_STATE(0x03, c)
> +
> +#define PCA9553_LED_OFF_ALL	(PCA9553_LED_OFF(0) | PCA9553_LED_OFF(1))
> +
> +#define PCA9553_LS0_INIT	0x40 /* initial value (!=3D from 0x00) */
> +
> +#define PCA9553_LS0_NONE	0x45 /* off value */
> +
> +/* PCAN-PCIeC specific (leds management) */
> +struct peak_pciec_chan {
> +	struct net_device *netdev;
> +	unsigned long prev_rx_bytes;
> +	unsigned long prev_tx_bytes;
> +};
> +
> +struct peak_pciec_card {
> +	void __iomem *cfg_base;		/* Common for all channels */
> +	void __iomem *reg_base;		/* first channel base address */
> +	u8 led_cache;			/* leds state cache */
> +
> +	/* PCIExpressCard i2c data */
> +	struct i2c_algo_bit_data i2c_bit;
> +	struct i2c_adapter led_chip;
> +
> +	struct timer_list led_timer;	/* activity timer */
> +	int chan_count;
> +	struct peak_pciec_chan channel[PEAK_PCI_CHAN_MAX];
> +};
> +
> +#endif /* PEAK_CONFIG_PCIEC_LEDS*/
> +
>  #define PEAK_PCI_CFG_SIZE	0x1000	/* Size of the config PCI bar */
>  #define PEAK_PCI_CHAN_SIZE	0x0400	/* Size used by the channel */
> =20
> +/* PCI stuff */
>  #define PEAK_PCI_VENDOR_ID	0x001C	/* The PCI device and vendor IDs */
>  #define PEAK_PCI_DEVICE_ID	0x0001	/* for PCI/PCIe slot cards */
> +#define PEAK_PCIEC_DEVICE_ID	0x0002	/* for ExpressCard slot cards */
> +#define PEAK_PCIE_DEVICE_ID	0x0003	/* for nextgen PCIe slot cards */
> +#define PEAK_MPCI_DEVICE_ID	0x0008	/* The miniPCI slot cards */
> =20
> -static const u16 peak_pci_icr_masks[] =3D {0x02, 0x01, 0x40, 0x80};
> +struct peak_pci_chan {
> +	void __iomem *cfg_base;		/* Common for all channels */
> +	struct net_device *prev_dev;	/* Chain of network devices */
> +	u16 icr_mask;			/* Interrupt mask for fast ack */
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +	struct peak_pciec_card *pciec_card;	/* only for PCIeC LEDs */
> +#endif

If you remove this ifdef, you can get rid of some of the following (e.g.
the kfree())

> +};
> +
> +static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] =3D {
> +	0x02, 0x01, 0x40, 0x80
> +};
> =20
>  static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) =3D {
>  	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>  	{0,}
>  };
> =20
> @@ -85,14 +163,370 @@ static void peak_pci_write_reg(const struct sja10=
00_priv *priv,
>  static void peak_pci_post_irq(const struct sja1000_priv *priv)
>  {
>  	struct peak_pci_chan *chan =3D priv->priv;
> -	u16 icr;
> +	u16 icr =3D readw(chan->cfg_base + PITA_ICR);
> =20
>  	/* Select and clear in PITA stored interrupt */
> -	icr =3D readw(chan->cfg_base + PITA_ICR);
>  	if (icr & chan->icr_mask)
>  		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
>  }
> =20
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +
> +static inline void pita_set_scl_highz(struct peak_pciec_card *card)
> +{
> +	u8 gp_outen =3D readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SCL;
> +	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
> +}
> +
> +static inline void pita_set_sda_highz(struct peak_pciec_card *card)
> +{
> +	u8 gp_outen =3D readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SDA;
> +	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
> +}
> +
> +static void peak_pciec_init_pita_gpio(struct peak_pciec_card *card)
> +{
> +	/* raise SCL & SDA GPIOs to high-Z */
> +	pita_set_scl_highz(card);
> +	pita_set_sda_highz(card);
> +}
> +
> +static void pita_setsda(void *data, int state)
> +{
> +	struct peak_pciec_card *card =3D (struct peak_pciec_card *)data;
> +	u8 gp_out, gp_outen;
> +
> +	/* set output sda always to 0 */
> +	gp_out =3D readb(card->cfg_base + PITA_GPOUT) & ~PITA_GPIN_SDA;
> +	writeb(gp_out, card->cfg_base + PITA_GPOUT);
> +
> +	/* control output sda with GPOEN */
> +	gp_outen =3D readb(card->cfg_base + PITA_GPOEN);
> +	if (state)
> +		gp_outen &=3D ~PITA_GPIN_SDA;
> +	else
> +		gp_outen |=3D PITA_GPIN_SDA;
> +
> +	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
> +}
> +
> +static void pita_setscl(void *data, int state)
> +{
> +	struct peak_pciec_card *card =3D (struct peak_pciec_card *)data;
> +	u8 gp_out, gp_outen;
> +
> +	/* set output scl always to 0 */
> +	gp_out =3D readb(card->cfg_base + PITA_GPOUT) & ~PITA_GPIN_SCL;
> +	writeb(gp_out, card->cfg_base + PITA_GPOUT);
> +
> +	/* control output scl with GPOEN */
> +	gp_outen =3D readb(card->cfg_base + PITA_GPOEN);
> +	if (state)
> +		gp_outen &=3D ~PITA_GPIN_SCL;
> +	else
> +		gp_outen |=3D PITA_GPIN_SCL;
> +
> +	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
> +}
> +
> +static int pita_getsda(void *data)
> +{
> +	struct peak_pciec_card *card =3D (struct peak_pciec_card *)data;
> +
> +	/* set tristate */
> +	pita_set_sda_highz(card);
> +
> +	return (readb(card->cfg_base + PITA_GPIN) & PITA_GPIN_SDA) ? 1 : 0;
> +}
> +
> +static int pita_getscl(void *data)
> +{
> +	struct peak_pciec_card *card =3D (struct peak_pciec_card *)data;
> +
> +	/* set tristate */
> +	pita_set_scl_highz(card);
> +
> +	return (readb(card->cfg_base + PITA_GPIN) & PITA_GPIN_SCL) ? 1 : 0;
> +}
> +
> +/*
> + * write commands to the LED chip though the I2C-bus of the PCAN-PCIeC=

> + */
> +static int peak_pciec_write_pca9553(struct peak_pciec_card *card,
> +				    u8 offset, u8 data)
> +{
> +	u8 buffer[2] =3D {
> +		offset,
> +		data
> +	};
> +	struct i2c_msg msg =3D {
> +		.addr =3D PCA9553_1_SLAVEADDR,
> +		.len =3D 2,
> +		.buf =3D buffer,
> +	};
> +	int ret;
> +
> +	/* cache led mask */
> +	if ((offset =3D=3D 5) && (data =3D=3D card->led_cache))
> +		return 0;
> +
> +	ret =3D i2c_transfer(&card->led_chip, &msg, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (offset =3D=3D 5)
> +		card->led_cache =3D data;
> +
> +	return 0;
> +}
> +
> +/*
> + * timer callback used to control the LEDs
> + */
> +static void peak_pciec_led_timer(unsigned long arg)
> +{
> +	struct peak_pciec_card *card =3D (struct peak_pciec_card *)arg;
> +	struct net_device *netdev;
> +	u8 new_led =3D card->led_cache;
> +	int i, up_count =3D 0;
> +
> +	/* first check what is to do */
> +	for (i =3D 0; i < card->chan_count; i++) {
> +		/* default is: not configured */
> +		new_led &=3D ~PCA9553_LED_MASK(i);
> +		new_led |=3D PCA9553_LED_ON(i);
> +
> +		netdev =3D card->channel[i].netdev;
> +		if (!netdev || !(netdev->flags & IFF_UP))
> +			continue;
> +
> +		up_count++;
> +
> +		/* no activity (but configured) */
> +		new_led &=3D ~PCA9553_LED_MASK(i);
> +		new_led |=3D PCA9553_LED_SLOW(i);
> +
> +		/* if bytes counters changed, set fast blinking led */
> +		if (netdev->stats.rx_bytes !=3D card->channel[i].prev_rx_bytes) {
> +			card->channel[i].prev_rx_bytes =3D netdev->stats.rx_bytes;
> +			new_led &=3D ~PCA9553_LED_MASK(i);
> +			new_led |=3D PCA9553_LED_FAST(i);
> +		}
> +		if (netdev->stats.tx_bytes !=3D card->channel[i].prev_tx_bytes) {
> +			card->channel[i].prev_tx_bytes =3D netdev->stats.tx_bytes;
> +			new_led &=3D ~PCA9553_LED_MASK(i);
> +			new_led |=3D PCA9553_LED_FAST(i);
> +		}
> +	}
> +
> +	/* check if LS0 settings changed, only update i2c if so */
> +	peak_pciec_write_pca9553(card, 5, new_led);
> +
> +	/* restart timer (except if no more configured channels) */
> +	if (up_count)
> +		mod_timer(&card->led_timer, jiffies + HZ);
> +}
> +
> +/*
> + * set LEDs blinking state
> + */
> +static void peak_pciec_set_leds(struct peak_pciec_card *card, u8 led_m=
ask, u8 s)
> +{
> +	u8 new_led =3D card->led_cache;
> +	int i;
> +
> +	/* first check what is to do */
> +	for (i =3D 0; i < card->chan_count; i++)
> +		if (led_mask & PCA9553_LED(i)) {
> +			new_led &=3D ~PCA9553_LED_MASK(i);
> +			new_led |=3D PCA9553_LED_STATE(s, i);
> +		}
> +
> +	/* check if LS0 settings changed, only update i2c if so */
> +	peak_pciec_write_pca9553(card, 5, new_led);
> +}
> +
> +/*
> + * start one second timer to control LEDs
> + */
> +static void peak_pciec_start_led_timer(struct peak_pciec_card *card)
> +{
> +	if (!timer_pending(&card->led_timer))
> +		mod_timer(&card->led_timer, jiffies + HZ);
> +}
> +
> +/*
> + * stop LEDs timer
> + */
> +static void peak_pciec_stop_led_timer(struct peak_pciec_card *card)
> +{
> +	del_timer_sync(&card->led_timer);
> +}
> +
> +/*
> + * initialize the PCA9553 4-bit I2C-bus LED chip
> + */
> +static int peak_pciec_init_leds(struct peak_pciec_card *card)
> +{
> +	int err;
> +
> +	/* prescaler for frequency 0: "SLOW" =3D 1 Hz =3D "44" */
> +	err =3D peak_pciec_write_pca9553(card, 1, 44 / 1);
> +	if (err)
> +		return err;
> +
> +	/* duty cycle 0: 50% */
> +	err =3D peak_pciec_write_pca9553(card, 2, 0x80);
> +	if (err)
> +		return err;
> +
> +	/* prescaler for frequency 1: "FAST" =3D 5 Hz */
> +	err =3D peak_pciec_write_pca9553(card, 3, 44 / 5);
> +	if (err)
> +		return err;
> +
> +	/* duty cycle 1: 50% */
> +	err =3D peak_pciec_write_pca9553(card, 4, 0x80);
> +	if (err)
> +		return err;
> +
> +	/* switch LEDs to initial state */
> +	return peak_pciec_write_pca9553(card, 5, PCA9553_LS0_INIT);
> +}
> +
> +/*
> + * restore LEDs state to off peak_pciec_leds_exit
> + */
> +static void peak_pciec_leds_exit(struct peak_pciec_card *card)
> +{
> +	/* switch LEDs to off */
> +	peak_pciec_write_pca9553(card, 5, PCA9553_LED_OFF_ALL);
> +}
> +
> +/*
> + * normal write sja1000 register method overloaded to catch when contr=
oller
> + * is started or stopped, to control leds
> + */
> +static void peak_pciec_write_reg(const struct sja1000_priv *priv,
> +				 int port, u8 val)
> +{
> +	struct peak_pci_chan *chan =3D priv->priv;
> +	struct peak_pciec_card *card =3D chan->pciec_card;
> +	int c =3D (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
> +
> +	/* sja1000 register changes control the leds state */
> +	if (port =3D=3D REG_MOD)
> +		switch (val) {
> +		case MOD_RM:
> +			/* Reset Mode: set led on */
> +			peak_pciec_set_leds(card, PCA9553_LED(c), PCA9553_ON);
> +			break;
> +		case 0x00:
> +			/* Normal Mode: led slow blinking and start led timer */
> +			peak_pciec_set_leds(card, PCA9553_LED(c), PCA9553_SLOW);
> +			peak_pciec_start_led_timer(card);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +	/* call base function */
> +	peak_pci_write_reg(priv, port, val);
> +}
> +
> +static struct i2c_algo_bit_data peak_pciec_i2c_bit_ops =3D {
> +	.setsda	=3D pita_setsda,
> +	.setscl	=3D pita_setscl,
> +	.getsda	=3D pita_getsda,
> +	.getscl	=3D pita_getscl,
> +	.udelay	=3D 10,
> +	.timeout =3D HZ,
> +};
> +
> +static int peak_pciec_init(struct pci_dev *pdev, struct net_device *de=
v)
> +{
> +	struct sja1000_priv *priv =3D netdev_priv(dev);
> +	struct peak_pci_chan *chan =3D priv->priv;
> +	struct peak_pciec_card *card;
> +	int err;
> +
> +	/* copy i2c object address from 1st channel */
> +	if (chan->prev_dev) {
> +		struct sja1000_priv *prev_priv =3D netdev_priv(chan->prev_dev);
> +		struct peak_pci_chan *prev_chan =3D prev_priv->priv;
> +
> +		card =3D prev_chan->pciec_card;
> +		if (!card)
> +			return -ENODEV;
> +
> +	/* channel is the first one: do the init part */
> +	} else {
> +		/* create the bit banging I2C adapter structure */
> +		card =3D kzalloc(sizeof(struct peak_pciec_card), GFP_KERNEL);
> +		if (!card) {
> +			dev_warn(&pdev->dev,
> +				 "failed allocating memory for leds chip\n");
> +			return -ENOMEM;
> +		}
> +
> +		card->cfg_base =3D chan->cfg_base;
> +		card->reg_base =3D priv->reg_base;
> +
> +		card->led_chip.owner =3D THIS_MODULE;
> +		card->led_chip.dev.parent =3D &pdev->dev;
> +		card->led_chip.algo_data =3D &card->i2c_bit;
> +		strncpy(card->led_chip.name, "peak_i2c",
> +			sizeof(card->led_chip.name));
> +
> +		card->i2c_bit =3D peak_pciec_i2c_bit_ops;
> +		card->i2c_bit.udelay =3D 10;
> +		card->i2c_bit.timeout =3D HZ;
> +		card->i2c_bit.data =3D card;
> +
> +		peak_pciec_init_pita_gpio(card);
> +
> +		err =3D i2c_bit_add_bus(&card->led_chip);
> +		if (err) {
> +			dev_warn(&pdev->dev, "i2c init failed\n");
> +			goto pciec_init_err;
> +		}
> +
> +		err =3D peak_pciec_init_leds(card);
> +		if (err) {
> +			dev_warn(&pdev->dev, "leds hardware init failed\n");
> +			i2c_del_adapter(&card->led_chip);
> +			goto pciec_init_err;
> +		}
> +
> +		/* init the timer which controls the leds */
> +		init_timer(&card->led_timer);
> +		card->led_timer.function =3D peak_pciec_led_timer;
> +		card->led_timer.data =3D (unsigned long)card;
> +	}
> +
> +	chan->pciec_card =3D card;
> +	card->channel[card->chan_count++].netdev =3D dev;
> +
> +	return 0;
> +
> +pciec_init_err:
> +	peak_pciec_init_pita_gpio(card);
> +	kfree(card);
> +
> +	return err;
> +}
> +
> +static void peak_pciec_remove(struct peak_pciec_card *card)
> +{
> +	peak_pciec_stop_led_timer(card);
> +	peak_pciec_leds_exit(card);
> +	i2c_del_adapter(&card->led_chip);
> +	peak_pciec_init_pita_gpio(card);
> +	kfree(card);
> +}
> +
> +#endif /* PEAK_CONFIG_PCIEC_LEDS */
> +
>  static int __devinit peak_pci_probe(struct pci_dev *pdev,
>  				    const struct pci_device_id *ent)
>  {
> @@ -107,7 +541,7 @@ static int __devinit peak_pci_probe(struct pci_dev =
*pdev,
>  	if (err)
>  		return err;
> =20
> -	err =3D pci_request_regions(pdev, DRV_NAME);
> +	err =3D pci_request_regions(pdev, PEAK_PCI_DRV_NAME);
>  	if (err)
>  		goto failure_disable_pci;
> =20
> @@ -170,6 +604,12 @@ static int __devinit peak_pci_probe(struct pci_dev=
 *pdev,
> =20
>  		priv->read_reg =3D peak_pci_read_reg;
>  		priv->write_reg =3D peak_pci_write_reg;
> +
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +		/* PCAN-ExpressCard needs its own callback for leds */
> +		if (pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID)
> +			priv->write_reg =3D peak_pciec_write_reg;
> +#endif
>  		priv->post_irq =3D peak_pci_post_irq;
> =20
>  		priv->can.clock.freq =3D PEAK_PCI_CAN_CLOCK;
> @@ -188,17 +628,40 @@ static int __devinit peak_pci_probe(struct pci_de=
v *pdev,
> =20
>  		SET_NETDEV_DEV(dev, &pdev->dev);
> =20
> +		/* Create chain of SJA1000 devices */
> +		chan->prev_dev =3D pci_get_drvdata(pdev);
> +		pci_set_drvdata(pdev, dev);
> +
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +		/*
> +		 * PCAN-ExpressCard needs some addtional support for leds.
> +		 * This must be done *before* register_sja1000dev() but
> +		 * *after* devices linkage
> +		 */
> +		if (pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
> +			err =3D peak_pciec_init(pdev, dev);
> +			if (err) {
> +				dev_warn(&pdev->dev,
> +					"%s channel led won't blink (err %d)\n",
> +					dev->name, err);
> +				/*
> +				 * PCIeC specific leds init failed? anyway,
> +				 * handle the board as a "classic" PCI card
> +				 */
> +				priv->write_reg =3D peak_pci_write_reg;
> +			}
> +		}
> +
> +#endif /* PEAK_CONFIG_PCIEC_LEDS */
> +
>  		err =3D register_sja1000dev(dev);
>  		if (err) {
>  			dev_err(&pdev->dev, "failed to register device\n");
> +			pci_set_drvdata(pdev, chan->prev_dev);
>  			free_sja1000dev(dev);
>  			goto failure_remove_channels;
>  		}
> =20
> -		/* Create chain of SJA1000 devices */
> -		chan->prev_dev =3D pci_get_drvdata(pdev);
> -		pci_set_drvdata(pdev, dev);
> -
>  		dev_info(&pdev->dev,
>  			 "%s at reg_base=3D0x%p cfg_base=3D0x%p irq=3D%d\n",
>  			 dev->name, priv->reg_base, chan->cfg_base, dev->irq);
> @@ -213,6 +676,7 @@ failure_remove_channels:
>  	/* Disable interrupts */
>  	writew(0x0, cfg_base + PITA_ICR + 2);
> =20
> +	chan =3D NULL;
>  	for (dev =3D pci_get_drvdata(pdev); dev; dev =3D chan->prev_dev) {
>  		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);
> @@ -220,6 +684,11 @@ failure_remove_channels:
>  		chan =3D priv->priv;
>  	}
> =20
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +	/* free any PCIeC resources too */
> +	if (chan && chan->pciec_card)
> +		peak_pciec_remove(chan->pciec_card);
> +#endif

this should not hurt

>  	pci_iounmap(pdev, reg_base);
> =20
>  failure_unmap_cfg_base:
> @@ -251,8 +720,15 @@ static void __devexit peak_pci_remove(struct pci_d=
ev *pdev)
>  		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);
>  		dev =3D chan->prev_dev;
> -		if (!dev)
> +
> +		/* do that only for first channel */
> +		if (!dev) {
> +#ifdef PEAK_CONFIG_PCIEC_LEDS
> +			if (chan->pciec_card)
> +				peak_pciec_remove(chan->pciec_card);
> +#endif
>  			break;
> +		}
>  		priv =3D netdev_priv(dev);
>  		chan =3D priv->priv;
>  	}
> @@ -266,7 +742,7 @@ static void __devexit peak_pci_remove(struct pci_de=
v *pdev)
>  }
> =20
>  static struct pci_driver peak_pci_driver =3D {
> -	.name =3D DRV_NAME,
> +	.name =3D PEAK_PCI_DRV_NAME,
>  	.id_table =3D peak_pci_tbl,
>  	.probe =3D peak_pci_probe,
>  	.remove =3D __devexit_p(peak_pci_remove),

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9D32BFB3A8706687D25470CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pWGcACgkQjTAFq1RaXHMHGACeJXEk8vZhpPPWO27M58ayT3Hi
3kwAnAzsroPwQeFMycNezQo88LvnfbcV
=d/DZ
-----END PGP SIGNATURE-----

--------------enig9D32BFB3A8706687D25470CE--
