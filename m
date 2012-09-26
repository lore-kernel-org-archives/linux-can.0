From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: can_oc: Add driver for CAN_OC cores from Aeroflex
 Gaisler
Date: Wed, 26 Sep 2012 11:38:47 +0200
Message-ID: <5062CD27.3090803@pengutronix.de>
References: <1348552379-3909-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6884328A2E546989DB400872"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40188 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2IZJjA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Sep 2012 05:39:00 -0400
In-Reply-To: <1348552379-3909-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6884328A2E546989DB400872
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/25/2012 07:52 AM, Andreas Larsson wrote:
> This driver is for the sja1000 compatible CAN_OC cores from Aeroflex
> Gaisler available in the GRLIB VHDL IP core library.

Why don't you describe a single sja1000 compatible core with an OF
device? The devices have indipendent address spaces and IRQs. With a
proper abstraction/desciption you would not need this driver.

> Multiple CAN controllers might be included in one platform device. The
> number of controllers is indicated by the "version" Open Firmware
> property of the device plus one.

Some general remarks:
- please use devm_* function, they do automatically cleanup if probe()
  fails or if the driver is unloaded. I've written the devm_* function
  names inline.

- Please avoid the double pointer void ** array:
  Create a "struct can_oc_priv" holding all your private data.
  You can work with an "open array" [1] to hold the pointers to the
  struct net_device.
  (I personally prefer an explizid length,
   not a NULL pointer terminated array.)

[1]  http://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html


>=20
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  drivers/net/can/sja1000/Kconfig  |    7 +
>  drivers/net/can/sja1000/Makefile |    1 +
>  drivers/net/can/sja1000/can_oc.c |  274 ++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 282 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/sja1000/can_oc.c
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 03df9a8..3573dc8 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -105,4 +105,11 @@ config CAN_TSCAN1
>  	IRQ numbers are read from jumpers JP4 and JP5,
>  	SJA1000 IO base addresses are chosen heuristically (first that works)=
=2E
> =20
> +config CAN_CAN_OC
> +	tristate "Aeroflex Gaisler CAN_OC driver"
> +	depends on SPARC
> +	---help---
> +	  This driver is for CAN_OC cores from Aeroflex Gaisler
> +	  (http://www.gaisler.com).
> +
>  endif
> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000=
/Makefile
> index b3d05cb..0186332 100644
> --- a/drivers/net/can/sja1000/Makefile
> +++ b/drivers/net/can/sja1000/Makefile
> @@ -13,5 +13,6 @@ obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o
>  obj-$(CONFIG_CAN_PEAK_PCI) +=3D peak_pci.o
>  obj-$(CONFIG_CAN_PLX_PCI) +=3D plx_pci.o
>  obj-$(CONFIG_CAN_TSCAN1) +=3D tscan1.o
> +obj-$(CONFIG_CAN_CAN_OC) +=3D can_oc.o
> =20
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/sja1000/can_oc.c b/drivers/net/can/sja1000=
/can_oc.c
> new file mode 100644
> index 0000000..3c39c8e
> --- /dev/null
> +++ b/drivers/net/can/sja1000/can_oc.c
> @@ -0,0 +1,274 @@
> +/*
> + * Socket CAN driver for CAN_OC cores from Aeroflex Gaisler.
> + *
> + * 2012 (c) Aeroflex Gaisler AB
> + *
> + * General organization derived from sja1000_of_platform driver:
> + * - Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> + *
> + * This driver supports CAN_OC CAN controllers available in the GRLIB
> + * VHDL IP core library.
> + *
> + * Full documentation of the CAN_OC core can be found here:
> + * http://www.gaisler.com/products/grlib/grip.pdf
> + *
> + * One device can contain several CAN_OC instantiations. The number of=

> + * instantiations is indicated by the "version" Open Firmware property=

> + * of the device plus one. The interrupt offset between such
> + * instantiations is 1 and the register base address offset between
> + * them is 0x100.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published by t=
he
> + * Free Software Foundation; either version 2 of the License, or (at y=
our
> + * option) any later version.
> + *
> + * Contributors: Andreas Larsson <andreas@gaisler.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/netdevice.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/can/dev.h>
> +
> +#include <linux/of_platform.h>
> +#include <asm/prom.h>
> +
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include "sja1000.h"
> +
> +#define DRV_NAME "can_oc"
> +
> +MODULE_AUTHOR("Aeroflex Gaisler AB.");
> +MODULE_DESCRIPTION("Socket CAN driver for CAN_OC cores from Aeroflex G=
aisler");
> +MODULE_LICENSE("GPL");
> +
> +#define CORE_OFFSET 0x100;

Please ad CAN_OC_ in front of that constant.

> +
> +static u8 can_oc_read_reg(const struct sja1000_priv *priv, int reg)
> +{
> +	return ioread8(priv->reg_base + reg);
> +}
> +
> +static void can_oc_write_reg(const struct sja1000_priv *priv,
> +				  int reg, u8 val)
> +{
> +	iowrite8(val, priv->reg_base + reg);
> +}
> +
> +/*
> + * Frees all devices in the NULL-terminated array and frees the
> + * array. Returns the base address of the register space
> + * (i.e. reg_base for core 0).
> + */
> +static void __iomem *can_oc_release_base_and_devices(void **base_and_d=
evices)
> +{
> +	struct net_device *dev;
> +	struct sja1000_priv *priv;
> +	int i;
> +	void __iomem *base =3D (void __iomem *)base_and_devices[0];
> +	for (i =3D 0; base_and_devices[i+1]; i++) {
> +		if (IS_ERR(base_and_devices[i+1]))
> +			continue;
> +		dev =3D (struct net_device *)base_and_devices[i+1];
> +		priv =3D netdev_priv(dev);
> +		unregister_sja1000dev(dev);
> +		irq_dispose_mapping(dev->irq);
> +		free_sja1000dev(dev);
> +	}
> +	kfree(base_and_devices);
> +	return base;
> +}
> +
> +/*
> + * Sets up and registers core with the specified index returning the
> + * net_device in the out parameter odev
> + */
> +static int __devinit can_oc_core_probe(struct platform_device *ofdev,
> +					void __iomem *base, int index,
> +					struct net_device **odev)
> +{
> +	struct device_node *np =3D ofdev->dev.of_node;
> +	struct sja1000_priv *priv;
> +	const u32 *prop;
> +	int err, irq, prop_size;
> +	struct net_device *dev;
> +
> +	*odev =3D NULL;
> +	irq =3D irq_of_parse_and_map(np, index);
> +	if (irq =3D=3D NO_IRQ) {
> +		dev_err(&ofdev->dev, "no irq found for core %d\n", index);
> +		return -ENODEV;
> +	}
> +
> +	dev =3D alloc_sja1000dev(0);
> +	if (!dev) {
> +		err =3D -ENOMEM;
> +		dev_err(&ofdev->dev,
> +			"unable to allocate memory for core %d\n", index);
> +		goto exit_dispose_irq;
> +	}
> +	dev->irq =3D irq;
> +
> +	priv =3D netdev_priv(dev);
> +	priv->reg_base =3D base + index * CORE_OFFSET;
> +	priv->irq_flags =3D IRQF_SHARED;
> +	priv->read_reg =3D can_oc_read_reg;
> +	priv->write_reg =3D can_oc_write_reg;
> +
> +	prop =3D of_get_property(np, "freq", &prop_size);
> +	if (prop && (prop_size =3D=3D  sizeof(u32))) {
> +		priv->can.clock.freq =3D *prop / 2;
> +	} else {
> +		err =3D -ENODEV;
> +		dev_err(&ofdev->dev, "unable to get \"freq\" property\n");
> +		goto exit_free_sja1000;
> +	}
> +
> +	dev_info(&ofdev->dev, "core %d: reg_base=3D0x%p irq=3D%d clock=3D%d\n=
",
> +		 index, priv->reg_base, dev->irq, priv->can.clock.freq);
> +	SET_NETDEV_DEV(dev, &ofdev->dev);
> +
> +	err =3D register_sja1000dev(dev);
> +	if (err) {
> +		dev_err(&ofdev->dev, "registering core %d failed (err=3D%d)\n",
> +			index, err);
> +		goto exit_free_sja1000;
> +	}
> +
> +	*odev =3D dev;
> +	return 0;
> +
> +exit_free_sja1000:
> +	free_sja1000dev(dev);
> +exit_dispose_irq:
> +	irq_dispose_mapping(irq);
> +
> +	return err;
> +}
> +
> +/* Initialize the CAN_OC Socket CAN */
> +static int __devinit can_oc_of_probe(struct platform_device *ofdev)
> +{
> +	struct device_node *np =3D ofdev->dev.of_node;
> +	struct resource res;
> +	const u32 *prop;
> +	int cores, i, err, res_size, prop_size;
> +	void __iomem *base;
> +	struct net_device *dev;
> +
> +	/* NULL-terminated array of pointers: base_and_devices[0] will
> +	 * contain the base address for the register address space for
> +	 * all the cores and base_and_devices[i+1] will contain a
> +	 * pointer to the net_device structure of core i */
> +	void **base_and_devices;

Please avoid this double pointer. base

> +
> +	const u32 *ampopts =3D of_get_property(np, "ampopts", NULL);

Please use of_property_read_u32() instead.

> +	if (ampopts) {
> +		dev_info(&ofdev->dev, "ampopts: 0x%08x\n", *ampopts);
> +		/* Ignore if used by another OS instance */
> +		if (*ampopts =3D=3D 0)
> +			return -ENODEV;
> +	}
> +
> +	err =3D of_address_to_resource(np, 0, &res);
> +	if (err) {
> +		dev_err(&ofdev->dev, "invalid address\n");
> +		return err;
> +	}
> +
> +	res_size =3D resource_size(&res);
> +	if (!request_mem_region(res.start, res_size, DRV_NAME)) {
> +		dev_err(&ofdev->dev, "couldn't request %pR\n", &res);
> +		return -EBUSY;
> +	}
> +
> +	base =3D ioremap_nocache(res.start, res_size);
> +	if (!base) {
> +		dev_err(&ofdev->dev, "couldn't ioremap %pR\n", &res);
> +		err =3D -ENOMEM;
> +		goto exit_release_mem;
> +	}

Please use:

	platform_get_resource(pdev, IORESOURCE_MEM, 0);
	devm_request_and_ioremap(dev, res);

> +
> +	prop =3D of_get_property(np, "version", &prop_size);

of_property_read_u32()

> +	if (prop && (prop_size =3D=3D  sizeof(u32))) {
> +		cores =3D *prop + 1;
> +		dev_info(&ofdev->dev, "found %d cores\n", cores);
> +	} else {
> +		cores =3D 1; /* default */
> +		dev_err(&ofdev->dev,
> +			"Unable to determine number of cores - assuming one");
> +	}
> +
> +	base_and_devices =3D kzalloc((cores + 2) * sizeof(void *), GFP_KERNEL=
);

devm_kzalloc()

> +	if (!base_and_devices) {
> +		dev_err(&ofdev->dev, "couldn't allocate memory\n");
> +		err =3D -ENOMEM;
> +		goto exit_unmap_mem;
> +	}
> +	dev_set_drvdata(&ofdev->dev, base_and_devices);
> +
> +	base_and_devices[0] =3D base;
> +	for (i =3D 0; i < cores; i++) {
> +		if (!ampopts || (1 << i) & *ampopts) {
> +			err =3D can_oc_core_probe(ofdev, base, i, &dev);
> +			if (err)
> +				goto exit_release_base_and_devices;
> +			base_and_devices[i+1] =3D dev;
> +		} else {
> +			base_and_devices[i+1] =3D ERR_PTR(-ENXIO);

Why not just NULL, or rather nothing, as the array already initialized
with 0x0.

> +		}
> +	}
> +
> +	return 0;
> +
> +exit_release_base_and_devices:
> +	can_oc_release_base_and_devices(base_and_devices);
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +exit_unmap_mem:
> +	iounmap(base);
> +exit_release_mem:
> +	release_mem_region(res.start, res_size);
> +
> +	return err;
> +}
> +
> +static int __devexit can_oc_of_remove(struct platform_device *ofdev)
> +{
> +	void **base_and_devices =3D dev_get_drvdata(&ofdev->dev);
> +	void __iomem *base;
> +	struct device_node *np =3D ofdev->dev.of_node;
> +	struct resource res;
> +
> +	base =3D can_oc_release_base_and_devices(base_and_devices);
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +	iounmap(base);
> +
> +	of_address_to_resource(np, 0, &res);
> +	release_mem_region(res.start, resource_size(&res));
> +
> +	return 0;
> +}
> +
> +static struct of_device_id can_oc_of_match[] =3D {
> +	{.name =3D "GAISLER_CANAHB"},
> +	{.name =3D "01_019"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, can_oc_of_match);
> +
> +static struct platform_driver can_oc_of_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D can_oc_of_match,
> +	},
> +	.probe =3D can_oc_of_probe,
> +	.remove =3D __devexit_p(can_oc_of_remove),
> +};
> +
> +module_platform_driver(can_oc_of_driver);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6884328A2E546989DB400872
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBizScACgkQjTAFq1RaXHP93QCaAvY/FFYHdCAWryg7W9Z2Of0B
Wj8An0pyma6V422UPcyEaP6e7RdQcj2D
=JZPY
-----END PGP SIGNATURE-----

--------------enig6884328A2E546989DB400872--
