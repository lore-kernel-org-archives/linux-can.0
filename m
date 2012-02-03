From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v5] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Fri, 03 Feb 2012 20:57:06 +0100
Message-ID: <4F2C3C12.8050501@grandegger.com>
References: <1328280824-11331-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47842 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab2BCT5J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 14:57:09 -0500
In-Reply-To: <1328280824-11331-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephan,

the driver looks really good now. You can add my:

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Just a few minor comments which you can fix if an

On 02/03/2012 03:53 PM, Stephane Grosjean wrote:
> This patch adds the support for the following 3x sja1000 based PCI cards
> from PEAK-System Technik (www.peak-system.com):
> 
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
> 
> The PCAN-ExpressCard card needs I2C bit-banging interface, so selecting that
> card automatically selects I2C and I2C_ALGOBIT bit-banging kernel configuration
> options.
> 
> v5 changes:
> - The PCANExpressCard should now be selected explicitly in Kconfig; this also
>   forces I2C and I2C_ALGOBIT to be selected
> - the PCANExpressCard device id is finally let into the device_id table even
>   if it is not explicitly selected in Kconfig; however the device probing fails
>   and logs an explicit error message
> - any error during probng the PCANExpressCard is now considered as fatal

General comment. Please move such comments *below* the "---" line
otherwise they show up in the commit message (when applied with "git am".

> Tests made on isolated and non-isolated PCANExpressCard ok.
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/Kconfig    |   18 +-
>  drivers/net/can/sja1000/peak_pci.c |  509 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 510 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
> index 36e9d59..8116336 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -44,11 +44,23 @@ config CAN_EMS_PCI
>  	  (http://www.ems-wuensche.de).
>  
>  config CAN_PEAK_PCI
> -	tristate "PEAK PCAN PCI/PCIe Cards"
> +	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
>  	depends on PCI
>  	---help---
> -	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> -	  from PEAK Systems (http://www.peak-system.com).
> +	  This driver is for the PCAN-PCI/PCIe/miniPCI cards
> +	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> +	  (http://www.peak-system.com).
> +
> +config CAN_PEAK_PCIEC
> +	bool "PEAK PCAN-ExpressCard Cards"
> +	depends on CAN_PEAK_PCI
> +	select I2C
> +	select I2C_ALGOBIT
> +	default y
> +	---help---
> +	  Say Y here if you want to use a PCAN-ExpressCard from PEAK-System
> +	  Technik. This will also automatically select I2C and I2C_ALGO
> +	  configuration options.
>  
>  config CAN_KVASER_PCI
>  	tristate "Kvaser PCIcanx and Kvaser PCIcan PCI Cards"
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index 2147959..c716183 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
....
> +#else
> +
> +/*
> + * Placebo functions when PCAN-ExpressCard support is not selected
> + */
> +static inline int peak_pciec_probe(struct pci_dev *pdev, struct net_device *dev)
> +{
> +	dev_err(&pdev->dev,
> +	      "the kernel is not configured to support PCAN-ExpressCard\n");
> +
> +	return -EINVAL;

-ENODEV is more appropriate.

> +}
> +
> +static inline void peak_pciec_remove(struct peak_pciec_card *card)
> +{
> +}
> +#endif /* CAN_PEAK_PCIEC */
> +
>  static u8 peak_pci_read_reg(const struct sja1000_priv *priv, int port)
>  {
>  	return readb(priv->reg_base + (port << 2));
> @@ -188,17 +642,30 @@ static int __devinit peak_pci_probe(struct pci_dev *pdev,
>  
>  		SET_NETDEV_DEV(dev, &pdev->dev);
>  
> +		/* Create chain of SJA1000 devices */
> +		chan->prev_dev = pci_get_drvdata(pdev);
> +		pci_set_drvdata(pdev, dev);
> +
> +		/*
> +		 * PCAN-ExpressCard needs some additional i2c init.
> +		 * This must be done *before* register_sja1000dev() but
> +		 * *after* devices linkage
> +		 */
> +		if (pdev->device == PEAK_PCIEC_DEVICE_ID) {
> +			err = peak_pciec_probe(pdev, dev);
> +			if (err) {
> +				dev_err(&pdev->dev,
> +				       "failed to init device (err %d)\n", err);

"probing failed" or drop the message completely (you have enough in
peak_pciec_probe).

Wolfgang.
