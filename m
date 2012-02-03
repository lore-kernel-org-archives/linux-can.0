From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Fri, 03 Feb 2012 17:03:00 +0100
Message-ID: <4F2C0534.2000305@hartkopp.net>
References: <1328280824-11331-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:29651 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab2BCQDC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 11:03:02 -0500
In-Reply-To: <1328280824-11331-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hallo Stephane,

looks really nice now.

Just a single question:

On 03.02.2012 15:53, Stephane Grosjean wrote:

> - the PCANExpressCard device id is finally let into the device_id table even
>   if it is not explicitly selected in Kconfig; however the device probing fails
>   and logs an explicit error message


What is the reason for that?

If we generally have the possibility to check for PCIEC, i would make it in
the device id table and the module description too:

>  #include <linux/kernel.h>
> @@ -26,22 +23,26 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>

#ifdef CONFIG_CAN_PEAK_PCIEC

> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>

#endif

>  #include <linux/can.h>
>  #include <linux/can/dev.h>
>  
>  #include "sja1000.h"
>  
>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
> -MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI/PCIe cards");
> -MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe CAN card");
> +MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
#ifdef CONFIG_CAN_PEAK_PCIEC
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");

#else

> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe miniPCI CAN cards");

#endif

>  MODULE_LICENSE("GPL v2");
>  
>  #define DRV_NAME  "peak_pci"
>  
> +struct peak_pciec_card;
>  struct peak_pci_chan {
>  	void __iomem *cfg_base;		/* Common for all channels */
>  	struct net_device *prev_dev;	/* Chain of network devices */
>  	u16 icr_mask;			/* Interrupt mask for fast ack */
> +	struct peak_pciec_card *pciec_card;	/* only for PCIeC LEDs */
>  };
>  
>  #define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
> @@ -61,16 +62,469 @@ struct peak_pci_chan {
>  
>  #define PEAK_PCI_VENDOR_ID	0x001C	/* The PCI device and vendor IDs */
>  #define PEAK_PCI_DEVICE_ID	0x0001	/* for PCI/PCIe slot cards */
> +#define PEAK_PCIEC_DEVICE_ID	0x0002	/* for ExpressCard slot cards */
> +#define PEAK_PCIE_DEVICE_ID	0x0003	/* for nextgen PCIe slot cards */
> +#define PEAK_MPCI_DEVICE_ID	0x0008	/* The miniPCI slot cards */
> +
> +#define PEAK_PCI_CHAN_MAX	4
>  
> -static const u16 peak_pci_icr_masks[] = {0x02, 0x01, 0x40, 0x80};
> +static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] = {
> +	0x02, 0x01, 0x40, 0x80
> +};
>  
>  static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) = {
>  	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
#ifdef CONFIG_CAN_PEAK_PCIEC
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},

#endif

>  	{0,}
>  };
>  


Regards,
Oliver

